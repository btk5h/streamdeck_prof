# frozen_string_literal: true

require "json"
require "streamdeck_prof/action"
require "streamdeck_prof/action_list"
require "streamdeck_prof/lazy_file"

module StreamdeckProf
  class Profile
    attr_reader :profile_dir, :manifest

    def initialize(profile_dir)
      @profile_dir = profile_dir
      @manifest = JSON.parse(File.read(manifest_path))
    end

    def uuid
      File.basename(profile_dir, ".sdProfile")
    end

    def name
      manifest["Name"]
    end

    def name=(name)
      manifest["Name"] = name
    end

    def app_identifier
      manifest["AppIdentifier"]
    end

    def app_identifier=(app_identifier)
      manifest["AppIdentifier"] = app_identifier
    end

    def actions
      @actions ||= StreamdeckProf::ActionList.new.tap do |actions|
        actions_hash = actions.to_h
        manifest["Actions"].each do |key, value|
          actions_hash[key] = make_action(key, value)
        end
      end
    end

    def actions=(actions)
      @actions = actions || StreamdeckProf::ActionList.new
    end

    def save
      sync_manifest
      @actions&.to_h&.each { |position_key, action| action.save(action_storage_path(position_key)) }
      File.write(manifest_path, JSON.dump(manifest))
    end

    private

    def sync_manifest
      manifest["Actions"] = actions.to_h.transform_values(&:to_h) unless @actions.nil?
    end

    def manifest_path
      File.join(profile_dir, "manifest.json")
    end

    def make_action(position_key, config)
      StreamdeckProf::Action.new(config).tap do |action|
        storage_path = action_storage_path(position_key)
        Dir.glob(File.join(storage_path, "**/*"))
           .reject { |path| File.directory?(path) }
           .each do |path|
             file_key = relative_path(storage_path, path)
             action.files[file_key] = StreamdeckProf::LazyFile.new(path)
           end
      end
    end

    def action_storage_path(position_key)
      File.join(profile_dir, position_key)
    end

    def relative_path(from_path, to_path)
      Pathname.new(to_path).relative_path_from(Pathname.new(from_path)).to_s
    end
  end
end

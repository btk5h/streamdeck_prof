# frozen_string_literal: true

require "json"
require "streamdeck_prof/action"
require "streamdeck_prof/action_list"

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
          actions_hash[key] = StreamdeckProf::Action.new(value)
        end
      end
    end

    def actions=(actions)
      @actions = actions || StreamdeckProf::ActionList.new
    end

    def save
      sync_manifest
      File.write(manifest_path, JSON.dump(manifest))
    end

    private

    def sync_manifest
      manifest["Actions"] = actions.to_h.transform_values(&:to_h) unless @actions.nil?
    end

    def manifest_path
      File.join(profile_dir, "manifest.json")
    end
  end
end

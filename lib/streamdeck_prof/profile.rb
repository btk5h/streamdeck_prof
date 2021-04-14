# frozen_string_literal: true

require "json"
require "streamdeck_prof/action"

module StreamdeckProf
  class Profile
    attr_reader :profile_dir, :manifest

    def initialize(profile_dir)
      @profile_dir = profile_dir
      @manifest = JSON.parse(File.read(manifest_path))
      @actions_cache = {}
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

    def has_action?(x, y)
      key = "#{x},#{y}"
      !@manifest["Actions"][key].nil?
    end

    def action(x, y)
      return nil unless has_action?(x, y)

      action!(x, y)
    end

    def action!(x, y)
      key = "#{x},#{y}"
      @actions_cache[key] ||= StreamdeckProf::Action.new(self, x, y)
    end

    def save
      File.write(manifest_path, JSON.dump(manifest))
    end

    private

    def manifest_path
      File.join(profile_dir, "manifest.json")
    end
  end
end

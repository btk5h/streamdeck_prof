# frozen_string_literal: true

require "streamdeck_prof/profile"
require "streamdeck_prof/device_data"
require "securerandom"

module StreamdeckProf
  class Context
    def initialize(profiles_dir: default_profiles_dir)
      @profiles_dir = profiles_dir
    end

    def profiles
      @profiles ||= Dir.glob(File.join(@profiles_dir, "*.sdProfile"))
                       .map { |profile_path| Profile.new(profile_path) }
                       .freeze
    end

    def profile_for_application(application, exact: true)
      if exact
        profiles.find { |p| p.app_identifier == application }
      else
        profiles.find { |p| p.app_identifier&.include?(application) }
      end
    end

    def profile_by_name(name)
      profiles.find { |p| p.name == name }
    end

    def new_profile(type: :xl)
      manifest = StreamdeckProf::DeviceData.const_get(type.upcase)[:empty_profile]
      uuid = SecureRandom.uuid.upcase
      profile_path = File.join(@profiles_dir, "#{uuid}.sdProfile")
      manifest_path = File.join(profile_path, "manifest.json")

      Dir.mkdir(profile_path)
      File.write(manifest_path, JSON.dump(manifest))

      @profiles = nil

      Profile.new(profile_path)
    end

    private

    def default_profiles_dir
      if Gem.win_platform?
        File.join(ENV["APPDATA"], "Elgato/StreamDeck/ProfilesV2")
      else
        File.expand_path("~/Library/Application Support/com.elgato.StreamDeck/ProfilesV2")
      end
    end
  end
end

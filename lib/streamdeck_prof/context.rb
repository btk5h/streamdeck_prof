# frozen_string_literal: true

require "streamdeck_prof/profile"

module StreamdeckProf
  class Context
    def initialize(profiles_dir: default_profiles_dir)
      @profiles_dir = profiles_dir
    end

    def profiles
      @profiles ||= Dir.glob(File.join(@profiles_dir, "*.sdProfile")).map { |profile_path| Profile.new(profile_path) }
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

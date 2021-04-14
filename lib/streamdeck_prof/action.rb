# frozen_string_literal: true

module StreamdeckProf
  class Action
    attr_reader :profie, :position_x, :position_y

    def initialize(profile, x, y)
      @profile = profile
      @position_x = x
      @position_y = y
    end

    def internal_id
      "#{position_x},#{position_y}"
    end

    def manifest
      profile.manifest["Actions"][internal_id] ||= {}
    end

    def uuid
      manifest["UUID"]
    end

    def uuid=(uuid)
      manifest["UUID"] = uuid
    end

    def name
      manifest["Name"]
    end

    def name=(name)
      manifest["Name"] = name
    end

    def state
      manifest["State"]
    end

    def state=(state)
      manifest["State"] = state
    end

    def settings
      manifest["Settings"]
    end

    def settings=(settings)
      manifest["Settings"] = settings
    end
  end
end

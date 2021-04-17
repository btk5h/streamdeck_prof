# frozen_string_literal: true

module StreamdeckProf
  class Action
    attr_accessor :config

    def initialize(config)
      @config = config
    end

    def uuid
      config["UUID"]
    end

    def uuid=(uuid)
      config["UUID"] = uuid
    end

    def name
      config["Name"]
    end

    def name=(name)
      config["Name"] = name
    end

    def state
      config["State"]
    end

    def state=(state)
      config["State"] = state
    end

    def settings
      config["Settings"]
    end

    def settings=(settings)
      config["Settings"] = settings
    end

    def to_hash
      config
    end

    alias to_h to_hash
  end
end

# frozen_string_literal: true

require "streamdeck_prof/file_list"

module StreamdeckProf
  class Action
    attr_accessor :config, :files

    def initialize(config)
      @config = config
      @files = FileList.new
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

    def save(storage_path)
      files.save(storage_path)
    end
  end
end

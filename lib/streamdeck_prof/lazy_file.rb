# frozen_string_literal: true

require "fileutils"

module StreamdeckProf
  class LazyFile
    attr_accessor :source_path

    def initialize(source_path)
      @source_path = source_path
    end

    def save(path)
      file_dir = File.dirname(path)
      FileUtils.mkdir_p(file_dir) unless Dir.exist?(file_dir)

      FileUtils.copy(source_path, path) unless File.realdirpath(path) == File.realdirpath(source_path)
    end
  end
end

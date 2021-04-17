# frozen_string_literal: true

module StreamdeckProf
  class FileList
    def initialize
      @files = {}
    end

    def [](path)
      @files[path]
    end

    def []=(path, file)
      if file.nil?
        @files.delete(path)
      else
        @files[path] = file
      end
    end

    def to_hash
      @files
    end

    alias to_h to_hash

    def save(storage_path)
      @files.each { |path, file| file.save(File.join(storage_path, path)) }
    end
  end
end

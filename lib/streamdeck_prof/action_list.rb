# frozen_string_literal: true

module StreamdeckProf
  class ActionList
    def initialize
      @actions = {}
    end

    def [](x, y)
      @actions[coordinates(x, y)]
    end

    def []=(x, y, value)
      key = coordinates(x, y)
      if value.nil?
        @actions.delete(key)
      else
        @actions[key] = value
      end
    end

    def to_hash
      @actions
    end

    alias to_h to_hash

    private

    def initialize_copy(original)
      @actions = original.to_h.dup
    end

    def coordinates(x, y)
      "#{x},#{y}"
    end
  end
end

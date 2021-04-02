# frozen_string_literal: true

require_relative "streamdeck_prof/version"
require_relative "streamdeck_prof/context"

module StreamdeckProf
  class Error < StandardError; end

  def self.run(&block)
    context = StreamdeckProf::Context.new
    context.instance_eval(&block)
    context.profiles.each(&:save)
  end
end

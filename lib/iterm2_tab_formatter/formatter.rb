require 'rspec/core/formatters/base_formatter'

module Iterm2TabFormatter
  class Formatter < RSpec::Core::Formatters::BaseFormatter
    attr_reader :controller

    def initialize(output)
      super
      @controller = Iterm2TabFormatter::Controller.new({})
    end

    def start(example_count)
      super
      controller.apply_start_color
    end

    def example_failed(example)
      super
      controller.apply_fail_color
    end
  end
end

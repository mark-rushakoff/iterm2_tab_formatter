require 'iterm2_tab_formatter/base'
require "iterm2_tab_formatter/version"
require "iterm2_tab_formatter/controller"

class Iterm2TabFormatter
  attr_reader :controller

  def initialize(output)
    super
    colors = {
      suite_start: [128, 128, 128],
      spec_fail: [255, 0, 0],
      suite_pass: [0, 0, 255]
    }
    @controller = Iterm2TabFormatter::Controller.new(colors)
  end

  def start(example_count)
    super
    controller.apply_start_color
  end

  def example_failed(example)
    super
    controller.apply_fail_color
  end

  def example_started(example)
    super

    controller.window_title = example.description
    controller.tab_title = "#{examples.size - 1}/#{example_count}"
  end

  def dump_summary(duration, example_count, failure_count, pending_count)
    controller.apply_pass_color if failure_count == 0 && example_count > 0

    pass_count = example_count - failure_count - pending_count
    controller.tab_title = "#{pass_count}.#{failure_count}F#{pending_count}?"
  end
end

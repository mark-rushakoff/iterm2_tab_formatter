require 'iterm2_tab_formatter/base'
require "iterm2_tab_formatter/version"
require "iterm2_tab_formatter/controller"
require "iterm2_tab_formatter/text_formatter"

class Iterm2TabFormatter
  attr_reader :controller

  def initialize(output)
    super
    colors = {
      suite_start: [128, 128, 128],
      spec_fail: [255, 0, 0],
      suite_pass: [0, 255, 0]
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

    pass_ratio = 1 - (1.0 * failure_count / example_count)
    controller.tab_title = "#{pass_ratio * 100}% passed"

    window_title = Iterm2TabFormatter::TextFormatter.status(failure_count)
    window_title << ' - '
    window_title << Iterm2TabFormatter::TextFormatter.window_title(example_count, failure_count, pending_count)
    window_title << ' - '
    window_title << Iterm2TabFormatter::TextFormatter.duration(duration)
    window_title << ' - Finished at '
    window_title << Iterm2TabFormatter::TextFormatter.finished_at(Time.now)
    controller.window_title = window_title
  end
end

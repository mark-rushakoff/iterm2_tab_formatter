require 'iterm2_tab_formatter/base'
require 'iterm2_tab_formatter/version'
require 'iterm2_tab_formatter/controller'
require 'iterm2_tab_formatter/text_formatter'
require 'iterm2_tab_formatter/color_parse'
require 'iterm2_tab_formatter/rspec_configuration'

class Iterm2TabFormatter
  attr_reader :controller

  def initialize(output)
    super
    colors = {
      suite_start: color(:it2tf_neutral),
      spec_fail: color(:it2tf_fail),
      suite_pass: color(:it2tf_pass)
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

    formatter = Iterm2TabFormatter::TextFormatter.new(
      duration_seconds: duration,
      example_count: example_count,
      failure_count: failure_count,
      pending_count: pending_count,
      finish_time: Time.now
    )

    window_title = formatter.status
    window_title << ' - '
    window_title << formatter.window_title
    window_title << ' - '
    window_title << formatter.duration
    window_title << ' - Finished at '
    window_title << formatter.finished_at
    controller.window_title = window_title
  end

  private
  def color(name)
    Iterm2TabFormatter::color_parse(RSpec.configuration.__send__(name))
  end
end

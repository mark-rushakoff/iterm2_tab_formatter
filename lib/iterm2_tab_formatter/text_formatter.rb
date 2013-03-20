require 'iterm2_tab_formatter/base'
require 'time'

class Iterm2TabFormatter
  class TextFormatter
    def initialize(options)
      @options = options.dup
    end

    def window_title
      window_title = "#{example_count} example"
      window_title << 's' unless example_count == 1

      window_title << ", #{failure_count} failure" if failure_count > 0
      window_title << 's' if failure_count > 1

      window_title << ", #{pending_count} pending" if pending_count > 0

      window_title
    end

    def finished_at
      finish_time.iso8601
    end

    def duration
      text_minutes = (duration_seconds / 60).to_i
      text_seconds = (duration_seconds % 60)

      text = ''
      text << "#{text_minutes}m" if text_minutes > 0
      text << ("%.1fs" % text_seconds)

      text
    end

    def status
      failure_count == 0 ? 'PASS' : 'FAIL'
    end

    private
    %w(
      example_count
      failure_count
      pending_count
      finish_time
      duration_seconds
    ).map(&:to_sym).each do |attr|
      define_method(attr) do
        @options.fetch(attr)
      end
    end
  end
end

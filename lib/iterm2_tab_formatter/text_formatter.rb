require 'iterm2_tab_formatter/base'
require 'time'

class Iterm2TabFormatter
  module TextFormatter
    class << self
      def window_title(example_count, failure_count, pending_count)
        window_title = "#{example_count} example"
        window_title << 's' unless example_count == 1

        window_title << ", #{failure_count} failure" if failure_count > 0
        window_title << 's' if failure_count > 1

        window_title << ", #{pending_count} pending" if pending_count > 0

        window_title
      end

      def finished_at(time)
        time.iso8601
      end

      def duration(seconds)
        text_minutes = (seconds / 60).to_i
        text_seconds = (seconds % 60)

        text = ''
        text << "#{text_minutes}m" if text_minutes > 0
        text << ("%.1fs" % text_seconds)

        text
      end
    end
  end
end

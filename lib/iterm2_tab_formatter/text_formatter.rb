require 'iterm2_tab_formatter/base'

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
    end
  end
end

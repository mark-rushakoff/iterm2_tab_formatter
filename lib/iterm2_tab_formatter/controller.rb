require 'iterm2_escape'

module Iterm2TabFormatter
  class Controller
    def initialize(colors)
      @colors = colors
    end

    def apply_start_color
      Iterm2Escape::Tab.set_color(*@colors.fetch(:suite_start))
    end

    def apply_fail_color
      Iterm2Escape::Tab.set_color(*@colors.fetch(:spec_fail))
    end

    def apply_pass_color
      Iterm2Escape::Tab.set_color(*@colors.fetch(:suite_pass))
    end

    def tab_title=(title)
      Iterm2Escape::Tab.title = title
    end

    def window_title=(title)
      Iterm2Escape::Tab.window_title = title
    end
  end
end

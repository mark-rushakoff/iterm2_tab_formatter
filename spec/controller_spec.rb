require 'spec_helper'
require 'iterm2_tab_formatter/controller'

describe Iterm2TabFormatter::Controller do
  describe 'colors' do
    let(:colors) do
      {
        suite_start: [128, 128, 128],
        spec_fail: [255, 0, 0],
        suite_pass: [0, 0, 255]
      }
    end

    let(:controller) { described_class.new(colors) }

    it 'sets the tab color to suite_start when starting suite' do
      Iterm2Escape::Tab.should_receive(:set_color).with(128, 128, 128)
      controller.apply_start_color
    end

    it 'sets the tab color to spec_fail on fail' do
      Iterm2Escape::Tab.should_receive(:set_color).with(255, 0, 0)
      controller.apply_fail_color
    end

    it 'sets the tab color to suite_pass when suite passed' do
      Iterm2Escape::Tab.should_receive(:set_color).with(0, 0, 255)
      controller.apply_pass_color
    end
  end
end

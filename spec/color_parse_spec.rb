require 'spec_helper'
require 'iterm2_tab_formatter/color_parse'

describe Iterm2TabFormatter do
  describe '.color_parse' do
    ({
      '#000000' => [0, 0, 0],
      '#FF0000' => [255, 0, 0],
      '#00FF00' => [0, 255, 0],
      '#0000FF' => [0, 0, 255],
      '#123456' => [0x12, 0x34, 0x56],
    }).each do |code, values|
      it "correctly parses #{code}" do
        expect(Iterm2TabFormatter.color_parse(code)).to eq(values)
      end
    end

    it 'raises on invalid code' do
      expect {
        Iterm2TabFormatter.color_parse('whatever')
      }.to raise_error(/RRGGBB/)
    end
  end
end

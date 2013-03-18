require 'iterm2_tab_formatter/text_formatter'

describe Iterm2TabFormatter::TextFormatter do
  describe '.window_title' do
    ({
      '1 example' => [1, 0, 0],
      '3 examples' => [3, 0, 0],
      '3 examples, 2 failures' => [3, 2, 0],
      '8 examples, 1 failure, 2 pending' => [8, 1, 2],
      '8 examples, 2 failures, 1 pending' => [8, 2, 1],
      '8 examples, 1 pending' => [8, 0, 1],
      '8 examples, 2 pending' => [8, 0, 2],
    }).each do |expected_message, counts|
      example_count, failure_count, pending_count = counts

      it "is correct for #{example_count}/#{failure_count}/#{pending_count}" do
        expect(described_class.window_title(example_count, failure_count, pending_count)).to eq(expected_message)
      end
    end
  end

  describe '.finished_at' do
    it 'formats as ISO-8601 datetime' do
      date = DateTime.new(2013, 3, 17, 19, 25, 0, '-7')
      expect(described_class.finished_at(date)).to eq('2013-03-17T19:25:00-07:00')
    end
  end

  describe '.duration' do
    it 'correctly prints the time under a minute' do
      expect(described_class.duration(1.1)).to eq('1.1s')
    end
    it 'correctly prints time over a minute' do
      expect(described_class.duration(65)).to eq('1m5.0s')
    end
  end
end

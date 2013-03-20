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
        opts = {example_count: example_count, failure_count: failure_count, pending_count: pending_count}
        formatter = described_class.new(opts)#example_count, failure_count, pending_count)
        expect(formatter.window_title).to eq(expected_message)
      end
    end
  end

  describe '.finished_at' do
    it 'formats as ISO-8601 datetime' do
      date = DateTime.new(2013, 3, 17, 19, 25, 0, '-7')
      formatter = described_class.new(finish_time: date)
      expect(formatter.finished_at).to eq('2013-03-17T19:25:00-07:00')
    end
  end

  describe '.duration' do
    it 'correctly prints the time under a minute' do
      formatter = described_class.new(duration_seconds: 1.1)
      expect(formatter.duration).to eq('1.1s')
    end

    it 'correctly prints time over a minute' do
      formatter = described_class.new(duration_seconds: 65)
      expect(formatter.duration).to eq('1m5.0s')
    end
  end

  describe '.status' do
    it 'is "PASS" when there are 0 failures' do
      formatter = described_class.new(failure_count: 0)
      expect(formatter.status).to eq('PASS')
    end

    it 'is "FAIL" when there are >0 failures' do
      formatter = described_class.new(failure_count: 1)
      expect(formatter.status).to eq('FAIL')
    end
  end
end

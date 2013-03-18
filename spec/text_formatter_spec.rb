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
end
require 'spec_helper'
require 'iterm2_tab_formatter/formatter'

describe Iterm2TabFormatter::Formatter do
  let(:formatter) { described_class.new(nil) }
  let(:controller) { formatter.controller }
  it 'makes a controller when initialized' do
    expect(formatter.controller).to be_an(Iterm2TabFormatter::Controller)
  end

  it 'uses the start color when starting suite' do
    controller.should_receive(:apply_start_color).with(no_args)

    formatter.start(100)
  end

  it 'uses the fail color when a spec fails' do
    controller.should_receive(:apply_fail_color).with(no_args)

    formatter.example_failed(double)
  end
end

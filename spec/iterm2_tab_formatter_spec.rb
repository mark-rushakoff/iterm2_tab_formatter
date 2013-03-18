require 'spec_helper'
require 'iterm2_tab_formatter'

describe Iterm2TabFormatter do
  let(:formatter) { described_class.new(nil).tap { |f| f.stub(:controller).and_return(controller) } }
  let(:controller) { double }

  it 'makes a controller when initialized' do
    expect(described_class.new(nil).controller).to be_an(Iterm2TabFormatter::Controller)
  end

  it 'uses the start color when starting suite' do
    controller.should_receive(:apply_start_color).with(no_args)

    formatter.start(100)
  end

  it 'uses the fail color when a spec fails' do
    controller.should_receive(:apply_fail_color).with(no_args)

    formatter.example_failed(double)
  end

  describe 'at the end of the suite' do
    before do
      controller.stub(:apply_pass_color)
      controller.stub(:tab_title=)
      controller.stub(:window_title=)
    end

    describe 'color' do
      it 'uses the pass color when the suite passes' do
        controller.should_receive(:apply_pass_color).with(no_args)

        formatter.dump_summary(1, 10, 0, 0)
      end

      it 'does not use the pass color when there are failures in the suite' do
        controller.should_not_receive(:apply_pass_color)

        formatter.dump_summary(1, 10, 1, 0)
      end

      it 'does not use the pass color if there were no examples' do
        controller.should_not_receive(:apply_pass_color)

        formatter.dump_summary(1, 0, 0, 0)
      end
    end

    describe 'text' do
      it 'sets the tab title to a summary of the specs' do
        controller.should_receive(:tab_title=).with('87.5% passed')

        formatter.dump_summary(1, 8, 1, 2)
      end

      it 'sets the window title through TextFormatter' do
        Iterm2TabFormatter::TextFormatter.should_receive(:window_title).with(8, 1, 2).and_return('win title')
        controller.should_receive(:window_title=).with('win title')

        formatter.dump_summary(1, 8, 1, 2)
      end
    end
  end

  it 'sets the window title to the description of a spec' do
    example = double("example", description: 'an example description')

    controller.should_receive(:window_title=).with('an example description')
    controller.should_receive(:tab_title=).with('0/100')

    formatter.stub(example_count: 100)
    formatter.example_started(example)
  end
end

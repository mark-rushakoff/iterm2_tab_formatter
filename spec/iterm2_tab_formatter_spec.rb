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

  it 'sets the window title to the description of a spec' do
    example = double("example", description: 'an example description')

    controller.should_receive(:window_title=).with('an example description')
    controller.should_receive(:tab_title=).with('0/100')

    formatter.stub(example_count: 100)
    formatter.example_started(example)
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
        now = Time.now
        Time.should_receive(:now).and_return(now)
        Iterm2TabFormatter::TextFormatter.should_receive(:new).with(
          duration_seconds: 5,
          example_count: 10,
          failure_count: 3,
          pending_count: 4,
          finish_time: now
        ).and_return(double(
          status: 'PASS_OR_FAIL',
          duration: 'the_duration',
          window_title: 'window_title',
          finished_at: 'finish_time'
        ))

        controller.should_receive(:window_title=).with('PASS_OR_FAIL - window_title - the_duration - Finished at finish_time')

        formatter.dump_summary(5, 10, 3, 4)
      end
    end
  end
end

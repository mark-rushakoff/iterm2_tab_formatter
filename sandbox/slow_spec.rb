require 'rspec'
require 'iterm2_tab_formatter/auto'

RSpec.configure do |c|
  c.add_formatter('documentation')
end

describe 'A slow test suite' do
  it 'starts off gray' do
    sleep 1
  end

  it 'turns green if ENV["PASS"] is set' do
    sleep 1
    expect(ENV['PASS'].to_s).not_to eq('')
  end
end

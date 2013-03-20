# Iterm2TabFormatter

[![Build Status](https://travis-ci.org/mark-rushakoff/iterm2_tab_formatter.png)](https://travis-ci.org/mark-rushakoff/iterm2_tab_formatter)
[![Code Climate](https://codeclimate.com/github/mark-rushakoff/iterm2_tab_formatter.png)](https://codeclimate.com/github/mark-rushakoff/iterm2_tab_formatter)

An RSpec2 formatter that uses your iTerm2 tabs' color and titles to inform you of your spec status.

iTerm2 Tab Formatter communicates your RSpec status through your iTerm2 tabs.
By default, here's what it does:
* Tab chrome color:
  * Gray while spec is running/pending
  * Red once a spec has failed
  * Green if all the specs pass
* Tab title:
  * Index of current spec and total number of specs
  * Percentage of specs that passed, after specs finish
* Window title:
  * Full spec name for the current spec
  * Summary, duration, and finish time after specs finish

(iterm2_tab_formatter is in no way affiliated with [iTerm2](https://github.com/gnachman/iTerm2) -- it was just made by a fan.)

## Installation

Add this line to your application's Gemfile:

    gem 'iterm2_tab_formatter'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install iterm2_tab_formatter

## Usage

Just add the following line to your spec_helper.rb file:

    require 'iterm2_tab_formatter/autoload'

And then your iTerm2 tabs will participate in testing too!

If you want to customize your colors:

  RSpec.configure do |c|
    # ugly monochrome
    c.it2tf_neutral = '#7F7F7F' # gray
    c.it2tf_pass = '#FFFFFF' # white
    c.it2tf_fail = '#000000' # black
  end

  require 'iterm2_tab_formatter/autoload' # must be after configuration

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

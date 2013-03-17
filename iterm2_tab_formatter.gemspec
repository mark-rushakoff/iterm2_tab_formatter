# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'iterm2_tab_formatter/version'

Gem::Specification.new do |gem|
  gem.name          = "iterm2_tab_formatter"
  gem.version       = Iterm2TabFormatter::VERSION
  gem.authors       = ["Mark Rushakoff"]
  gem.email         = ["mark.rushakoff@gmail.com"]
  gem.description   = %q{An RSpec2 formatter that uses your iTerm2 tabs' color and titles to inform you of your spec status.}
  gem.summary       = <<-SUMMARY
                        iTerm2 Tab Formatter communicates your RSpec status through your iTerm2 tabs.
                        By default, here's what it does:
                        * Tab chrome color:
                          * Gray while spec is running/pending
                          * Red once a spec has failed
                          * Green if all the specs pass
                        * Tab title:
                          * Index of current spec and total number of specs
                        * Window title:
                          * Full spec name for the current spec
                         SUMMARY
  gem.homepage      = "https://github.com/mark-rushakoff/iterm2_tab_formatter"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency 'iterm2_escape', '~> 1.0'
  gem.add_development_dependency 'rspec', '~> 2.13'
end

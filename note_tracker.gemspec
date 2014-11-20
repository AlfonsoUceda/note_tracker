# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'note_tracker/version'

Gem::Specification.new do |spec|
  spec.name          = "note_tracker"
  spec.version       = NoteTracker::VERSION
  spec.authors       = ["Alfonso Uceda Pompa"]
  spec.email         = ["uceda73@gmail.com"]
  spec.summary       = %q{Track your notes with Pivotal tracker}
  spec.description   = %q{This gem provides the feature to track your notes with pivotal tracker}
  spec.homepage      = "https://github.com/AlfonsoUceda/note_tracker"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"

  spec.add_dependency "tracker_api"
end

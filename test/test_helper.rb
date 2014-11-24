require 'rubygems'
require 'bundler/setup'
require 'minitest/byebug' if ENV['DEBUG']
require 'minitest/autorun'
require 'note_tracker'

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

if ENV['COVERAGE'] == 'true'
  require 'simplecov'
  require 'coveralls'

  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
      SimpleCov::Formatter::HTMLFormatter,
      Coveralls::SimpleCov::Formatter
  ]

  SimpleCov.start do
    command_name 'test'
    add_filter   'test'
  end
end
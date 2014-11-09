$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'minitest/byebug' if ENV['DEBUG']
require 'minitest/autorun'
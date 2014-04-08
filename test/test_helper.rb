ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)

require 'minitest/autorun'
require 'minitest/spec'
require 'rails/test_help'

require 'turn'
# :outline, :progress, :dotted, :pretty, :marshal, :cue
Turn.config.format = :outline
Turn.config.natural = true

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  # Add more helper methods to be used by all tests here...
end

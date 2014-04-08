ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)

require 'minitest/autorun'
require 'minitest/spec'
require 'rails/test_help'
require 'factories'

require 'turn'
# :outline, :progress, :dotted, :pretty, :marshal, :cue
Turn.config.format = :outline
Turn.config.natural = true

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  # Add more helper methods to be used by all tests here...
end

module Minitest::Assertions
  def assert_has_invalid(field, model)
    model.must_be :invalid?
    model.errors[field].must_be :present?
  end
end
ActiveRecord::Base.infect_an_assertion :assert_has_invalid, :must_have_invalid

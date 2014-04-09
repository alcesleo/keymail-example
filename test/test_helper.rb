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
end

class Minitest::Spec
  include ActiveSupport::Testing::Assertions # assert_difference etc...
  include ActiveSupport::Testing::SetupAndTeardown # before, after

  class << self
    alias_method :context, :describe
  end
end

module Minitest::Assertions
  def assert_has_invalid(field, model)
    model.must_be :invalid?
    model.errors[field].must_be :present?
  end
end
ActiveRecord::Base.infect_an_assertion :assert_has_invalid, :must_have_invalid

class Proc
  infect_an_assertion :assert_difference, :must_change
  infect_an_assertion :assert_no_difference, :wont_change
end

class ControllerSpec < Minitest::Spec
  include Rails.application.routes.url_helpers
  include ActionController::TestCase::Behavior

  before do
    @routes = Rails.application.routes
  end
end
Minitest::Spec.register_spec_type(/Controller$/, ControllerSpec)

class Minifacture
  class << self
    def attributes_for(name, attrs={})
      build(name, attrs).attributes
    end
  end
end

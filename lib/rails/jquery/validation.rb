require "rails/jquery/validation/version"
require 'rails/jquery/validation/form_builder.rb'

module Rails
  module Jquery
    module Validation
      # ...
    end
  end
end

# Form Builders
ActionView::Helpers::FormBuilder.send(:include, Rails::Jquery::Validation::FormBuilder) if defined?(::ActionView)
BootstrapForm::FormBuilder.send(:include, Rails::Jquery::Validation::FormBuilder) if defined?(::BootstrapForm)
SimpleForm::FormBuilder.send(:include, Rails::Jquery::Validation::FormBuilder) if defined?(::SimpleForm)
Formtastic::FormBuilder.send(:include, Rails::Jquery::Validation::FormBuilder) if defined?(::Formtastic)

##
# PREDEFINED VALIDATORS
##

# Active Model Validators
Dir[File.dirname(__FILE__) + 'rails/jquery/validation/active_model/*.rb'].each {|file| require file } if defined?(::ActiveModel)

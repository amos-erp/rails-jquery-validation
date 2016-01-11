# Rails::Jquery::Validation

[![Build Status](https://travis-ci.org/amos-erp/rails-jquery-validation.svg)](https://travis-ci.org/amos-erp/rails-jquery-validation)

**NOTE:** This gem is in an early alpha state and a lot of validations are missing. They will be added time after time.

This gem adds the according data-rule-x attributes to your rails form, according to your active record validations, including translations.

The aim is to reuse rails validation rules and i18n messages.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rails-jquery-validation'
```

And then execute:

    $ bundle

### Dependencies

* jQuery Version: https://github.com/jzaefferer/jquery-validation/blob/master/bower.json#L28
* jQuery Validation Plugin: https://github.com/jzaefferer/jquery-validation/#including-it-on-your-page

Note: There are several gems out there which add the jqery validation plugin (also to the asset pipeline).

## Usage

### howitworks

This gem does simply adds `data-rule-x` attributes to your form fields. E.g. if you have a presence validation on a name input field this gem will add `data-rule-required` and `data-msg-required` to your input element with the according values. The error message is built using rails built-in i18n mechanism.

### javascript

This gem does not provide any javascript assets. You are totally free to setup the jQuery Validation Plugin the way you want. Of course you have to add jquery and the jquery validation library first. However, a sample validation initalizer for bootstrap could look like this (initialized in a document ready block or after the form was rendered):

````javascript
$('form[data-validate=true]').validate({
	highlight: function(element) {
      $(element).closest('.form-group').removeClass('has-success').addClass('has-error');
  },
  unhighlight: function(element) {
      $(element).closest('.form-group').removeClass('has-error');
  },
  onfocusout: function(element) {
      this.element(element);
  },
  errorElement: 'span',
  errorClass: 'help-block error-help-block',
  errorPlacement: function(error, element) {
      if (element.parent('.input-group').length || element.prop('type') === 'checkbox' || element.prop('type') === 'radio') {
          error.insertAfter(element.parent());
      } else {
          error.insertAfter(element);
      }
  }
});
````

### validate

This is where the magic happens: simply add `validate: true` to your form or fields (field options will always override form options) and this gem will generate the according data atrributes for the jquery validation plugin:

````html
<%= bootstrap_form_for @model, validate: true do |f| %>
  <div class="panel panel-default">
    <div class="panel-heading">
      <h3 class="panel-title">My model form</h3>
    </div>
    <div class="panel-body">

      <div class="row">
        <div class="col-md-12 col-lg-4">
          <%= f.text_field :name %>
        </div>
        <div class="col-md-12 col-lg-4">
          <!-- Only gets validated if model's context is :iam_admin -> see context -->
          <%= f.email :name, context: :iam_admin %>
        </div>
        <div class="col-sm-12 col-lg-8">
          <!-- Won't be validated -->
          <%= f.text_field :description, validate: false %>
        </div>
      </div><!-- row -->

    </div>
    <div class="panel-footer">
      <%= f.submit class: 'btn btn-primary', id: 'submit-dispatch-type-button' %>
    </div>
    <!-- panel-footer -->
  </div>
<% end %>

````

### context

You can add a context to your form or field so the model validation will only be added if the context on the model and the form/field matches:

````ruby
class MyModel < ActiveRecord::Base
    validates :name, presence: true, context: 'admin'
    validates :description, presence: true, context: 'user'
end

<%= bootstrap_form_for @model, validate: true do |f| %>
	<!-- ... -->
 	<%= f.text_field :name, context: (current_user.admin? ? 'admin' : 'user') %>
  	<%= f.text_field :description, context: (current_user.admin? ? 'admin' : 'user') %>
	<!-- ... -->
<% end %>
````

In the example above, the client side validations for `:name` will only be added if the current user is an 'admin'. `:description` will only be validated if the current user is a normal 'user'.


### conditionals

Conditional validations are not supported since the state before we render the form does not provide us enough informations to render the client side validation rules.

### own validators

If you have your own custom validator, the only thing you have to do is to include a `prepare_jquery_validation_rules` method and return the corresponding data attributes. Example:

````ruby
module MyNameSpace
	module MyPresenceValidator < ActiveModel::Validator
    # ... def validate(record)
		def prepare_jquery_validation_rules(validation_rules, record, attribute, form_options, field_options)
			validation_rules[:rule_required] = true
			validation_rules[:msg_required] = record.errors.full_message(attribute, record.errors.generate_message(attribute, :blank))
		end
	end
end
````

Please feel free to open pull requests for you own validators. I'm thinking about including additional validators so we match all validators (rails and jquery validation side).

## Supported validators

The following list will be extended by the time:

* ActiveModel::NumericalityValidator
* ActiveModel::PresenceValidator
* ActiveModel::LengthValidator

## Form builder support

This gem should support any relevant form builders out there. Currently supported are:

* ActionView
* BootstrapForm
* SimpleForm (not tested)
* Formtastic (not tested)

If you have any other builder feel free to open an issue or better: create a pull request!

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/amos-erp/rails-jquery-validation. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

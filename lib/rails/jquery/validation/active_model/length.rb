module Rails
  module Jquery
    module Validation
      module ActiveModel
        module LengthValidator

          def prepare_jquery_validation_rules(validation_rules, record, attribute, form_options, field_options)
            if options[:minimum].present?
              validation_rules[:rule_minlength] = options[:minimum]
              validation_rules[:msg_minlength] = record.errors.full_message(attribute, record.errors.generate_message(attribute, :too_short, {count: options[:minimum]}))
            end
            if options[:maximum].present?
              validation_rules[:rule_maxlength] = options[:maximum]
              validation_rules[:msg_maxlength] = record.errors.full_message(attribute, record.errors.generate_message(attribute, :too_long, {count: options[:maximum]}))
            end
            if options[:is].present?
              validation_rules[:rule_minlength] = options[:is]
              validation_rules[:rule_maxlength] = options[:is]
              validation_rules[:msg_minlength] = record.errors.full_message(attribute, record.errors.generate_message(attribute, :wrong_length, {count: options[:is]}))
              validation_rules[:msg_maxlength] = record.errors.full_message(attribute, record.errors.generate_message(attribute, :wrong_length, {count: options[:is]}))
            end
            if options[:in].present?
              validation_rules[:rule_minlength] = options[:in].first
              validation_rules[:rule_maxlength] = options[:in].last
              validation_rules[:msg_minlength] = record.errors.full_message(attribute, record.errors.generate_message(attribute, :too_short, {count: options[:in].first}))
              validation_rules[:msg_maxlength] = record.errors.full_message(attribute, record.errors.generate_message(attribute, :too_long, {count: options[:in].last}))
            end
          end

        end
      end
    end
  end
end

ActiveModel::Validations::LengthValidator.send :include, Rails::Jquery::Validation::ActiveModel::LengthValidator

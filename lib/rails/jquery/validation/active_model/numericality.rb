module Rails
  module Jquery
    module Validation
      module ActiveModel
        module NumericalityValidator

          def prepare_jquery_validation_rules(validation_rules, record, attribute, form_options, field_options)
            if options[:greater_than].present?
              validation_rules[:rule_min] = options[:greater_than] + 1
              validation_rules[:msg_min] = record.errors.full_message(attribute, record.errors.generate_message(attribute, :greater_than, {count: options[:greater_than]}))
            end
            if options[:greater_than_or_equal_to].present?
              validation_rules[:rule_min] = options[:greater_than_or_equal_to]
              validation_rules[:msg_min] = record.errors.full_message(attribute, record.errors.generate_message(attribute, :greater_than_or_equal_to, {count: options[:greater_than_or_equal_to]}))
            end
            if options[:equal_to].present?
              validation_rules[:rule_min] = options[:equal_to]
              validation_rules[:rule_max] = options[:equal_to]
              validation_rules[:msg_min] = record.errors.full_message(attribute, record.errors.generate_message(attribute, :equal_to, {count: options[:equal_to]}))
              validation_rules[:msg_max] = record.errors.full_message(attribute, record.errors.generate_message(attribute, :equal_to, {count: options[:equal_to]}))
            end
            if options[:less_than].present?
              validation_rules[:rule_max] = options[:less_than] - 1
              validation_rules[:msg_max] = record.errors.full_message(attribute, record.errors.generate_message(attribute, :less_than, {count: options[:less_than]}))
            end
            if options[:less_than_or_equal_to].present?
              validation_rules[:rule_max] = options[:less_than_or_equal_to]
              validation_rules[:msg_max] = record.errors.full_message(attribute, record.errors.generate_message(attribute, :less_than_or_equal_to, {count: options[:less_than_or_equal_to]}))
            end
            if options[:only_integer].present? and options[:only_integer]
              validation_rules[:rule_digits] = true
              validation_rules[:msg_digits] = record.errors.full_message(attribute, record.errors.generate_message(attribute, :only_integer))
            end
          end

        end
      end
    end
  end
end

ActiveModel::Validations::NumericalityValidator.send :include, Rails::Jquery::Validation::ActiveModel::NumericalityValidator

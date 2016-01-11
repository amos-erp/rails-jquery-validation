module Rails
  module Jquery
    module Validation
      module ActiveModel
        module PresenceValidator

          def prepare_jquery_validation_rules(validation_rules, record, attribute, form_options, field_options)
            validation_rules[:rule_required] = true
            validation_rules[:msg_required] = record.errors.full_message(attribute, record.errors.generate_message(attribute, :blank))
          end

        end
      end
    end
  end
end

ActiveModel::Validations::PresenceValidator.send :include, Rails::Jquery::Validation::ActiveModel::PresenceValidator

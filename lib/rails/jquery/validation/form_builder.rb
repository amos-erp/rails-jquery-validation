module Rails
  module Jquery
    module Validation
      module FormBuilder

        VALIDATION_HELPERS = %w{color_field date_field datetime_field datetime_local_field
          email_field month_field number_field password_field phone_field
          range_field search_field telephone_field text_area text_field time_field
          url_field week_field}

        def self.included(base)
          base.class_eval do

            VALIDATION_HELPERS.each do |method_name|
              with_method_name = "#{method_name}_with_rails_jquery_validation"
              without_method_name = "#{method_name}_without_rails_jquery_validation"

              define_method(with_method_name) do |name, options = {}|
                merged_options = merge_options name, @options, options
                send without_method_name, name, merged_options
              end

              alias_method_chain method_name, :rails_jquery_validation
            end

          end
        end

        def merge_options(field_name, form_options, field_options)
          if form_options[:validate] and (field_options.has_key?(:validate) == false or (field_options.key?(:validate) and field_options[:validate])) and (![:if, :unless].all? { |k| field_options.key? k })
            field_options[:data] ||= {}
            field_options[:data] = determine_validation_rules(@object, field_name, form_options, field_options).merge field_options[:data]
          end
          field_options
        end

        def determine_validation_rules(record, attribute, form_options, field_options)
          validation_rules = {}

          if field_options[:context].present?
            current_context = field_options[:context].to_sym
          elsif form_options[:context].present?
            current_context = form_options[:context].to_sym
          else
            current_context = nil
          end

          record.class.validators_on(attribute).each do | validator |
            if validator.options[:on].nil?
              context_is_valid = true
            elsif validator.options[:on] == :create
              context_is_valid = record.new_record?
            elsif validator.options[:on] == :update
              context_is_valid = !record.new_record?
            else
              context_is_valid = validator.options[:on].eql? current_context
            end

            # Only add validations if the current context is valid and the validator is supported.
            if context_is_valid and validator.class.method_defined? :prepare_jquery_validation_rules
              validator.prepare_jquery_validation_rules validation_rules, record, attribute, form_options, field_options
            end
          end

          validation_rules
        end
        
      end
    end
  end
end

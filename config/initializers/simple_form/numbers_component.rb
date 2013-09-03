# module SimpleForm
#   module Components
#     module JqueryMobile
#       # Add a data-role="fieldcontain" attribute to each input
#       def wrapper_html_options
#         css_classes = input_html_classes.unshift(wrapper_class)
#         css_classes << wrapper_error_class if has_errors?
#         css_classes << disabled_class if disabled?
#         html_options_for(:wrapper, css_classes).tap do |o|
#           o[:'data-role'] = 'fieldcontain' # Add data-role attribute
#         end
#       end
#     end
#   end
# end

module SimpleForm
  module Components
    # Needs to be enabled in order to do automatic lookups
    module Numbers
      # Name of the component method
      def number
        @number ||= begin
          options[:number].to_s.html_safe if options[:number].present?
        end
      end

      # Used when the number is optional
      def has_number?
        number.present?
      end
    end
  end
end

SimpleForm::Inputs::Base.send(:include, SimpleForm::Components::Numbers)
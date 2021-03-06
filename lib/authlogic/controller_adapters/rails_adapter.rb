module Authlogic
  module ControllerAdapters
    # = Rails Adapter
    #
    # Adapts authlogic to work with rails. The point is to close the gap between what authlogic expects and what the rails controller object
    # provides. Similar to how ActiveRecord has an adapter for MySQL, PostgreSQL, SQLite, etc.
    class RailsAdapter < AbstractAdapter
      def authenticate_with_http_basic(&block)
        controller.authenticate_with_http_basic(&block)
      end
      
      def cookies
        controller.send(:cookies)
      end
      
      def request_content_type
        request.format.to_s
      end
      
      # = Rails Implementation
      #
      # Lets Authlogic know about the controller object via a before filter, AKA "activates" authlogic.
      module RailsImplementation
        def self.included(klass) # :nodoc:
          klass.prepend_before_filter :activate_authlogic
        end

        private
          def activate_authlogic
            Authlogic::Session::Base.controller = RailsAdapter.new(self)
          end
      end
    end
  end
end

ActionController::Base.send(:include, Authlogic::ControllerAdapters::RailsAdapter::RailsImplementation)
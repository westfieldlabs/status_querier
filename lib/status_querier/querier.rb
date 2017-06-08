require 'active_support/concern'
require 'where-or'

# HACK: Override 'structurally_compatible_for_or?' from the 'where-or' gem
# to permit potentially invalid combinations.
ActiveSupport.on_load(:active_record) do
  module ActiveRecord
    module QueryMethods

      def structurally_compatible_for_or_with_suppressed?(other)
        return true if structurally_compatible_for_or_without_suppressed?(other)
        Rails.logger.warn "Combining potentially ambiguous conditions. Consider reviewing the scopes and SQL statements involved." if Rails.env.development? || Rails.env.test?
        true
      end

      alias_method_chain :structurally_compatible_for_or?, :suppressed

    end
  end
end


module StatusQuerier
  module Querier
    extend ActiveSupport::Concern

    included do
      def self.with_any_statuses(statuses)
        statuses = statuses.map(&:to_sym)
        return all if statuses.include?(StatusQuerier::ALL)
        (statuses.size > 0) ? Query.new.combine_scopes(self, statuses) : default_listing
      end
    end

    private

    class Query
      def combine_scopes(model_class, statuses, with = :or)
        statuses.map { |status| with_resource_status(model_class, status) }.reduce(with)
      end

      def with_resource_status(model_class, status)
        unless StatusQuerier::SUPPORTED_STATUSES.include?(status)
          raise Error::InvalidStatus, "Status needs to be #{StatusQuerier::SUPPORTED_STATUSES.join(', ')}"
        end

        unless model_class.respond_to?(status)
          raise ::NotImplementedError
        end

        model_class.send(status)
      end
    end
  end
end

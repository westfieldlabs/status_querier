require 'status_querier/version'
require 'status_querier/querier'

module StatusQuerier
  SUPPORTED_STATUSES = %i(pending preview live expired invalid disabled).freeze
  ALL = :all
  WHITELIST = (SUPPORTED_STATUSES + [ALL]).freeze
  DEFAULT_LISTING = :default_listing

  module Error
    class InvalidStatus < ArgumentError; end
  end

  def self.allow?(status)
    WHITELIST.include?(status)
  end
end


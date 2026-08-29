#!/usr/bin/env ruby

require 'featurevisor'
require 'json'
require 'net/http'

DATAFILE_URL = 'https://featurevisor-example-cloudflare.pages.dev/production/featurevisor-sdk-v3.json'.freeze

uri = URI(DATAFILE_URL)
response = Net::HTTP.start(
  uri.host,
  uri.port,
  use_ssl: uri.scheme == 'https',
  open_timeout: 10,
  read_timeout: 10
) { |http| http.get(uri.request_uri, { 'Accept' => 'application/json' }) }

unless response.is_a?(Net::HTTPSuccess)
  raise "Datafile request failed with HTTP #{response.code}"
end

f = Featurevisor.create_featurevisor(
  datafile: JSON.parse(response.body, symbolize_names: true),
  log_level: 'error',
  context: {
    userId: 'customer-123',
    country: 'nl',
    locale: 'nl-NL',
    accountPlan: 'pro'
  }
)

begin
  commerce_enabled = f.is_enabled('commerce_platform')
  checkout_variation = f.get_variation('checkout_experience')
  max_items = f.get_variable_integer('checkout_experience', 'max_items')
  payment_methods = f.get_variable_array('checkout_experience', 'payment_methods')
  endpoints = f.get_variable_object('serviceEndpoints')
  support_contact = f.get_variable_string('supportContact')

  puts "Commerce platform enabled: #{commerce_enabled}"
  puts "Checkout variation: #{checkout_variation || 'unavailable'}"
  puts "Maximum checkout items: #{max_items || 'unavailable'}"
  puts "Payment methods: #{payment_methods || []}"
  puts "Service endpoint: #{endpoints[:baseUrl]} " \
       "(timeout: #{endpoints[:timeoutMs]} ms, retries: #{endpoints[:retries]})"
  puts "Support contact: #{support_contact || 'unavailable'}"
ensure
  f.close
end

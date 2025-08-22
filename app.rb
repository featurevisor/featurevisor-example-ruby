#!/usr/bin/env ruby

require 'featurevisor'
require 'net/http'
require 'json'

def symbolize_keys(obj)
  case obj
  when Hash
    obj.transform_keys(&:to_sym).transform_values { |v| symbolize_keys(v) }
  when Array
    obj.map { |v| symbolize_keys(v) }
  else
    obj
  end
end

##
# Initialize Featurevisor
#
datafile_url = "https://featurevisor-example-cloudflare.pages.dev/production/featurevisor-tag-all.json"

# Fetch the datafile
response = Net::HTTP.get(URI(datafile_url))
datafile_content = JSON.parse(response)
symbolized_datafile = symbolize_keys(datafile_content) # @TODO: this shouldn't be required

# Create Featurevisor instance
featurevisor = Featurevisor.create_instance(
  datafile: symbolized_datafile,
)

# Get the feature flag value
feature_flag_value = featurevisor.is_enabled("my_feature")

# Print results to terminal
puts "Feature flag 'my_feature' is enabled: #{feature_flag_value}"

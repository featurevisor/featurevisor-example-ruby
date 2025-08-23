#!/usr/bin/env ruby

require 'featurevisor'
require 'net/http'
require 'json'

##
# Fetch datafile
#
datafile_url = "https://featurevisor-example-cloudflare.pages.dev/production/featurevisor-tag-all.json"
response = Net::HTTP.get(URI(datafile_url))
datafile_content = JSON.parse(response, symbolize_names: true)

# Create Featurevisor instance
f = Featurevisor.create_instance(
  datafile: datafile_content,
)

# Get the feature flag value
feature_flag_value = f.is_enabled("my_feature")

# Print results to terminal
puts "Feature flag 'my_feature' is enabled: #{feature_flag_value}"

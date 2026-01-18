#!/usr/bin/env ruby

require 'net/http'
require 'uri'
require 'json'

def get_request(url)
  uri = URI.parse(url)
  response = Net::HTTP.get_response(uri)

  # Print status
  puts "Response status: #{response.code} #{response.message}"

  # Blank line exactly once
  puts "Response body:"

  # Parse JSON
  json_body = JSON.parse(response.body)

  # Pretty print JSON without extra blank lines
  puts JSON.pretty_generate(json_body)
end

#!/usr/bin/env ruby

require 'net/http'
require 'uri'
require 'json'

def post_request(url, body_params = {})
  uri = URI.parse(url)
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = uri.scheme == 'https'

  request = Net::HTTP::Post.new(uri.path, { 'Content-Type' => 'application/json' })
  request.body = body_params.to_json unless body_params.empty?

  response = http.request(request)

  # Print status
  puts "Response status: #{response.code} #{response.message}"

  # Print body
  puts "Response body:"

  begin
    parsed_body = JSON.parse(response.body)
    if parsed_body.empty?
      puts '{}'  # compact JSON for empty object
    else
      puts JSON.pretty_generate(parsed_body)
    end
  rescue JSON::ParserError
    puts response.body
  end
end

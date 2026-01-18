#!/usr/bin/env ruby

require 'open-uri'
require 'fileutils'
require 'uri'

# Check arguments
if ARGV.length != 2
  puts 'Usage: 9-download_file.rb URL LOCAL_FILE_PATH'
  exit
end

url, local_path = ARGV

begin
  puts "Downloading file from #{url}…"

  # Open the URL and read content
  URI.open(url) do |remote_file|
    # Ensure directory exists
    FileUtils.mkdir_p(File.dirname(local_path))
    # Write to local file
    File.open(local_path, 'wb') do |file|
      file.write(remote_file.read)
    end
  end

  puts "File downloaded and saved to #{local_path}."
rescue StandardError => e
  puts "Error downloading file: #{e.message}"
end

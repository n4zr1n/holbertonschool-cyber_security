#!/usr/bin/env ruby

def print_arguments
  if ARGV.empty?
    puts 'No arguments provided.'
  else
    ARGV.each { |arg| puts arg }
  end
end

#!/usr/bin/env ruby

def print_arguments
  if ARGV.empty?
    puts 'No arguments provided.'
  else
    puts 'Arguments:'
    puts
    ARGV.each { |arg| puts arg }
  end
end

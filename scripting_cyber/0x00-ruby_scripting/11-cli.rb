#!/usr/bin/env ruby

require 'optparse'
require 'fileutils'

TASK_FILE = 'tasks.txt'

FileUtils.touch(TASK_FILE) unless File.exist?(TASK_FILE)

options = {}

parser = OptionParser.new do |opts|
  opts.banner = "Usage: cli.rb [options]"

  opts.on("-a", "--add TASK", "Add a new task") do |task|
    options[:add] = task
  end

  opts.on("-l", "--list", "List all tasks") do
    options[:list] = true
  end

  opts.on("-r", "--remove INDEX", Integer, "Remove a task by index") do |index|
    options[:remove] = index
  end

  opts.on("-h", "--help", "Show help") do
    puts opts
    exit
  end
end

parser.parse!

# ADD
if options[:add]
  File.open(TASK_FILE, 'a') { |f| f.puts options[:add] }
  puts "Task '#{options[:add]}' added."
  exit
end

# LIST
if options[:list]
  tasks = File.readlines(TASK_FILE, chomp: true)

  puts "Tasks:"
  tasks.each_with_index do |task, index|
    puts "#{index + 1}. #{task}"
  end
  exit
end

# REMOVE
if options[:remove]
  tasks = File.readlines(TASK_FILE, chomp: true)
  index = options[:remove]

  if index < 1 || index > tasks.length
    puts "Invalid index."
    exit
  end

  removed = tasks.delete_at(index - 1)
  File.open(TASK_FILE, 'w') { |f| tasks.each { |t| f.puts t } }
  puts "Task '#{removed}' removed."
  exit
end

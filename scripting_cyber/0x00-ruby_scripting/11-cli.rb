#!/usr/bin/env ruby

require 'optparse'
require 'fileutils'

TASK_FILE = 'tasks.txt'

# Ensure the tasks file exists
FileUtils.touch(TASK_FILE) unless File.exist?(TASK_FILE)

options = {}
OptionParser.new do |opts|
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
end.parse!

# Handle add
if options[:add]
  File.open(TASK_FILE, 'a') { |f| f.puts options[:add] }
  puts "Task '#{options[:add]}' added."
  exit
end

# Handle list
if options[:list]
  tasks = File.readlines(TASK_FILE, chomp: true)
  tasks.each { |t| puts t }
  exit
end

# Handle remove
if options[:remove]
  index = options[:remove]
  tasks = File.readlines(TASK_FILE, chomp: true)
  if index < 1 || index > tasks.length
    puts "Invalid index."
    exit
  end
  removed_task = tasks.delete_at(index - 1)
  File.open(TASK_FILE, 'w') { |f| tasks.each { |t| f.puts t } }
  puts "Task '#{removed_task}' removed."
  exit
end

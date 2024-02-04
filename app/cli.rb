require 'thor'
require_relative '../lib/util'
require_relative '../lib/command'

class Cli < Thor
  class_option :db, default: :gdbm

  desc 'sequential-write COUNT', 'write continuously'
  def sequential_write(count = 500)
    ::Command.new(options[:db]).sequential_write(count)
  end
end

if __FILE__ == $0
  Cli.start(ARGV)
end

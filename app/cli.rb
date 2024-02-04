require 'thor'
require_relative '../lib/util'
require_relative '../lib/command'

def init
  ::Command.new(options[:db], options[:with_bench])
end

class Cli < Thor
  class_option :db, default: :gdbm
  class_option :with_bench, type: :boolean, default: false

  desc 'sequential-write COUNT', 'write continuously'
  def sequential_write(count = 500)
    init.sequential_write(count)
  end
end

if __FILE__ == $0
  Cli.start(ARGV)
end

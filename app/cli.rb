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

  desc 'random-read COUNT', 'random read'
  method_options read_once: :boolean
  def random_read(count = 500)
    init.random_read(count, read_once: options[:read_once])
  end
end

if __FILE__ == $0
  Cli.start(ARGV)
end

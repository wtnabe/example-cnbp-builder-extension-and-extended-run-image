require_relative '../store'
require 'gdbm'
require 'forwardable'

module Store
  class GDBM
    include Store
    extend Forwardable

    def initialize
      @db = ::GDBM.new(db_file)
    end

    def db_file
      File.join(db_dir, 'gdbm.db')
    end

    def method_missing(name, *args)
      @db.send name, *args
    end
  end
end

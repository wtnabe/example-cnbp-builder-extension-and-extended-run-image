require_relative '../store'
require 'dbm'
require 'forwardable'

module Store
  class DBM
    include Store
    extend Forwardable

    def initialize
      @db = ::DBM.new(db_file)
    end

    def db_file
      File.join(db_dir, 'dbm')
    end

    def method_missing(name, *args)
      @db.send name, *args
    end
  end
end

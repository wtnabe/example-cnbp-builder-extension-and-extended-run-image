require_relative '../store'
require 'rocksdb'
require 'forwardable'

module Store
  class RocksDB
    include Store
    extend Forwardable

    def_delegators :@db, :put

    def initialize
      @db = ::RocksDB.open(db_file)
    end

    def db_file
      File.join(db_dir, 'rocksdb.db')
    end
    
    alias_method :[]=, :put

    def method_missing(name, *args)
      @db.send name, *args
    end
  end
end


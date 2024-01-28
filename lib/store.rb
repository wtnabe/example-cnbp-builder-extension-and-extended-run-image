module Store
  #
  # @return [String]
  #
  def db_dir
    File.join(__dir__, '..', 'db')
  end

  def self.init(type)
    case type
    when :dbm
      require_relative './stores/dbm'
      Store::DBM.new
    when :gdbm
      require_relative './stores/gdbm'
      Store::GDBM.new
    when :rocksdb
      require_relative './stores/rocksdb'
      Store::RocksDB.new
    end
  end
end

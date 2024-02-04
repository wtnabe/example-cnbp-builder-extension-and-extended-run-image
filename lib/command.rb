require 'benchmark'
require_relative './store'
require_relative './util'

class Command
  CONTENT_SIZE = 1 * Util::KILO
  COUNT_UNIT = 1 * Util::KILO
  
  #
  # @param [String] type
  #
  def initialize(type = :gdbm)
    @type = type.to_s.sub(/\A:+/, '').to_sym
    @store = Store.init(type)
  end

  #
  # @param [String|Interger] count
  # @return [Interger]
  #
  def calc_count(count = "500")
    count.to_i * COUNT_UNIT
  end

  #
  # @param [Interger] count
  # @return [String]
  #
  def starting_message(count)
    {
      type: @type,
      content_size: (CONTENT_SIZE / Util::KILO).to_s + ' KB',
      count: count,
      amount: (Util::KILO * count / Util::MEGA.to_f).to_s + ' MB'
    }.to_s
  end

  #
  # @param [Interger] count
  #
  def sequential_write(count)
    content = Util::random_contents(CONTENT_SIZE)
    puts starting_message(calc_count(count))
    
    (1..calc_count(count)).each { |e|
      @store[e.to_s] = content
    }
  end
end

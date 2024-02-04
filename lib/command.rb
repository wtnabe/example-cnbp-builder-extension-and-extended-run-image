require 'benchmark'
require_relative './store'
require_relative './util'

class Command
  CONTENT_SIZE = 1 * Util::KILO
  COUNT_UNIT = 1 * Util::KILO
  
  #
  # @param [String] type
  #
  def initialize(type = :gdbm, with_bench = false)
    @with_bench = with_bench
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
  # @param [Proc] block
  #
  def bench(count, &block)
    previous = caller(1, 1).first
    message_base = "#{@type}, #{count}"
    message =
      if previous.split(':').first == __FILE__ && previous =~ /`(.+)'\z/
        "#{$1}: #{message_base}"
      else
        message_base
      end

    Benchmark.benchmark(message) do |x|
      x.report do
        block.call
      end
    end
  end

  #
  # @param [Interger] count
  # @param [Boolean] with_bench
  #
  def sequential_write(count, with_bench = @with_bench)
    content = Util::random_contents(CONTENT_SIZE)

    code = -> {
      (1..calc_count(count)).each { |e|
        @store[e.to_s] = content
      }
    }

    if with_bench
      bench(count) do
        code.call
      end
    else
      puts starting_message(calc_count(count))
      code.call
    end
  end
end

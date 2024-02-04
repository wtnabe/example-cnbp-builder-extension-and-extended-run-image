module Util
  KILO = 1024
  MEGA = KILO ** 2
  DEFAULT_COUNT = 500 * KILO

  #
  # @param [Integer] size
  # @return [String]
  #
  def random_contents(size = 1 * KILO)
    (1..size).to_a.map { |e|
      Random.rand(32..126).chr
    }.join
  end
  module_function :random_contents
end

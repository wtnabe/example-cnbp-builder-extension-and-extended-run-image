require_relative '../lib/store'

KILO = 1024
MEGA = KILO ** 2

#
# @param [Symbol] type
# @param [Integer] size
#
def main(type, size)
  store = Store.init(type.to_sym)
  
  (1..size).each { |e|
    store[e.to_s] = random_1kb_content
  }
end

def clean(type)
  store = Store.init(type.to_sym)
  store.clear
end

#
# @return [String]
#
def random_1kb_content
  (1..KILO).to_a.map { |e|
    Random.rand(32..126).chr
  }.join
end

if __FILE__ == $0
  type = (ARGV[0] || :gdbm).to_s.sub(/\A:+/, '')
  size = eval(ARGV[1].to_s) || 500 * KILO

  puts({ type: type, size: "#{size / KILO} KB" }.to_s)
  
  main(type, size)
end

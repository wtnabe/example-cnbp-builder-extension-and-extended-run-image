require_relative '../lib/store'
require_relative '../lib/util'

DEFAULT_STORE_COUNT = 500

#
# @param [Symbol] type
# @param [Integer] count
#
def main(type, count)
  store = Store.init(type.to_sym)
  
  (1..count).each { |e|
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
  (1..Util::KILO).to_a.map { |e|
    Random.rand(32..126).chr
  }.join
end

if __FILE__ == $0
  type = (ARGV[0] || :gdbm).to_s.sub(/\A:+/, '')
  count = (eval(ARGV[1].to_s) || DEFAULT_STORE_COUNT) * Util::KILO

  puts({ type: type, count: count, size: (Util::KILO * count / Util::MEGA.to_f).to_s + ' MB' })
  
  main(type, count)
end

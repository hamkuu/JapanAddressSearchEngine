require "json"
require "set"

japan_addresses = JSON.parse(File.read("data/ken_all.json"))

bigram_map = JSON.parse(File.read("data/bigram_map.json"))

loop do
  puts "Input two Kanji for address query:"
  input_text = gets
  query_text = input_text.strip

  break if query_text == "exit"

  if query_text.length != 2
    puts "expect only two Kanji"
    next
  end

  for row in bigram_map[query_text]
    puts japan_addresses[row.to_s].inspect
  end
end

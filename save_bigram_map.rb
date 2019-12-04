require "csv"
require "set"
require "json"

class String
  def to_ngram(n)
    self.each_char
        .each_cons(n)
        .map { |chars| chars.join }
  end
end

def make_bigram_map(csv_row_index, address_string)
  for bigram in address_string.to_ngram(2)
    if $bigram_map.has_key?(bigram)
      $bigram_map[bigram].add(csv_row_index)
    else
      $bigram_map.store(bigram, Set[csv_row_index])
    end
  end
end

$bigram_map = {}
$csv_row_index = 0

CSV.foreach("data/KEN_ALL.CSV", headers: false, encoding: "Shift_JIS:UTF-8") do |row|
  # puts row.inspect

  perfecture = row[6]
  city_ward = row[7]
  street = row[8]

  make_bigram_map($csv_row_index, perfecture)
  make_bigram_map($csv_row_index, city_ward)
  make_bigram_map($csv_row_index, street)

  $csv_row_index += 1
end

$bigram_map.each_key do |key|
  $bigram_map[key] = $bigram_map[key].to_a
end

File.open("data/bigram_map.json", "w") do |f|
  f.write($bigram_map.to_json)
end

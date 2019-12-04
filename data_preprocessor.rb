require "csv"
require "set"
require "json"

class DataPreprocessor
  public

  def initialize
    @bigram_map = {}
  end

  def convert_address_csv_to_json
    japan_address_hash = {}

    csv_file = CSV.open("data/KEN_ALL.CSV", headers: false, encoding: "Shift_JIS:UTF-8")
    csv_file.each do |csv_row|
      japan_address_hash.store(csv_file.lineno - 1, csv_row)
    end

    File.open("data/ken_all.json", "w") do |f|
      f.write(japan_address_hash.to_json)
    end
  end

  def generate_bigram_map
    japan_addresses = JSON.parse(File.read("data/ken_all.json"))

    japan_addresses.length.times do |index|
      address_record = japan_addresses[index.to_s]

      perfecture = address_record[6]
      city_ward = address_record[7]
      street = address_record[8]

      make_bigram_map(index, perfecture)
      make_bigram_map(index, city_ward)
      make_bigram_map(index, street)
    end

    @bigram_map.each_key do |key|
      @bigram_map[key] = @bigram_map[key].to_a
    end

    File.open("data/bigram_map.json", "w") do |f|
      f.write(@bigram_map.to_json)
    end
  end

  private

  def make_bigram_map(csv_row_index, address_string)
    for bigram in address_string.to_ngram(2)
      if @bigram_map.has_key?(bigram)
        @bigram_map[bigram].add(csv_row_index)
      else
        @bigram_map.store(bigram, Set[csv_row_index])
      end
    end
  end
end

class String
  def to_ngram(n)
    self.each_char
        .each_cons(n)
        .map { |chars| chars.join }
  end
end

## Usage
# myDataPreprocessor = DataPreprocessor.new
# myDataPreprocessor.convert_address_csv_to_json
# myDataPreprocessor.generate_bigram_map

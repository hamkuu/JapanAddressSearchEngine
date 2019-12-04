require "csv"
require "json"

japan_address_hash = {}

csv_file = CSV.open("KEN_ALL.CSV", headers: false, encoding: "Shift_JIS:UTF-8")
csv_file.each do |csv_row|
  japan_address_hash.store(csv_file.lineno, csv_row)
end

File.open("data/ken_all.json", "w") do |f|
  f.write(japan_address_hash.to_json)
end

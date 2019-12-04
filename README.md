# JapanAddressSearchEngine

Using 2-Gram Algorithm

## Data Preparation

1. Get raw address data in CSV format

   - Download from http://www.post.japanpost.jp/zipcode/dl/kogaki/zip/ken_all.zip
   - Save file under `/data` as `KEN_ALL.CSV`

2. Convert original CSV format into JSON format

```
myDataPreprocessor = DataPreprocessor.new
myDataPreprocessor.convert_address_csv_to_json
```

related json data will be saved under `/data` as `ken_all.json`

3. Generate 2-Gram hash map

```
myDataPreprocessor = DataPreprocessor.new
myDataPreprocessor.generate_bigram_map
```

2-Gram hash map will be saved under `/data` as `bigram_map.json`

## Start Search Engine in Command Mode

```
myAddressSearchEngine = AddressSearchEngine.new
myAddressSearchEngine.start
```

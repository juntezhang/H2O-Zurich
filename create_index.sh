curl -XPUT es-search-1.internal-local.ch/poi_fountains -H 'Content-Type: application/json' -d '
{
   "settings":{
      "number_of_shards":1
   },
   "mappings":{
      "_doc":{
         "properties":{
            "description":{
               "type":"text",
               "fields":{
                  "keyword":{
                     "type":"keyword",
                     "ignore_above":256
                  }
               }
            },
            "historic_year":{
               "type":"long"
            },
            "location":{
               "type":"geo_point"
            },
            "number":{
               "type":"long"
            },
            "title":{
               "type":"text",
               "fields":{
                  "keyword":{
                     "type":"keyword",
                     "ignore_above":256
                  }
               }
            },
            "type":{
               "type":"text",
               "fields":{
                  "keyword":{
                     "type":"keyword",
                     "ignore_above":256
                  }
               }
            }
         }
      }
   }
}'


cat ./data/brunnen.json | jq -c '[.features[] | {_id: .properties.objectid|tostring, number: .properties.nummer|tonumber, location: .geometry.coordinates, historic_year: .properties.historisches_baujahr, type: .properties.wasserart_txt, title: .properties.brunnenart_txt, description: .properties.bezeichnung}] | .[]' > ./data/zurich.data

while read p; do
  index_id=`echo $p | cut -d ',' -f 1 | tr -d '{'`
  echo {\"index\":{$index_id}}
  echo $p | sed -e "s/$index_id,//"
done <./data/zurich.data > ./data/index.data

curl -XPOST es-search-1.internal-local.ch/poi_fountains/_doc/_bulk --data-binary @./data/index.data -H "Content-Type: application/x-ndjson"


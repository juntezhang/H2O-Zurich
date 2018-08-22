# fountains near casa ferlin
curl -s -XGET 'http://es-search-1.internal-local.ch/poi_fountains/_search' -H 'Content-Type: application/json' -d '
{
  "sort": [
    {
      "_geo_distance": {
        "location": [
          47.379801,
          8.543377
        ],
        "order": "asc",
        "unit": "m",
        "mode": "min",
        "distance_type": "arc"
      }
    }
  ],
  "query": {
    "bool": {
      "must": {
        "match_all": {}
      },
      "filter": {
        "geo_distance": {
          "distance": "1000m",
          "location": {
            "lat": 47.379801,
            "lon": 8.543377
          }
        }
      }
    }
  }
}' | jq '.hits.hits[] | {doc: ._source, sort: .sort}' | jq -s

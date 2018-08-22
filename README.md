# "H2O Zurich" 

Inspired by http://skyplan.ch/maps/zurich-water/ and the hot weather, this little project creates an Elasticsearch index based on public data of all 1,200 fountains in Zurich with high quality water. Some of these fountains may even be part of a bigger monument or sculpture. In any way, these could be interesting seasonal (i.e. Summer) POIs for Zurich. Public data set is available for Bern as well, see https://opendata.swiss/en/

  - `create_index.sh` transforms the data and creates an Elasticsearch index.
  - `query.sh` consist of a query template that in this case retrieves the closest fountains near Casa Ferlin in Zurich, not that I am suggesting to save on drinks there...
  
We could load these as regular POIs via MongoDB and then in Solr as we do now with ATMs.
 
Use-case primarily for mobile. It could be another reason to open the apps during hot summer days in Zurich ;-).

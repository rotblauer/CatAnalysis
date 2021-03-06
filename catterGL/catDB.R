library(optparse)
library(jsonlite)
library(maps)
library(maptools)
library(dplyr)
library(mongolite)

# https://spark.apache.org/docs/latest/sparkr.html
option_list = list(
  make_option(
    c("-i", "--input"),
    type = "character",
    default = "/Users/Kitty/tdata/master.json.gz",
    help = "new-line delimited json.gz file of catTracks",
    metavar = "character"
  ),
  make_option(
    c("-o", "--outputDir"),
    type = "character",
    help = "output directory",
    default = "./parsed/",
    metavar = "character"
  )
)

# loc <- stream_in(file(opt$input), pagesize = 2000000)
# > use Cats
# switched to db Cats
# > show collections
# cats
# > db.cats.drop()
# true
# >

# https://datascienceplus.com/using-mongodb-with-r/

m2 = mongo(collection = "cats", db = "Cats") # create connection, database and collection
# m2$drop()


opt_parser = OptionParser(option_list = option_list)
opt = parse_args(opt_parser)
print(opt)

dir.create(opt$outputDir)
idx = m2$count()
print(paste0(idx, " total cats"))

scan = 0
con_in <-
  file(opt$input)

stream_in(
  con_in,
  handler = function(df) {
    scan <<- scan + nrow(df$properties)
    if (scan >= idx) {
      loc = do.call(rbind.data.frame, df$geometry$coordinates)
      colnames(loc) = c("lon", "lat")
      loc$uuid = df$properties$UUID
      loc$date = as.Date(df$properties$Time)
      loc$name = df$properties$Name
      loc$activity = df$properties$Activity
      loc$speed = df$properties$Speed
      loc$accuracy = df$properties$Accuracy
      loc$elevation = df$properties$Elevation
      loc$pressure = df$properties$Pressure
      loc$time = df$properties$Time
      loc$index = m2$count():m2$count() + nrow(loc)
      m2$insert(loc)
    } else{
      print(paste0("skipping ", scan))
    }
  },
  pagesize = 500000
)

m2$index(add = '{"name" : 1, "accuracy" : 1, "lon" : 1, "lat" : 1, "activity" : 1}')

#
# length(my_collection$distinct("name"))
# length(my_collection$distinct("activity"))
#
# query1 = my_collection$find('{"name" : "Rye8", "activity" : "Running" }')


# > min(query1$lon)
# [1] -90.30376
# > min(query1$lat)
# [1] 38.63027
# > max(query1$lon)
# [1] -90.26455
# > max(query1$lat)
# [1] 38.64781

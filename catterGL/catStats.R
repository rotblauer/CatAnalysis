library(optparse)
library(jsonlite)
library(maps)
library(maptools)
library(dplyr)

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



opt_parser = OptionParser(option_list = option_list)
opt = parse_args(opt_parser)
print(opt)

dir.create(opt$outputDir)

mapsToCount = c("state", "county", "world")

getOverlappingIDs <- function(pointsSP, map) {
  # Prepare SpatialPolygons object with one SpatialPolygon
  mapP <- map(map,
              fill = TRUE,
              col = "transparent",
              plot = FALSE)
  IDs <- sapply(strsplit(mapP$names, ":"), function(x)
    x[1])
  map_sp <- map2SpatialPolygons(mapP,
                                IDs = IDs,
                                proj4string = CRS("+proj=longlat +datum=WGS84"))
  
  # Use 'over' to get _indices_ of the Polygons object containing each point
  indices <- over(pointsSP, map_sp)
  
  # Return the state names of the Polygons object containing each point
  names <- sapply(map_sp@polygons, function(x)
    x@ID)
  
  names[indices]
  # stri_trans_totitle(stateNames[indices])
}




summarizeCount <- function(type, names) {
  perType = as.data.frame(table(names))
  colnames(perType) = c("VARIABLE", "COUNT")
  perType$TYPE = type
  perType$VARIABLE = as.character(perType$VARIABLE)
  return(perType)
}

# perState$count=log10(perState$count)




con_in <-
  file(opt$input)
tmp <- paste0(opt$outputDir, "collapsed.txt")
con_out <- file(tmp, open = "wb")

# loc <- stream_in(file(opt$input), pagesize = 2000000)
# df=loc

stream_in(
  con_in,
  handler = function(df) {
    loc = do.call(rbind.data.frame, df$geometry$coordinates)
    
    colnames(loc) = c("lon", "lat")
    loc$name = df$properties$Name
    loc$activity = df$properties$Activity
    
    print(colnames(loc))
    
    
    pointsSP <- SpatialPoints(loc[, c(1, 2)],
                              proj4string = CRS("+proj=longlat +datum=WGS84"))
    
    
    countedIds = data.frame()
    for (map in mapsToCount) {
      countedIdsType = summarizeCount(map, getOverlappingIDs(pointsSP = pointsSP , map = map))
      countedIds = rbind(countedIds, countedIdsType)
    }
    # print(loc$activity)
    
    activitiesToCount = loc[which(nchar(loc$activity) > 0), "activity"]
    if (length(activitiesToCount) > 0) {
      # print(activitiesToCount)
      countedActivities = summarizeCount("activity", activitiesToCount)
      countedIds = rbind(countedIds, countedActivities)
      
      countedActivitiesCat = summarizeCount("name-activity", apply(loc[, c("name", "activity")] , 1 , paste , collapse = "-"))
      countedIds = rbind(countedIds, countedActivitiesCat)
      # print(countedIds)
      loc$DateDay = cut(as.Date(df$properties$Time), "day")
      countedActivitiesCatDate = summarizeCount("name-activity--day", apply(loc[, c("name", "activity", "DateDay")] , 1 , paste , collapse = "-"))
      countedIds = rbind(countedIds, countedActivitiesCatDate)
    }
    
    namesToCount = loc[which(nchar(loc$name) > 0), "name"]
    if (length(namesToCount) > 0) {
      countedNames = summarizeCount("name", namesToCount)
      countedIds = rbind(countedIds, countedNames)
    }
    
    
    stream_out(countedIds, con_out, pagesize = 100)
    
    # loc$speed = df$properties$Speed
    # loc$accuracy = df$properties$Accuracy
    # loc$elevation = df$properties$Elevation
    # loc$pressure = df$properties$Pressure
    # loc$time = df$properties$Time
    # loc_gc <-
    #   filter(loc, lat < 38.793865 &
    #            lat > 38.508583) %>% filter(lon > -90.533524 &
    #                                          lon < -90.051498)
    # save(loc_gc, file = paste0(tmp, "_", format(Sys.time(), "%Y%m%d_%H%M%S"), "col.Rdata"))
    
  },
  pagesize = 1000000
)
close(con_out)


# loc <- stream_in(file(tmp), pagesize = 2000000)



# loc$elevation = df$properties$Elevation
# loc$note = df$properties$Notes
# loc$name = df$properties$Name
# loc$time = df$properties$Time
# loc$unixTime = df$properties$UnixTime
# loc$speed = df$properties$Speed
# loc$pressure = df$properties$Pressure
# loc$activity = df$properties$Activity

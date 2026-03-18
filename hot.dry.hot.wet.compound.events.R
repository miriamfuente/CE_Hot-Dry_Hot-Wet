options(java.parameters = "-Xmx32g") 
library(rJava)
.jinit()

# Cargar librerías
library(loadeR)
library(transformeR)
library(visualizeR)

df <- read.csv("data_inventory.csv")

# In this example, the ERA5-Land reanalysis dataset will be loaded.
subset.pi <- subset(df, dataset == "ERA5-Land_Iberia_day")
lon.pi <- as.character(subset.pi$endpoint)
# Doing a data Inventory allow as to see what variables the dataset has,
# the years, the latitude and longitude and the units of each variable.

# We select a 20-year period
years <- 1986:2005

# Adjusting lat and lon to northeast of Spain
latitude <- c(39.8, 43)
longitude <- c(-2.3, 3.6)
year.range <- paste0(min(years), "-", max(years))

# Load the variables. We need maximum temperature (tasmax) and precipitation (pr) to compute the indices.   
tasmax <- loadGridData(dataset=lon.pi, var ="tasmax", years = years, latLim = latitude, lonLim = longitude)
tasmax <- gridArithmetics(tasmax, 273.15, operator="-")  # Conversion to °C

pr <- loadGridData(dataset=lon.pi, var ="pr", years = years, latLim = latitude, lonLim = longitude)
pr <- gridArithmetics(pr, 1000, operator="*")  # Conversion to mm/day

# If pr < 1 mm/day, it is considered a day without precipitation from a climatological perspective, so a value of 0 is assigned.
pr$Data[pr$Data < 1] <- 0

# We create a earth mask
mask <- climatology(tasmax)
mask$Data[!is.na(mask$Data)] <- 1

# Function to get the months from the mobile window
moving.window <- function(month) {
  months <- c((month-1)%%12, month%%12, (month+1)%%12)  # Previous, current, and next month
  months[months == 0] <- 12  # Corrects December (when (month-1)%%12 gives 0)
  return(sort(months))
}

tmax.vm <- list()

# We convert the diary data of tasmax in a estational cicle
for(i in 1:12){
  tmax.month <- subsetGrid(tasmax, season=moving.window(i))
  tmax.month <- aggregateGrid(grid = tmax.month, aggr.y = list(FUN = "mean", na.rm = FALSE))
  tmax.clim <- climatology(tmax.month)
  tmax.vm[[i]] <- tmax.clim
}
tmax.estational.cicle <- do.call(bindGrid, c(tmax.vm, list(dimension = "time")))

source("functions/fun.hottest.season.R")
hottest.season <- fun.hottest.season(tmax.estational.cicle)

# Processing data 
source("functions/fun.transform.data.R")
pr.tf <- transform.data(pr, hottest.season)
tmax.tf <- transform.data(tasmax, hottest.season)
saveRDS(tmax.tf, file = "save.data/tmax.tf.era5.land.rds", compress = "xz")
print("Transformed data: Done")

source("functions/fun.intensity.hw.hd_90_95_100.R")
intensity <- fun.intensity(pr.obs=pr.tf, tmax.obs=tmax.tf, tmax.daily=tmax.tf)

source("functions/fun.magnitude.R")
magnitude <- fun.magnitude(intensity, tmax.tf)
saveRDS(magnitude, file = "save.data/magnitude.era5.land.rds", compress = "xz")

source("functions/fun.categories.intensity.mean.hw.hd.R")
categories <- fun.categories(intensity)
saveRDS(categories, file = "save.data/categories.era5.land.rds", compress = "xz")

source("functions/fun.duration.hw.hd.R")
duration <- d.int(intensity)
saveRDS(duration, file = "save.data/duration.era5.land.rds", compress = "xz")
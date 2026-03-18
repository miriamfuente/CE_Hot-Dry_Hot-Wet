d.int <- function(intensity.s) {
  list_c1_year_num <- list()
  list_c1_year_median <- list()
  list_c1_year_mean <- list()
  list_c2_year_num <- list()
  list_c2_year_median <- list()
  list_c2_year_mean <- list()
  list_c3_year_num <- list()
  list_c3_year_median <- list()
  list_c3_year_mean <- list()
  list_c4_year_num <- list()
  list_c4_year_median <- list()
  list_c4_year_mean <- list()

  list_c1_lon_num <- list()
  list_c1_lon_median <- list()
  list_c1_lon_mean <- list()
  list_c2_lon_num <- list()
  list_c2_lon_median <- list()
  list_c2_lon_mean <- list()
  list_c3_lon_num <- list()
  list_c3_lon_median <- list()
  list_c3_lon_mean <- list()
  list_c4_lon_num <- list()
  list_c4_lon_median <- list()
  list_c4_lon_mean <- list()

  list_c1_lat_num <- list()
  list_c1_lat_median <- list()
  list_c1_lat_mean <- list()
  list_c2_lat_num <- list()
  list_c2_lat_median <- list()
  list_c2_lat_mean <- list()
  list_c3_lat_num <- list()
  list_c3_lat_median <- list()
  list_c3_lat_mean <- list()
  list_c4_lat_num <- list()
  list_c4_lat_median <- list()
  list_c4_lat_mean <- list()

  list_total_c1_num <- list()
  list_total_c1_median <- list()
  list_total_c1_mean <- list()
  list_total_c2_num <- list()
  list_total_c2_median <- list()
  list_total_c2_mean <- list()
  list_total_c3_num <- list()
  list_total_c3_median <- list()
  list_total_c3_mean <- list()
  list_total_c4_num <- list()
  list_total_c4_median <- list()
  list_total_c4_mean <- list()  

  list_num <- list()
  list_median <- list()
  list_mean <- list()

  source("functions/binSpell.R")
  source("functions/fun.def.duration.R")

  for (i in 1:dim(intensity.s$Data)[which(attr(intensity.s$Data, "dimensions") == "lat")]) {
    years <- unique(year(intensity.s$Dates$start))
    racha = 2
    intensity.lat <- subsetDimension(intensity.s,  dimension="lat", indices=i)
    for(j in 1:dim(intensity.s$Data)[which(attr(intensity.s$Data, "dimensions") == "lon")]) {
      intensity.lon <- subsetDimension(intensity.lat,  dimension="lon", indices=j)
      for(k in seq(years)){
        intensity.year <- subsetGrid(intensity.lon, year=years[k])
        # categorias <- list("c1" = 1, "c2" = 2, "c3" = 3, "c4" = 4)
        # racha = 2
        # Categorie C1
        c1 <- def.dur(intensity.year, racha, 1)
        c2 <- def.dur(intensity.year, racha, 2)
        c3 <- def.dur(intensity.year, racha, 3)
        c4 <- def.dur(intensity.year, racha, 4)

        num.c1 <- climatology(intensity.year)
        num.c2 <- num.c1
        num.c3 <- num.c1
        num.c4 <- num.c1

        median.c1 <- num.c1
        median.c2 <- num.c1
        median.c3 <- num.c1
        median.c4 <- num.c1

        mean.c1 <- num.c1
        mean.c2 <- num.c1
        mean.c3 <- num.c1
        mean.c4 <- num.c1

        num.c1$Data[] <- c1[1]
        num.c2$Data[] <- c2[1]
        num.c3$Data[] <- c3[1]
        num.c4$Data[] <- c4[1]

        median.c1$Data[] <- c1[2]
        median.c2$Data[] <- c2[2]
        median.c3$Data[] <- c3[2]
        median.c4$Data[] <- c4[2]

        mean.c1$Data[] <- c1[3]
        mean.c2$Data[] <- c2[3]
        mean.c3$Data[] <- c3[3]
        mean.c4$Data[] <- c4[3]
        
        list_c1_year_num[[k]] <- num.c1
        list_c1_year_median[[k]] <- median.c1
        list_c1_year_mean[[k]] <- mean.c1
        list_c2_year_num[[k]] <- num.c2
        list_c2_year_median[[k]] <- median.c2
        list_c2_year_mean[[k]] <- mean.c2
        list_c3_year_num[[k]] <- num.c3
        list_c3_year_median[[k]] <- median.c3
        list_c3_year_mean[[k]] <- mean.c3
        list_c4_year_num[[k]] <- num.c4
        list_c4_year_median[[k]] <- median.c4
        list_c4_year_mean[[k]] <- mean.c4
      }
      list_c1_lon_num[[j]] <- redim(do.call(bindGrid, c(list_c1_year_num, list(dimension = "time", skip.temporal.check = FALSE))), drop = TRUE)
      list_c1_lon_median[[j]] <- redim(do.call(bindGrid, c(list_c1_year_median, list(dimension = "time", skip.temporal.check = FALSE))), drop = TRUE)
      list_c1_lon_mean[[j]] <- redim(do.call(bindGrid, c(list_c1_year_mean, list(dimension = "time", skip.temporal.check = FALSE))), drop = TRUE)
      list_c2_lon_num[[j]] <- redim(do.call(bindGrid, c(list_c2_year_num, list(dimension = "time", skip.temporal.check = FALSE))), drop = TRUE)
      list_c2_lon_median[[j]] <- redim(do.call(bindGrid, c(list_c2_year_median, list(dimension = "time", skip.temporal.check = FALSE))), drop = TRUE)
      list_c2_lon_mean[[j]] <- redim(do.call(bindGrid, c(list_c2_year_mean, list(dimension = "time", skip.temporal.check = FALSE))), drop = TRUE)
      list_c3_lon_num[[j]] <- redim(do.call(bindGrid, c(list_c3_year_num, list(dimension = "time", skip.temporal.check = FALSE))), drop = TRUE)
      list_c3_lon_median[[j]] <- redim(do.call(bindGrid, c(list_c3_year_median, list(dimension = "time", skip.temporal.check = FALSE))), drop = TRUE)
      list_c3_lon_mean[[j]] <- redim(do.call(bindGrid, c(list_c3_year_mean, list(dimension = "time", skip.temporal.check = FALSE))), drop = TRUE)
      list_c4_lon_num[[j]] <- redim(do.call(bindGrid, c(list_c4_year_num, list(dimension = "time", skip.temporal.check = FALSE))), drop = TRUE)
      list_c4_lon_median[[j]] <- redim(do.call(bindGrid, c(list_c4_year_median, list(dimension = "time", skip.temporal.check = FALSE))), drop = TRUE)
      list_c4_lon_mean[[j]] <- redim(do.call(bindGrid, c(list_c4_year_mean, list(dimension = "time", skip.temporal.check = FALSE))), drop = TRUE)
    }
    list_c1_lat_num[[i]] <- redim(do.call(bindGrid, c(list_c1_lon_num, list(dimension = "lon", skip.temporal.check = FALSE))), drop = TRUE)
    list_c1_lat_median[[i]] <- redim(do.call(bindGrid, c(list_c1_lon_median, list(dimension = "lon", skip.temporal.check = FALSE))), drop = TRUE)
    list_c1_lat_mean[[i]] <- redim(do.call(bindGrid, c(list_c1_lon_mean, list(dimension = "lon", skip.temporal.check = FALSE))), drop = TRUE)
    list_c2_lat_num[[i]] <- redim(do.call(bindGrid, c(list_c2_lon_num, list(dimension = "lon", skip.temporal.check = FALSE))), drop = TRUE)
    list_c2_lat_median[[i]] <- redim(do.call(bindGrid, c(list_c2_lon_median, list(dimension = "lon", skip.temporal.check = FALSE))), drop = TRUE)
    list_c2_lat_mean[[i]] <- redim(do.call(bindGrid, c(list_c2_lon_mean, list(dimension = "lon", skip.temporal.check = FALSE))), drop = TRUE)
    list_c3_lat_num[[i]] <- redim(do.call(bindGrid, c(list_c3_lon_num, list(dimension = "lon", skip.temporal.check = FALSE))), drop = TRUE)
    list_c3_lat_median[[i]] <- redim(do.call(bindGrid, c(list_c3_lon_median, list(dimension = "lon", skip.temporal.check = FALSE))), drop = TRUE)
    list_c3_lat_mean[[i]] <- redim(do.call(bindGrid, c(list_c3_lon_mean, list(dimension = "lon", skip.temporal.check = FALSE))), drop = TRUE)
    list_c4_lat_num[[i]] <- redim(do.call(bindGrid, c(list_c4_lon_num, list(dimension = "lon", skip.temporal.check = FALSE  ))), drop = TRUE)
    list_c4_lat_median[[i]] <- redim(do.call(bindGrid, c(list_c4_lon_median, list(dimension = "lon", skip.temporal.check = FALSE))), drop = TRUE)
    list_c4_lat_mean[[i]] <- redim(do.call(bindGrid, c(list_c4_lon_mean, list(dimension = "lon", skip.temporal.check = FALSE))), drop = TRUE)
  }
  list_total_c1_num <- redim(do.call(bindGrid, c(list_c1_lat_num, list(dimension = "lat", skip.temporal.check = FALSE))), drop = TRUE)
  list_total_c1_median <- redim(do.call(bindGrid, c(list_c1_lat_median, list(dimension = "lat", skip.temporal.check = FALSE))), drop = TRUE)
  list_total_c1_mean <- redim(do.call(bindGrid, c(list_c1_lat_mean, list(dimension = "lat", skip.temporal.check = FALSE))), drop = TRUE)    
  list_total_c2_num <- redim(do.call(bindGrid, c(list_c2_lat_num, list(dimension = "lat", skip.temporal.check = FALSE))), drop = TRUE)
  list_total_c2_median <- redim(do.call(bindGrid, c(list_c2_lat_median, list(dimension = "lat", skip.temporal.check = FALSE))), drop = TRUE)
  list_total_c2_mean <- redim(do.call(bindGrid, c(list_c2_lat_mean, list(dimension = "lat", skip.temporal.check = FALSE))), drop = TRUE)    
  list_total_c3_num <- redim(do.call(bindGrid, c(list_c3_lat_num, list(dimension = "lat", skip.temporal.check = FALSE))), drop = TRUE)
  list_total_c3_median <- redim(do.call(bindGrid, c(list_c3_lat_median, list(dimension = "lat", skip.temporal.check = FALSE))), drop = TRUE)
  list_total_c3_mean <- redim(do.call(bindGrid, c(list_c3_lat_mean, list(dimension = "lat", skip.temporal.check = FALSE))), drop = TRUE)    
  list_total_c4_num <- redim(do.call(bindGrid, c(list_c4_lat_num, list(dimension = "lat", skip.temporal.check = FALSE))), drop = TRUE)
  list_total_c4_median <- redim(do.call(bindGrid, c(list_c4_lat_median, list(dimension = "lat", skip.temporal.check = FALSE))), drop = TRUE)
  list_total_c4_mean <- redim(do.call(bindGrid, c(list_c4_lat_mean, list(dimension = "lat", skip.temporal.check = FALSE))), drop = TRUE)  

  list_num <- list("c1"= list_total_c1_num, 
                    "c2"= list_total_c2_num, 
                    "c3"= list_total_c3_num, 
                    "c4"= list_total_c4_num)
  list_median <- list("c1"= list_total_c1_median, 
                       "c2"= list_total_c2_median, 
                       "c3"= list_total_c3_median, 
                       "c4"= list_total_c4_median)
  list_mean <- list("c1"= list_total_c1_mean, 
                     "c2"= list_total_c2_mean, 
                     "c3"= list_total_c3_mean, 
                     "c4"= list_total_c4_mean)

  return(list("num"= list_num, "median"= list_median, "mean"= list_mean))
}
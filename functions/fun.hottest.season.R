# The data of tmax have to be in estational cicles 
# 12 values per gridbox
fun.hottest.season <- function(tmax){
    idx.lon <- list()
    idx.lat <- list()
    for(i in 1:dim(tmax$Data)[which(attr(tmax$Data, "dimensions") == "lat")]){
        tmax.lat <- subsetDimension(tmax, dimension="lat", indices=i)
        for(j in 1:dim(tmax$Data)[which(attr(tmax$Data, "dimensions") == "lon")]){
            tmax.lon <- subsetDimension(tmax.lat, dimension="lon", indices=j)
            aux.lon <- tmax.lon
            tryCatch({
                if (all(is.na(tmax.lon$Data))){
                    aux.lon$Data <- array(NA, dim = c(3,1,1))
                    attr(aux.lon$Data, "dimensions") <- c("time", "lat","lon")
                }else{
                    mean.tmax <- mean(tmax.lon$Data)
                    sd.tmax <- sd(tmax.lon$Data)
                    tmax.lon$Data <- (tmax.lon$Data - mean.tmax)/sd.tmax
                    # Find the highest value
                    month.max.dif <- which.max(tmax.lon$Data)
                    months.vm <- c(month.max.dif - 1, month.max.dif, month.max.dif + 1) # Add to th moving window the previous and subsequent month
                    # Adjust so that the months are in the range 1-12
                    months.vm[months.vm == 0] <- 12  # If the central hottest month is January, the previous month will be December
                    months.vm[months.vm == 13] <- 1  # If the central hottest month is December, the subsequent month will be January
                    aux.lon$Data <- array(sort(months.vm), dim = c(length(months.vm),1,1))
                    attr(aux.lon$Data, "dimensions") <- c("time", "lat","lon")
                }
            }, error = function(e) {
                warning(paste("Error in latitude i=:", i, ", longitude j=", j, e$message))
            })
            idx.lon[[j]] <- aux.lon
        }
        idx.lat[[i]] <- redim(do.call(bindGrid, c(idx.lon, list(dimension = "lon", skip.temporal.check = TRUE))), drop = TRUE)
    }
    idx.hot.dry.month <- redim(do.call(bindGrid, c(idx.lat, list(dimension = "lat", skip.temporal.check = TRUE))), drop=TRUE)

}

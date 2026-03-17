fun.intensity <- function(pr.obs, tmax.obs, tmax.daily) {

    # All the data must be introduced once it's transformed
    # Difference: for ERA5-LAND data.obs == data.daily
    # For models: data.daily== data from historic period (transformed)
    #             data.obs== data from future period (transformed)


    source("functions/fun.define.intensity.hw.hd.R")
    t90 <- climatology(tmax.daily, clim.fun = list(FUN = "quantile", probs=0.90, na.rm = TRUE))
    t95 <- climatology(tmax.daily, clim.fun = list(FUN = "quantile", probs=0.95, na.rm = TRUE))

    list.lat <- list()
    list.lon <- list()
    list.final <- list()
    start_date <- NULL
    end_date <- NULL

    for (i in 1:dim(tmax.obs$Data)[which(attr(tmax.obs$Data, "dimensions") == "lat")]) {
        print(paste("i= ", i))
        t90.lat <- subsetDimension(t90, dimension="lat", indices=i)
        t95.lat <- subsetDimension(t95, dimension="lat", indices=i)

        tmax.lat <- subsetDimension(tmax.obs, dimension="lat", indices=i)
        pr.lat <- subsetDimension(pr.obs, dimension="lat", indices=i)

        for(j in 1:dim(tmax.obs$Data)[which(attr(tmax.obs$Data, "dimensions") == "lon")]) {
            t90.lon <- subsetDimension(t90.lat, dimension="lon", indices=j)
            t95.lon <- subsetDimension(t95.lat, dimension="lon", indices=j)

            tmax.lon <- subsetDimension(tmax.lat, dimension="lon", indices=j)
            pr.lon <- subsetDimension(pr.lat, dimension="lon", indices=j)
                t90.lon.hot <- t90.lon
                t95.lon.hot <- t95.lon
                tmax.lon.hot <- tmax.lon
                pr.lon.hot <- pr.lon
                cat.lon.hot <- tmax.lon
                categorias <- f.int(pr.lon.hot, t90.lon.hot, t95.lon.hot, tmax.lon.hot)
                cat.lon.hot$Data <- categorias
                attr(cat.lon.hot$Data, "dimensions") <- "time"
            list.lon[[j]] <- cat.lon.hot
        }
        list.lat[[i]] <- redim(do.call(bindGrid, c(list.lon, list(dimension = "lon", skip.temporal.check = TRUE))), drop = TRUE)
    }
    list.final <- redim(do.call(bindGrid, c(list.lat, list(dimension = "lat", skip.temporal.check = TRUE))), drop = TRUE)
    return(list.final)
}
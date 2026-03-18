fun.magnitude <- function(intensity, variable) {
    # pone 1 donde no es NA y es distinto de 0
    c1 <- intensity
    c1$Data[c1$Data != 1] <- NA
    c1$Data[c1$Data == 1] <- 1
    c2 <- intensity
    c2$Data[c2$Data != 2] <- NA
    c2$Data[c2$Data == 2] <- 1
    c3 <- intensity
    c3$Data[c3$Data != 3] <- NA
    c3$Data[c3$Data == 3] <- 1
    c4 <- intensity
    c4$Data[c4$Data != 4] <- NA
    c4$Data[c4$Data == 4] <- 1

    var.c1 <- gridArithmetics(c1, variable, operator = "*")
    var.c2 <- gridArithmetics(c2, variable, operator = "*")
    var.c3 <- gridArithmetics(c3, variable, operator = "*")
    var.c4 <- gridArithmetics(c4, variable, operator = "*")
    
    var.c1.agg <- climatology(var.c1, clim.fun=list(FUN="median", na.rm=TRUE))
    var.c2.agg <- climatology(var.c2, clim.fun=list(FUN="median", na.rm=TRUE))
    var.c3.agg <- climatology(var.c3, clim.fun=list(FUN="median", na.rm=TRUE))
    var.c4.agg <- climatology(var.c4, clim.fun=list(FUN="median", na.rm=TRUE))


    result <- list(c1 = var.c1.agg, c2 = var.c2.agg, c3 = var.c3.agg, c4 = var.c4.agg)
    return(result)
}
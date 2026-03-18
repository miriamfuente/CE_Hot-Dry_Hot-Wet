source("functions/binSpell.R")

def.dur <- function(data, racha, categoria) {
  data$Data[data$Data != categoria] <- NA
  d <- binSpell(data$Data)
  len <- d$len
  val <- d$val
  idx.valid <- len >= racha
  len.valid <- len[idx.valid]
  val.valid <- val[idx.valid]
  idx.val <- which(val.valid == categoria)
  duration.events <- len.valid[idx.val]
  num.rachas <- length(duration.events)
  median.duration <- median(duration.events)
  mean.duration <- mean(duration.events)
  return(c(num.rachas, median.duration, mean.duration))
}
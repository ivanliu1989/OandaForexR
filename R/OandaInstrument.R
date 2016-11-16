# source("./R/settings.R")

# dat = getCandles(ACCOUNT_TYPE, ACCESS_TOKEN, INSTRUMENTS = 'AUD_USD', price = 'BA', granularity = 'M5', count = 500)

getCandles <- function(ACCOUNT_TYPE, ACCESS_TOKEN, INSTRUMENTS = 'AUD_USD', count = 100,
                       price = "BA", granularity = "M1", ...){

  # Must
  price = paste("price=",price,sep="")
  granularity = paste("granularity=",granularity,sep="")
  QUERY <- paste(price, granularity, sep="&")

  if(exists('count')){count = paste("count=",count,sep=""); QUERY <- paste(QUERY, count, sep="&")}

  # Optional1
  if(exists('from')){from = paste("from=",from,sep=""); QUERY <- paste(QUERY, from, sep="&")}
  if(exists('to')){to = paste("to=",to,sep=""); QUERY <- paste(QUERY, to, sep="&")}

  # Optional2
  if(exists('smooth.param')) {smooth.param = paste("smooth=",smooth.param,sep=""); QUERY <- paste(QUERY, smooth.param, sep="&")}
  if(exists('includeFirst')) {includeFirst = paste("includeFirst=",includeFirst,sep=""); QUERY <- paste(QUERY, includeFirst, sep="&")}
  if(exists('dailyAlignment')) {dailyAlignment = paste("dailyAlignment=",dailyAlignment,sep=""); QUERY <- paste(QUERY, dailyAlignment, sep="&")}
  if(exists('alignmentTimezone')) {alignmentTimezone = paste("alignmentTimezone=",alignmentTimezone,sep=""); QUERY <- paste(QUERY, alignmentTimezone, sep="&")}
  if(exists('weeklyAlignment')) {weeklyAlignment = paste("weeklyAlignment=",weeklyAlignment,sep=""); QUERY <- paste(QUERY, weeklyAlignment, sep="&")}


  # Generate URL ------------------------------------------------------------
  URL = paste0("https://", ENVIRONMENTS$api[ACCOUNT_TYPE])
  URL = paste0(URL, "/v3/instruments/", INSTRUMENTS, "/candles?")
  URL = paste0(URL, QUERY)


  # Headers -----------------------------------------------------------------
  HEADERS <- c(Authorization = paste("Bearer",ACCESS_TOKEN,sep=" "), "Content-Type" = "application/json")

  tryCatch({
    json.data <- getURL(URL,cainfo=system.file("CurlSSL","cacert.pem",
                                               package="RCurl"),httpheader=HEADERS)
    parsed.data <- fromJSON(json.data, simplifyDataFrame = TRUE, flatten = TRUE)$candles
    parsed.data$time <- as.POSIXct(strptime(parsed.data$time, "%Y-%m-%dT%H:%M:%OS"),
                                   origin="1970-01-01",tz = "UTC")
  }, error = function(e) e)

  return(parsed.data)
}






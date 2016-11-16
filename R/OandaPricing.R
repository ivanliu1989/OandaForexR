# source("./R/settings.R")

# getCurrentPricing(ACCOUNT_TYPE, ACCESS_TOKEN, ACCOUNT_ID, 'AUD_USD')

getCurrentPricing <- function(ACCOUNT_TYPE, ACCESS_TOKEN, ACCOUNT_ID, INSTRUMENTS = c('AUD_USD')){

  INSTRUMENTS = paste(INSTRUMENTS, collapse = "%2C")

  URL = paste0("https://", ENVIRONMENTS$api[ACCOUNT_TYPE])
  URL = paste0(URL, "/v3/accounts/", ACCOUNT_ID, "/pricing?instruments=")
  URL = paste0(URL, INSTRUMENTS)

  HEADERS <- c(Authorization = paste("Bearer",ACCESS_TOKEN,sep=" "))

  json.data <- getURL(URL,cainfo=system.file("CurlSSL","cacert.pem",
                                             package="RCurl"),httpheader=HEADERS)

  tryCatch({
    parsed.data <- fromJSON(json.data, simplifyDataFrame = TRUE, flatten = TRUE)$prices
    parsed.data <- parsed.data[, c("instrument", "closeoutAsk", "closeoutBid", "status", "time")]
    colnames(parsed.data) <- c('instrument', 'ask', 'bid', 'status', 'time')
  }, error = function(e) e)

  return(parsed.data)
}


# getCurrentPricingStream

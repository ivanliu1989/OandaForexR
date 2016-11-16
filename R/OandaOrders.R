source("./R/settings.R")

# createMarketOrder(ACCOUNT_TYPE, ACCESS_TOKEN, ACCOUNT_ID, INSTRUMENTS = 'AUD_USD', UNITS = -10000)

createMarketOrder <- function(ACCOUNT_TYPE, ACCESS_TOKEN, ACCOUNT_ID, INSTRUMENTS = 'AUD_USD'
                        , UNITS, POSITIONFILL = 'DEFAULT', ...){
  # MARKET_IF_TOUCHED
  # MARKET
  # LIMIT

  # Generate URL ------------------------------------------------------------
  URL = paste0("https://", ENVIRONMENTS$api[ACCOUNT_TYPE])
  URL = paste0(URL, "/v3/accounts/", ACCOUNT_ID, "/orders")

  # Headers -----------------------------------------------------------------
  HEADERS <- add_headers(Authorization = paste("Bearer",ACCESS_TOKEN,sep=" "), "Content-Type" = "application/json")

  # Parameters
  PARAMS <- list(order = list(units = as.character(UNITS),
                              instrument = INSTRUMENTS,
                              timeInForce = 'FOK',
                              type = 'MARKET',
                              positionFill = 'DEFAULT'))

  tryCatch({
    resp <- POST(URL, config = HEADERS, body = PARAMS, encode = "json")
  }, error = function(e) e)

  if(resp$status_code == 201) {
    cat("HTTP 201 – The Order was created as specified")
  }else{
    cat(paste0(resp$status_code, " | Failed to create order!"))
  }

  return(resp)
}



# createTakeProfit
# createEntryOrder
# createLimitOrder


# getOrderList(ACCOUNT_TYPE, ACCESS_TOKEN, ACCOUNT_ID, INSTRUMENTS = 'USD_CAD')
getOrderList <- function(ACCOUNT_TYPE, ACCESS_TOKEN, ACCOUNT_ID, INSTRUMENTS = 'AUD_USD'){

  # Generate URL ------------------------------------------------------------
  URL = paste0("https://", ENVIRONMENTS$api[ACCOUNT_TYPE])
  URL = paste0(URL, "/v3/accounts/", ACCOUNT_ID, "/orders?instrument=", INSTRUMENTS)

  # Headers -----------------------------------------------------------------
  HEADERS <- c(Authorization = paste("Bearer",ACCESS_TOKEN,sep=" "), "Content-Type" = "application/json")

  tryCatch({
    json.data <- getURL(URL,cainfo=system.file("CurlSSL","cacert.pem",
                                               package="RCurl"),httpheader=HEADERS)
    parsed.data <- fromJSON(json.data, simplifyDataFrame = TRUE, flatten = TRUE)
  }, error = function(e) e)

  return(parsed.data)
}

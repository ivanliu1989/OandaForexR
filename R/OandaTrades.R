# source("./R/settings.R")

# getTrades(ACCOUNT_TYPE, ACCESS_TOKEN, ACCOUNT_ID, INSTRUMENTS = 'USD_CAD')
getTrades <- function(ACCOUNT_TYPE, ACCESS_TOKEN, ACCOUNT_ID, INSTRUMENTS = 'AUD_USD'){

  # Generate URL ------------------------------------------------------------
  URL = paste0("https://", ENVIRONMENTS$api[ACCOUNT_TYPE])
  URL = paste0(URL, "/v3/accounts/", ACCOUNT_ID, "/trades?instrument=", INSTRUMENTS)

  # Headers -----------------------------------------------------------------
  HEADERS <- c(Authorization = paste("Bearer",ACCESS_TOKEN,sep=" "), "Content-Type" = "application/json")

  tryCatch({
    json.data <- getURL(URL,cainfo=system.file("CurlSSL","cacert.pem",
                                               package="RCurl"),httpheader=HEADERS)
    parsed.data <- fromJSON(json.data, simplifyDataFrame = TRUE, flatten = TRUE)
  }, error = function(e) e)

  return(parsed.data)
}

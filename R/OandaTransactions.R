# source("./R/settings.R")

# getTransactions(ACCOUNT_TYPE, ACCESS_TOKEN, ACCOUNT_ID)
getTransactions <- function(ACCOUNT_TYPE, ACCESS_TOKEN, ACCOUNT_ID, PAGESIZE = 1000, FROM = NULL, TO = NULL){

  # Generate URL ------------------------------------------------------------
  URL = paste0("https://", ENVIRONMENTS$api[ACCOUNT_TYPE])
  URL = paste0(URL, "/v3/accounts/", ACCOUNT_ID, "/transactions?pageSize=", PAGESIZE)

  # Headers -----------------------------------------------------------------
  HEADERS <- c(Authorization = paste("Bearer",ACCESS_TOKEN,sep=" "), "Content-Type" = "application/json")

  tryCatch({
    json.data <- getURL(URL,cainfo=system.file("CurlSSL","cacert.pem",
                                               package="RCurl"),httpheader=HEADERS)
    parsed.data <- fromJSON(json.data, simplifyDataFrame = TRUE, flatten = TRUE)
  }, error = function(e) e)

  return(parsed.data)
}

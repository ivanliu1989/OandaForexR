library(httr)
library(jsonlite)
library(RCurl)

ACCOUNT_TYPE = 'practice'

ENVIRONMENTS = list(
  streaming = list(
    real = "stream-fxtrade.oanda.com",
    practice = "stream-fxpractice.oanda.com",
    sandbox = "stream-sandbox.oanda.com"
  ),
  api = list(
    real = "api-fxtrade.oanda.com",
    practice = "api-fxpractice.oanda.com",
    sandbox = "api-sandbox.oanda.com"
  )
)

STREAM_DOMAIN = ENVIRONMENTS$streaming[ACCOUNT_TYPE]

API_DOMAIN = ENVIRONMENTS$api[ACCOUNT_TYPE]

ACCESS_TOKEN = '450188cd62d103f23afbbee7e72b1339-d9c47c032f04ff46a65ec24786d11357'
ACCOUNT_ID = '101-011-4686012-001'




#
# AccountType = "practice"
# Token = '450188cd62d103f23afbbee7e72b1339-d9c47c032f04ff46a65ec24786d11357'
# AccountID = '101-011-4686012-001'
# Headers = add_headers(Authorization = paste("Bearer",Token,sep=" "), "Content-Type" = "application/json")
#
# httpaccount <- "https://api-fxpractice.oanda.com"
# Queryhttp  <- paste(httpaccount,"/v3/accounts/",sep="")
# Queryhttp1 <- paste(Queryhttp,AccountID,sep="")
# Queryhttp2 <- paste(Queryhttp1,"/orders",sep="")
#
# POST(Queryhttp2, config = Headers,
#      body = list(order = list(units = '999',
#                               instrument = 'EUR_USD',
#                               timeInForce = 'FOK',
#                               type = 'MARKET',
#                               positionFill = 'DEFAULT')),
#      encode = "json")
#
#
#
#
# HEADERS = add_headers(Authorization = paste("Bearer",ACCESS_TOKEN,sep=" "),
#                       "Content-Type" = "application/json")

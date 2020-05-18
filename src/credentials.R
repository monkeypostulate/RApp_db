library(RMySQL)

mydb <- dbConnect(MySQL(), user = user$user,
                  password = user$password, 
                  dbname = user$db,
                  host = user$db)


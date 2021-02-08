#
# # metric.df.to.json <- function(df) {
# #     jsonlite::toJSON(df, dataframe = 'columns', POSIXt = "string",
# #                      null = "list", na = "string", auto_unbox = F)
# # }
# #
# # metric.df.from.json <- function(df) {
# #     data <- as.data.frame(jsonlite::fromJSON(df), stringsAsFactors = F)
# #     data$carga <- as.integer(data$carga)
# #     data$fecha <- ymd_hms(data$fecha)
# #     data
# # }
#
# get.conn <- function() {
#     if(not(exists("mySQL.conn")) || tryCatch(not(dbIsValid(mySQL.conn)), error = function(e) T)) {
#         warning("connection to MySQL...\n")
#         mySQL.conn <<- dbConnect(MySQL(), user = 'amanas', password = '237237237',
#                                  dbname = 'tffmadrid', host = 'tff-madrid.c0rrvmnilxnf.eu-west-1.rds.amazonaws.com')
#     }
#     mySQL.conn
# }
#
# as.sql.in <- function(lst) {
#     lst %>% unlist %>% paste0(',', collapse = ' ') %>% substr(., 1, nchar(.)-1)
# }
#
# exist.metric <- function(y, m, d) {
#     0 < dbGetQuery(get.conn(), sprintf("select count(1) from metrics where year=%d and month=%d and device=%d;", y, m, d))[1,1]
# }
#
# put.metric <- function(df) {
#     y <- as.integer(year(df$fecha[1]))
#     m <- as.integer(month(df$fecha[1]))
#     d <- ifelse(is.null(df$id), ifelse(is.null(df$idelem), df$identif[1], df$idelem[1]), df$id[1])
#     if (!exist.metric(y, m, d)) {
#         q <- "INSERT INTO metrics (year, month, device, data) VALUES(%d, %d, %d, '%s')"
#         dbGetQuery(get.conn(), sprintf(q, y, m, d, encode.obj(df)))
#     }
# }
#
# down.put.metrics <- function(y, m) {
#     df <- download.data(y, m, 'metric')
#     if(!is.null(df$identif))
#         df %>% group_by(identif) %>% do(data.frame(put.metric(.)))
#     else if(!is.null(df$idelem))
#         df %>% group_by(idelem) %>% do(data.frame(put.metric(.)))
#     else if(!is.null(df$id))
#         df %>% group_by(id) %>% do(data.frame(put.metric(.)))
# }
#
# estimate.cores <- function() {
#     max(1, detectCores()-1)
# }
#
# get.raw.metrics <- function(y=c(), m=c(), d=c()) {
#     y.in <- ifelse(length(y)==0, "-1", as.sql.in(y))
#     m.in <- ifelse(length(m)==0, "-1", as.sql.in(m))
#     d.in <- ifelse(length(d)==0, "-1", as.sql.in(d))
#     metrics <- "SELECT data
#                   FROM metrics
#                  WHERE ('%s'='-1' OR year IN (%s))
#                    AND ('%s'='-1' OR month IN (%s))
#                    AND ('%s'='-1' OR device IN (%s))" %>%
#         sprintf(y.in, y.in, m.in, m.in, d.in, d.in) %>%
#         dbGetQuery(get.conn(), .)
#     if(nrow(metrics)<64) {
#         metrics %>% magrittr::extract(,1) %>% lapply(decode.obj)
#     } else {
#         metrics %>% magrittr::extract(,1) %>% mclapply(decode.obj, mc.cores = estimate.cores())
#     }
# }
#
# get.parsed.metrics <- function(y=c(), m=c(), d=c()) {
#     metrics <- get.raw.metrics(y,m,d)
#     if(length(metrics)<64) {
#         metrics %>% lapply(parse.raw.metric) %>% rbindlist()
#     } else {
#         metrics %>% mclapply(parse.raw.metric, mc.cores = estimate.cores()) %>% rbindlist()
#     }
# }
#
# exist.location <- function(y,m) {
#     0 < dbGetQuery(get.conn(), sprintf("select count(1) from locations where year=%d and month=%d;", y, m))[1,1]
# }
#
# put.location <- function(y,m,df) {
#     if (!exist.location(y, m)) {
#         q <- "INSERT INTO locations (year, month, data) VALUES(%d, %d, '%s')"
#         dbGetQuery(get.conn(), sprintf(q, y, m, encode.obj(df)))
#     }
# }
#
# down.put.locations <- function(y,m) {
#     df <- download.data(y, m, 'device')
#     put.location(y,m,df)
# }
#
# get.raw.location <- function(y,m) {
#     sprintf("SELECT data FROM locations WHERE year=%d AND month=%d",y,m) %>%
#         dbGetQuery(get.conn(), .) %>% magrittr::extract(,1) %>% decode.obj
# }
#
# get.parsed.location <- function(y,m, with.ym = F) {
#     df <- parse.raw.location(get.raw.location(y,m))
#     if (with.ym) {
#         df$year <- y
#         df$month <- m
#     }
#     df
# }
#
# get.all.parsed.locations <- function() {
#     dbGetQuery(get.conn(), "select year, month from locations") %>%
#         apply(1, function(r) get.parsed.location(r[1], r[2])) %>% rbindlist()
# }

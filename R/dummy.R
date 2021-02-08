#
# # PRUEBAS
# source("R/config.R")
# source("R/data.R")
# source("R/db.R")
#
# all.locations <- get.all.parsed.locations()
#
#
# sd(all.locations$x) # 3407
# sd(all.locations$y) # 4057
#
# sd(all.locations)
#
# # Si consideramos las posiciones incluyendo 2017, todos hac cambiado => no puede ser
# loc.diffs.with.2017 <- all.locations %>%
#     group_by(id) %>%
#     summarise_at(vars(x,y), funs(min, max), na.rm = TRUE) %>%
#     mutate(x_diff = x_max - x_min, y_diff = y_max - y_min)
# plot(loc.diffs.with.2017$id, loc.diffs.with.2017$x_diff)
#
#
#
# # Si consideramos las posiciones excluyendo 2017, hay pocos cambios
# loc.diffs.without.2017 <- all.locations %>%
#     filter(year > 2017) %>%
#     group_by(id) %>%
#     summarise_at(vars(x,y), funs(min, max), na.rm = TRUE) %>%
#     mutate(x_diff = x_max - x_min, y_diff = y_max - y_min)
# plot(loc.diffs.without.2017$id, loc.diffs.without.2017$x_diff)
#
# # TODO: excluimos los que aparece con cambios
#
# # TODO: Hacer kable <- pander, y ponerlo todo como kable, por si acaso.
# #       Poner el caption en la invocación de la función y no en el chunk de código
#
#
#
#
#

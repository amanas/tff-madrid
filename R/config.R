#
# # decimal.mark <- ','
# # big.mark <- "."
# # digits <- 14
#
# install.dependencies <- function() {
#     local({
#         r <- getOption("repos")
#         if (!length(r) || identical(unname(r["CRAN"]), "@CRAN@")) {
#             r["CRAN"] <- "https://cran.rstudio.com"
#         }
#         options(repos = r)
#     })
#
#     libraries <-
#         c(
#             "DT",
#             "citr",
#             "formatR",
#             "svglite",
#             "knitr",
#             "magrittr",
#             "data.table",
#             "lubridate",
#             "RMySQL",
#             "ggplot2",
#             "pander",
#             "ggfortify",
#             "forecast",
#             "gridExtra",
#             "padr",
#             "tidyr",
#             "dplyr",
#             "imputeTS",
#             "seasonal",
#             "leaflet",
#             "rgdal",
#             "parallel",
#             "RCurl",
#             "kableExtra",
#             "summarytools"
#         )
#
#     lapply(libraries, function(pkg) {
#         if (system.file(package = pkg) == "")
#             install.packages(pkg)
#         library(pkg, character.only = T)
#     })
# }
#
# setup.knitr <- function() {
#     knitr::opts_chunk$set(
#         warning = F,
#         message = F,
#         echo = F,
#         cache = T,
#         cache.path = "cache/"
#         # formatR.indent = 2,
#         # width = 55,
#         # digits = digits,
#         # warnPartialMatchAttr = FALSE,
#         # warnPartialMatchDollar = FALSE,
#     )
# }
#
# kable.tiny <-
#     function(x,
#              format,
#              digits = getOption("digits"),
#              row.names = NA,
#              col.names = NA,
#              align,
#              caption = NULL,
#              format.args = list(),
#              escape = T,
#              longtable = T,
#              booktabs = T,
#              font_size = 10,
#              latex_options = c("striped", "repeat_header"),
#              position = "center",
#              full_width = F,
#              ...) {
#         kable(
#             x,
#             format,
#             digits = digits,
#             row.names = row.names,
#             col.names = col.names,
#             align,
#             caption = caption,
#             format.args = format.args,
#             escape = escape,
#             longtable = longtable,
#             booktabs = booktabs,
#             ...
#         ) %>%
#             kable_styling(
#                 latex_options = latex_options,
#                 font_size = font_size,
#                 position = position,
#                 full_width = full_width
#             )
#
#     }
#
# kable.scaled <- function(...) {
#     kable.tiny(
#         ...,
#         longtable = F,
#         font_size = NULL,
#         latex_options = c("striped", "scale_down", "repeat_header"),
#     )
# }
#
# # if (!require("reticulate")) {
# #     install.packages("reticulate")
# #     conda_create("reticulate")
# #     conda_install("reticulate", "boto")
# # }
# # library("reticulate")
# # use_condaenv('reticulate', required = T)
#
# # panderOptions('decimal.mark', decimal.mark)
# # panderOptions('big.mark', big.mark)
# # panderOptions('keep.line.breaks', TRUE)
# # panderOptions("table.split.table", 80)
#
# # knitr::knit_hooks$set(
# #     inline = function(x) {
# #         if (!is.numeric(x)) {
# #             x
# #         } else {
# #             prettyNum(round(x, 2),
# #                       big.mark = big.mark,
# #                       decimal.mark = decimal.mark)
# #         }
# #     }
# # )
#
# # kable2 = function(...) {
# #     # format = 'pandoc',
# #     knitr::kable(...,  booktabs = T, format = 'pandoc',
# #                  format.args = list(decimal.mark = decimal.mark, big.mark = big.mark))
# # }
# #
# # render.table <- function(data, caption, digits = 2, ...) {
# #     if (full.instalation) {
# #         if (is_latex_output()) {
# #             kable_styling(
# #                 kable2(
# #                     data,
# #                     "latex",
# #                     booktabs = T,
# #                     digits = digits,
# #                     ...
# #                 ),
# #                 latex_options = c("scale_down")
# #             )
# #         } else {
# #             kable_styling(kable2(
# #                 data,
# #                 "html",
# #                 booktabs = T,
# #                 digits = digits,
# #                 ...
# #             ),
# #             font_size = 12)
# #         }
# #     } else {
# #         kable(data, booktabs = T, ...)
# #     }
# # }
#
#
# # kable2 <- function(data, format, ...) {
# #     knitr::kable(
# #         data,
# #         format,
# #         ...,
# #         booktabs = T,
# #         longtable = T,
# #         digits = digits,
# #         format.args = list(decimal.mark = decimal.mark, big.mark = big.mark)
# #     )
# # }
# #
# # kable <- function(data, ...) {
# #     if (is_latex_output()) {
# #         # panderOptions('decimal.mark', decimal.mark)
# #         # panderOptions('big.mark', big.mark)
# #         # panderOptions('keep.line.breaks', T)
# #         # panderOptions("table.split.table", 80)
# #         # panderOptions('knitr.auto.asis', T)
# #         # kable_styling(kable2(data, "latex", ...),
# #         #               latex_options = c("scale_down"),
# #         #               # font_size = 11,
# #         #               full_width = F)
# #         pander(data, ...)
# #     } else {
# #         kable_styling(kable2(data, "html", ...),
# #                       font_size = 12,
# #                       full_width = F)
# #     }
# # }

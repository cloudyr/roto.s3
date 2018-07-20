#' Access and Orchestrate Amazon Simple Storage Service..
#'
#' This is a 'reticulated' wrapper for the 'Python' 'boto3' 'AWS'
#' 'S3' client library <https://boto3.readthedocs.io/en/latest/reference/services/s3.html>.
#' It requires 'Python' version 3.5+ and an 'AWS' account.
#'
#' @md
#' @name roto.s3
#' @note This package **requires** Python >= 3.5 to be available and the
#'       `boto3` Python module. The package author highly recommends setting
#'       `RETICULATE_PYTHON=/usr/local/bin/python3` in your `~/.Renviron` file
#'       to ensure R + `reticulate` will use the proper python version.
#' @docType package
#' @author Bob Rudis (bob@@rud.is)
#' @import reticulate
NULL

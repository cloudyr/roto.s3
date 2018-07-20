
# roto.s3

Access and Orchestrate Amazon Simple Storage Service

## Description

This is a ‘reticulated’ wrapper for the ‘Python’ ‘boto3’ ‘AWS’ ‘S3’
client library
<https://boto3.readthedocs.io/en/latest/reference/services/s3.html>. It
requires ‘Python’ version 3.5+ and an ‘AWS’ account.

## What’s Inside The Tin

The following functions are implemented: *(more to come)*

  - `download_file`: Download an S3 object to a file
  - `upload_file`: Upload a file to an S3 object
  - `file_exists`: Test if a file exists in the specified bucket

## Installation

``` r
devtools::install_github("hrbrmstr/roto.s3")
# OR
devtools::install_git("git://gitlab.com/hrbrmstr/roto.s3")
```

## Usage

``` r
library(roto.s3)
library(tidyverse)

# current verison
packageVersion("roto.s3")
```

    ## [1] '0.1.0'

### Upload

``` r
write_csv(mtcars, "/tmp/mtcars.csv")

upload_file(
  filename = "/tmp/mtcars.csv", 
  bucket = "is.rud.test", 
  key = "mtcars.csv",
  profile_name = "personal"
)

file_exists(
  bucket = "is.rud.test", 
  key = "mtcars.csv", 
  profile_name = "personal"
)
```

    ## [1] TRUE

### Download

``` r
download_file(
  bucket = "is.rud.test", 
  key = "mtcars.csv", 
  filename = "/tmp/mtcars-again.csv", 
  profile_name = "personal"
)

read_csv("/tmp/mtcars-again.csv")
```

    ## Parsed with column specification:
    ## cols(
    ##   mpg = col_double(),
    ##   cyl = col_integer(),
    ##   disp = col_double(),
    ##   hp = col_integer(),
    ##   drat = col_double(),
    ##   wt = col_double(),
    ##   qsec = col_double(),
    ##   vs = col_integer(),
    ##   am = col_integer(),
    ##   gear = col_integer(),
    ##   carb = col_integer()
    ## )

    ## # A tibble: 32 x 11
    ##      mpg   cyl  disp    hp  drat    wt  qsec    vs    am  gear  carb
    ##    <dbl> <int> <dbl> <int> <dbl> <dbl> <dbl> <int> <int> <int> <int>
    ##  1  21       6  160    110  3.9   2.62  16.5     0     1     4     4
    ##  2  21       6  160    110  3.9   2.88  17.0     0     1     4     4
    ##  3  22.8     4  108     93  3.85  2.32  18.6     1     1     4     1
    ##  4  21.4     6  258    110  3.08  3.22  19.4     1     0     3     1
    ##  5  18.7     8  360    175  3.15  3.44  17.0     0     0     3     2
    ##  6  18.1     6  225    105  2.76  3.46  20.2     1     0     3     1
    ##  7  14.3     8  360    245  3.21  3.57  15.8     0     0     3     4
    ##  8  24.4     4  147.    62  3.69  3.19  20       1     0     4     2
    ##  9  22.8     4  141.    95  3.92  3.15  22.9     1     0     4     2
    ## 10  19.2     6  168.   123  3.92  3.44  18.3     1     0     4     4
    ## # ... with 22 more rows

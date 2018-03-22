
<!-- README.md is generated from README.Rmd. Please edit that file -->
gshhg
=====

[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)

Installation
------------

You can install gshhg from github with:

``` r
# install.packages("devtools")
devtools::install_github("jsta/gshhg")
```

Usage
-----

``` r
library(gshhg)
```

``` r
# Download raw data
gshhg_get(version = "2.3.7")
```

``` r
library(sf)

dt <- st_read(
  list.files(file.path(gshhg:::cache_path(), "2.3.7", "GSHHS_shp", "i"), 
             pattern = "L1.shp", full.names = TRUE, include.dirs = TRUE))

bb <- st_sfc(st_polygon(list(rbind(c(-6.46, 49.696), 
                             c(-7.2, 58.768), 
                             c(1.9336, 58.7909), 
                             c(2.417, 50.18), 
                             c(-6.46, 49.696)))), crs = 4326)

dt_britain <- dt[sapply(st_within(dt, bb), 
                        function(x) length(x) > 0),]

plot(dt_britain$geometry)
```

![](README-unnamed-chunk-4-1.png)

References
----------

See <http://www.soest.hawaii.edu/pwessel/gshhg/>

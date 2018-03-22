
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

# intermediate
dt_i <- st_read(
  list.files(file.path(gshhg:::cache_path(), "2.3.7", "GSHHS_shp", "i"), 
             pattern = "L1.shp", full.names = TRUE, include.dirs = TRUE))

# low
dt_l <- st_read(
  list.files(file.path(gshhg:::cache_path(), "2.3.7", "GSHHS_shp", "l"), 
             pattern = "L1.shp", full.names = TRUE, include.dirs = TRUE))

# crude
dt_c <- st_read(
  list.files(file.path(gshhg:::cache_path(), "2.3.7", "GSHHS_shp", "c"), 
             pattern = "L1.shp", full.names = TRUE, include.dirs = TRUE))

bb <- st_sfc(st_polygon(list(rbind(c(-6.46, 49.696), 
                             c(-7.2, 58.768), 
                             c(1.9336, 58.7909), 
                             c(2.417, 50.18), 
                             c(-6.46, 49.696)))), crs = 4326)

get_britain <- function(dt){
  dt[sapply(st_within(dt, bb), 
                        function(x) length(x) > 0),]
}

dt_britain <- lapply(list(dt_i, dt_l, dt_c), 
                     function(x) get_britain(x))

par(mfrow = c(1, 3))
lapply(dt_britain, function(x) plot(st_geometry(x)))
```

![](README-unnamed-chunk-4-1.png)

References
----------

See <http://www.soest.hawaii.edu/pwessel/gshhg/>

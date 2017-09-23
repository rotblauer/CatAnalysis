# cats
JL  
9/23/2017  




```r
library(dplyr)
```

```
## 
## Attaching package: 'dplyr'
```

```
## The following objects are masked from 'package:stats':
## 
##     filter, lag
```

```
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

```r
library(ggplot2)
theme_set(theme_bw(20))
library(scatterplot3d)
load("loc.RData")

0.0025
```

```
## [1] 0.0025
```

```r
loc_gc <- filter(loc, lat < 38.6485 & lat > 38.646) %>% filter(lon > -90.2775& lon < -90.275)

ggplot(loc_gc, aes(x = lon, y = lat,colour=elevation)) + geom_point()
```

![](cat2_files/figure-html/p-1.png)<!-- -->

```r
ggplot(loc_gc, aes(x = lon, y = elevation,colour=elevation)) + geom_point()
```

![](cat2_files/figure-html/p-2.png)<!-- -->

```r
ggplot(loc_gc, aes(x = lat, y = elevation,colour=elevation)) + geom_point()
```

![](cat2_files/figure-html/p-3.png)<!-- -->


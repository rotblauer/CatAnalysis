# cats
JL  
9/23/2017  


```r
library(ClusterR)
```

```
## Loading required package: gtools
```

```r
library(knitr)
library(rgl)
library(rglwidget)
```

```
## The functions in the rglwidget package have been moved to rgl.
```

```r
knit_hooks$set(webgl = hook_webgl)
library(scatterplot3d)
library(ggplot2)
library(sm)
```

```
## Package 'sm', version 2.2-5.4: type help(sm) for summary information
```

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
clustME <- function(numberOfClusters,clust,loc_gc) {
  cols <- paste0("clust",c(1:numberOfClusters))
  clusStats = data.frame(K=numeric(),WithinSS=numeric())
  i=1
  for(i in 1:numberOfClusters){
    print(i)
    km_rc = KMeans_rcpp(clust, clusters = i, num_init = 100, max_iters = 1000, 
                      
                      initializer = 'optimal_init', threads = 4, verbose = T)
    
    tmp=data.frame(km_rc$clusters)
    colnames(tmp)=c(cols[i])
    loc_gc=cbind(loc_gc,tmp)
    print(colnames(loc_gc))
    tmp2 = data.frame(K=c(i),WithinSS=c(mean(km_rc$between.SS_DIV_total.SS)))
    clusStats= rbind(clusStats,tmp2)
  }
  save(clusStats,file = "clusStats.RData")

  return(loc_gc)
}
```







![](cat3_files/figure-html/p-1.png)<!-- -->![](cat3_files/figure-html/p-2.png)<!-- -->![](cat3_files/figure-html/p-3.png)<!-- -->![](cat3_files/figure-html/p-4.png)<!-- -->![](cat3_files/figure-html/p-5.png)<!-- -->![](cat3_files/figure-html/p-6.png)<!-- -->![](cat3_files/figure-html/p-7.png)<!-- -->![](cat3_files/figure-html/p-8.png)<!-- -->![](cat3_files/figure-html/p-9.png)<!-- -->![](cat3_files/figure-html/p-10.png)<!-- -->![](cat3_files/figure-html/p-11.png)<!-- -->![](cat3_files/figure-html/p-12.png)<!-- -->![](cat3_files/figure-html/p-13.png)<!-- -->![](cat3_files/figure-html/p-14.png)<!-- -->![](cat3_files/figure-html/p-15.png)<!-- -->![](cat3_files/figure-html/p-16.png)<!-- -->![](cat3_files/figure-html/p-17.png)<!-- -->![](cat3_files/figure-html/p-18.png)<!-- -->![](cat3_files/figure-html/p-19.png)<!-- -->![](cat3_files/figure-html/p-20.png)<!-- -->![](cat3_files/figure-html/p-21.png)<!-- -->![](cat3_files/figure-html/p-22.png)<!-- -->![](cat3_files/figure-html/p-23.png)<!-- -->![](cat3_files/figure-html/p-24.png)<!-- -->![](cat3_files/figure-html/p-25.png)<!-- -->![](cat3_files/figure-html/p-26.png)<!-- -->![](cat3_files/figure-html/p-27.png)<!-- -->![](cat3_files/figure-html/p-28.png)<!-- -->![](cat3_files/figure-html/p-29.png)<!-- -->![](cat3_files/figure-html/p-30.png)<!-- -->![](cat3_files/figure-html/p-31.png)<!-- -->![](cat3_files/figure-html/p-32.png)<!-- -->![](cat3_files/figure-html/p-33.png)<!-- -->![](cat3_files/figure-html/p-34.png)<!-- -->![](cat3_files/figure-html/p-35.png)<!-- -->![](cat3_files/figure-html/p-36.png)<!-- -->![](cat3_files/figure-html/p-37.png)<!-- -->![](cat3_files/figure-html/p-38.png)<!-- -->![](cat3_files/figure-html/p-39.png)<!-- -->![](cat3_files/figure-html/p-40.png)<!-- -->![](cat3_files/figure-html/p-41.png)<!-- -->![](cat3_files/figure-html/p-42.png)<!-- -->![](cat3_files/figure-html/p-43.png)<!-- -->![](cat3_files/figure-html/p-44.png)<!-- -->![](cat3_files/figure-html/p-45.png)<!-- -->![](cat3_files/figure-html/p-46.png)<!-- -->![](cat3_files/figure-html/p-47.png)<!-- -->![](cat3_files/figure-html/p-48.png)<!-- -->

```
## 
## Attaching package: 'MASS'
```

```
## The following object is masked from 'package:dplyr':
## 
##     select
```

```
## The following object is masked from 'package:sm':
## 
##     muscle
```

![](cat3_files/figure-html/p-49.png)<!-- -->




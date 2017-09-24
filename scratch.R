
# scatterplot3d(loc_gc, pch = 16,
#              grid=TRUE, box=FALSE)


n_interpolation <- 70
# https://stackoverflow.com/questions/36413652/3d-surface-interpolation
spline_interpolated <- interp(loc_gc$lon, loc_gc$lat, loc_gc$elevation,
                              xo=seq(min(loc_gc$lon), max(loc_gc$lon), length = n_interpolation),
                              yo=seq(min(loc_gc$lat), max(loc_gc$lat), length = n_interpolation),
                              linear = FALSE, extrap = FALSE,duplicate = "median")

x.si <- spline_interpolated$x
y.si <- spline_interpolated$y
z.si <- spline_interpolated$z

# zlim <- range(y.si)
# zlen <- zlim[2] - zlim[1] + 1
# # 
#  colorlut <- terrain.colors(zlen)
#  col <- colorlut[ z.si - zlim[1] + 1 ] # assign colors to heights for each point


library(mgcv)
library(deldir)
mod <- gam(elevation ~ te(lon, lat), data = loc_gc)

zfit <- fitted(mod)
col <- cm.colors(20)[1 + 
                       round(19*(zfit - min(zfit))/diff(range(zfit)))]

persp3d(deldir(loc_gc$lon, loc_gc$lat, z = zfit))

persp3d(x.si, y.si, z.si, col = "blue")

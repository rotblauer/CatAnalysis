#!/usr/bin/env bash


rsync -avz ./catterStatsStream.html arew:/home/freyabison/catStats.rotblauer.com/index.html
rsync -avz ./map.png arew:/home/freyabison/catStats.rotblauer.com/map.png

rsync -avz ./catterGL.html arew:/home/freyabison/catStats.rotblauer.com/catterGL.html
rsync -avz ./mapCat.png arew:/home/freyabison/catStats.rotblauer.com/mapCat.png

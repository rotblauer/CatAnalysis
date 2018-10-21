#!/usr/bin/env bash


rsync -avz ./catterStatsStream.html arew:/home/freyabison/catStats.rotblauer.com/index.html
rsync -avz ./map.png arew:/home/freyabison/catStats.rotblauer.com/map.png

rsync -avz ./getCats.html arew:/home/freyabison/punktlich.rotblauer.com/install/getCats.html
rsync -avz ./cat.png arew:/home/freyabison/punktlich.rotblauer.com/install/cat.png
#!/usr/bin/env bash


# rsync -avz ./catterStatsStream.html arew:/home/freyabison/catStats.rotblauer.com/index.html
# rsync -avz ./map.png arew:/home/freyabison/catStats.rotblauer.com/map.png

# rsync -avz ./catterGL.html arew:/home/freyabison/catStats.rotblauer.com/catterGL.html
# rsync -avz ./mapCat.png arew:/home/freyabison/catStats.rotblauer.com/mapCat.png


# cat metaS.html >base.html
# cat slamD.html >>base.html
# rsync -avz ./base.html arew:/home/freyabison/catStats.rotblauer.com/slamD.html
# rsync -avz ./slamD.png arew:/home/freyabison/catStats.rotblauer.com/slamD.png


rsync -avz ./walks.png arew:/home/freyabison/catStats.rotblauer.com/walks.png
rsync -avz ./catWalks.html arew:/home/freyabison/catStats.rotblauer.com/catWalks.html



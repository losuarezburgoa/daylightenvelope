% example3GrechiEtal2021eqareaSCR
addpath("../bins");

## Description.
## In Grechi et al. (2021), Fig. 12a (page 21) is plot one DLE related to a 
## plane with an orientation of 100/75. This script plots the DLE in equal-area
## spherical projection.
##
## Reference:
## Grechi, G., Fiorucci, M., Marmoni, G. M., & Martino, S.. (2021). 3D thermal
## monitoring of jointed rock masses through infrared thermography and 
## photogrammetry. Remote Sensing, 13(957), 1–25.
##

## Author: Ludger O. Suarez-Burgoa <losuarezb@unal.edu.co>
## Created: 2022-03-18

clear all

projStr = "equalarea";
[xyDaylight, xyPlane] = daylight (projStr, 100, 75);
## The figure.
figure()
hold on
plotdaylight (xyDaylight, xyPlane, 1);
hold off
box off
axis off
axis equal

%print example3GrechiEtal2021.svg

## Copyright (C) 2022 Ludger Suarez-Burgoa & Universidad Nacional de Colombia.
## BSD-3 License.
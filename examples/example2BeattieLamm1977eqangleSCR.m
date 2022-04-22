% example2BeattieLamm1977eqangleSCR
addpath("../bins");

## Description.
## Plots the daylight-envelope (DLE) that is shown in Fig. 10c (page 31) in 
## [Beattie.Lam1977.article] in the equal-angle spherical projection. 
## The plane whose DLE is plot here is that of orientation 050/65, given in 
## dip-direction and dip in degrees. 
##
## Reference:
## Beattie, A. A., & Lam, C. L.. (1977). Rock slope failures: Their prediction 
## and prevention. Hong Kong Engineer, Journal of the Honk Kong Institution of 
## Engineers, 5(7), 27–40.
##
## Author: Ludger O. Suarez-Burgoa <losuarezb@unal.edu.co>
## Created: 2022-03-18

clear all

projType = 'equalangle';
[xyDaylight, xyPlane] = daylight (projType, 050, 65);
## The figure.
figure()
hold on
plotdaylight (xyDaylight, xyPlane, 1);
hold off
box off
axis off
axis equal

%print example2BeattieLamm1977eqangle.svg

## Copyright (C) 2022 Ludger Suarez-Burgoa & Universidad Nacional de Colombia.
## BSD-3 License.
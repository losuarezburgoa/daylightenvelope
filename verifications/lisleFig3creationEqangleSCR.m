% lisleFig3creationEqangleSCR
addpath(genpath('../bins'));

## Descrition.
##
## Plots the Figure 3 of the Lisle2004.article with the use of the created
## function 'daylight',  but in the equal-angle projection.
## Figure 3 title is: Examples of computer-drawn daylight envelopes for a
## series of dipping rock faces with angles of dip ranging from 5 to 85 degrees.
## This figure could be used as a reference equal-angle net for tracing off the
## appropriate daylight curve.
## The planes all have dip-direction to the East.
##
## Reference:
## R.J. Lisle, 2004. Calculation of the daylight envelope for plane failure of 
## rock slopes. Gèotechnique, Vol.54(4): 279-280.

## Author: Ludger O. Suarez-Burgoa <losuarezb@unal.edu.co>
## Created: 2022-02-24

clear all
## Input  variables.
# The dip angle of planes that have dip-direction to the East.
d = 0:5:90;
# alternative test for extreme values.
%d = [0:1:10, 85:1:90];

## The figure.
figure()
hold on
# The planes' traces and their respective DLE.
for ii=1:1:length(d)
    [xyDaylight, xyPlane] = daylight ('equalangle', 90, d(ii));
    plotdaylight (xyDaylight, xyPlane, ii==1);
endfor
# The labels.
xl = -sqrt(1 ./ (1 + sind(90) .* sind(90-d))) .* sind(90) .* cosd(90-d);
yl = zeros(size(xl));
labelNum = d(1:2:length(d));
labelText = cellstr(num2str(labelNum'));
text(xl(1:2:length(d)), yl(1:2:length(d)), labelText, 'horizontalalignment', ...
    'center');
# Closing the plot.
hold off
box off
axis off
axis equal

%print lisleFig3Eqanglecreation.svg

## Copyright (C) 2022 Ludger Suarez-Burgoa & Universidad Nacional de Colombia.
## BSD-3 License.
## -*- texinfo -*- 
## @deftypefn {} {@var{[]} =} plotlislealldipplanes (@var{projStr}, 
##   @var{dType}, @var{dleNpts}, @var{genType}, @var{wantRecomm}, @var{npts})
##
## Is a specific function that creates many daylight envelopes for its
## corresponding planes. The user should specify the spherical projection where
## the plot is wanted to show with the variable @var{projStr}; a string that can
## have values of 'equalarea' or 'equalangle'.
## There are two set of planes whose dips are preimplemented, those specified
## with the variable @var{dType}. One, that groups planes with dip starting from
## 0 to 90 degrees equal spaced every 5 degrees, when the string is 'eq5'.
## The other groups a planes that are spaced every 1 degree, but near the zero
## and the 90 degrees (the extremes), when the string is 'fine10'. It generates
## planes from 0 to 10 spaced every 1 degree and from 85 to 90 degrees, also
## spaced every 1 degree.
## Appart of the plane set specification, the user can select the numbers of 
## points the Daylight-Evelopes will be formed with, this with the variable
## @var{dleNpts}, which is by default 45 points. Also the function provides with
## chossing the probabilisic density function to be used in the points spacing,
## which can be of type 'uniform', 'triangular' or 'saltbox' at the variable
## @var{genType}. 
## If the user does not an idea of how many points is a good number to plot the
## daylight-evelope's curve, with the variable @var{wantRecomm} setting 'true'
## will allow the program to set a recommendation number of points.
## THe number of points to be used to plot the plane's trace can be controled
## with the variable @var{npts}.
## All the planes are assumed to be oriented to the East.
## The plot shows also the labels of the dip-values for each generated plane.
##
## @seealso{daylight, plotdaylight}
## @end deftypefn

## Author: Ludger O. Suarez-Burgoa <losuarezb@unal.edu.co>
## Created: 2022-03-23

function [] = plotalldipplanes (projStr, dType='eq5', dleNpts=45,  ...
    genType='saltbox', wantRecomm=false, npts=36)
## Input  variables.
# The dip angle of planes that have dip-direction to the East.
switch dType
    case 'eq5'
        d = 0:5:90;
    case 'fine10'
        d = [0:1:10, 85:1:90];
    otherwise
        error("String type for 'd' should be 'eq5' or 'fine10'!")
endswitch

## The figure.
hold on
# The planes' traces and their respective DLE.
for ii = 1:1:length(d)
    [xyDaylight, xyPlane] = daylight (projStr, 90, d(ii), dleNpts, ...
        genType, wantRecomm, npts);
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
box off
axis off
axis equal
endfunction
## Copyright (C) 2022 Ludger Suarez-Burgoa & Universidad Nacional de Colombia.
## BSD-3 License.
## https://opensource.org/licenses/BSD-3-Clause
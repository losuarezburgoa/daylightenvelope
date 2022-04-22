## -*- texinfo -*- 
## @deftypefn {} {@var{[]} =} plotdaylight (@var{xyDaylight}, @var{xyPlane},
##    @var{plotAddsTrue})
##
## Plots the daylight envelope with the coordiantes in @var{xyDaylight}, the
## trace of the plane with the coordiantes @var{xyPlane}, and other added 
## features in the unit circle that represents a spherical projection.
## The variables @var{xyDaylight} and @var{xyPlane} are obtained after running
## theh @fun{daylight}. If @var{plotAddsTrue} is true, in the plot is drawn
## the North, the center ans the great circle of the spherical projection.
##
## @seealso{daylight}
## @end deftypefn

## Author: Ludger O. Suarez-Burgoa <losuarezb@unal.edu.co>
## Created: 2022-02-23

function [] = plotdaylight (xyDaylight, xyPlane, plotAddsTrue=false)

xE = xyDaylight(1,:);
yE = xyDaylight(2,:);
xg = xyPlane(1,:);
yg = xyPlane(2,:);

## The greatest great circle: The unit circle.
thetaG = linspace(0, 2*pi, 36);
xG = cos(thetaG);
yG = sin(thetaG);

## Plotting ...
hold on
# Extended plot features.
if plotAddsTrue
    # the north tick line and text,
    plot(zeros(1,2), [1, 1.05], 'k-');
    th = text(0, 1.05, 'N', 'horizontalalignment', 'center', ...
        'verticalalignment', 'bottom');
    # the greatest great circle,
    plot(xG, yG, 'k-');
    # the center of the gratest great circle,
    plot(0, 0, 'k+');
endif
# The daylight envelopes.
if and(length(xE) == 1, length(yE) == 1)
    plot(xE, yE, 'rx');
else
    plot(xE, yE, 'r-');
endif
# the great circles.
plot(xg, yg, 'b-');

endfunction
## Copyright (C) 2022 Ludger Suarez-Burgoa & Universidad Nacional de Colombia.
## BSD-3 License.
## https://opensource.org/licenses/BSD-3-Clause
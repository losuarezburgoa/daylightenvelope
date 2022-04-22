## -*- texinfo -*- 
## @deftypefn {} {@var{xyPlane}, @var{r} =} planeeqareaeastgen (@var{d}, 
##     @var{npts})
##
## Creates the coordinates of the plane's trace related to @var{d}, for a plane 
## that is oriented Eastwards in the equal-area spherical projection. 
##
## The input @var{d} is the dip-angle from which the x-y coordiantes of the 
## plane's  trace is wanted to generate.
## Variable @var{npts} is the number of points the plane's trace is wanted to 
## discretize.
## The result is stored in variable @var{xyPlane} which 
## is a matrix of @var{npts} rows and 2 columns. The colums are representing the
## x and y coordiantes of every point. The function returns also a vector of 
## @var{npts} of length, with the values of rake-angles from which each pair of
## x-y coordiantes comes.
##
## @seealso{planeqangleeastgen}
## @end deftypefn

## Author: Ludger O. Suarez-Burgoa <losuarezb@unal.edu.co>
## Created: 2022-03-18

function [xyPlane, r] = planeeqareaeastgen (d, npts=36)
    r = linspace(0, 180, npts);
    [dDegM, rDegM] = meshgrid (d, r);
    # The transformation factor is k.
    k = sqrt(2 ./ (1 + sind(rDegM) .* sind(dDegM)));
    # Coordiantes (xg, yg) in the Cartesian system of the plane trace.
    # The factor k was also divided by sqrt(2) to have a unit circle.
    f = sqrt(2);
    xg = k/f .* cosd(dDegM) .* sind(rDegM);
    yg = k/f .* cosd(rDegM);
    xyPlane = [xg(:)'; yg(:)'];
endfunction
## Copyright (C) 2022 Ludger Suarez-Burgoa & Universidad Nacional de Colombia.
## BSD-3 License.
## https://opensource.org/licenses/BSD-3-Clause
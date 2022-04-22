## -*- texinfo -*- 
## @deftypefn {} {@var{n} =} dip2maxpoints (@var{d})
##
## Given a dip-angle value of @var{d}, from which a daylight envelope is wanted 
## to generate, the function returns a recommended value of the number of points
## the daylight envelope will have for its approximation with a polygon.
## This value is returned in the variable @var{n}.
##
## @seealso{dip2rakeofmaxcurvature}
## @end deftypefn

## Author: Ludger O. Suarez-Burgoa <losuarezb@unal.edu.co>
## Created: 2022-03-23

function n = dip2maxpoints (d)
    limAngleDeg = 80;

    npFitFun = @(x) 78/10000 .* x.^2 .* and(x >= 0, x <= limAngleDeg) + ...
        50 .* and(x > limAngleDeg, x <= 90);
    n = floor(npFitFun(d)) + 1;
endfunction
## Copyright (C) 2022 Ludger Suarez-Burgoa & Universidad Nacional de Colombia.
## BSD-3 License.
## https://opensource.org/licenses/BSD-3-Clause
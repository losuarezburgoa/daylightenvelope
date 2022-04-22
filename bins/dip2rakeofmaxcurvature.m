## -*- texinfo -*- 
## @deftypefn {} {@var{rk} =} dip2rakeofmaxcurvature (@var{d})
##
## Given a dip-angle value of @var{d}, from which a daylight envelope is wanted 
## to generate, the function returns a recommended value of the rake where the 
## maximum curvature of the daylight envelope is located, returned in @var{rk}.
##
## @seealso{dip2maxpoints}
## @end deftypefn

## Author: Ludger O. Suarez-Burgoa <losuarezb@unal.edu.co>
## Created: 2022-03-23

function rk = dip2rakeofmaxcurvature (d)
    pOrigin = [5, 45];
    a = 50/10000;

    kFitOriginFun = @(x) pOrigin(2) + a .* (x - pOrigin(1)).^2;
    rk = kFitOriginFun(d) .* and(d > pOrigin(1), d <= 90) + ...
        pOrigin(2) .* and(d >= 0, d <= pOrigin(1));
endfunction
## Copyright (C) 2022 Ludger Suarez-Burgoa & Universidad Nacional de Colombia.
## BSD-3 License.
## https://opensource.org/licenses/BSD-3-Clause
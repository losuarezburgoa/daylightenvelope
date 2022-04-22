## -*- texinfo -*- 
## @deftypefn {} {@var{xx} =} rndtriang (@var{a}, @var{b}, @var{c}, , @var{n}
##    , @var{genType})
##
## Generates random numbers of a triangular nonsymetric distribution between 
## the interval [a, b], being c the mode of the distribution.
##
## @seealso{rndsaltbox}
## @end deftypefn

## Author: Ludger O. Suarez-Burgoa <losuarezb@unal.edu.co>
## Created: 2022-02-24

function [xx] = rndtriang (a, b, c, n=50, genType="rnd")

fx1 = @(x) 2*(x-a) / (b-a) / (c-a);                                                                              
fx2 = @(x) 2*(b-x) / (b-a) / (b-c);

Fx1 = @(x) (a^2 - 2*a*x + x.^2) / ((a - b)*(a - c));
Fx2 = @(x) (a^2 - 2*a*c + c^2) / ...
    ((a - b)*(a - c)) + (2*b*c - c^2 - 2*b*x + x.^2) / ((a - b)*(b - c));

xu1 = @(u) a + sqrt(u*a^2 - u*a*b - (u*a - u*b)*c);
xu2 = @(u) b - sqrt((u - 1)*a*b - (u - 1)*b^2 - ((u - 1)*a - (u - 1)*b)*c);

U1lim = Fx1(c);
U2lim = Fx2(c);

switch genType
    case "rnd"
        u = rand(1, n);
    case "lin"
        u = linspace(0, 1, n);
endswitch

xx1 = and(u >= 0, u < U1lim) .* xu1(u);
xx2 = and(u >= U2lim, u <= 1) .* xu2(u);

xx = xx1 + xx2;

endfunction
## Copyright (C) 2022 Ludger Suarez-Burgoa & Universidad Nacional de Colombia.
## BSD-3 License.
## https://opensource.org/licenses/BSD-3-Clause
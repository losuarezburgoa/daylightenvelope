## -*- texinfo -*- 
## @deftypefn {} {@var{uu} =} rndsaltbox (@var{a}, @var{b}, @var{c}, @var{p}, 
##    @var{n} , @var{genType})
##
## Generates random numbers of a saltbox distribution between the interval 
## [a, b], being c the mode and p the shape factor of the distribution.
##
## @seealso{rndtriang}
## @end deftypefn

## Author: Ludger O. Suarez-Burgoa <ludger@losuarezb>
## Created: 2022-03-17

function [uu] = rndsaltbox (a, b, c, p, n=50, genType="rnd")
    
# Storing the absolute values in new variables.
aa = a;
bb = b;

# Relative values.
c = (c - a) / (b - a);
a = 0; 
b = 1;
hc = p + 1;

# The Cummulative Density Functions (CDF) of the saltbox distribution.
Fx1 = @(x) 1/2 * (a^2*hc - 2*a*hc*x + hc*x.^2) / (c - a);
Fx2 = @(x) 1/2 * (((c + a - 2*b)*hc + 2) * x.^2 + ...
    2*c^2 + (2*c*a*b - (c + a)*b^2)*hc - 2*((c*a - b^2)*hc + 2*c) .* x) ./ ...
    (c^2 - 2*c*b + b^2);
# The functions that will generate the random numbers.
xu1 = @(u) (a * hc + sqrt(2) * sqrt((u*c - u*a)*hc)) / hc;
xu2 = @(u) ((c * a - b^2) * hc - sqrt((a^2 - 2*a*b + b^2) * hc^2 + ...
    2*((u - 1)*c + (u + 1)*a - 2*u*b) * hc + 4*u) * ...
    (c - b) + 2*c) / ((c + a - 2*b) * hc + 2);

switch genType
    case "rnd"
        u = rand(1, n);
    case "lin"
        u = linspace(0, 1, n);
endswitch

# Evaluating both functions.
U1lim = Fx1(c);
U2lim = Fx2(c);
uuHat = and(u >= 0, u < U1lim) .* xu1(u) + and(u >= U2lim, u <= 1) .* xu2(u);
# Transforming to the input limits.
uu = aa + (bb - aa) * uuHat;

endfunction
## Copyright (C) 2022 Ludger Suarez-Burgoa & Universidad Nacional de Colombia.
## BSD-3 License.
## https://opensource.org/licenses/BSD-3-Clause
## -*- texinfo -*- 
## @deftypefn {} {@var{rArray} =} genrakelist0to90uniform (@var{d}, 
##     @var{dleNpts}, var{wantRecomm}, var{minNumPoints})
##
## Generates a list of @var{dleNpts} rake-angle values from 0 to 90 degrees, 
## under an uniform distribution, to be used to plot the daylight envelope
## related to a plane with dip @var{d}.
##
## If the flag @var{wantRecomm} is set to 'true', the @var{dleNpts} value is 
## ommited and the function recommends a value.
## The user can also set the minimum number of points to be considered to add
## to the recommended value, this with variable @var{minNumPoints}.
## The function returns a vector with a variable length, depending on the 
## input options, of rake-values to be used in the generation of the daylight
## envelope.
##
## @seealso{genrakelist0to90triangular, genrakelist0to90saltbox}
## @end deftypefn

## Author: Ludger O. Suarez-Burgoa <losuarezb@unal.edu.co>
## Created: 2022-03-23

function rArray = genrakelist0to90uniform (d, dleNpts=45, wantRecomm=false, ...
            minNumPoints=3)
    # Number of maximum points.
    if wantRecomm
        n = minNumPoints + dip2maxpoints (d, dleNpts);
    else
        if dleNpts < minNumPoints
            error('Minimum points is 3!');
        else
            n = dleNpts;
        endif
    endif
    # Using the function 'linspace' it generates 'dleNpts' ordered values under  
    # the uniform distribution in the real-line. Rake varies equal spaced 
    # between [0, 90] degrees.
    rArray = linspace(0, 90, n);
endfunction
## Copyright (C) 2022 Ludger Suarez-Burgoa & Universidad Nacional de Colombia.
## BSD-3 License.
## https://opensource.org/licenses/BSD-3-Clause
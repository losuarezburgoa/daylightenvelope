## -*- texinfo -*- 
## @deftypefn {} {@var{xyDaylight}, @var{r} =} daylighteqareaeastgen 
##     (@var{d}, @var{dleNpts}, @var{genType}, @var{wantRecomm})
##
## Creates the coordinates of the daylight-envelope related to @var{d}, for a 
## plane that is oriented Eastwards in the equal-area spherical projection.
## 
## The input @var{d} is the dip-angle from which the x-y coordiantes of the 
## plane's  trace is wanted to generate.
## Variable @var{npts} is the number of points the plane's trace is wanted to 
## discretize.
##
## Appart of the plane set specification, the user can select the numbers of 
## points the Daylight-Evelopes will be formed with, this with the variable
## @var{dleNpts}, which is by default 45 points. Also the function provides with
## chossing the probabilisic density function to be used in the points spacing,
## which can be of type 'uniform', 'triangular' or 'saltbox' at the variable
## @var{genType}. By default is set to 'saltbox'. 
## If the user does not an idea of how many points is a good number to plot the
## daylight-evelope's curve, with the variable @var{wantRecomm} setting 'true'
## will allow the program to set a recommendation number of points.
##
## The result is stored in variable @var{xyDaylight} which 
## is a matrix of @var{npts} rows and 2 columns. The colums are representing the
## x and y coordiantes of every point. The function returns also a vector of 
## @var{npts} of length under the name @var{r}, with the values of rake-angles 
## from which each pair of x-y coordiantes comes.
##
## @seealso{genrakelist0to90uniform, genrakelist0to90triangular, 
##     genrakelist0to90saltbox, daylighteqangleeastgen}
## @end deftypefn

## Author: Ludger O. Suarez-Burgoa <losuarezb@unal.edu.co>
## Created: 2022-03-18

function [xyDaylight, r] = daylighteqareaeastgen (d, dleNpts=45, ...
    genType='saltbox', wantRecomm=false)
    # Selection uniform points to generate the coordinates (linear) or using 
    # an algorithm to generate spaced coordinates accordingn to curvature.
    switch genType
        case 'uniform'
            r90array = genrakelist0to90uniform (d, dleNpts, wantRecomm);
        case 'triangular'
            r90array = genrakelist0to90triangular (d, dleNpts, wantRecomm);
        case 'saltbox'
            r90array = genrakelist0to90saltbox (d, dleNpts, wantRecomm);
        otherwise
            error(["The string to flag should be ", ...
                "'uniform', 'triangular' or 'saltbox'!"]);
    endswitch
    r = [r90array, 180-fliplr(r90array)];
    ## Creating the different combinations of d and r as mesh.
    [dDegM, rDegM] = meshgrid (d, r);
    ## Calculatinig the transformation factor K (Eq. 11 qnd 12).
    # Auxiliary variable.
    tk = sqrt(1 - sind(dDegM).^2 .* sind(rDegM).^2);
    # The reduced expression with the auxiliary value.
    K = sind(dDegM) .* sind(rDegM) ./ tk .* sqrt(2 ./ (1 + tk));
    # Coordiantes (xE, yE) in the Cartesian system of the daylight envelope.
    # The factor K was divided by sqrt(2) to have a unit circle.
    f = sqrt(2);
    xE = -K/f .* cosd(dDegM) .* sind(rDegM);
    yE = -K/f .* cosd(rDegM);
    xyDaylight = [xE(:)'; yE(:)'];
endfunction
## Copyright (C) 2022 Ludger Suarez-Burgoa & Universidad Nacional de Colombia.
## BSD-3 License.
## https://opensource.org/licenses/BSD-3-Clause
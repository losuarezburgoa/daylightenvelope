## -*- texinfo -*- 
## @deftypefn {} {[@var{xyDaylightE}, @var{xyPlaneE}, @var{rdle}, @var{rp}] =} 
##     daylighteast (@var{projStr}, @var{d}, @var{dleNpts}, 
##     @var{genType}, @var{wantRecomm}, @var{npts})
##
## Creates the coordinates of the daylight-envelope related to @var{d}, for a 
## plane that is oriented Eastwards; also creates the coordinates of the plane's
## trace related to the same plane; in the in the equal-angle or equal-area 
## spherical projection, depending the flag value in @var{projStr}.
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
## Simmilar, the result is stored in variable @var{xyPlane} which 
## is a matrix of @var{npts} rows and 2 columns. The colums are representing the
## x and y coordiantes of every point. 
##
## The function returns also a vector of @var{dleNpts} of length (or the 
## generated after the programm recommended), with the values of rake-angles 
## from which each pair of x-y coordiantes comes for the plane's trace; stored 
## in the variable @var{rdle}.
## Simmilar, the function returns also a vector of @var{npts} of length, with 
## the values of rake-angles from which each pair of x-y coordiantes comes for 
## the plane's trace; stored in the variable @var{rp}.
##
## The variable @var{npts} is the number of points the plane's trace is wanted 
## to discretize and set by default to 36 points.
##
## @seealso{daylight, daylighteqareaeastgen, daylighteqangleeastgen, 
##     planeeqareaeastgen, planeeqangleeastgen}
## @end deftypefn

## Author: Ludger O. Suarez-Burgoa <losuarezb@unal.edu.co>
## Created: 2022-02-22

function [xyDaylightE, xyPlaneE, rdle, rp] = daylighteast (projStr, d, ...
    dleNpts=45, genType='saltbox', wantRecomm=false, npts=36)
    
    # Guaratying d is between 0 and 90.
    if d > 90, d = mod(d, 90) endif;
    # Analysing special cases.
    switch d
        case 0
            # plane has dip=0
            [xyDaylightE, rdle] = pointdaylight;
            [xyPlaneE, rp] = opensemicircleeast(npts);
        case 90
            # plane has dip=90
            [xyDaylightE, rdle] = closedsemicirclewest(npts);
            [xyPlaneE, rp] = lineplanetrace;
        otherwise
            # the general case
            switch projStr
                case 'equalarea'
                    [xyDaylightE, rdle] = daylighteqareaeastgen (d, ...
                        dleNpts, genType, wantRecomm);
                    [xyPlaneE, rp] = planeeqareaeastgen (d, npts);
                case 'equalangle'
                    [xyDaylightE, rdle] = daylighteqangleeastgen (d, ...
                            dleNpts, genType, wantRecomm);
                    [xyPlaneE, rp] = planeeqangleeastgen (d, npts);
                otherwise
                    error(["String of the projection should be ", ...
                        "'equalangle' or 'equalarea'!"]);;
            endswitch
    endswitch
endfunction

function [xyArray, thetaDeg] = pointdaylight
    xyArray = [0; 0];
    thetaDeg = 90;
endfunction

function [xyArray, thetaDeg] = opensemicircleeast(npts)
    theta = linspace(0, pi, npts) - pi/2;
    thetaDeg = rad2deg(theta);
    xyArray = [cos(theta); sin(theta)];
endfunction

function [xyArray, thetaDeg] = closedsemicirclewest(npts)
    theta = linspace(0, pi, npts) - pi/2;
    thetaDeg = rad2deg(theta);
    xyArray = [cos(theta); sin(theta)];
    xyArray = -[xyArray, xyArray(:,1)];
    thetaDeg = [thetaDeg, thetaDeg(1)];
endfunction

function [xyArray, thetaDeg] = lineplanetrace
    xyArray = [0, 0; -1, 1];
    thetaDeg = [0, 180];
endfunction
## Copyright (C) 2022 Ludger Suarez-Burgoa & Universidad Nacional de Colombia.
## BSD-3 License.
## https://opensource.org/licenses/BSD-3-Clause
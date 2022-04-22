## -*- texinfo -*- 
## @deftypefn {} {[@var{xyDaylightE}, @var{xyPlaneE}, @var{rdle}, @var{rp}] =} 
##     daylight (@var{projStr}, @var{ddir}, @var{d}, @var{dleNpts}, 
##     @var{genType}, @var{wantRecomm}, @var{npts})
##
## Creates the coordinates of the daylight-envelope related to @var{d}, for a 
## plane that is oriented according to its dip-direction angle in variable 
## @var{ddir}; also creates the coordinates of the plane's trace related to 
## the same plane; in the in the equal-angle or equal-area 
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
## The variable @var{npts} is the number of points the plane's trace is wanted 
## to discretize and set by default to 36 points.
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
## @seealso{daylight, daylighteast, daylighteqareaeastgen, 
##     daylighteqangleeastgen, planeeqareaeastgen, planeeqangleeastgen}
## @end deftypefn

## Author: Ludger O. Suarez-Burgoa <losuarezb@unal.edu.co>
## Created: 2022-02-23

function [xyDaylight, xyPlane, rdle, rp] = daylight (projStr, ddir, d, ...
    dleNpts=45,  genType='saltbox', wantRecomm=false, npts=36)
    ## Evaluating at East.
    # Obtains the plane's trace and the DLE curves.
    [xyDaylightE, xyPlaneE, rdle, rp] = daylighteast (projStr, d, ...
        dleNpts, genType, wantRecomm, npts);
    ## Rotating to the ddir.        
    # Obtaining the rotation matrix.
    if ddir == 90
        xyDaylight = xyDaylightE;
        xyPlane = xyPlaneE;
    else
        # Rotates the two mentioned curves into the specified orinetation.
        thetaDeg = ddir - 90;
        Rmat = [cosd(thetaDeg), sind(thetaDeg); ...
            -sind(thetaDeg), cosd(thetaDeg)];
        xyDaylight = Rmat * xyDaylightE;
        xyPlane = Rmat * xyPlaneE;
    endif
endfunction
## Copyright (C) 2022 Ludger Suarez-Burgoa & Universidad Nacional de Colombia.
## BSD-3 License.
## https://opensource.org/licenses/BSD-3-Clause
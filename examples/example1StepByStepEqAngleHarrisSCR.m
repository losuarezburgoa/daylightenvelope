% example1StepByStepEqAngleHarrisSCR
clear all

## Description:
## The cut slope at chaining 7000 Tuen Mun Road (Honk Kong) dips at an angle 
## 75 degrees (3:1, vertical:horizontal) in a dip direction of 8 degrees 
## --nearly due north.
## ... A further construction, based on this (the cut-slope plane) leads to an 
## ovoid daylight zone which encloses all those poles representing joint planes 
## dipping out of the slope.
## Plot the Datlight Envelope (DLE) by using equations for the equal-angle 
## projection.
##
## Reference:
## R. Harris, 1982. Stereographic projections for the engineering rock. 
## Hong Kong Engineer, Journal of the Honk Kong Institution of Engineers, 
## Vol.10(8): 37-47.


# The problem will be solved first as is the dip-direction is at the East, then
# d_{dir} = 130 degrees and the diference is dDiff.
dDir = 008;
theta = dDir - 90;

# The dip direction is 70.
d = 75;

# To plot the plane's trace, we will generate 18 points according to each
# rake (pitch) r.
n = 18;
ii = 0:1:n;
r = linspace(0, 180, n+1);


# PART 1: Creating.
# We obtaing cos(d) and sin(d) which will usefull to have.
cd = cosd(d);
sd = sind(d);

# The values are tabulated.

cr = cosd(r);
sr = sind(r);
A = sr * sd;
B = sr * cd;
k1p = 1 ./ (1 + A);
x = k1p .* B;
y = k1p .* cr;

# No we will find the coordiantes of the Daylight-Envelope simmilar to the
# above table but using Eq. 26.
C = sqrt(1 - A.^2);
K1 = A ./ (C.^2 + C);
xE = -K1 .* B;
yE = -K1 .* cr;


## PART 2: Rotating.
# The rotation matrix.
R = [cosd(theta), sind(theta); -sind(theta), cosd(theta)];
# Matrix of points of the slope's trace.
D = [x; y];
E = [xE; yE];

Dabs = R * D;
Eabs = R * E;


# PART 3: The great circle.
# The great circle.
xG = [cr, -cr(2:end)];
yG = [sr, -sr(2:end)];
iiG = 0:1:(2*n-0);

# PART 4: Plotting.
lbl = cellstr(num2str(ii'));
lblG = cellstr(num2str(iiG'));
dx = 0.05;
dy = 0;
limP = 1.2;

# The unrotated plane trace and the DLE.
figure()
hold on
plot(x, y, 'ko-');
plot(xE, yE, 'k^-');
plot(xG, yG, 'kx-');
axis equal
hold off
set(gca, 'XAxisLocation', 'origin', 'YAxisLocation', 'origin');
xticks(-1:0.2:1);
yticks(-1:0.2:1);
xlim(limP*[-1, 1]);
ylim(limP*[-1, 1]);
grid on
legend({'Plane''s Trace', 'Daylight Env.', 'Great Circ.'});
legend('Orientation','horizontal');
legend('Location', 'southoutside');
legend boxoff 
%print example1unrotTraceAndDLEeqangleHarris.svg

# The rotated plane trace and the DLE.
figure()
hold on
plot(Dabs(1,:), Dabs(2,:), 'ko-');
plot(Eabs(1,:), Eabs(2,:), 'k^-');
plot(xG, yG, 'kx-');
axis equal
hold off
set(gca, 'XAxisLocation', 'origin', 'YAxisLocation', 'origin');
xticks(-1:0.2:1);
yticks(-1:0.2:1);
xlim(limP*[-1, 1]);
ylim(limP*[-1, 1]);
grid on
legend({'Plane''s Trace', 'Daylight Env.', 'Great Circ.'});
legend('Orientation','horizontal');
legend('Location', 'southoutside');
legend boxoff
%print example1rotTraceAndDLEeqangleHarris.svg

## Display tables at terminal.
%display("Table 1. Trigonometric calculations of angles d and r.");
%display(sprintf("r\tcr\tsr\tA\tB\tC"));
%for k = 1:1:(n+1)
%    display(sprintf("%3.0f\t%7.4f\t%7.4f\t%7.4f\t%7.4f\t%7.4f", ...
%        [r(k), cr(k), sr(k), A(k), B(k), C(k)]));
%endfor
%
%display("Table 2. K coefficients and unrotated coordinates.");
%display(sprintf("r\tk1\tK1\tx\ty\txE\tyE\txG\tyG"));
%for k = 1:1:(n+1)
%    display(sprintf("%3.0f\t%5.2f\t%5.2f\t%5.2f\t%5.2f\t%5.2f\t%5.2f\t%5.2f\t%5.2f", ...
%        [r(k), k1p(k), K1(k), x(k), y(k), xE(k), yE(k), xG(k), yG(k)]));
%endfor
%
%display("Table 3. Rotated coordinates.");
%display(sprintf("r\tx\ty\txE\tyE"));
%for k = 1:1:(n+1)
%    display(sprintf("%3.0f\t%5.2f\t%5.2f\t%5.2f\t%5.2f", ...
%        [r(k), Dabs(1,k), Dabs(2,k), Eabs(1,k), Eabs(2,k)]));
%endfor
%%display(sprintf("%8d%8.0f%8.4f", 1,2.0,-cosd(30)));

## Create an HTMl table.

display("<table id='tab_trigCalcsAngDandR'>");
display("  <caption>Trigonometric calculations of angles d and r.</caption>");
display(sprintf("  <tr><th>\\(%s\\)</th><th>\\(%s\\)</th><th>\\(%s\\)</th><th>\\(%s\\)</th><th>\\(%s\\)</th><th>\\(%s\\)</th></tr>", ...
   'r', 'cr', 'sr', 'A', 'B', 'C'));
for k = 1:1:(n+1)
    display(sprintf("  <tr><td>%3.0f</td><td>%7.4f</td><td>%7.4f</td><td>%7.4f</td><td>%7.4f</td><td>%7.4f</td></tr>", ...
        [r(k), cr(k), sr(k), A(k), B(k), C(k)]));
endfor
display("</table>");

display("<table id='tab_kCoeffsAndCoords'>");
display("  <caption>K coefficients and unrotated coordinates.</caption>");
display(sprintf("  <tr><th>\\(%s\\)</th><th>\\(%s\\)</th><th>\\(%s\\)</th><th>\\(%s\\)</th><th>\\(%s\\)</th><th>\\(%s\\)</th><th>\\(%s\\)</th><th>\\(%s\\)</th><th>\\(%s\\)</th></tr>", ...
   'r', 'k''_1', 'K_1', 'x', 'y', 'x_E', 'y_E', 'x_G', 'y_G'));
for k = 1:1:(n+1)
    display(sprintf("  <tr><td>%3.0f</td><td>%5.2f</td><td>%5.2f</td><td>%5.2f</td><td>%5.2f</td><td>%5.2f</td><td>%5.2f</td><td>%5.2f</td><td>%5.2f</td></tr>", ...
        [r(k), k1p(k), K1(k), x(k), y(k), xE(k), yE(k), xG(k), yG(k)]));
endfor
display("</table>");

display("<table id='tab_rotatedCoords'>");
display("  <caption>Rotated coordinates.</caption>");
display(sprintf("  <tr><th>\\(%s\\)</th><th>\\(%s\\)</th><th>\\(%s\\)</th><th>\\(%s\\)</th><th>\\(%s\\)</th></tr>", ...
   'r', 'x', 'y', 'x_E', 'y_E'));
for k = 1:1:(n+1)
    display(sprintf("  <tr><td>%3.0f</td><td>%5.2f</td><td>%5.2f</td><td>%5.2f</td><td>%5.2f</td></tr>", ...
        [r(k), Dabs(1,k), Dabs(2,k), Eabs(1,k), Eabs(2,k)]));
endfor
display("</table>");
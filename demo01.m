%% MATH 6890 Demo 01. 
%
% 1D Polynomial Interpolation - study the approximation properties of
% polynomial interpolants on [0 1].
%
% A Horning. January 20, 2026

%% "Ground Truth" - function being interpolated

G = @(x) exp(-5*x.^2);
%G = @(x) cos(6./(0.2+x.^2));
%G = @(x) sqrt(x);

figure(1)
x = linspace(0,1,500).';
plot(x,G(x),'-','LineWidth',2)

%% Interpolation points

npts = 20;
%xpts = linspace(0,1,npts+1).';
xpts = chebpts(npts+1,[0 1]);

figure(1), hold on
plot(xpts,G(xpts),'or')
hold off

%% Construct interpolant by 'fitting' dictionary at n+1 points

D = @(x) (x).^(0:npts);             % dictionary of monomials
%D = legpoly(0:npts,[0 1]);         % dictionary of Legendre polynomials
coeffs =  D(xpts) \ G(xpts);        % dictionary fit to data

figure(1), hold on
plot(x, D(x)*coeffs,'LineWidth',2)
err = max(abs(G(x)-D(x)*coeffs))

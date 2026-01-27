%% MATH 6890 Demo 02.
%
% 1D Polynomial Regression - study the approximation properties of
% polynomial approximants that "best fit" discrete data on [0 1].
%
% A Horning. January 22, 2026

%% "Ground Truth" - function being approximated

%G = @(x) exp(-5*x.^2);
G = @(x) cos(6./(0.2+x.^2));
%G = @(x) sqrt(x);

figure(1)
x = linspace(0,1,500).';
plot(x,G(x),'-','LineWidth',2)

%% Sample points for regression

npts = 120;
xpts = linspace(0,1,npts+1).';
%xpts = chebpts(npts+1,[0 1]);

figure(1), hold on
plot(xpts,G(xpts),'or')
hold off

%% Construct approximant by 'fitting' dictionary at << n+1 points

%D = @(x) (x).^(0:floor(sqrt(npts)));   % dictionary of monomials
D = legpoly(0:floor(npts/5),[0 1]);     % dictionary of Legendre polynomials
coeffs =  D(xpts) \ G(xpts);            % dictionary fit to data

figure(1), hold on
plot(x, D(x)*coeffs,'LineWidth',2)
err = max(abs(G(x)-D(x)*coeffs))

%% Plot approximation error as number of sample points increases

s = 2;
nnpts = 10:10:500;
errvec = zeros(size(nnpts));
for j = 1:length(nnpts)
    npts = nnpts(j);                        % number of points
    xpts = linspace(0,1,npts+1).';          % equispaced points
    D = legpoly(0:floor(npts/s),[0 1]);              % Legendre dictionary
    coeffs =  D(xpts) \ G(xpts);            % calculate coeffs
    errvec(j) = max(abs(G(x)-D(x)*coeffs)); % calculate error
end

figure(3) 
%hold on
semilogy(nnpts,errvec,'o')
set(gca, 'FontSize', 14)

%% Plot approximation error as polynomial degree increases

s = 2;
nnpts = 10:10:500;
errvec = zeros(size(nnpts));
for j = 1:length(nnpts)
    npts = nnpts(j);                        % number of points
    xpts = linspace(0,1,npts+1).';          % equispaced points
    D = legpoly(0:floor(npts/s),[0 1]);              % Legendre dictionary
    coeffs =  D(xpts) \ G(xpts);            % calculate coeffs
    errvec(j) = max(abs(G(x)-D(x)*coeffs)); % calculate error
end

figure(4) 
%hold on
semilogy(floor(nnpts/s),errvec,'o')
set(gca, 'FontSize', 14)

%% Compare with Chebyshev interpolant (near-best)

nnpts = 10:10:250;
errvec = zeros(size(nnpts));
for j = 1:length(nnpts)
    npts = nnpts(j);                        % number of points
    xpts = chebpts(npts+1,[0 1]);           % equispaced points
    D = legpoly(0:npts,[0 1]);              % Legendre dictionary
    coeffs =  D(xpts) \ G(xpts);            % calculate coeffs
    errvec(j) = max(abs(G(x)-D(x)*coeffs)); % calculate error
end

figure(4) 
hold on
semilogy(nnpts,errvec,'--r','LineWidth',2)
set(gca, 'FontSize', 14)

%% Plot condition number of oversampled dictionary as n-> infty


s = 2;
nnpts = 10:10:500;
condD = zeros(size(nnpts));
for j = 1:length(nnpts)
    npts = nnpts(j);                        % number of points
    xpts = linspace(0,1,npts+1).';          % equispaced points
    D = legpoly(0:floor(npts/s),[0 1]);     % Legendre dictionary
    condD(j) =  cond(D(xpts));              % calculate condition number
end

figure(5) 
%hold on
semilogy(floor(nnpts),condD,'o')
set(gca, 'FontSize', 14)
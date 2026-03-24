%% MATH 6890 Demo04 - Data-Driven Advection with piDMD
%
% Illustrate the difficulties that advection poses for standard DMD, and
% demonstrate how building in physics (piDMD) to the DMD regression can
% improve the data-driven model learned from snapshot data.

%% Discrete time/space advection model

% wave speed
ws = 1.0;

% Spatial and temporal grid (e.g., "measurement" parameters)
npts = 800;
dx = 1/(npts-1);
dt = 0.01;
mpts = 20;

% discrete advection matrix on grid
b = [0; -1; zeros(npts-2,1)];
c = [0; 1; zeros(npts-2,1)];
B = toeplitz(b,c') / (2*dx);
B(1,end) = -1 / (2*dx);
B(end,1) = 1 / (2*dx);

% matrix exponential for discrete time propogation
T = expm(ws*B*dt);

% plot eigenvalues of discrete time matrices
lam = eig(T);
figure(1)
plot(real(lam),imag(lam),'or')
hold on
t = linspace(0,2*pi,200);
plot(cos(t),sin(t),'-b')
axis equal

% generate snapshot data for DMD
xgrid = linspace(0,1,npts).';
U = exp(-40*(xgrid-0.5).^2);
for j = 1:mpts
    U = [U T*U(:,end)];
end
X = U(:,1:end-1);
Y = U(:,2:end);

% plot singular values of data matrix X
figure(2)
semilogy(svd(X,'econ'),'o'), hold on

% SVD of data matrix for truncated DMD model
r = 8;
[W,S,V] = svd(X,"econ");
Wr = W(:,1:r);
Sr = S(1:r,1:r);
Vr = V(:,1:r);

% truncated DMD model
Tr = Wr' * Y * (Vr / Sr);
lamTr = eig(Tr);

% plot eigenvalues of reduced-order model
figure(1)
hold on
plot(real(lamTr),imag(lamTr),'xg')

%% Plot wave

figure(3)
u = U(:,1); %cos((xgrid-0.5).^2); %exp(-50*(xgrid-0.5).^2); %
h = plot(xgrid,u, 'LineWidth', 2);
grid on;
title('1D Advection');
xlabel('x (position)');
ylabel('u (density)');

xlim([0 1]);
ylim([min(u)*1.2, max(u)*1.2]);
for i = 1:10*mpts

    % Update plot with model
    %u = T*u;               % true model
    u = Wr*Tr*Wr'*u;        % DMD model

    % Update plot with next snapshot
    set(h, 'YData', u);
    
    % Force the draw and control speed
    drawnow;
    pause(0.05); % Adjust pause for speed (in seconds)
end

%% Plot piDMD model (shift-invariant + unitary)

F = dftmtx(npts) / sqrt(npts);
FTX = F*X;
FTY = F*Y;

lamP = diag(FTY*FTX'); % ./ diag(FTX*FTX');
lamP = lamP ./ abs(lamP);

% reduced-order model
Tp = F' * diag(lamP) * F;

% plot eigenvalues of physics-informed reduced-order model
figure(1)
hold on
plot(real(lamP),imag(lamP),'+y')

%% Plot wave

figure(3)
u = U(:,1);
h = plot(xgrid,u, 'LineWidth', 2);
grid on;
title('1D Advection');
xlabel('x (position)');
ylabel('u (density)');

xlim([0 1]);
ylim([min(U(:,1))*1.2, max(U(:,1))*1.2]);
for i = 1:10*mpts

    % Update plot with model
    %u = T*u;           % true model
    %u = Wr*Tr*Wr'*u;   % DMD model
    u = Tp*u;           % piDMD model

    % Update plot with next snapshot
    set(h, 'YData', real(u));
    
    % Force the draw and control speed
    drawnow;
    pause(0.05); % Adjust pause for speed (in seconds)
end

%% MATH 6890 Demo 03.
%
% Dynamic Mode Decomposition - recover a linear dynamical system from
% "snaphsot" data gathered along one or more trajectories.
%
% A Horning. February 12, 2026

%% Set up linear dynamical system for numerical integration
freq = pi;
damp = 0*freq;
A = [0 1; -freq.^2 -2*damp];
osc = @(t,y) [A(1,1)*y(1) + A(1,2)*y(2); A(2,1)*y(1)+A(2,2)*y(2)];

% numerically integrate ODE to get trajectory/snapshot data
y0 = [1, 0]; % rand(1,2); %                     % intial condition
Tstop = 2*2*pi/freq;                            % stopping time
Nsamp = 10*Tstop;                               % number of samples
tspan = linspace(0,Tstop,Nsamp);                % temporal grid for snapshots
opts = odeset('RelTol', 1e-12, 'AbsTol', 1e-14); % set time-stepping tols 
[t,y] = ode45(osc,tspan,y0,opts);               % numerically integrate ODE

% plot position and velocity trajectories
figure(1)
plot(t,y(:,1),'-o','LineWidth',2)                    % position
hold on, plot(t,y(:,2),'-o','LineWidth',2)           % velocity
title('Damped Oscillator Trajectories');
xlabel('Time t');
legend('Displacement','Velocity')
hold off

% plot state trajectory
figure(2)
title('State/Phase Space Trajectory')
plot(y(:,1),y(:,2),'-o','LineWidth',2)
xlabel('Displacement');
ylabel('Velocity');
axis equal

%% "Fit" linear dynamical model to snapshot data

% form snapshot matrices
X = y(1:end-1,:);
Y = y(2:end,:);

% solve least-squares problem
U = X \ Y;
res = norm(X*U-Y);
disp("Least-squares residual is " + res)

% compare linear model to "fit"
trueModel = expm( A*(t(2)-t(1)) )
fitModel = U.'
errModel = norm(trueModel-fitModel);
disp("Model error is " + errModel)

% compare eigenvalues
[trueV,trueD] = eig(trueModel)
[fitV,fitD] = eig(fitModel)

figure(3)
theta = linspace(0,2*pi,100);
plot(cos(theta),sin(theta),':b','LineWidth',2)
hold on
plot(linspace(0,1,100),zeros(100,1),':b','LineWidth',2)
plot(real(diag(trueD)),imag(diag(trueD)),'or','MarkerSize',10)
plot(real(diag(fitD)),imag(diag(fitD)),'+g','MarkerSize',10)
xlim([0 1])
axis equal

%% Test Model prediction

yPred = y(1,:);
yTrue = y(1,:);
for j = 2:2*length(tspan)-1
    yTemp1 = fitModel*yPred(end,:).';
    yTemp2 = trueModel*yTrue(end,:).';
    yPred = [yPred; yTemp1.'];
    yTrue = [yTrue; yTemp2.'];
end

% plot position and velocity trajectories
figure(4)
plot([t; t(end)+t(2:end)],yTrue(:,1),'-o','LineWidth',2)             % position (true)
hold on
plot([t; t(end)+t(2:end)],yTrue(:,2),'-o','LineWidth',2)         % velocity (true)
plot([t; t(end)+t(2:end)],yPred(:,1),'-+','LineWidth',1)        % position (predict)
plot([t; t(end)+t(2:end)],yPred(:,2),'-+','LineWidth',1)        % velocity (predict)
plot(Tstop*ones(1,100),linspace(-4,4,100),':','LineWidth',3)
hold off
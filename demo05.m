%% MATH 6890 Demo 05.
%
% Fourier averaging - compute isochrons of the Van der Pol oscillator
% using "snaphsot" data gathered along multiple trajectories.
%
% A Horning. April 13, 2026

%% Set up nonlinear oscillator for numerical integration
mu = 0.3;                           % nonlinear coupling strength
w0 = 0.995;                         % frequency for limit cycle
F = @(t,y) [ y(2); mu*(1-y(1).^2)*y(2) - y(1)];

% numerically integrate ODE to get trajectory/snapshot data
y0 = [5, 0]; % rand(1,2); %                     % intial condition
Tstop = 3*2*pi/w0;                              % stopping time
Nsamp = ceil(10*Tstop);                         % number of samples
tspan = linspace(0,Tstop,Nsamp);                % temporal grid for snapshots
opts = odeset('RelTol', 1e-12, 'AbsTol', 1e-14); % set time-stepping tols 
[t,y] = ode45(F,tspan,y0,opts);                 % numerically integrate ODE

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

%% Sample observable trajectories for Fourier averaging

g = @(y) y(:,1) + y(:,2);           % observable for Fourier averaging
dt = tspan(2)-tspan(1);             % adjust phase for sampling rate
s = exp(-1i*w0*dt).^(0:Nsamp-1)';    % phase scaling for Fourier average

nypts = 80;
y0grid1 = linspace(-4,4,nypts);        % spatial grid for measurements
y0grid2 = linspace(-4,4,nypts);
w = zeros(nypts);
tic
for i = 1:nypts
    for j = 1:nypts
        y0 = [y0grid1(i), y0grid2(j)];
        [~,y] = ode45(F,tspan,y0,opts); % numerically integrate ODE
        w(i,j) = sum(s.*g(y)) / Nsamp;
    end
end
toc
figure(3)
[Y1,Y2] = meshgrid(y0grid1,y0grid1);
contour(Y2,Y1,angle(w),[-pi,-3*pi/4,-pi/2,-pi/4,0,pi/4,pi/2,3*pi/4])

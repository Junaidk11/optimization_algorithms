%% 
% Note: The Particle Structure and the setup used in this code was inspired by the following github
% repository: 
%       Github repo: https://github.com/Diptiranjan1/PSO-vs-WOA
%       Username: github.com/Diptiranjan1
% I have adapted the code for my needs. 

%%
clear all;
%% Set problem number
%  1 = Question 1.a
%  2 = Question 1.b 
%  3 = Question 5.c 
global problemNumber; 
problemNumber = 2; 

%% Problem Definiton
ObjectiveFunction = @(x) myfunction(x);   % Cost Function
nVar = 2;                           % Number of Decision Variables
VarSize = [1 nVar];                 % Matrix Size of Decision Variables
VarMin =  -100;                     % Lower Bound of Decision Variables
VarMax =  100;                      % Upper Bound of Decision Variables

%% Parameters of PSO
nPop = 30;           % Swarm Size
w = 0.7;             % Intertia Coefficient
c1 = 2;              % Personal Acceleration Coefficient
c2 = 2;              % Social Acceleration Coefficient
vMin = -1000;        % Lower Bound on Initial Velocity
vMax = 1000;         % Upper Bound on Initial Velocity 

%% Initialisation

% Create a particle struture with Fields: Position, Velocity, Best Position  
empty_particle.Position = [];
empty_particle.Velocity = [];
empty_particle.FitnessValue = [];
empty_particle.Best.Position = [];
empty_particle.Best.FitnessValue = [];

% Initialize global best
GlobalBest.FitnessValue = inf;

% Create a structure array to hold all the particles
particle = repmat(empty_particle, nPop, 1); 

% Initialize Particles default parameters given
for i=1:nPop

        % Generate Random Position within (-100, 100) 
        particle(i).Position = unifrnd(VarMin, VarMax, VarSize);

        % Initialize Velocity wihtin (-1000, 1000)
        particle(i).Velocity = unifrnd(vMin, vMax, VarSize);

        % Function Evaluation 
        particle(i).FitnessValue = ObjectiveFunction(particle(i).Position);
           
        % Update the Personal Best
        particle(i).Best.Position = particle(i).Position;
        particle(i).Best.FitnessValue = particle(i).FitnessValue;

        % Update Global Best
        if particle(i).Best.FitnessValue < GlobalBest.FitnessValue
            GlobalBest = particle(i).Best;
        end
end

%% Define stopping criteria
tol = 1;
tol_desired = 1e-6;
max_iter = 400;        
iter = 1;
previousIter = 1;

%% Results Structure 

% Create a Result Structure with Fields:
% globalBestPosition,globalBestFitnessValue, tolerance
empty_results.globalBestPosition=[];
empty_results.globalBestFitnessValue=[]; 
empty_results.tolerance=[]; % for every iteration

% Create a structure array to hold results of all the iterations
results = repmat(empty_results, max_iter, 1); 

% initialize structure 
results(iter).globalBestFitnessValue = nan; 
results(iter).globalBestPosition = GlobalBest.Position;
results(iter).tolerance = inf; 

%% Include Penalty Factor Initialization For Problem 3 
if problemNumber == 3
    % Penalty Factor 
    r = 0.5;
end

%% PSO Main Loop
while(tol>tol_desired && iter<max_iter)  
        iter=iter+1;
        
       for i=1:nPop
           
            %% Update Velocity
            r1 = unifrnd(0, 1, VarSize);      % Random value within (0,1)
            r2 = unifrnd(0, 1, VarSize);      % Random value within (0,1)           
            
            particle(i).Velocity = w*particle(i).Velocity ...
                + c1*r1.*(particle(i).Best.Position - particle(i).Position) ...
                + c2*r2.*(GlobalBest.Position - particle(i).Position);
            
            %% Clamp velocity to max 1000, to avoid divergence          
            particle(i).Velocity = max(particle(i).Velocity, vMin);
            particle(i).Velocity = min(particle(i).Velocity, vMax);

            %% Update Position
            particle(i).Position = particle(i).Position + particle(i).Velocity;

            % Apply Lower bound and Upper Bound
             particle(i).Position=max(particle(i).Position, VarMin);
             particle(i).Position=min(particle(i).Position, VarMax);
             
            % Current particle's fitness value
            particle(i).FitnessValue = ObjectiveFunction(particle(i).Position);
            
            %% Penalty Calculation for Problem 3 only
            if problemNumber == 3           
                % Evaluate constraint for the current particle - i.e. Penalty
                Penalty = r*(constraint_func(particle(i).Position))^2;
            else
                Penalty = 0;
            end
            %% Update Personal Best
            if particle(i).FitnessValue + Penalty < particle(i).Best.FitnessValue
                
                particle(i).Best.Position = particle(i).Position;
                particle(i).Best.FitnessValue = particle(i).FitnessValue + Penalty;
              
                % Update Global Best
                if particle(i).Best.FitnessValue < GlobalBest.FitnessValue
                    tol = abs(particle(i).Best.FitnessValue - GlobalBest.FitnessValue);
                    GlobalBest = particle(i).Best;
                end            

            end
       end
       
       %% Storing Iteration Results 
        results(iter).globalBestPosition = GlobalBest.Position;
        results(iter).globalBestFitnessValue = GlobalBest.FitnessValue; 
        previousIter = iter-1;
        results(iter).tolerance = tol;
             
        %% Update penalty factor - only for Problem 3
        if problemNumber == 3
        r = r+0.5; % Incrementing Penalty Factor slowly until point of convergence
        end
        
        %% Display Iteration Result
        disp(['Iteration ' num2str(iter) ': Minimum = ' num2str(results(iter).globalBestFitnessValue) ': Global Best Position =' num2str(GlobalBest.Position) ', Tolerance =' num2str(results(iter).tolerance)]);   
           
end
%% Print Final Solution
        fprintf('\n');
        disp("The Total Number of Iterations taken: "), disp(iter);
        disp ("The Best Solution obtained in PSO is :"), disp(results(iter))
        
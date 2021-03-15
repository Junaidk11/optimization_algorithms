clear all;
% Set problem number
%  1 = Question 1.a
%  2 = Question 1.b 
%  3 = Question 5.c 

global problemNumber; 
problemNumber = 1; 
%% Problem Definiton
CostFunction = @(x) myfunction(x);   % Cost Function
nVar = 2;                           % Number of Decision Variables
VarSize = [1 nVar];                 % Matrix Size of Decision Variables
VarMin =  -100;                     % Lower Bound of Decision Variables
VarMax =  100;                      % Upper Bound of Decision Variables

%% Parameters of PSO
nPop = 30;           % Swarm Size
w = 0.7;             % Intertia Coefficient
c1 = 2;              % Personal Acceleration Coefficient
c2 = 2;              % Social Acceleration Coefficient

vMin = -100;        % Lower Bound on Initial Velocity
vMax = 100;         % Upper Bound on Initial Velocity 

%% Initialisation

% Create a particle struture with Fields: Position, Velocity, Best Position  
empty_particle.Position = [];
empty_particle.Velocity = [];
empty_particle.Cost = [];
empty_particle.Best.Position = [];
empty_particle.Best.Cost = [];

% Initialize global best
GlobalBest.Cost = inf;

% Create a structure array to hold all the particles
particle = repmat(empty_particle, nPop, 1); 

% Initialize Particles default parameters given
for i=1:nPop

        % Generate Random Position within (-100, 100) 
        particle(i).Position = unifrnd(VarMin, VarMax, VarSize);

        % Initialize Velocity
        particle(i).Velocity = unifrnd(vMin, vMax, VarSize);

        % Function Evaluation 
        particle(i).Cost = CostFunction(particle(i).Position);

        % Update the Personal Best
        particle(i).Best.Position = particle(i).Position;
        particle(i).Best.Cost = particle(i).Cost;

        % Update Global Best
        if particle(i).Best.Cost < GlobalBest.Cost
            GlobalBest = particle(i).Best;
        end
end

%Define stopping criteria
tol = 1;
tol_desired = 1e-6;
max_iter = 300;        
iter = 1;
previousIter = 1;

% Array to Hold Minimum on Each Iteration 
BestCosts = zeros(max_iter, 1);
BestCosts(iter) = GlobalBest.Cost; 

%% PSO Main Loop
while(tol>tol_desired && iter<max_iter)  
        iter=iter+1;
            previousBestCost = GlobalBest.Cost; 
       for i=1:nPop

            r1 = unifrnd(0, 1, VarSize);      % Random value within (0,1)
            r2 = unifrnd(0, 1, VarSize);      % Random value within (0,1)
            
            % Update Velocity
            particle(i).Velocity = w*particle(i).Velocity ...
                + c1*r1.*(particle(i).Best.Position - particle(i).Position) ...
                + c2*r2.*(GlobalBest.Position - particle(i).Position);
            
            % Clamp velocity to max, to avoid divergence          
            particle(i).Velocity = max(particle(i).Velocity, vMin);
            particle(i).Velocity = min(particle(i).Velocity, vMax);

            % Update Position
            particle(i).Position = particle(i).Position + particle(i).Velocity;

            %Apply Lower bound and Upper Bound
             particle(i).Position=max(particle(i).Position, VarMin);
             particle(i).Position=min(particle(i).Position, VarMax);

            % Evaluation
            particle(i).Cost = CostFunction(particle(i).Position);

            % Update Personal Best
            if particle(i).Cost < particle(i).Best.Cost

                particle(i).Best.Position = particle(i).Position;
                particle(i).Best.Cost = particle(i).Cost;

                % Update Global Best
                if particle(i).Best.Cost < GlobalBest.Cost                
                    GlobalBest = particle(i).Best;
                end            

            end
       end
       
        currentBestCost = GlobalBest.Cost;
        
        BestCosts(iter) = GlobalBest.Cost;
        % Without this check, the loop stops at less < 10 iterations
        % as two consecutive GBest are the same, so tol = 0, which <
        % tol_desired and the loop stops. 
        if currentBestCost ~= previousBestCost
            % Store the Best Cost Value 
            % Display Iteration Information
                                       
            previousIter = iter-1; 
            tol = abs(BestCosts(iter) - BestCosts(previousIter));   
        end
               
        disp(['Iteration ' num2str(iter) ': Minimum = ' num2str(BestCosts(iter))]);   
         
end
%Print solution
        disp ("The Best Solution obtained in PSO is :"), disp (GlobalBest)
        disp ("The Best Cost obtained in PSO is :"), disp (BestCosts(iter))
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
c1 = 5;              % Personal Acceleration Coefficient
c2 = 5;              % Social Acceleration Coefficient
vMin = -1000;        % Lower Bound on Initial Velocity
vMax = 1000;         % Upper Bound on Initial Velocity 

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

        % Initialize Velocity wihtin (-1000, 1000)
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
max_iter = 400;        
iter = 1;
previousIter = 1;

% Array to Hold Minimum on Each Iteration 
empty_results.globalBestFeval=[]; 
empty_results.globalBestPosition=[]; 
empty_results.tolerance=[];

% Create a structure array to hold all the iterations
results = repmat(empty_results, max_iter, 1); 

% initialize Results structure array
results(iter).globalBestFeval = nan; 
results(iter).globalBestPosition = GlobalBest.Position;
results(iter).tolerance = inf; 

%% PSO Main Loop
while(tol>tol_desired && iter<max_iter)  
        iter=iter+1;
        %previousBestCost = GlobalBest.Cost; 
        
       for i=1:nPop          
            r1 = unifrnd(0, 1, VarSize);      % Random value within (0,1)
            r2 = unifrnd(0, 1, VarSize);      % Random value within (0,1)
            
            % Update Velocity
            particle(i).Velocity = w*particle(i).Velocity ...
                + c1*r1.*(particle(i).Best.Position - particle(i).Position) ...
                + c2*r2.*(GlobalBest.Position - particle(i).Position);
            
            % Clamp velocity to max 1000, to avoid divergence          
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
                    tol = abs(particle(i).Best.Cost - GlobalBest.Cost);
                    GlobalBest = particle(i).Best;
                end            

            end
       end
       
       % Storing Iteration Results 
        results(iter).globalBestPosition = GlobalBest.Position;
        results(iter).globalBestFeval = GlobalBest.Cost; 
        previousIter = iter-1;
        %difference = abs(results(iter).globalBestPosition - results(previousIter).globalBestPosition);
        %results(iter).tolerance = vectorMag(difference);
        results(iter).tolerance = tol;
        
        % Without this check, the loop stops at less < 10 iterations
        % as two consecutive GBest are the same, so tol = 0, which <
        % tol_desired and the loop stops. 
%         if results(iter).globalBestPosition == results(previousIter).globalBestPosition                        
%             continue; 
%         else
%             tol = results(iter).tolerance;
%         end 
        
        disp(['Iteration ' num2str(iter) ': Minimum = ' num2str(results(iter).globalBestFeval) ': Global Best Position =' num2str(GlobalBest.Position) ', Tolerance =' num2str(results(iter).tolerance)]);   
       
end
%Print solution
        fprintf('\n');
        disp("The total Number of Iterations taken: "), disp(iter);
        disp ("The Best Solution obtained in PSO is :"), disp (results(iter).globalBestPosition)
        disp ("The Best Cost obtained in PSO is :"), disp (results(iter))
function [mea ,st,gbes,gBestValue] = tlboga(Np, Nd, Nt, xMin, xMax, clas, val)
% Copyright (c) 2015, Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Code: YPEA111
% Project Title: Implementation of TLBO in MATLAB
% Publisher: Yarpiz (www.yarpiz.com)
% 
% Developer: S. Mostapha Kalami Heris (Member of Yarpiz Team)
% 
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
%

clc;
% clear;
% close all;
cr = 0.8;
%% Problem Definition

% Cost Function
CostFunction = @(x) Fitness(x);

nVar = Nd;          % Number of Unknown Variables
VarSize = [1 nVar]; % Unknown Variables Matrix Size

VarMin = xMin;       % Unknown Variables Lower Bound
VarMax =  xMax;       % Unknown Variables Upper Bound

%% TLBO Parameters

MaxIt = Nt;        % Maximum Number of Iterations

nPop = Np;           % Population Size
run = 1;
%% Initialization 
for irun = 1 : run
% Empty Structure for Individuals
empty_individual.Position = [];
empty_individual.Cost = [];
empty_individual.Velocity = [];

% Initialize Population Array
pop = repmat(empty_individual, nPop, 1);

% Initialize Best Solution
BestSol.Cost = -inf;

% Initialize Population Members
for i=1:nPop
    for j = 1 : nVar
        if rand >= 0.5
            pop(i).Position(j) = 1;%unifrnd(VarMin, VarMax, VarSize);
        else
            pop(i).Position(j) = 0;
        end
        pop(i).Velocity(j) = 0;
    end
    pop(i).Cost = Fitness(pop(i).Position,val,clas);
    
    if pop(i).Cost > BestSol.Cost
        BestSol = pop(i);
    end
end

% Initialize Best Cost Record
BestCosts = zeros(MaxIt,1);

%% TLBO Main Loop

for it=1:MaxIt
    
    % Calculate Population Mean
    Mean = 0;
    for i=1:nPop
        Mean = Mean + pop(i).Position;
    end
    bar(Mean)
    Mean = Mean/nPop;
    
    % Select Teacher
    Teacher = pop(1);
    for i=2:nPop
        if pop(i).Cost > Teacher.Cost
            Teacher = pop(i);
        end
    end
    
    % Teacher Phase
    for i=1:nPop
        % Create Empty Solution
        newsol = empty_individual;
        
        % Teaching Factor
        TF = randi([1 2]);
        
        % Teaching (moving towards teacher)
        newsol.Position = pop(i).Position ...
            + rand(VarSize).*(Teacher.Position - TF*Mean);
        newsol.Velocity = rand(VarSize).*(Teacher.Position - TF*Mean);
        
        Tanh = tanh(abs(newsol.Velocity));
        newsol.Position = rand < Tanh;
        
        % Boundary conditions when everything is zero%
        onind = find(newsol.Position);
        if isempty(onind)
            newsol.Position = randi([0 1],nVar);
        end
        
        % Clipping
%         newsol.Position = max(newsol.Position, VarMin);
%         newsol.Position = min(newsol.Position, VarMax);
        
        % Evaluation
        newsol.Cost = Fitness(newsol.Position,val,clas);
        
        % Comparision
        if newsol.Cost > pop(i).Cost
            pop(i) = newsol;
            if pop(i).Cost > BestSol.Cost
                BestSol = pop(i);
            end
        end
    end
    
    % Learner Phase
    for i=1:nPop
        
        A = 1:nPop;
        A(i)=[];
        j = A(randi(nPop-1));
        
        Step = pop(i).Position - pop(j).Position;
        if pop(j).Cost < pop(i).Cost
%             Step = -Step;
        end
        
        % Create Empty Solution
        newsol = empty_individual;
        
        % Teaching (moving towards teacher)
        newsol.Position = pop(i).Position + rand(VarSize).*Step;
        newsol.Velocity = rand(VarSize).*Step;
        
        Tanh = tanh(abs(newsol.Velocity));
        newsol.Position = rand < Tanh;
        
        onind = find(newsol.Position);
        
        if isempty(onind)
            newsol.Position = randi([0 1],nVar);
        end
        
        % Clipping
%         newsol.Position = max(newsol.Position, VarMin);
%         newsol.Position = min(newsol.Position, VarMax);
        
        % Evaluation
        newsol.Cost = Fitness(newsol.Position,val,clas);
        
        % Comparision
        if newsol.Cost>pop(i).Cost
            pop(i) = newsol;
            if pop(i).Cost > BestSol.Cost
                BestSol = pop(i);
            end
        end
    end
    
    if cr > 0.5
        p1 = randi(nPop);
        p2 = randi(nPop);
        if p1 == p2 || p1 == 0 || p2 == 0
            p2 = mod(p2 + 1,nPop);
        end
       [fs,se] = crossover_tlbo(pop,p1,p2,1,nVar);
       c1Cost = Fitness(fs,val,clas);
       c2Cost= Fitness(se,val,clas);
       p1Cost = pop(p1).Cost;
       p2Cost = pop(p2).Cost;
       als = [fs;se;pop(p1).Position;pop(p2).Position];
       CO = [c1Cost c2Cost p1Cost p2Cost];
       [sv, si] = sort(CO);
       pop(p1).Position = als(si(1),:);
       pop(p2).Position = als(si(2),:);
       pop(p1).Cost = CO(si(1));
       pop(p2).Cost = CO(si(2));
       
    end
%     % Store Record for Current Iteration
%     BestCosts(it) = BestSol.Cost;
%     
    % Show Iteration Information
    disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCosts(it))]);
    
end
runbest(irun) = BestSol.Cost;
irun = irun + 1;
end
%% Results
gBestValue = BestSol.Cost;
gbes = BestSol.Position;
mea = mean(runbest);
st = std(runbest);
figure;
%plot(BestCosts, 'LineWidth', 2);
semilogy(BestCosts, 'LineWidth', 2);
xlabel('Iteration');
ylabel('Best Cost');
grid on;

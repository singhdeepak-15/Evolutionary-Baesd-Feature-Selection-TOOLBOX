function [me, st, bestfit, bestpop] = aco(np,nd,nt,lb,ub,clas,data)

clc;
% clear;
% close all;

%% Problem Definition

% data=LoadData();

nf=nd;   % Desired Number of Selected Features

% CostFunction=@(q) FeatureSelectionCost(q,nf,data);    % Cost Function
% CostFunction = @(x)Fitness(q,data,clas)
nVar=size(data,2)-1;


%% ACO Parameters

MaxIt=nt;      % Maximum Number of Iterations

nAnt=np;        % Number of Ants (Population Size)

Q=1;

tau0=1;	% Initial Phromone

alpha=1;        % Phromone Exponential Weight
beta=1;         % Heuristic Exponential Weight

rho=0.05;       % Evaporation Rate

run = 1;
%% Initialization
while run <= 3
eta=ones(nVar,nVar);        % Heuristic Information Matrix

tau=tau0*ones(nVar,nVar);   % Phromone Matrix

BestCost=zeros(MaxIt,1);    % Array to Hold Best Cost Values

% Empty Ant
empty_ant.Tour=[];
empty_ant.Cost=[];
empty_ant.Out=[];
empty_ant.Visit=[];

% Ant Colony Matrix
ant=repmat(empty_ant,nAnt,1);

% Best Ant
BestAnt.Cost=-inf;


%% ACO Main Loop

for it=1:MaxIt
    
    % Move Ants
    for k=1:nAnt
        ant(k).Tour = randi([1 nd]);
        for kk = 1 : nd
            if rand > 0.5
                ant(k).Visit(kk)=1;
            else
                ant(k).Visit(kk)=0;
            end
        end
        for l=2:nd
            
            i=ant(k).Tour(end);
            
            P=tau(i,:).^alpha.*eta(i,:).^beta;
            
            P(ant(k).Tour)=0;
            
            P=P/sum(P);
            
            j=RouletteWheelSelection(P);
            
            ant(k).Tour=[ant(k).Tour j];
            
        end
        IND = find(ant(k).Visit);
        S = ant(k).Tour(IND);
        [ant(k).Cost]=Fitness(ant(k).Visit,data,clas);
        ant(k).Out = IND;
        if ant(k).Cost>BestAnt.Cost
            BestAnt=ant(k);
        end
        
    end
    
    % Update Phromones
    for k=1:nAnt
        
        tour=ant(k).Tour;
        ntour  = ant(k).Out;
        
        tour=[tour tour(1)];
        ntour = [ntour ntour(1)];
        
%         for l=1:nVar
%             
%             i=tour(l);
%             j=tour(l+1);
%             tau(i,j)=tau(i,j)+Q/ant(k).Cost;
%             
%         end
        
        for l = 1 : length(ntour) - 1
           i=ntour(l);
           j=ntour(l+1);
           tau(i,j)=tau(i,j)+Q/ant(k).Cost;
            
        end
        
    end
    
    % Evaporation
    tau=(1-rho)*tau;
    
    % Store Best Cost
    BestCost(it)=BestAnt.Cost;
    
    % Show Iteration Information
    disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it))]);
    
end
bestrun(run) = BestAnt.Cost;
run = run + 1;
end
%% Results
me = mean(bestrun);
st = std(bestrun);
bestfit = BestAnt.Cost;
bestpop = BestAnt.Tour;
%end

figure;
plot(BestCost,'LineWidth',2);
xlabel('Iteration');
ylabel('Best Cost');


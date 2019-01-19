function [me, st, bestfit, bestpop] = runABC(np,nd,nt,lb,ub,clas,data)
%%%%%ARTIFICIAL BEE COLONY ALGORITHM%%%%

%Artificial Bee Colony Algorithm was developed by Dervis Karaboga in 2005 
%by simulating the foraging behaviour of bees.

%Copyright © 2008 Erciyes University, Intelligent Systems Research Group, The Dept. of Computer Engineering

%Contact:
%Dervis Karaboga (karaboga@erciyes.edu.tr )
%Bahriye Basturk Akay (bahriye@erciyes.edu.tr)


%clear all
%close all
clc



% Set ABC Control Parameters
ABCOpts = struct( 'ColonySize',  np, ...   % Number of Employed Bees+ Number of Onlooker Bees 
    'MaxCycles', nt,...   % Maximum cycle number in order to terminate the algorithm
    'ErrGoal',     1e-03, ...  % Error goal in order to terminate the algorithm (not used in the code in current version)
    'Dim',       nd , ... % Number of parameters of the objective function   
    'Limit',   100, ... % Control paramter in order to abandone the food source 
    'lb',  lb, ... % Lower bound of the parameters to be optimized
    'ub',  ub, ... %Upper bound of the parameters to be optimized
    'ObjFun' , 'Fitness', ... %Write the name of the objective function you want to minimize
    'RunTime',3); % Number of the runs 



GlobalMins=zeros(ABCOpts.RunTime,ABCOpts.MaxCycles);

for r=1:ABCOpts.RunTime
    
% Initialise population
Range = repmat((ABCOpts.ub-ABCOpts.lb),[ABCOpts.ColonySize ABCOpts.Dim]);
Lower = repmat(ABCOpts.lb, [ABCOpts.ColonySize ABCOpts.Dim]);
Colony = ceil(rand(ABCOpts.ColonySize,ABCOpts.Dim) .* Range + Lower);
Col_ind = randi([0,1],[ABCOpts.ColonySize,ABCOpts.Dim]);
Employed=Colony(1:(ABCOpts.ColonySize/2),:);
Emp_ind  = Col_ind(1:(ABCOpts.ColonySize/2),:);


%evaluate and calculate fitness
ObjEmp=feval(ABCOpts.ObjFun,Emp_ind,data,clas);
FitEmp=calculateFitness(ObjEmp);

%set initial values of Bas
Bas=zeros(1,(ABCOpts.ColonySize/2));


GlobalMin=ObjEmp(find(ObjEmp==max(ObjEmp),end));
% GlobalParams=Employed(find(ObjEmp==max(ObjEmp),end),:);
GlobalParams=Emp_ind(find(ObjEmp==max(ObjEmp),end),:);

Cycle=1;
while ((Cycle <= ABCOpts.MaxCycles)),
    
    %%%%% Employed phase
    Employed2=Employed;
    for i=1:ABCOpts.ColonySize/2
        Param2Change=fix(rand*ABCOpts.Dim)+1;
        neighbour=fix(rand*(ABCOpts.ColonySize/2))+1;
            while(neighbour==i)
                neighbour=fix(rand*(ABCOpts.ColonySize/2))+1;
            end;
        Employed2(i,Param2Change)=Employed(i,Param2Change)+(Employed(i,Param2Change)-Employed(neighbour,Param2Change))*(rand-0.5)*2;
         if (Employed2(i,Param2Change)<ABCOpts.lb)
             Employed2(i,Param2Change)=ABCOpts.lb;
         end;
        if (Employed2(i,Param2Change)>ABCOpts.ub)
            Employed2(i,Param2Change)=ABCOpts.ub;
        end;
        Employed2 = ceil(Employed2);
    end;   

    ObjEmp2=feval(ABCOpts.ObjFun,Employed2,data,clas);
    FitEmp2=calculateFitness(ObjEmp2);
    [Employed ObjEmp FitEmp Bas]=GreedySelection(Employed,Employed2,ObjEmp,ObjEmp2,FitEmp,FitEmp2,Bas,ABCOpts);
    
    %Normalize
    NormFit=FitEmp/sum(FitEmp);
    
    %%% Onlooker phase  
    Employed2=Employed;
    i=1;
    t=0;
while(t<ABCOpts.ColonySize/2)
    if(rand<NormFit(i))
        t=t+1;
        Param2Change=fix(rand*ABCOpts.Dim)+1;
        neighbour=fix(rand*(ABCOpts.ColonySize/2))+1;
            while(neighbour==i)
                neighbour=fix(rand*(ABCOpts.ColonySize/2))+1;
            end;
         Employed2(i,:)=Employed(i,:);
         Employed2(i,Param2Change)=Employed(i,Param2Change)+(Employed(i,Param2Change)-Employed(neighbour,Param2Change))*(rand-0.5)*2;
         if (Employed2(i,Param2Change)<ABCOpts.lb)
             Employed2(i,Param2Change)=ABCOpts.lb;
         end;
        if (Employed2(i,Param2Change)>ABCOpts.ub)
            Employed2(i,Param2Change)=ABCOpts.ub;
         end;
         Employed2 = ceil(Employed2);
    ObjEmp2=feval(ABCOpts.ObjFun,Employed2,data,clas);
    FitEmp2=calculateFitness(ObjEmp2);
    [Employed, ObjEmp, FitEmp, Bas]=GreedySelection(Employed,Employed2,ObjEmp,ObjEmp2,FitEmp,FitEmp2,Bas,ABCOpts,i);
   
   end;
    
    i=i+1;
    if (i==(ABCOpts.ColonySize/2)+1) 
        i=1;
    end;   
end;
    
    
    %%%Memorize Best
 CycleBestIndex=find(FitEmp==max(FitEmp));
 CycleBestIndex=CycleBestIndex(end);
 CycleBestParams=Employed(CycleBestIndex,:);
 CycleMin=ObjEmp(CycleBestIndex);
 
 if CycleMin>GlobalMin 
       GlobalMin=CycleMin;
       GlobalParams=CycleBestParams;
 end
 
 GlobalMins(r,Cycle)=GlobalMin;
 
 %% Scout phase
 ind=find(Bas==max(Bas));
ind=ind(end);
if (Bas(ind)>ABCOpts.Limit)
Bas(ind)=0;
Employed(ind,:)=(ABCOpts.ub-ABCOpts.lb)*(0.5-rand(1,ABCOpts.Dim))*2;%+ABCOpts.lb;
%message=strcat('burada',num2str(ind))
end;
ObjEmp=feval(ABCOpts.ObjFun,Employed,data,clas);
FitEmp=calculateFitness(ObjEmp);
    


    fprintf('Cycle=%d ObjVal=%g\n',Cycle,GlobalMin);
    
    Cycle=Cycle+1;

end % End of ABC

end; %end of runs

me = mean(GlobalMins(:,end));
st = std(GlobalMins(:,end));
bestfit = GlobalMin;
bestpop =  CycleBestParams;

semilogy(mean(GlobalMins))
title('Mean of Best function values');
xlabel('cycles');
ylabel('error');
fprintf('Mean =%g Std=%g\n',mean(GlobalMins(:,end)),std(GlobalMins(:,end)));
  

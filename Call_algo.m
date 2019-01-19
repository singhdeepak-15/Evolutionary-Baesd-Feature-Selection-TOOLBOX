function res = Call_algo(param,choice,data,clas)
tfea = size(data,2)-1;
switch choice
    case 1
        %Genetic
        [me, st, bestpop, bestfit] = Genetic(param(1),param(2),param(3),1,tfea,data,param(2),clas);
        res.mean = me;
        res.std = st;
        res.bestpop = bestpop;
        res.bestfit = bestfit;
        
    case 2
        %pso
        [man, st, bestpop, bestfit] = PSO(param(1),param(2),param(3),1,tfea,-5.12,5.12,data,param(2),clas);
        res.mean = man;
        res.std = st;
        res.bestpop = bestpop;
        res.bestfit = bestfit;
        
    case 3
        %aco
         [man, st, bestpop, bestfit] = aco(param(1),param(2),param(3),1,tfea,clas,data);
        res.mean = man;
        res.std = st;
        res.bestpop = bestpop;
        res.bestfit = bestfit;
    case 4
        %abc
        [man, st, bestpop, bestfit] = runABC(param(1),param(2),param(3),1,tfea,clas,data);
        res.mean = man;
        res.std = st;
        res.bestpop = bestpop;
        res.bestfit = bestfit;
        
    case 5
        %de
        [man ,st , bestpop ] = devec('Fitness',0.001,param(2),1,tfea,data,param(1),param(3),clas);
        res.mean = man;
        res.std = st;
        res.bestpop = bestpop;
%         res.bestfit = bestfit;
   
    case 6
        %tabu
        
        
    case 7
        %cukoo
        
    case 8
        [man, st, bestpop, bestfit] = tlboga(param(1),param(2),5,1,tfea,clas,data);
        res.mean = man;
        res.std = st;
        res.bestpop = bestpop;
        res.bestfit = bestfit;
        
end
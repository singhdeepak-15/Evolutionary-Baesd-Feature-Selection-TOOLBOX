function [mea st bestpop bestfit ] = Genetic(Np, D, Itermax, xMin, xMax, val,dim,clas)%D,Itermax,res)

% res = num(1,:)
% Np = 10;
% D = 20;
% Itermax = 200;
% tma = [ 22];
% tmi = [ 1];
run = 1; 
while run <= 3
    for i = 1 : Np
        for j = 1 : D
            if rand > 0.5
                pop(i,j) = 1;%ceil(xMin + (xMax-xMin) * rand);
            else
                pop(i,j) = 0; 
            end
        end
    end
    
    fit = Fitness(pop,val,clas);
    iter = 1;
    
    ci = 1;
    while iter < Itermax
        fs = randi(Np,1);
        se = randi(Np,1);
        if fs == se
            se = mod(se + 1,Np)+1;
        end
        [ch1 ch2] = crossover(pop,fs,se,ci,D);
        size(ch1);
        size(ch2);
        f1 = Fitness(ch1,val,clas);
        f2 = Fitness(ch2,val,clas);
        if f1 > fit(fs)
            pop(fs,:) = ch1;
        else
            if f2 > fit(fs)
                pop(fs,:) = ch2;
            end
        end
        if f1 > fit(se)
            pop(se,:) = ch1;
        else
            if f2 > fit(se)
                pop(se,:) = ch2;
            end
        end
        ra = randi(Np,1);
        mu = mutation(pop,ra,D);
        fit(ra) = Fitness(mu,val,clas)
        pop(ra,:) = mu;
        
        bestfit = max(fit)
        ind = find(bestfit == fit);
        bestpop = pop(ind(1),:);
        
        itrbest(iter) = bestfit;
        size(bestpop);
        iterpop(iter,:) = bestpop;
        
        iter = iter + 1;
        
    end
    % unit = unique(itrbest);
    % assignin('base','unit',unit);
    % tabuni = tabulate(itrbest);
    % assignin('base','tab',tabuni);
    % [ma,ind] = max(tabuni(:,2));
    % t1 = find(unit == tabuni(ind,1));
    % % t2 = find(itrbest == t1(1))
    citer = 0;%t2(1)
    run = run + 1;
    runbest(run) = bestfit;
end
bestpop = abs(bestpop);
bestfit;


plot(itrbest)
mea = mean(runbest);
st = std(runbest);
% save('Enocde_GA.mat','bestpop');
  

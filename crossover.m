function [first , sec] = crossover(pop,fs,se,ci,D)
first = pop(fs,:);
sec = pop(se,:);
size(first);
switch(ci)
    case 1
        ra = randi(D,1);
        %for i = 1:ra(1)
        first(1,ra:end,:) = pop(se,ra:end,:);
        sec(1,ra:end,:) = pop(fs,ra:end,:);
    case 2
        ra = randi(D, [1 2]);
        ra = sort(ra);
        first(1,ra(1):ra(2)) = pop(se,ra(1):ra(2));
        sec(1,ra(1):ra(2)) = pop(fs,ra(1):ra(2));
    case 3
                
    case 4
        
    case 5
        
    case 6
        
    case 7
end

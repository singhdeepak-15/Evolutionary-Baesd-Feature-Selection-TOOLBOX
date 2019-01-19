function [first , sec] = crossover_tlbo(pop,fs,se,ci,D)
first = pop(fs).Position;
sec = pop(se).Position;
tfirst = first;
tsec = sec;
size(first);
switch(ci)
    case 1
        ra = randi(D,1);
        %for i = 1:ra(1)
        first(ra:end) = tfirst(ra:end);
        sec(ra:end) = tsec(ra:end);
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

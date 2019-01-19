function [str] = Algo_select(val)
if strcmp(val,'CLASSICAL')
    str = {'Select','GENETIC','DE','PSO','ACO','ABC','TABU','CUKOO'};
else
    if strcmp(val,'HYBRID')
        str = {'Select','TLBO+GA','GA+PSO','GA+ABC','PSO+TABU','ACO+TABU','ABC+TABU','PSO+DE'};
    else
        if strcmp(val,'GA_VARIENT')
            str = '';
        else
            if strcmp(val,'DE_VARIENT')
                str = '';
            else
                if strcmp(val,'PSO_VARIENT')
                    str = '';
                else
                    
                end
            end
        end
        
    end
end
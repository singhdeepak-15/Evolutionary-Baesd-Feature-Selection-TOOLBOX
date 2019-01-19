function [choi] = Get_algo(algo)
if strcmp('GENETIC',algo)
    %str = {'Enter the Population Size','Enter the iteration','Enter the Features','Enter the Crossover rate','Enter the mtation rate'};
    choi = 1;
else
    if strcmp('PSO',algo)
        %str = {'Enter the Population Size','Enter the iteration','Enter the Features'};
        choi = 2;
    else
        if strcmp('ACO',algo)
            %str = {'Enter the Population Size','Enter the iteration','Enter the Features'};
            choi = 3;
        else
            if strcmp('ABC',algo)
                %str = {'Enter the Population Size','Enter the iteration','Enter the Features'};    
                choi = 4;
            else
                if strcmp('DE',algo)
                    %str = {'Enter the Population Size','Enter the iteration','Enter the Features'};    
                    choi = 5;
                else
                    if strcmp('TABU',algo)
                        %str = {'Enter the Population Size','Enter the iteration','Enter the Features'};    
                        choi = 6;
                    else
                        if strcmp('CUKOO',algo)
                            %str = {'Enter the Population Size','Enter the iteration','Enter the Features'};
                            choi = 7;
                        else
                            if strcmp('TLBO+GA',algo)
                                
                                choi = 8;
                            else
                                
                            end
                        end
                    end
                end
            end
        end
    end
end
%inp = inputdlg(str);
%param = str2num(char(inp));
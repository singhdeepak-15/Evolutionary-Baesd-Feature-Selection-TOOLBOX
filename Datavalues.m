function data = Datavalues(val)
if strcmp(val,'DERMI')
    load dermi.txt;
    data = dermi;
else
    if strcmp(val,'WINE')
        load wine.txt
        data = wine;
    else
        if strcmp(val,'CONNECT')
            load abalone_dataset
            data = [abaloneInputs' abaloneTargets'];
        else
            if strcmp(val,'GLASS')
%                 load glass.txt
                    load glass_dataset ;
                    data = [glassInputs' glassTargets(1,:)'];
                    
%                 data = glass;
            end
        end
    end
end
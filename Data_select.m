function [list,str] = Data_select(val)
if strcmp(val,'BINARY CLASS')
    str = 'Data\Binary class'
else
    if strcmp(val,'MULTI CLASS')
        str = 'Data\Multi class'
    else
        if strcmp(val,'IMBALANCE BINARY')
            str = 'Data\Imbalance binary'
        else
            if strcmp(val,'IMBALANCE MULTI')
                str = 'Data\Imbalance Multi'    
            else
                if strcmp(val,'NOISY BINARY')
                    str = 'Data\Noisy binary'
                else
                    if strcmp(val,'NOISY MULTI')
                        str = 'Data\Noisy multi'
                    else
                        if strcmp(val,'OUTLIAR BINARY')
                            str = 'Data\Outliar binary'
                        else
                            if strcmp(val,'OUTLIAR MULTI')
                                str = 'Data\Outliar multi'    
                            else
                                str = 'Data\Gene';
                            end
                        end
                    end
                end
            end
        end
    end
end
list = dir(str);

                    
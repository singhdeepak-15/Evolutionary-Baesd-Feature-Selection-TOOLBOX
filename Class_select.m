function [vac,model] = Class_select(val,data)
if strcmp(val,'DTREE')
    [model,vac] = trainClassifier_decision(data);
else
    if strcmp(val,'SVM')
        [model,vac] = trainClassifier_svmlinear(data);
    else
        if strcmp(val,'KNN')
            [model,vac] = trainClassifier_knncosine(data);
        else
            if strcmp(val,'NBAYES')
                
            else
                if strcmp(val,'BOOST')
                    [model,vac] = trainClassifier_RUSboost(data);
                else
                    if strcmp(val,'BAGG')
                        [model,vac] = trainClassifier_Bagged(data);
                    else
                        
                    end
                end
            end
        end
    end
end
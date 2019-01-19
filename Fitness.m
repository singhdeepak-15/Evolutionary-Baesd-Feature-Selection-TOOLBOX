function fit = Fitness(pop,val,dim)
fea = val;
for i = 1 : size(pop,1)
    %for j = 1 : size(pop,2)
        ind = find(pop(i,:));
        fe = val(:,ind);
        fe = [fe val(:,end)];
        %fea(:,1:dim) = fe;
        [b,a] = Class_select(dim,fe);
        fit(i) = b;
    %end
end
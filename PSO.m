% This program implements a clean version of Particle Swarm Optimization (PSO)

function [man ,st,gbes,gBestValue] = PSO(Np, Nd, Nt, xMin, xMax, vMin, vMax,val,dim,clas)

% Np = 20;
% Nd = 35;
% Nt = 5;
% xMin = 1;
% xMax = 41;
% vMin = -2.12;
% vMax = 2.12;
% val = num;
% %dim = 35;

W  = 0.25;
C1 = 2.05;
C2 = 2.05;    
run = 5;
phi = C1 + C2;    
chi = 2.0/abs(2.0-phi-sqrt(phi^2-4*phi));

% Init personal best values
pBestValue    = ones(Np) .* -Inf;
pBestPosition = zeros(Np, Nd);

% Init global best values
gBestValue    = -Inf;
gBestPosition = zeros(Nd);

% Record of best Fitness for plotting
bestFitnessHistory = [];
r =  1;
run = 3;
% Initialize position of each particle
   while ( r <= run)

    
%     if(nargin < 9) 
        R = zeros(Np, Nd); % Position
        for p=1:Np % For each Particle
            for i =1:Nd % For each dimension
                %R(p,i) =  ceil(xMin + (xMax-xMin) * rand);
                 if rand < 0.5
                     R(p,i) = 1;
                 else
                     R(p,i) = 0;
                 end
            end
        end
%     end
    
    % Initialize velocity of each particle
    V = zeros(Np, Nd); % Velocity
    for p=1:Np % For each Particle
       for i =1:Nd % For each dimension
           V(p,i) =  vMin + (vMax-vMin) * rand;
           if rand < 0.5
               V(p,i) = -V(p,i);
           end
       end
    end
    
    % Evaluate Fitness (Optional outside of Loop)
    % Modify this section to use a different fitness function
    % The curretn function is sum(x^2)
       
    M = Fitness(R,val,clas);
        
    for j=1:Nt % For each time step
        
        % Update Position
         for p=1:Np
            for i=1:Nd
                R(p,i) = ceil(R(p,i) + V(p,i));
                si = 1 / (1 + exp(-R(p,i)));
                if rand < si
                    R(p,i) = 0;
                else
                    R(p,i) = 1;

                end
                % Correct any errors
                if R(p,i) > xMax
                   % R(p,i) = xMax;
                elseif  R(p,i) < xMin
                    %R(p,i) = xMin;
                end
                
                if rand < 0.5
                    %R(p,i) = -R(p,i);
                end
            end
        end
        
        % Evaluate Fitness
        M = Fitness(R,val,clas);
        for p=1:Np
            %Check if it is a personal best
            %If it is, record the value and the position
            if M(p) > pBestValue(p)                
                pBestValue(p) = M(p);
                for i=1:Nd
                    pBestPosition(p,i) = R(p,i);
                end 
            end
            if M(p) > gBestValue                
                gBestValue = M(p);
                for i=1:Nd
                    gBestPosition(p,i) = R(p,i);
                end 
            end            
        end
        bestFitnessHistory(j) = gBestValue;
        
       
        for p=1:Np
            for i=1:Nd
                
                V(p,i)  = chi*(V(p,i) + C1 * (pBestPosition(p,i)-R(p,i)) + C2 * (gBestPosition(i) - R(p,i)));
                if V(p,i) > vMax
                    V(p,i) = vMax;
                elseif  V(p,i) < vMin
                    V(p,i) = vMin;
                end
            end
        end
        str = sprintf('Iteration: %d Best Value: %f', j, gBestValue);
        disp(str)
    end
    
    bestrun(r)  = gBestValue;
    r = r+1;
    gbes = gBestPosition(1,:);
%end while finish
    
    man = sum(bestrun)/run
    st = std(bestrun)
     
   end

   figure,plot(bestFitnessHistory);
     xlabel('Iteration');
     ylabel('Best Value');
'DONE'
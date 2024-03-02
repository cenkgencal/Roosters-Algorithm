%  --------------- ROOSTERS ALGORITHM --------------------------------

% How to cite the article?

% M. Gencal and M. Oral, "Roosters algorithm: a novel nature-inspired optimization algorithm,"
% Computer Systems Science and Engineering, vol. 42, no.2, pp. 727–737, 2022.

% --------------------------- Inputs --------------------------------------
% The algorithm gets seven parameters:
% popsize                       : Size of the population
% maxIter                       : Number of generations
% num_roo                       : The number of roosters in the cage
% ul                            : Upper limit of the range 
% ll                            : Lower limit of the range
% dim                           : Dimension of the space
% f_name                        : The name of objective function which must
%                                 be entered like 'function name'.
% -------------------------------------------------------------------------

% ------------------------ Outputs ----------------------------------------
% mincost                       : The found minimum fitness value
% value                         : The individual having mincost value
% bests                         : All bests throughout iterations
% -------------------------------------------------------------------------

function [mincost,value,bests]=RA(popsize, maxIter,num_roo,ul,ll,dim,f_name,seed)

rng(seed);
% As an example, you can call the algorithm like;
% [mincost,value,bests]=RA(100,100,4,5,-5,2,'dejong',1)

n = dim;
ff = f_name;

%%%%%%%%%%%% Initialization %%%%%%%%%%%%%%%%

% Creating population having default values
pop = ones(popsize,n);

% Using ul and ll, we create our population
Lb = ll*ones(1,n); 
Ub = ul*ones(1,n);
for i=1:popsize
    pop(i,:) = Lb+(Ub-Lb).*rand(size(Lb));
end

count = maxIter;
bests = zeros(maxIter,1);
elit_rate = 0.3;
% For plotting
% iter=1:maxIter;

while maxIter > 0
    
    %%%%%%%%%%%% Identification %%%%%%%%%%%%%%%%%%
    
    % Randomly identify roosters (1) and chickens (0) 
    id = round(rand(popsize,1));
    roo = pop(id==1,:);
    ch = pop(id==0,:);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%%%%%%%%%%%%% Roosters %%%%%%%%%%%%%%%%%%%%%%
    offspring = roosters(roo,ch,num_roo,ff,Lb,Ub,dim);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%%%%%%%%%%%%%% Elitism %%%%%%%%%%%%%%%%%%%%%%
    n_elit = popsize*elit_rate;
    if n_elit < 1
        n_elit = 1;
    end
    cost = feval(ff,pop(:,1),pop(:,2));
    [~,in] = sort(cost);
    part1 = pop(in(1:popsize-n_elit),:);
    cost_off = feval(ff,offspring(:,1),offspring(:,2));
    [~,in1] = sort(cost_off);
    part2 = offspring(in1(1:n_elit),:);
    pop = [part1;part2];
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % Finding the best for each iteration
    maxIter = maxIter-1;
    index = count-maxIter;
    cost = feval(ff,pop(:,1),pop(:,2));
    [val,~] = min(cost);
    bests(index) = val;
end

last_cost = feval(ff,pop(:,1),pop(:,2));
[mincost,in] = min(last_cost);
value = pop(in,:);

% For plotting
% figure, semilogy(iter,bests,'r');
% xlabel('Iterations');
% ylabel('Best Value');





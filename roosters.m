%%%%%%%%%%%%%% Roosters Main Code %%%%%%%%%%%%%%%%%%%%%%
function offspring=roosters(roo,ch,num_roo,ff,Lb,Ub,dim)

ro_size = size(roo,1);
ch_size = size(ch,1);
cost_r = feval(ff,roo(:,1),roo(:,2));
cost_ch = feval(ff,ch(:,1),ch(:,2));
% Depends on n, you can write this equality as follows;
% cost=feval(f_name,pop(:,1),pop(:,2),...,pop(:,n))
offspring = zeros(ch_size,dim);
o = zeros(ch_size,dim,num_roo);

for i=1 : ch_size
    % Roosters that want to mate with chicken_i is chosen
    for j=1 : num_roo
        can = ceil((ro_size-1)*rand+1);
        % For a minimization problem ( for maximization, make it ">" )
        if cost_r(can) <= cost_ch(i)
            o(i,:,j) = roo(can,:)./2+ch(i,:)./2+(1/2+0.1).*abs(ch(i,:) - roo(can,:)).*(2*rand-1);
        end
    end
    
    % If the attractive chicken has more than one male, get the best one
    cost_o = feval(ff,o(i,1,:),o(i,2,:));
    [~,ind1] = min(cost_o);
    offspring(i,:) = o(i,:,ind1);
        
    % If the attractive chicken is stressfull;     
    %%%%%%%%%%%%%%%%% Mutation %%%%%%%%%%%%%%%%
    mut_prob = 0.05;
    if rand <= mut_prob    
        offspring(i,:) = Lb+(Ub-Lb).*rand(size(Lb));
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
end
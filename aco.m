function [aco_path,aco_cost]=aco(point1,point2,mapdata)

PopNum=15;          %种群个数
BestFitness=[];     %最佳个体
iter_max=15;

%% 画图
pheromone=ones(200,200,200);
%pheromone=initial_pheromone(pheromone,point1);
pheromone=initial_pheromone(pheromone,point2);


%初始化搜索路径
[flag,judges,paths,pheromone]=searchpath(PopNum,pheromone,point1,point2,mapdata);



fitness=CacuFit(judges,paths,PopNum);           %适应度计算
[bestfitness,bestindex]=min(fitness);           %最佳适应度
bestpath=paths{1,bestindex};                    %最佳路径
%[worstfitness,worstindex]=max(fitness);		%最坏适应度
%worstpath=paths{1,worstindex};					%最坏路径
BestFitness=[BestFitness;bestfitness];          %适应度值记录


%% 信息素更新
rou=0.3;%信息素衰减系数
cfit=200/bestfitness;%信息素增量
[n,m]=size(bestpath);
for i=1:n
    %根据具体更新相应的信息素质
	pheromone(bestpath(i,1),bestpath(i,2),bestpath(i,3))=(1-rou)*pheromone(bestpath(i,1),bestpath(i,2),bestpath(i,3))+rou*cfit;
end


maxpathcost=[];
%% 循环寻找最优路径
for iter=1:iter_max
    %% 路径搜索
    if flag==1
        break;
    end
    [flag,judges,paths,pheromone]=searchpath(PopNum,pheromone,point1,point2,mapdata);

    
    %% 适应度值计算更新
    fitness=CacuFit(judges,paths,PopNum);%适应度越小越好
    [newbestfitness,newbestindex]=min(fitness);
    
%    if iter == 1
%        bestfitness = newbestfitness;
%        bestpath = path(newbestindex,:); 
%    end 
    
    if newbestfitness<bestfitness
        bestfitness=newbestfitness;
		bestpath=paths{1,newbestindex};   
    end
    
    %%画图用,figure(2)
    %maxpathcost_1=path_cost(bestpath);
    %maxpathcost=[maxpathcost;maxpathcost_1];
    
	BestFitness=[BestFitness;bestfitness];
    
    %% 更新信息素
    cfit=200/bestfitness;
	[n,m]=size(bestpath);
	for i=1:n
		pheromone(bestpath(i,1),bestpath(i,2),bestpath(i,3))=(1-rou)*pheromone(bestpath(i,1),bestpath(i,2),bestpath(i,3))+rou*cfit;
    end
    
     
end

% 最佳路径
path = bestpath;
aco_cost=bestfitness;
aco_path=path;
disp('aco run');
toc

%[aco_cost,aco_path]=optimize_nodes(path,mapdata);


%% %画图用
%mycolor8 = [
%    1 0 0
%   1 1 0
%     0 0 1
%     1 0.5 0
%     1 0 1
%     0 0 0
%     1 1 1
%     0 1 0
%     ];
%path=aco_path;
%figure(1)
%hold on;
% plot3(path(:,1),path(:,2),path(:,3),'LineWidth',2);
% plot3(aco_path(:,1),aco_path(:,2),aco_path(:,3),'color',mycolor8(2,:),'LineWidth',2);% %% 适应度变化
%legend('aco')

%figure(2);
%plot(maxpathcost);
%title('最佳个体适应度变化趋势');
%xlabel('迭代次数');
%ylabel('适应度值');
% % 	





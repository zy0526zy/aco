function [aco_path,aco_cost]=aco(point1,point2,mapdata)

PopNum=15;          %��Ⱥ����
BestFitness=[];     %��Ѹ���
iter_max=15;

%% ��ͼ
pheromone=ones(200,200,200);
%pheromone=initial_pheromone(pheromone,point1);
pheromone=initial_pheromone(pheromone,point2);


%��ʼ������·��
[flag,judges,paths,pheromone]=searchpath(PopNum,pheromone,point1,point2,mapdata);



fitness=CacuFit(judges,paths,PopNum);           %��Ӧ�ȼ���
[bestfitness,bestindex]=min(fitness);           %�����Ӧ��
bestpath=paths{1,bestindex};                    %���·��
%[worstfitness,worstindex]=max(fitness);		%���Ӧ��
%worstpath=paths{1,worstindex};					%�·��
BestFitness=[BestFitness;bestfitness];          %��Ӧ��ֵ��¼


%% ��Ϣ�ظ���
rou=0.3;%��Ϣ��˥��ϵ��
cfit=200/bestfitness;%��Ϣ������
[n,m]=size(bestpath);
for i=1:n
    %���ݾ��������Ӧ����Ϣ����
	pheromone(bestpath(i,1),bestpath(i,2),bestpath(i,3))=(1-rou)*pheromone(bestpath(i,1),bestpath(i,2),bestpath(i,3))+rou*cfit;
end


maxpathcost=[];
%% ѭ��Ѱ������·��
for iter=1:iter_max
    %% ·������
    if flag==1
        break;
    end
    [flag,judges,paths,pheromone]=searchpath(PopNum,pheromone,point1,point2,mapdata);

    
    %% ��Ӧ��ֵ�������
    fitness=CacuFit(judges,paths,PopNum);%��Ӧ��ԽСԽ��
    [newbestfitness,newbestindex]=min(fitness);
    
%    if iter == 1
%        bestfitness = newbestfitness;
%        bestpath = path(newbestindex,:); 
%    end 
    
    if newbestfitness<bestfitness
        bestfitness=newbestfitness;
		bestpath=paths{1,newbestindex};   
    end
    
    %%��ͼ��,figure(2)
    %maxpathcost_1=path_cost(bestpath);
    %maxpathcost=[maxpathcost;maxpathcost_1];
    
	BestFitness=[BestFitness;bestfitness];
    
    %% ������Ϣ��
    cfit=200/bestfitness;
	[n,m]=size(bestpath);
	for i=1:n
		pheromone(bestpath(i,1),bestpath(i,2),bestpath(i,3))=(1-rou)*pheromone(bestpath(i,1),bestpath(i,2),bestpath(i,3))+rou*cfit;
    end
    
     
end

% ���·��
path = bestpath;
aco_cost=bestfitness;
aco_path=path;
disp('aco run');
toc

%[aco_cost,aco_path]=optimize_nodes(path,mapdata);


%% %��ͼ��
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
% plot3(aco_path(:,1),aco_path(:,2),aco_path(:,3),'color',mycolor8(2,:),'LineWidth',2);% %% ��Ӧ�ȱ仯
%legend('aco')

%figure(2);
%plot(maxpathcost);
%title('��Ѹ�����Ӧ�ȱ仯����');
%xlabel('��������');
%ylabel('��Ӧ��ֵ');
% % 	





function [aco_path,aco_cost]=aco1(point1,point2,mapdata)
[path1,cost1]=aco(point1,point2,mapdata);
[path2,cost2]=aco(point2,point1,mapdata);

if cost1<cost2
   aco_path=path1;
   aco_cost=cost1;
else
    aco_path=flip(path2);%反转数组
    aco_cost=cost2;
end


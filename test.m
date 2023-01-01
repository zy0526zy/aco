%测试蚁群算法两点之间最短路径

%清空环境
clear 
clc
tic

%% 地图
load mapCity
point_start=[20 175 96];
point_end=[196 49 30];


figure(1);
h1=mesh(mapdata);
hold on;
shading interp;
h2=plot3(20 ,175,   96,'k.','markersize',20);
h3=plot3(196 ,  49,   30,'k.','markersize',20);
xlabel('x km');
ylabel('y km');
zlabel('z m');
set(h1,'handlevisibility','off');
set(h2,'handlevisibility','off');
set(h3,'handlevisibility','off');

load mapCity_run
[aco_path,aco_cost]=aco(point_start,point_end,mapdata);

%% 画图用

%红，黄，蓝，橙，紫，黑，白，绿
mycolor8 = [
    1 0 0 
    1 1 0
    0 0 1
    1 0.5 0
    1 0 1
    0 0 0
    1 1 1
    0 1 0
    ];

plot3(aco_path(:,1),aco_path(:,2),aco_path(:,3),'color',mycolor8(4,:),'LineWidth',1.5);
text(point_start(:,1),point_start(:,2),point_start(:,3),'起点');
text(point_end(:,1),point_end(:,2),point_end(:,3),'终点');
legend('aco');


hold off;



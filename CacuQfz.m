function qfz=CacuQfz(point_next,point_now,point_end,mapdata)
%% �ú������ڼ�����������ֵ��Խ��Խ�ã�
% point_next    input    �¸�������
% point_now     input    ��ǰ������
% point_end     input    �յ�����
% mapdata       input    ��ͼ�߶�
% qfz           output    ����ֵ

%% �ж��¸����Ƿ�ɴ���ɴ�Ϊ0
if mapdata(point_next(2),point_next(1))<point_next(3)
    S=1;
else
    S=0;
end

%% ��������ֵ
%D����
D=5000/(sqrt((point_next(1)-point_end(1))^2 + (point_next(2)-point_end(2))^2 + (point_next(3)-point_end(3))^2));
% ����߶�
M=20/point_next(3);

%��������ֵ
qfz=S*(M+D);


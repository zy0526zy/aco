function [flag,judges,paths,pheromone]=searchpath(PopNum,pheromone,point1,point2,mapdata)
%% �ú�������Ⱥ�㷨������·��
%judges            �Ƿ�ɹ�������·��
%pheromone         input    ��Ϣ��
%mapdata           input    ��ͼ�߶�
%point1,point2     input    ��ʼ��
%path              output   �滮·��
%pheromone         output   ��Ϣ��

%% ��������
xcMax=1; %���Ϻ������䶯
ycMax=1; %�����������䶯
zcMax=1; %���ϴ�ֱ���䶯
decr=0.99;  %��Ϣ��˥������
judges=ones(1,PopNum);
paths=cell(1,PopNum);
flag=0;


%% ѭ������·��
for pi=1:PopNum
    len=1;
    path(len,1:3)=point1(1:3);
    NowPoint=point1(1:3);
    while distance(NowPoint(1),NowPoint(2),NowPoint(3),point2(1),point2(2),point2(3))
        count=1;
        %% ��������Ӧ��ֵ
        for x=-xcMax:xcMax
            for y=-ycMax:ycMax
                for z=-zcMax:zcMax
                    %���ݴ���
                    if x==0&&y==0&z==0
                        continue;
                    end
                    
                    if(NowPoint(1)+x<200&&NowPoint(2)+y<200&&NowPoint(3)+z<200&&NowPoint(1)+x>0&&NowPoint(2)+y>0&&NowPoint(3)+z>0)
                        if mapdata(NowPoint(2)+y,NowPoint(1)+x)>NowPoint(3)+z
                            continue;
                        end
                        
                        NextPoint(count,:)=[NowPoint(1)+x,NowPoint(2)+y,NowPoint(3)+z];
                        qfz(count)=CacuQfz(NextPoint(count,:),NowPoint,point2,mapdata);
                        qz(count)=qfz(count)*pheromone(NextPoint(count,1),NextPoint(count,2),NextPoint(count,3));
                        %qz(count)=pheromone(NextPoint(count,1),NextPoint(count,2),NextPoint(count,3));
                        if   qz(count)==0
                            continue;
                        else
                            count=count+1;
                        end
                    end
                    
                %x,y,z    
                end
            end
        end
        
        if count==1
            len=round(2*len/3);
            NowPoint=path(1,1:3);
            continue;
        end
        
        
        % ѡ����һ����
        [max_1,index]=max(qz);%�ҵ�����ֵ����(26����)
        temp_m=find(qz==max_1);%�ҵ����λ��
        index_m=randperm(size(temp_m,2),1);%size(temp_m,2)����temp_m�еĸ���
        index=temp_m(index_m);
        
       %%  ���̶ĸ��򵥷�ʽ
%          P = qz/sum(qz);% ���̶ķ�ѡ����һ�����ʳ���
%          Pc = cumsum(P);     %�ۼӺ�������ǰ�����ۼӵ�1
%          target_index = find(Pc >= rand);
%          index = target_index(1);        
        %% �������̶ķ�ѡ����һ����
%        if isempty(find(qz==inf,1))==0
%            index=find(qz==inf,1);
%       else
%            if rand>5
%                sum_qz=qz/sum(qz);
%                P_qz=cumsum(sum_qz);
%                index=find(P_qz>=rand);
%            else
%                [max_1,index]=max(qz);               
%                temp_m=find(qz==max_1);
%                index_m=randperm(size(temp_m,2),1);
%                index=temp_m(index_m);
%            end
%        end
       
        %debug
        assert(isempty(NextPoint)==0)
        assert(isempty(qz)==0)
        assert(isempty(index)==0)


        oldpoint=NextPoint(index(1),:);
        %assert(isequal(NowPoint,oldpoint))
        NowPoint=oldpoint;
        pheromone(oldpoint(1),oldpoint(2),oldpoint(3))=decr*pheromone(oldpoint(1),oldpoint(2),oldpoint(3));
        
        %·�����棬���10000*3
        len=len+1;
        if len>10000
            judges(1,pi)=0;
            flag=1;%flag==1��ʾ��10000������֮��û��û���ҵ�һ��·��
            break;
        end
        path(len,1:3)=NowPoint;
        NextPoint=[];
        qz=[];
        qfz=[];
    end
    
    paths{1,pi}=path;
    path=[];
end

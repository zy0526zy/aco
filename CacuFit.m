function fitness=CacuFit(judges,paths,PopNum)
%% �ú������ڼ��������Ӧ��ֵ(·������+����ƽ���߶ȣ�
%path       input     ·��
%fitness    input     ·��

fitness=ones(1,PopNum);
for pi=1:PopNum
	path=paths{1,pi};
	[n,m]=size(path);
	fit_temp=sum(path,1)/n;%sum(a,2)��֮��
	if judges(1,pi)==0%���ɵ���
		judge=inf;
	else
		judge=1;
	fitness(pi)=judge*(fit_temp(3)+n);
    end
end

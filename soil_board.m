% ���ű������������϶΢�۱�������������ص�����
% ����: Liskelleo (liskello_o@outlook.com)
clc; clear all;
fid=fopen('C:\Users\Lsk\Desktop\soil_board.dat','w+'); % ���ļ�����д������
fida=fopen('C:\Users\Lsk\Desktop\air_backround.dat','w+'); % ���ļ�����д������
lat_c=0.01; % ����Ԫ�ĳߴ�
nx=55; % x������������
ny=101; % y������������
x0=-0.02; % x�������ʼ����
y0=0; % y�������ʼ����
coord=zeros(nx*ny,4); % ��ʼ����������
coord2=zeros(nx*ny,4); % ��ʼ����������
ii=0; ai=0; % ��ʼ������������
for i=1:nx
    for j=1:ny
        xi=x0+(i-1)*lat_c; % ����x����
        yi=y0+(j-1)*lat_c; % ����y����
        if xi<=0 ||  xi>=0.5 % ��������Ƿ�Ϊ����
            ii=ii+1;    
            coord(ii,:)=[ii,xi,yi,2]; % �洢���������꣬�����������Ϊ2
        else
            ai=ai+1;    
            coord2(ai, :)=[ai,xi yi,0]; % �洢���������꣬������������Ϊ0
            if yi >=0.2 && yi<=0.8
                ii=ii+1;
                coord(ii,:)=[ii,xi,yi,1]; % �洢���������꣬�������ӱ��Ϊ1
            end
        end
    end
end 
npart=ii; apart=ai; % ����ii,ai������ֵ���������Ӹ���npart,apart
 
%��ʼ�� zuobiao ���飬���ڴ洢�������ӵ�����������
zuobiao=zeros(npart,4);
zuobiao(:,1)=1:npart;
zuobiao(1:npart,2:4)=coord(1:ii,2:4);
%fprintf(fid,'%d\t ',npart); % д����������
%fprintf(fid,'%d\t ',lat_c);  % д�����ӳߴ�
%fprintf(fid,'\n');

for i=1:npart
    b=zuobiao(i,1);
    c=[zuobiao(i,2) zuobiao(i,3)];
    d=zuobiao(i,4);
    fprintf(fid,'%d\t',b);         % д��ÿ�����ӵ��������
    fprintf(fid,'%15.5e\t',c);   % д��ÿ�����ӵ�λ������
    fprintf(fid,'%d\t',d);         % д��ÿ�����ӵı߽���Ϣ
    fprintf(fid,'\n');
end

%��ʼ�� azuobiao ���飬���ڴ洢�������ӵ�����������
azuobiao=zeros(apart,4);
azuobiao(:,1)=1:apart;
azuobiao(1:apart,2:4)=coord2(1:ai,2:4);
%fprintf(fida,'%d\t ',apart); % д����������
%fprintf(fida,'%d\t ',lat_c);  % д�����ӳߴ�
%fprintf(fida,'\n');

for i=1:apart
    ab=azuobiao(i,1);
    ac=[azuobiao(i,2) azuobiao(i,3)];
    ad=azuobiao(i,4);
    fprintf(fida,'%d\t',ab+npart);         % д��ÿ�����ӵ��������
    fprintf(fida,'%15.5e\t',ac);   % д��ÿ�����ӵ�λ������
    fprintf(fida,'%d\t',ad);         % д��ÿ�����ӵı߽���Ϣ
    fprintf(fida,'\n');
end

% ��������λ������Ѱ�ұ߽�����
point=find((zuobiao(:,4)==2));
mpart=length(point);
bc=zeros(mpart,4);
bc(:,1)=zuobiao(point,1);
bc(1:mpart,2:3)=zuobiao(point,2:3);

point2=find((zuobiao(:,4)==1));
mpart2=length(point2);
bcf=zeros(mpart2,4);
bcf(:,1)=zuobiao(point2,1);
bcf(1:mpart2,2:3)=zuobiao(point2,2:3);

x=azuobiao(:,2);
y=azuobiao(:,3);
scatter(x,y,'g','filled');
hold on
xf=bcf(:,2);
yf=bcf(:,3);
scatter(xf,yf,'b');
hold on
x1=bc(:,2);
x2=bc(:,3);
scatter(x1,x2,'r','filled');
axis equal %daspect([1 1 1]);
hold off

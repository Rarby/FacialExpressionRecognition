function [V,Z,X_tst]=SparseLocal_FDA(XXX,Y,x_tst,r,kNN,epsilon)
%
% ϡ��ֲ�Fisher�б���������мල��ά��
%       
% ����:
%    X:      d �� n ԭʼ��������     
%            d --- ������ά�ȣ�jaffe����Ϊ64*64��
%            n --- �����ĸ�����jaffeΪ213��
%    Y:      n ά������ǩ��  
%    r:      ��ά�ռ��ά�ȣ�Ĭ��ֵd��
%    kNN:    ����ֲ������ڽ�Ȩֵ����ʱҪ�õ�������ڲ���(Ĭ��ֵ 7)
%    epsilon:torlence  
% ���:
%    V: d �� r ͶӰ���� (Z=T'*X)
%    Z: r �� n ��ά����������� 

XXX = double(XXX);

[d,n]=size(XXX);

if nargin<5
   kNN=2;
end

if nargin<4
  r=d;
end

tSb=zeros(d,d);%�����ɢ�Ⱦ���
tSw=zeros(d,d);%������ɢ�Ⱦ���
W = ones(n)./n;
for c=1:max(Y)
  Xc=XXX(:,Y==c);
  Temp = find(Y==c);              
  nc=size(Xc,2); % ����Xc����������nc

  % ����Ȩֵ����A  LFDA���þֲ�����Ȩֵ����
  Xc2=sum(Xc.^2,1);
  distance2=repmat(Xc2,nc,1)+repmat(Xc2',1,nc)-2*Xc'*Xc;
  [sorted,index]=sort(distance2);
  kNNdist2=sorted(kNN+1,:);
  sigma=sqrt(kNNdist2);
  localscale=sigma'*sigma;
  flag=(localscale~=0);
  A=zeros(nc,nc);
  A(flag)=exp(-distance2(flag)./localscale(flag));
   
  W(Temp,Temp)=A./n;
  
  Xc1=sum(Xc,2);
  G=Xc*(repmat(sum(A,2),[1 d]).*Xc')-Xc*A*Xc';
  tSb=tSb+G/n+Xc*Xc'*(1-nc/n)+Xc1*Xc1'/n;
  tSw=tSw+G/nc;
end

%��������������ɢ�Ⱦ���
X1=sum(XXX,2);
tSb=tSb-X1*X1'/n-tSw;

tSb=(tSb+tSb')/2;
tSw=(tSw+tSw')/2;

%��������ɢ�Ⱦ���tSt
tSt = tSb+tSw;

Dlt = diag(sum(W));
Llt = Dlt - W;
[Qlt,Alpha]=eig(Llt);
Hlt = XXX*Qlt*abs(Alpha^(1/2));

%��������ֵ�ֽ�
% tHt = chol(tSt);    %R = chol(A) ����R'*R = A.���A�����������ᱨ��
% tHt = tHt';
[P,~,~]=svd(Hlt);                                                                                      

Sb = P'*tSb*P;
Sw = P'*tSw*P;

%�����������ֵ���Ⲣ��þ���U
if r==d       %U=eigvec,D=eigval_matrix
  [U,D]=eig(Sb,Sw); %����������������U�͹�������ֵ����D,��Խ����ϵ�N��Ԫ�ؼ�Ϊ��Ӧ�Ĺ�������ֵ
else    % ��λ�����ʱ����,rʹ��Ĭ��ֵd
  opts.disp = 0; 
  [U,D]=eigs(Sb,Sw,r,'la',opts);
end


%����bregman��������ϡ�账��
% V = P*U;
tq = size(U,2);
%��ʼ����ر���
V = zeros(d,tq); B = zeros(d,tq);                                                                                         
delta=.01; mu=.5;    % delta mu ��Ϊ���� �Աȵ����õ���V��PU��˵�V
if nargin<6
    %epsilon=10^(-5);
    epsilon=50;
end
%���Ե����㷨
k=1;
ttemp(1) = norm(P'*V-U);
while ttemp(k)>=epsilon %ѭ���ж�
    k=k+1;
    B = B - P*(P'*V-U);
    V = delta*shrink(B,mu);
    ttemp(k) = norm(P'*V-U);
end

Z=V'*XXX;
X_tst = V'*x_tst;

function [V,eigvalues,X_trn,X_tst,d]=SparseLocality_DNE(x_trn,x_tst,y_trn,t,Knn,dim)
% Inputs:
% x_trn   -Train samples one row present a samples
% x_tst   -Test samples
% Outputs
% eigenvectorslast   -a transform matrix
% X_trn      - new train samples
% X_tst      - new test samples
x_trn = double(x_trn);
x_tst = double(x_tst);


% global Knn
if nargin<4 Knn=1;end
% % % % DNE����**********************DNE����
for i=1:size(x_trn,1)
    for j=1:size(x_trn,1)
        dist(i,j)=norm(x_trn(i,:)-x_trn(j,:),2);
    end
end
% dist=L2_distance(x_trn',x_trn');
[shu,index]=sort(dist,2);
F=zeros(size(x_trn,1),size(x_trn,1));
for i=1:size(x_trn,1)
    temp=index(i,2:Knn+1);
    in1=find(y_trn(temp)==y_trn(i));
    in2=find(y_trn(temp)~=y_trn(i));
    F(i,temp(in1))=-exp(-dist(i,temp(in1))./t);
    F(temp(in1),i)=-exp(-dist(temp(in1),i)./t);       
    F(i,temp(in2))=exp(-dist(i,temp(in2))./t);
    F(temp(in2),i)=exp(-dist(temp(in2),i)./t); 
end

S=diag(sum(F));   % S��ΪDlt

Llt = (S-F);
[Qlt,Alpha]=eig(Llt);
Hlt = x_trn'*Qlt*abs(Alpha^(1/2));
[PP,aaa,~]=svd(Hlt);
index=find(diag(aaa)>1.e-5);
PP=PP(:,index);

symMatrix=(x_trn*PP)'*(S-F)*(x_trn*PP);   %symMatrix��ΪSlt
symMatrix=(symMatrix+symMatrix')./2;
[eigvectors,eigvalues ]=eig(symMatrix+eye(size(symMatrix,1))*1.e-8); % ������������������ֵ

[sort_eigval,sort_eigval_index]=sort(diag(eigvalues));
sort_eigval_index=find(sort_eigval<0);

eigvalues=sort_eigval(sort_eigval_index);
U=eigvectors(:,sort_eigval_index);

%����bregman����
   

%����bregman��������ϡ�账��
tq = size(U,2);
%��ʼ����ر���
[n,d]=size(x_trn);
V = zeros(d,tq); B = zeros(d,tq);   
delta=.1; mu=.5;    % delta mu ��Ϊ���� �Աȵ����õ���V��PU��˵�V
    %epsilon=10^(-5);
    epsilon=0.001;
%���Ե����㷨
k=1;
ttemp(1) = norm(PP'*V-U);
while ttemp(k)>=epsilon && k<=1000%ѭ���ж�
    k=k+1;
    B = B - PP*(PP'*V-U);
    V = delta*shrink(B,mu);
    ttemp(k) = norm(PP'*V-U);
end

X_trn=x_trn*V;
X_tst=x_tst*V;
% end
end
% % % % DNE����**********************DNE����

        


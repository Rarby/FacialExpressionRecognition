function [eigenvectorslast,eigvalues,X_trn,X_tst,d]=DNE(x_trn,x_tst,y_trn,Knn)
% Inputs:
% x_trn   -Train samples one row present a samples
% x_tst   -Test samples
% Outputs
% eigenvectorslast   -a transform matrix
% X_trn      - new train samples
% X_tst      - new test samples

% global Knn
if nargin<4 Knn=1;end
% % % % DNE����**********************DNE����

x_trn = double(x_trn);
x_tst = double(x_tst);

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
    F(i,temp(in1))=1;
    F(temp(in1),i)=1;       
     F(i,temp(in2))=-1;
    F(temp(in2),i)=-1;  
end

S=diag(sum(F));
symMatrix=x_trn'*(S-F)*x_trn;
symMatrix=(symMatrix+symMatrix')./2;
[eigvectors,eigvalues ]=eig(symMatrix+eye(size(symMatrix,1))*1.e-8);
% [eigvectors,eigvalues]=eig(symMatrix);
[shu,order]=sort(diag(eigvalues));
order = find(shu<0);
eigvalues=shu(order);
eigvectors=eigvectors(:,order);
% % ѡ���d������ֵ����d������ֵ�ǽӽ�����ģ�
% W'*x_trn'*(S-F)*x_trn*W
 d=sum(eigvalues<0);
% if d==0
%     disp('������ݼ����ý�ά����Ϊ����γ��Ҳ����ʹ�ֱ��ʱ��');
%     X_trn=x_trn;
%     X_tst=x_tst;
%     eigenvectorslast=[];
% else
%     disp('����%dά',d);
%     order=order(1:dimension);
%      eigenvectorslast=eigvectors(:,1:dim);
eigenvectorslast=eigvectors(:,:);
%     eigenvectorslast=eigvectors(:,end-d:end);
    % % % % eigenvectorslastҲ����ͶӰ����
    % % ͶӰ
    X_trn=x_trn*eigenvectorslast;
    X_tst=x_tst*eigenvectorslast;
% end
end
% % % % DNE����**********************DNE����

        


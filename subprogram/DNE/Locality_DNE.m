function [eigenvectorslast,eigvalues,X_trn,X_tst,d]=Locality_DNE(x_trn,x_tst,y_trn,t,Knn,dim)
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
% % % % DNE方法**********************DNE方法
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

S=diag(sum(F));
symMatrix=x_trn'*(S-F)*x_trn;
symMatrix=(symMatrix+symMatrix')./2;
[eigvectors,eigvalues ]=eig(symMatrix+eye(size(symMatrix,1))*1.e-8);
% [eigvectors,eigvalues]=eig(symMatrix);
[shu,order]=sort(diag(eigvalues),'descend');
eigvalues=shu;
eigvectors=eigvectors(:,order);
% % 选择第d个特征值，第d个特征值是接近于零的；
% W'*x_trn'*(S-F)*x_trn*W
 d=sum(eigvalues>0.00000001);
% if d==0
%     disp('这个数据集不用降维，因为降低纬度也不能使分辨率变高');
%     X_trn=x_trn;
%     X_tst=x_tst;
%     eigenvectorslast=[];
% else
%     disp('降到%d维',d);
%     order=order(1:dimension);
     eigenvectorslast=eigvectors(:,1:dim);
%     eigenvectorslast=eigvectors(:,end-d:end);
    % % % % eigenvectorslast也就是投影矩阵
    % % 投影
    X_trn=x_trn*eigenvectorslast;
    X_tst=x_tst*eigenvectorslast;
% end
end
% % % % DNE方法**********************DNE方法

        


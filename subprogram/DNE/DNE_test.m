clear
% ����ʶ��
load Jaffe;
load Jaffe32_row;
% load YaleB32_row;
% load YaleB_Y;
% load AR32_row;
% load AR32_row_Y;
% load CK_Y;
% load CK64_row;

%Z=double(Z)./255;
N1=20;%ѵ��������
global p1 knn
knn=1;
p1=2^-8;


% %���ѡȡ140����Ϊѵ��������73����Ϊ���Լ��� 
% for loop=1:8
%  [x_trn,y_trn,x_tst,y_tst,trainindex,testindex]=sample_random(Jaffe16,Y,N1);
% [eigenvectorslast,eigvalues,X_trn,X_tst,d]=DNE(x_trn,x_tst,y_trn,1);
% %   [eigenvectors_transMat,eigvalues,X_trn,X_tst]=sparse_DNE(x_trn,x_tst,y_trn);
% 
% 
%  %% KNN
%   [out]=cknear(knn,X_trn,y_trn,X_tst); 
% %   [x_trn,y_trn,x_tst,y_tst,trainindex,testindex]=sample_random(Jaffe16,Y,N1);
% %   [out]=cknear(knn,x_trn,y_trn,x_tst); 
%   Acc(loop,1)=mean(out==y_tst);
% 
% end


% n�۽�����֤
% [M,N]=size(X);%���ݼ�Ϊһ��M*N�ľ�������ÿһ�д���һ������
 X = Jaffe32_row;
% X = AR32_row;
% X = CK64_row;

indices=crossvalind('Kfold',Y,8);%��������ְ�
for k=1:8                  %������֤k=10��10����������Ϊ���Լ�   
   test = (indices == k);   %���test��Ԫ�������ݼ��ж�Ӧ�ĵ�Ԫ���
% test = (indices==1);
   train = ~test;           %train��Ԫ�صı��Ϊ��testԪ�صı��
   x_trn=X(train,:);     %�����ݼ��л��ֳ�train����������
%    y_trn=Y(train);%����������Ĳ���Ŀ�꣬�ڱ�������ʵ�ʷ������
   y_trn=Y(train);
   x_tst=X(test,:);%test������
%    y_tst=Y(test);
   y_tst=Y(test);
%  [eigenvectors_transMat,eigvalues,X_trn,X_tst]=sparse_DNE(x_trn,x_tst,y_trn);
%    [out1]=cknear(knn,X_trn,y_trn,X_tst); 
% %    Acc(1,1)=mean(out1==y_tst);
%   Acc(k,1)=mean(out1==y_tst);
%   
% %   [V,eigvalues,X_trn,X_tst]=sparse_DNE_kickingBreagmanIteration(x_trn,x_tst,y_trn);
% %     [out2]=cknear(knn,X_trn,y_trn,X_tst); 
% %   Acc(k,2)=mean(out2==y_tst);
% 
%  [eigenvectorslast,eigvalues,X_trn,X_tst,d]=DNE(x_trn,x_tst,y_trn,1);
%   [out2]=cknear(knn,X_trn,y_trn,X_tst); 
% %    Acc(1,2)=mean(out2==y_tst);
%   Acc(k,2)=mean(out2==y_tst);
 [eigenvectorslast,eigvalues,X_trn,X_tst,d]=Locality_DNE(x_trn,x_tst,y_trn,20,1,23);
 [out3]=cknear(knn,X_trn,y_trn,X_tst); 
  Acc(k,3)=mean(out3==y_tst);
 [eigenvectorslast,eigvalues,X_trn,X_tst,d]=SparseLocality_DNE(x_trn,x_tst,y_trn,20,1,23);
 [out4]=cknear(knn,X_trn,y_trn,X_tst); 
  Acc(k,4)=mean(out4==y_tst);
 
%    %% KNN
%   [out]=cknear(knn,x_trn,y_trn,x_tst); 
%   Acc(k,1)=mean(out==y_tst);
 end
%�������Ϊ����㷨MLKNN�ļ�����ָ֤�꼰���һ����֤������ͽ������ÿ��ָ�궼��һ��kԪ�ص�������
mean(Acc)
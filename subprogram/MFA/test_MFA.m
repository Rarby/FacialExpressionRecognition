clear
% ����ʶ��
% load Jaffe;
% load Jaffe32_row;
% load YaleB32_row;
% load YaleB_Y;
% load AR32_row;
% load AR32_row_Y;
% load CK_Y;
% load CK64_row;
load CK32Row;
load CKROW_Y;
%Z=double(Z)./255;
N1=20;%ѵ��������
global p1 knn
knn=1;
p1=2^-8;

% n�۽�����֤
% [M,N]=size(X);%���ݼ�Ϊһ��M*N�ľ�������ÿһ�д���һ������
 X = CK32Row;
 Y=CKROW_Y;
% X = AR32_row;
% X = CK64_row;

indices=crossvalind('Kfold',Y,8);%��������ְ�
for k=1:8                  %������֤k=10��10����������Ϊ���Լ�   
   test = (indices == k);   %���test��Ԫ�������ݼ��ж�Ӧ�ĵ�Ԫ���
   train = ~test;           %train��Ԫ�صı��Ϊ��testԪ�صı��
   x_trn=X(train,:);     %�����ݼ��л��ֳ�train����������
%    y_trn=Y(train);%����������Ĳ���Ŀ�꣬�ڱ�������ʵ�ʷ������
   y_trn=Y(train);
   x_tst=X(test,:);%test������
   y_tst=Y(test);
   
 [eigenvectors_transMat,X_trn,X_tst]=sparse_MFA(x_trn,y_trn,x_tst); 
   [out1]=cknear(knn,X_trn,y_trn,X_tst); 
  Acc(k,1)=mean(out1==y_tst);
  
 [mapping,X_trn,X_tst] = MFA(x_trn,y_trn,x_tst,186);
 [out2]=cknear(knn,X_trn,y_trn,X_tst); 
  Acc(k,2)=mean(out2==y_tst);

 end

mean(Acc)
clear
% ����ʶ��
load Jaffe;
load JaffeThirtyTwo;
% clear Y1;
% Y=Y1;
% load JaffeThirtyTwo;

% %����ʶ��
% load YaleBThirtyTwo;
% load YaleB_Y;


% ����ʶ��
% [V,Z]=SparseLocal_FDA(JaffeThirtyTwo,Y); % V��ͶӰ����  Z�ǽ�ά֮��ľ���

% % ����ʶ��
% [V,Z]=SparseLocal_FDA(YaleBThirtyTwo,YaleB_Y);



%ZZ = imageResize2(Z);
% ZZ = Z';

N1=20;
%Z=double(Z)./255;

global p1 knn
 knn=1;
p1=2^-8;
C=100;
ker='linear';
ker='rbf';
% for loop=1:8
%  %[x_trn,y_trn,x_tst,y_tst,trainindex,testindex]=sample_random(ZZ,YaleB_Y,N1);
%  [x_trn,y_trn,x_tst,y_tst,trainindex,testindex]=sample_random(ZZ,Y,N1);
% %  [~,P]=pca(x_trn,size(x_trn,1));
% %  newx_trn=x_trn*P;
% %  newx_tst=x_tst*P;
% %   [out]=cknear(knn,newx_trn,y_trn,newx_tst); 
% %   mean(out==y_tst)
% 
%  %% KNN
%   [out]=cknear(knn,x_trn,y_trn,x_tst); 
%   Acc(loop,1)=mean(out==y_tst);
%   
% %   %% SVM
% %  [model,err,predictY,out]= SVC_lib_tt(x_trn,y_trn,ker,C,x_tst,y_tst);
% %    Acc(loop,2)=1-err;
% 
% %    %% Fisher discriminant analysis
% %    [W,bias,method]=fisher_discriminant(x_trn,y_trn);
% %     [out]=fisher_out(x_trn,y_trn,x_tst,'knn',W,knn);
% %       Acc(loop,3)=mean(out==y_tst);
% 
% end


 X = JaffeThirtyTwo;

indices=crossvalind('Kfold',Y,10);%��������ְ�
for k=1:10                   %������֤k=10��10����������Ϊ���Լ�   
   test = (indices == k);   %���test��Ԫ�������ݼ��ж�Ӧ�ĵ�Ԫ���
   train = ~test;           %train��Ԫ�صı��Ϊ��testԪ�صı��
   x_trn=X(:,train);     %�����ݼ��л��ֳ�train����������
%    y_trn=Y(train);%����������Ĳ���Ŀ�꣬�ڱ�������ʵ�ʷ������
   y_trn=Y(train);
   x_tst=X(:,test);%test������
%    y_tst=Y(test);
   y_tst=Y(test);
%  [eigenvectors_transMat,eigvalues,X_trn,X_tst]=sparse_DNE(x_trn,x_tst,y_trn);
 [V,X_trn,X_tst]=SparseLocal_FDA(x_trn,y_trn,x_tst);
 X_trn = real(X_trn);
 X_tst = real(X_tst);
   [out1]=cknear(knn,X_trn,y_trn,X_tst); 
  Acc(k,1)=mean(out1==y_tst);
%  [eigenvectorslast,eigvalues,X_trn,X_tst,d]=DNE(x_trn,x_tst,y_trn,1);
    [V,X_trn]=LFDA(x_trn,y_trn);
    X_tst=V'*x_tst;
  [out2]=cknear(knn,X_trn,y_trn,X_tst); 
  Acc(k,2)=mean(out2==y_tst);

 end
mean(Acc)
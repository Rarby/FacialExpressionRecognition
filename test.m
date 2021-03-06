clear
load Jaffe
% clear Y1;
% Y=Y1;
N1=20;
X=double(X)./255;

global p1 knn
 knn=1;
p1=2^-8;
C=100;
ker='linear';
ker='rbf';
for loop=1:10
 [x_trn,y_trn,x_tst,y_tst,trainindex,testindex]=sample_random(X,Y,N1);
 [~,P]=pca(x_trn,size(x_trn,1));
 newx_trn=x_trn*P;
 newx_tst=x_tst*P;
  [out]=cknear(knn,newx_trn,y_trn,newx_tst); 
  mean(out==y_tst)
 %% KNN
   [out]=cknear(knn,x_trn,y_trn,x_tst); 
  Acc(loop,1)=mean(out==y_tst);
%   %% SVM
%  [model,err,predictY,out]= svc_lib_tt(x_trn,y_trn,ker,C,x_tst,y_tst);
%    Acc(loop,2)=1-err;
%    %% Fisher discriminant analysis
%    [W,bias,method]=fisher_discriminant(x_trn,y_trn);
%     [out]=fisher_out(x_trn,y_trn,x_tst,'knn',W,knn);
%       Acc(loop,3)=mean(out==y_tst);

end
mean(Acc)
% Acc
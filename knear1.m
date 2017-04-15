function [judge] = knear1(sampleset, testset,method)
if nargin<3 method='mean';end
distance=zeros(size(sampleset,2),size(testset,2));
switch lower(method)
    case 'mean'
        for i=1:length(testset)        % 1Ϊ��ȡ������2Ϊ��ȡ����
            for j=1:length(sampleset)                
              
%                         temp(m,n)=(cell2mat(sampleset{1,j}(m,n))-cell2mat(testset{1,i}(m,n)))*(cell2mat(sampleset{1,j}(m,n))-cell2mat(testset{1,i}(m,n)))';
                temp=sum(abs(sampleset{j}-testset{i}),2);             
                distance(j,i)=mean(temp);
            end
        end
    case 'min'
        for i=1:size(testset,2)        % 1Ϊ��ȡ������2Ϊ��ȡ����
            for j=1:size(sampleset,2)
              
%                         temp(m,n)=(cell2mat(sampleset{1,j}(m,n))-cell2mat(testset{1,i}(m,n)))*(cell2mat(sampleset{1,j}(m,n))-cell2mat(testset{1,i}(m,n)))';
                        temp=sum(abs(sampleset{j}-testset{i}),2);  
              
                distance(j,i)=min(temp);
            end
        end
    case 'max'
        for i=1:size(testset,2)        % 1Ϊ��ȡ������2Ϊ��ȡ����
            for j=1:size(sampleset,2)
                temp=[];
              
%                         temp(m,n)=(cell2mat(sampleset{1,j}(m,n))-cell2mat(testset{1,i}(m,n)))*(cell2mat(sampleset{1,j}(m,n))-cell2mat(testset{1,i}(m,n)))';
                       temp=sum(abs(sampleset{j}-testset{i}),2);  
                 
                distance(j,i)=max(temp);
            end
        end
end
[minDist,minIndex]=min(distance); %����������minDist��judge��minDist������¼distance��ÿ�е����ֵ��judge������¼ÿ�����ֵ���к�
judge=minIndex;


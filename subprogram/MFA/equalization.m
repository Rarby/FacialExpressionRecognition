% function equ_imageLBP = equalization( imgLBP, n )
function equ_image = equalization( image )
%%%%%%%%%%%%%%%%%%%%%%%%
%   ���������ֱ��ͼ���⻯��ʵ��
%   ����image����Ҫ����ĺ���
%   ����ֵequ_image�Ǿ��⻯֮���ͼƬ

% image=imread('s1.png');
% subplot(1,2,1);
% imshow(uint8(image));
[row,column] = size(image);

%ͳ������ֵ�ķֲ��ܶ�
pixelNum=zeros(1,256);
for i=0:255
    pixelNum(i+1)=length(find(image==i))/(row*column*1.0);
end

%����ֱ��ͼ�ֲ�
pixelEqualize=zeros(1,256);
for i=1:256
    if i==1
        pixelEqualize(i)=pixelNum(i);
    else
        pixelEqualize(i)=pixelEqualize(i-1)+pixelNum(i);
    end
end

%ȡ��
pixelEqualize=round(256 .* pixelEqualize +0.5);

%���⻯
for i=1:row
    for j=1:column
        equ_image(i,j)=pixelEqualize(image(i,j)+1);
    end
end

% subplot(1,2,2);
% imshow(uint8(equ_image));
end


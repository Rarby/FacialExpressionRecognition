mydir1 = 'C:\Users\Administrator\Desktop\CKProc\6\';
DIRS = [mydir1,'S506_006_00000042.png'];


MyYuanLaiPic = imread(DIRS);%��ȡRGB��ʽ��ͼ��  
MyFirstGrayPic = rgb2gray(MyYuanLaiPic);%�����еĺ�������RGB���Ҷ�ͼ���ת��

imwrite(MyFirstGrayPic,DIRS,'png');


% MyYuanLaiPic = imread('e:/image/matlab/darkMouse.jpg');%��ȡRGB��ʽ��ͼ��  
% MyFirstGrayPic = rgb2gray(MyYuanLaiPic);%�����еĺ�������RGB���Ҷ�ͼ���ת��  
%   
% [rows , cols , colors] = size(MyYuanLaiPic);%�õ�ԭ��ͼ��ľ���Ĳ���  
% MidGrayPic = zeros(rows , cols);%�õõ��Ĳ�������һ��ȫ��ľ���������������洢������ķ��������ĻҶ�ͼ��  
% MidGrayPic = uint8(MidGrayPic);%��������ȫ�����ת��Ϊuint8��ʽ����Ϊ���������䴴��֮��ͼ����double�͵�  
%   
% for i = 1:rows  
%     for j = 1:cols  
%         sum = 0;  
%         for k = 1:colors  
%             sum = sum + MyYuanLaiPic(i , j , k) / 3;%����ת���Ĺؼ���ʽ��sumÿ�ζ���Ϊ��������ֶ����ܳ���255  
%         end  
%         MidGrayPic(i , j) = sum;  
%     end  
% end  
% imwrite(MidGrayPic , 'E:/image/matlab/DarkMouseGray.png' , 'png');  
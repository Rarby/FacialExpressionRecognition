% ������ͼƬ��һ�� �����������и����������
function Unitery(num) %height,width��Ŀ��ͼƬ�ĳ���m��ͼƬ����
    clear; % ɾ�������ռ��е���Ŀ���ͷ�ϵͳ�ڴ�
    close all;%�ر�����figure����

    % set the number of the images
    num = 82;
    % set the path of the images
    mydir = 'C:\Users\Administrator\Desktop\CKPic\7\';
    % set suffix
    DIRS = dir([mydir,'*.png']);  % dir����ȡ�ַ���Ŀ¼�µ��ļ�
    
    % ����ÿ��ͼ ���зָ�
    for i=1:num
        str1 = [mydir,DIRS(i).name];% ���λ��ÿ�ű���ͼ��·��
        eval('OriImg=imread(str1)'); %ִ���ַ���ÿ��ѭ������img %����ͼ��
        figure,imshow(OriImg),[x,y] = ginput(2); %�ֹ���ȡ����E1��E2������
        d = x(2,1)-x(1,1);   %��������֮��Ŀ��d
        
        % ��E1,E2������O(Ox,Oy)
        Ox = sum(x)/2;
        Oy = sum(y)/2;
        
        % �и�����
%         I1 = imcrop(OriImg,[Ox-d Oy-0.5*d 2*d 2*d]); 
        I1 = imcrop(OriImg,[Ox-0.75*d Oy-0.4*d 1.5*d 2*d]); 
        
        %resizeͼƬ
        I1=imresize(I1,[64,64]);
        str2 = strcat('C:\Users\Administrator\Desktop\CKProc\7\',DIRS(i).name);
        eval('imwrite(I1,str2);'); % ִ���ַ��� ÿ��ѭ������img %����ͼ�� %�����һ�����ͼ��
        close all;
    end
end
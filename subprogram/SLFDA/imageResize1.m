% function JaffeThirtyTwo = imageResize()
%     %��213*4096�ľ�����32*32*213�ľ���
%     load Jaffe;
%     JaffeThirtyTwo = zeros(32*32,213);
%     for i=1:213
%         line = X(i,:);
%         resTemp = reshape(line,64,64);
%         newPic = imresize(resTemp,[32,32]);
%         imshow(newPic);
%         acol = reshape(newPic,32*32,1);
% %         acol = zeros(32*32,1);
% %         for j=0:31
% %             acol(j*32+1:j*32+32,1) = newPic(1:32,j+1);
% %         end
%         JaffeThirtyTwo(:,i) = acol;
%     end
%     save JaffeThirtyTwo.mat JaffeThirtyTwo;
% end


% ����JaffeThirtyTwo�Ƿ���ȷ
load JaffeThirtyTwo;
for i=1:213
    acol = JaffeThirtyTwo(:,i);
%     newPic = zeros(32,32);
%     for j=0:31
%       newPic(1:32,j+1) = acol(j*32+1:j*32+32,1);
%     end
    newPic = reshape(acol,32,32);
    imshow(uint8(newPic));
end

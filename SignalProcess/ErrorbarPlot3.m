function [Mdata,Sdata,p]=ErrorbarPlot3(dataA,nameA,dataB,nameB,dataU,nameU,ylableName,varargin)
%plot the errorbar of data
%return mean,standard and similarity between affected and mean value

%% reload function
error(nargchk(7,8,nargin));
if nargin ==8 && varargin{1}==1
    Display = 1;
else
    Display = 0;
end
p=0;
%% calculate the mean value and standard error
sA=size(dataA);
sU=size(dataU);
inDataA=dataA;
inDataU=dataU;
MdataA=mean(inDataA);
MdataB=mean(dataB);
MdataU=mean(inDataU);
SdataA=std(inDataA,1);
SdataB=std(dataB,1);
SdataU=std(inDataU,1);
Mdata=[MdataA;MdataB;MdataU]';
Sdata=[SdataA;SdataB;SdataU]';

% %% calculate similarity
% for i=1:sA(1)
%     if sA(1)==1
%         s=similarity(dataA,dataU);
%
%         break
%     end
%     s(i) = similarity(inDataA(i,:),MdataU);
% end

%% display bar figure
if Display
    if sA(2)==1
        
        figure
        bar(Mdata,0.5,'c')
        hold on
        errorbar(Mdata,Sdata,'k','LineStyle','none');
        set(gca,'XTickLabel',{'Affected','Unaffected'})
        [h,p]=ttest2(inDataA,inDataU);
    end
    figure
    bar(Mdata,0.5);
    hold on
    %x=[0.85,1.15];
    for i=1:sA(2)
        x(i,:)=[0.85+i-1,i,1.15+i-1];
%         [h,p(i)]=ttest2(inDataA(:,i),inDataU(:,i));
%         if 0.01<p(i) && p(i)<0.05
%             text(i,max(Mdata(i,:))+5,'*');
%         elseif p(i)<0.01
%             text(i,max(Mdata(i,:))+5,'**');
%         end
    end
   % errorbar(x,Mdata,Sdata,'k','LineStyle','none');
%     set(gca,'XTickLabel',{'�ش�';'б����';'���Ǽ�ǰ��';'���Ǽ�����';'�Ŷ�ͷ��';'����ͷ��';'�����'})
set(gca,'XTickLabel',{'���Ǽ�ǰ��/б����';'�Ŷ�ͷ��/����ͷ��';'���Ǽ�ǰ�飯����'})
    %ylabel('Power Ratio')
    ylabel(ylableName)
%       legend(nameA,nameU,'*p<0.05   ','**p<0.01   ')
 legend(nameA,nameB,nameU)
end
end


%{

p=zeros(1,4);
for i=1:4
   
    %[r,p1(i)]=corr(x4',y');
    
    if p(i)<0.05
        text(i,max(MdataT(i,1:2))+0.1,'*');
    end
    
end
legend('Affected','Unaffected','*p<0.05    ')

subplot(2,2,1)
bar(Mdata(1,:),'grouped','c');
set(gca,'XTickLabel',{'б����','���Ǽ�ǰ��','�Ŷ�ͷ��','����ͷ��'})
hold on;
errorbar(Mdata(1,:),Vdata(1,:),'k','LineStyle','none');
title('Affected isometric ')
ylabel('Power Ratio')
%}
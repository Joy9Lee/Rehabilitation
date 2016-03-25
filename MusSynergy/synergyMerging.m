close all; clear ; clc;
addpath('G:\SNARC\Rehabilitation\SignalProcess')
load('./data/Na');
Na=Na';
load('./data/Nau');
load('../DATA/SynDataA_35');
load('./data/Hn_min');
%load('./data/Hn_5');

load('./data/H');
load('./data/ind');
s=size(Hn);
index=zeros(s(1),s(1));
num=zeros(35,1);
%hn=zeros(1,7);
hn=[];
%Hn=Hn(ind,:);
%for i=1:length(cmpEMGA.name)            %affect
for i=1:length(H)
    for j=1:Na(i)
        
        m{i}(:,j) =lsqnonneg(Hn',H{i}(j,:)'); % the jth synergy of patients merging of the healthy people's synergy
        a=find(m{i}(:,j)>0.2==1);           % ind is the index of merging sy
        num(i)=num(i)+length(a);
        
        if length(a)==2
            index(a(1),a(2))= index(a(1),a(2))+1;  %'胸大肌';'斜方肌';'三角肌前组';'三角肌中组';'肱二头肌';'肱三头肌';'肱桡机'
            index(a(2),a(1))= index(a(2),a(1))+1;
        elseif length(a)>2
            t=combnk(a,2);
            for k=1:length(t)
                index(t(k,1),t(k,2))= index(t(k,1),t(k,2))+1;
                index(t(k,2),t(k,1))= index(t(k,2),t(k,1))+1;
                
            end
        end
        if i==3
            hn=[hn;Hn(a,:)];
            
            
        end
    end
    if i==3
        
        figure
        
        for l=1:length(hn)
            subplot(1,length(hn),l)
            barh(hn(l,:))
            if l==1
                ylabel('Unaffcted')
            end
        end
        
        r(1,:)=m{3}(1,1)*Hn(1,:)+m{3}(2,1)*Hn(2,:);
        r(2,:)=m{3}(5,2)*Hn(5,:)+m{3}(7,2)*Hn(7,:);
        r(3,:)=m{3}(4,3)*Hn(4,:)+m{3}(6,3)*Hn(6,:)+m{3}(7,3)*Hn(7,:);
        for n=1:3
        s(n)=similarity(r(n,:),H{3}(n,:));
        end
        figure
        for k=1:3
            subplot(1,6,k*2-1);
            barh(H{3}(k,:))
            if k==1
                ylabel('Affcted')
            end
            subplot(1,6,k*2);
            barh(r(k,:))
            xlim([0 1])
            title(num2str(s(k)))
        end
        
    end
    num(i)=num(i)/Na(i);
end
for i=1:size(Hn,1)
    n(i)=length(find(index==i));
end
% %r=m{1}(1,2)*Hn(1,:)+m{1}(2,2)*Hn(2,:);
%
imagesc(index/35);

% colormap(gray(256));
colorbar
% [r,p]=corrAnaly(num,'mean num of merging',SynDataA.FM,'FM',1);
figure
for i=1:s(1)
    subplot(1,length(Hn),i);
    barh(Hn(i,:))
    xlabel(num2str(i))
    %   xlim([0 1])
  
end
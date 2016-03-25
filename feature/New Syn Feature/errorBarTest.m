function [Mdata,Sdata,p]=errorBarTest(inDataA,group,nameA,inDataU,nameU,ylableName,varargin)
%% group
for i=1:length(group)
    if  max(group)==2
        switch group(i)
            case 1
                Grp1=[Grp1 i];
            case 2
                Grp2=[Grp2 i];
        end
    elseif max(group)==3
        switch group(i)
            case 1
                Grp1=[Grp1 i];
            case 2
                Grp2=[Grp2 i];
            case 3
                Grp3=[Grp3 i];
        end
    elseif max(group)==4
        switch group(i)
            case 1
                Grp1=[Grp1 i];
            case 2
                Grp2=[Grp2 i];
            case 3
                Grp3=[Grp3 i];
            case 4
                Grp4=[Grp4 i];
        end
        
    end
end
%% calculate the mean value and standard error
sA=size(dataA);
sU=size(dataU);
MdataA1=mean(inDataA(Grp1));
SdataA1=std(inDataA(Grp1),1);
MdataA2=mean(inDataA(Grp2));
SdataA2=std(inDataA(Grp2),1);
Mdata=[MdataA1;MdataA2]';
Sdata=[SdataA1;SdataA2]';
if max(group)>2
    MdataA3=mean(inDataA(Grp3));
    SdataA3=std(inDataA(Grp3),1);
    Mdata=[MdataA1;MdataA2;MdataA3]';
    Sdata=[SdataA1;SdataA2;SdataA3]';
    if max(group)>3
        MdataA4=mean(inDataA(Grp4));
        SdataA=std(inDataA(Grp4),1);
        Mdata=[MdataA1;MdataA2;MdataA3;MdataA4]';
        Sdata=[SdataA;SdataA2;SdataA3;SdataA4]';
    end
end
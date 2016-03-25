function [Grp1,Grp2,Grp3,Grp4]=group4(data)
Grp1=[]; Grp2=[];Grp3=[];Grp4=[];
for i=1:length(data)
    switch data(i)
        
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


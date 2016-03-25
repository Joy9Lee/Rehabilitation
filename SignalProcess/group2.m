function [group,Grp1,Grp2]=group2(data,cla)
group=[]; Grp1=[]; Grp2=[];
for i=1:length(data)
    if cla=='b'
        %% classify by Brunnstrom
        switch data(i)
            case {1,2}
                group=[group 1];
            case {3,4}
                group=[group 2];
        end
        
    elseif cla=='h'
        %% classify by hypertonia
        switch data(i)
            case {1,3}
                group=[group 1];
            case {2,4}
                group=[group 2];
        end
    end
end
for i=1:length(group)
        switch group(i)
            case 1
                Grp1=[Grp1 i];
            case 2
                Grp2=[Grp2 i];
        end
end
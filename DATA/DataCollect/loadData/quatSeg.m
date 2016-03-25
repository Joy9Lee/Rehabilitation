function quat = quatSeg(quatTemp,index,kl)
%Segment the quaternions into each motion.
%N=length(index)-1;

    for j=1:4
        if kl==1
            quat.limb{j}=quatTemp.limb{j}(1:index(1),:);
               
        else
            quat.limb{j}=quatTemp.limb{j}(index(kl-1)+1:index(kl),:);
          
        end
    end


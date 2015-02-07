close all;

for n=1:length(DataA)
    
subplot(8,5,n)
    if ~isempty(DataA(n).L.flx.sEMG)
        plot(DataA(n).L.flx.sEMG{1})
        title(DataA(n).name)
    end
end
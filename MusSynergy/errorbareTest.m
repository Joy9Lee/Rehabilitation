x = 1:10;
	y = sin(x)+2;
	e = std(y)*ones(size(x));
    figure
	%errorbare(x,y,e)	% use function "errorbar" directly
    barh(y)
   hold on  
    errorbare('h',y,x,e)
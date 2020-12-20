
function retval = check (points)
  retval = 1;
  maxX = 0;maxY = 0;minX = 1000000;miny = 1000000;
  for i=  1: 3
    tempx = points(i,1);
    tempy = points(i,2);
    maxX = max(maxX,tempx);
    maxY = max(maxY,tempy);
    minX = min(minX,tempx);
    miny = min(miny,tempy);
  endfor
 for i = 1:3
    tempx = points(i,1);
    tempy = points(i,2);
    if abs(maxY - tempy) <= 5 && abs(minX - tempx)>5
     retval = 0;
    endif    
 endfor
endfunction

function retval = draw2 (img, points)
maxX = 0;maxY = 0;minX = 1000000;miny = 1000000;
  retval = img;
  points
  for i=  1: 3
    tempx = points(i,1);
    tempy = points(i,2);
    maxX = max(maxX,tempx);
    maxY = max(maxY,tempy);
    minX = min(minX,tempx);
    miny = min(miny,tempy);
  endfor
  uint64(maxX)
  maxY
 for i = minX: maxX
   for j = miny : maxY
     retval(uint64(j),uint64(i)) = 1;
    endfor
 endfor
endfunction

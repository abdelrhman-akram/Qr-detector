function [x1,y1,x2,y2] = GetAngleAndRotate (points)
  N = size(points);
  ma = 0;
  x1 = 0;
  y1 = 0;
  indx1 = 0;
  indx2 = 0;
  for i = 1 : N
    for j = i + 1:N
      dx = points(i,1) - points(j,1);
      dx = dx .* dx;
      dy = points(i,2) - points(j,2);
      dy = dy .* dy;
      if dy + dx > ma 
        ma = dy + dx;
        indx1 = i;
        indx2 = j;
      endif
     endfor
   endfor
    x1 = points(indx1,1);
    y1 = points(indx1,2);
    
    x2 = points(indx2,1);
    y2 = points(indx2,2);
endfunction


function [rx,ry] = RotatePoint (x2,y2,x1,y1,Angle)
  Angle = -Angle;
  if Angle < 0
  Angle = Angle + 360.0;
 endif
  Angle = Angle * acos(-1.0) / 180.0;
  rx = cos(Angle) * (x2-x1) - sin(Angle) * (y2-y1) + x1;
  ry = sin(Angle) * (x2-x1) + cos(Angle) * (y2-y1) + y1;
endfunction

im = imread('1.1.bmp');
temp = im;
im = rgb2gray(im);
[rows,cols] = size(im);

for i = 1:rows
  for j = 1:cols
    if im(i,j) >= 35 && im(i,j) <= 200
      im(i,j) = im(i,j) - 35;
     endif
   endfor
endfor

%im = imnoise(im,'gaussian');
Thresh = graythresh(im);
im = im2bw(im,Thresh);
im = ~im;

im = bwareaopen(im, 20);
[L, N] = bwlabel(im);
rp =  regionprops(L,'BoundingBox','Centroid');

Centroid = cat(1, rp.Centroid);
ListOfCentroids = [];
ListOfPoints = [];

for i = 1: N
  for j = i + 1:N
    if abs(Centroid(i,1) - Centroid(j,1)) <= 2 && abs(Centroid(i,2) - Centroid(j,2)) <=2
      ListOfCentroids = [ListOfCentroids,rp(i)];
      ListOfCentroids = [ListOfCentroids,rp(j)];
       ListOfPoints = [ListOfPoints;[Centroid(i,1),Centroid(i,2)]];
    endif
  endfor
endfor
temp3 = temp;
temp = im;
%draw(im,ListOfCentroids);

%figure,imshow(temp);
[x1,y1,x2,y2] = GetAngleAndRotate(ListOfPoints)
Angle = -(-45.0-atand((y2 - y1) ./ (x2 - x1)));
temp = RotateAround(temp,y1,x1,Angle);
temp3 = RotateAround(temp3,y1,x1,Angle);
[nx2,ny2] = RotatePoint(x2,y2,x1,y1,Angle)
CenterX = (x1 + nx2) ./2.0
CenterY = (y1 + ny2) ./2.0
NewList=  [];

for i = 1: 3
    tempX = ListOfPoints(i,1);
    tempY = ListOfPoints(i,2); 
   [r1,r2] = RotatePoint(tempX,tempY,x1,y1,Angle);
   NewList = [NewList;[r1,r2]];
endfor
for i = 1:4
  ret = check(NewList);
   if ret == 1
     break
    endif
  temp = RotateAround(temp,CenterY, CenterX ,90.0);
  temp3 = RotateAround(temp3,CenterY, CenterX ,90.0);
  Temp = [];
  for j = 1: 3
      tempX = NewList(j,1);
      tempY = NewList(j,2); 
      [r1,r2] = RotatePoint(tempX,tempY,CenterX,CenterY,90);
      Temp = [Temp;[r1,r2]];
   endfor
  NewList = Temp;
endfor
temp = draw2(temp,NewList);
%figure,imshow(temp);
[L, N] = bwlabel(temp);
rp =  regionprops(L,'BoundingBox');
boxs = cat(1,rp.BoundingBox);
%draw(temp,rp);

indx = -1; mn = 10000000000;
[SZ,_] = size(boxs);
for i = 1 : SZ
  cnt = 0;
  x1 = boxs(i,1);
  y1 = boxs(i,2);
  x2 = x1 + boxs(i,3);
  y2 = y1 + boxs(i,4);
  for j = 1 : 3
      tempX = NewList(j,1);
      tempY = NewList(j,2); 
   if  x1 - tempX <= 5 && tempX - x2 <= 5 && y1 - tempY <= 5 && tempY - y2 <= 5
     cnt= cnt + 1;
   endif
  endfor
 if cnt == 3
   area = boxs(i,3) * boxs(i,4);
   if area < mn
     mn = area;
     indx = i;
   endif
 endif
endfor
temp3 = imcrop(temp3,[boxs(indx,1)-20,boxs(indx,2) - 20,boxs(indx,3)+ 30 ,boxs(indx,4) + 40]);
figure,imshow(temp3);

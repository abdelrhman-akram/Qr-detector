

function retval = draw (im,rp)

figure, imshow(im);
for i = 1 : numel(rp)
rectangle('Position', rp(i).BoundingBox, 'EdgeColor', 'r');
endfor
endfunction

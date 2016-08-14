function new_pic = black_cards(image)
% This function does segmentation for the black cards. It will blur the
% image first, then it does thresholding.

new_image = myjpgload(image, 0);

% Show the orginal image.
% imshow(new_image)
% pause(1) 

% Blur the image using a gaussian model
h = fspecial('gaussian', [7,7], 1.0); 
new_image = imfilter(new_image, h,'same');

% imshow(new_image)
% pause(1)

image_hist = dohist(new_image,0);
threshold = findthresh(image_hist,3,0);

% Alternative
% new_pic = im2bw(new_image, (threshold-5)/255);

%Getting rid of the edges by setting a distance threshold (the center of
%the image)
center=size(new_image)/2+.5;
[R,C] = size(new_image);
new_pic = zeros(R,C);
for i = 1 : R;
    for j = 1 : C;
        x = new_image(i,j);
        if x < threshold - 5 && pdist([i, j; center], 'euclidean') < 220
            new_pic(i, j) = 1;
        else
            new_pic(i, j) = 0;
        end
    end
end

% imshow(new_pic)
% pause(1)

new_pic = bwareaopen(new_pic, 15);

% Show the binary image.
% imshow(new_pic)
% pause(1)

end
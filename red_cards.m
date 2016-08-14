function r_image = red_cards(image)
% This function does segmnetation for the red cards. It will normalize the
% image first, then it focuses on the red channel and then it uses
% thresholding.

Image_rgb = importdata(image, 'jpg');

%Show the original image
% imshow(Image_rgb)
% pause(1)

Image_rgb   = double(Image_rgb);
Image_red   = Image_rgb(:, :, 1);
Image_green = Image_rgb(:, :, 2);
Image_blue  = Image_rgb(:, :, 3);

[row, col] = size(Image_rgb(:,:,1));

for y = 1 : row    %-->number of rows    in image
   for x = 1 : col %-->number of columns in the image
      Red   = Image_red  (y, x);
      Green = Image_green(y, x);
      Blue  = Image_blue (y, x);

    NormalizedRed   = Red   / sqrt(Red^2 + Green^2 + Blue^2);
    NormalizedGreen = Green / sqrt(Red^2 + Green^2 + Blue^2);
    NormalizedBlue  = Blue  / sqrt(Red^2 + Green^2 + Blue^2);

    Image_red  (y, x) = NormalizedRed;
    Image_green(y, x) = NormalizedGreen;
    Image_blue (y, x) = NormalizedBlue;
   end
end

Image_rgb(:, :, 1) = Image_red;
Image_rgb(:, :, 2) = Image_green;
Image_rgb(:, :, 3) = Image_blue;

Image_rgb = Image_rgb .* Image_rgb;
Image_rgb = Image_rgb .* Image_rgb;

% Normalization done.
% imshow(Image_rgb)
% pause(1)

% Focus on the red channel by setting other colours to black.
Image_rgb(:, :, 2) = 0;
Image_rgb(:, :, 3) = 0;

% imshow(Image_rgb)
% pause(1)


% Change the image to binary using thresholding. 20 is hard coded value,
% found by trying different values (as all of the histograms looks the
% same. For some reason, findthreshold function fails to find a good
% threshold.
image_hist = dohist(Image_rgb, 0);
pause(2)
new_pic = im2bw(Image_rgb, 20/255);

% imshow(new_pic);
% pause(1)

% Getting rid of all the noises, by removing all objects smaller than 195
% pixels.
new_pic = bwareaopen(new_pic, 195);
r_image = new_pic;

% Show the image after segmentation.
% imshow(r_image);
% pause(1)

end
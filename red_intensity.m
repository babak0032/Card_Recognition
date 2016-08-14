function red_average = red_intensity(image)
% This function finds the red intensity of an image. It is used to
% differentiate weahter a card is red or black.

Image_rgb = importdata(image, 'jpg');

% imshow(Image_rgb)
% pause(1)

% Image_rgb = imresize(Image_rgb, [400 400]);
Image_rgb   = double(Image_rgb);
Image_red   = Image_rgb(:, :, 1);
Image_green = Image_rgb(:, :, 2);
Image_blue  = Image_rgb(:, :, 3);

[row, col] = size(Image_rgb(:, :, 1));

for y = 1 : row    %-->numberof rows in image
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

% imshow(Image_rgb)
% pause(1)

red_channel = Image_rgb(:, :, 1);
red_average = mean(mean(red_channel));
end
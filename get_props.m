function [props,symbol_classes] = get_props()
%Goes through the folder of the training cards and display their binary
%form and get their properties. If the red_intensity fo the card is high,
%it will use red_cards function for segmnetattion. Otherwise, it will use
%the black_cards function.

%initialize props
props = zeros(240,3);
counter_p = 1;

%initalize classes
counter_c = 1;
symbol_classes = zeros(240, 1);
card_classes   = zeros(32, 1);
for i = 0 : 7
    card_classes(4 * i + 1) = 1;
    card_classes(4 * i + 2) = 2;
    card_classes(4 * i + 3) = 3;
    card_classes(4 * i + 4) = 4;
end


for i = 1 : 32
    image = ['cards/train',int2str(i),'.jpg'];
    r_intensity = red_intensity(image);
    
    if r_intensity > 0.1119
        binary_image = red_cards(image);
    else
        binary_image = black_cards(image);
    end

    %Get all properties
    labeled = bwlabel(binary_image, 4);
    regions = regionprops(labeled,['basic']);
    imshow(binary_image);
    size_y = size(regions);
    
    bounding_boxes = zeros(1,size_y(1));
    %Draw rectangles around all objects
    for j = 1:size_y(1);
        rectangle('Position', regions(j).BoundingBox, ...
                  'EdgeColor', [0 1 0], 'LineWidth', 2);
        box = regions(j).BoundingBox;
        bounding_boxes(j) = box(3)*box(4);

    end
    
    for z = 1:size_y(1) - 2;
        symbol_classes(counter_c) = card_classes(i);
        counter_c = counter_c + 1; 
    end
    
    pause(1)
    
    %Getting rid of number symbols
    sorted_areas = sort(bounding_boxes);
    [~, C] = size(sorted_areas);
    sorted_areas(C)     = [];
    sorted_areas(C - 1) = [];

    
    for x = 1:size_y;
        box = regions(x).BoundingBox;
        area = box(3) * box(4);
        
        if ismember(area,sorted_areas)
            
            % imshow(imcrop(binary_image,box))
            % pause(1)
            
            props(counter_p, :) = getproperties(imcrop(binary_image, box));
            counter_p = counter_p + 1;
            
        end
    end      
end
end
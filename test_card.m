function [number, suit] = test_card(image, M, I, A)
    
    r_intensity = red_intensity(image);

    if r_intensity > 0.1119
        binary_image = red_cards(image);
    else
        binary_image = black_cards(image);
    end

    %Get all properties
    labeled = bwlabel(binary_image, 4);
    regions = regionprops(labeled, ['basic']);
    imshow(image);
    size_y = size(regions);

    bounding_boxes = zeros(1, size_y(1));
    %Draw rectangles around all objects
    for j = 1 : size_y(1);
        rectangle('Position', regions(j).BoundingBox, ...
                  'EdgeColor', [0 1 0], 'LineWidth', 2);
        box = regions(j).BoundingBox;
        bounding_boxes(j) = box(3) * box(4);

    end

    pause(1)

    sorted_areas = sort(bounding_boxes);
    [~, C] = size(sorted_areas);
    sorted_areas(C)     = [];
    sorted_areas(C - 1) = [];

    [~,C] = size(sorted_areas);
    props = zeros(C, 3);
    counter_p = 1;

    for x = 1:size_y;
        box = regions(x).BoundingBox;
        area = box(3) * box(4);

        if ismember(area, sorted_areas)

%                 imshow(imcrop(binary_image,box))
%                 pause(1)

            props(counter_p, :) = getproperties(imcrop(binary_image, box));
            counter_p = counter_p + 1;

        end
    end

    class_probabilities = zeros(C, 2);

    for z = 1:C ;
        props(z, :);
        [Symbol,Prob] = classify(props(z, :), 4, M, I, 3, A);
        class_probabilities(z, 1) = Symbol;
        class_probabilities(z, 2) = Prob;
    end

    [R, ~] = size(class_probabilities);
    max_prob = 0;
    suit = 0;

    for y = 1 : R;
        if class_probabilities(y, 2) > max_prob
            max_prob = class_probabilities(y, 2);
            suit = class_probabilities(y, 1);
        end
    end

    [~, C] = size(sorted_areas);
    number = C - 2;

end
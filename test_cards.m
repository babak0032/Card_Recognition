function test_cards()

    [M, I, A] = load_models();
    
    for i = 1 : 32;
        image = ['test_cards/test', int2str(i), '.jpg'];
        [number, suit] = test_card(image, M, I, A);
        switch suit
            case 1
                ['This is ', int2str(number), ' of Spade'  ] %#ok<NOPRT>
            case 2
                ['This is ', int2str(number), ' of Heart'  ] %#ok<NOPRT>
            case 3
                ['This is ', int2str(number), ' of Club'   ] %#ok<NOPRT>
            case 4
                ['This is ', int2str(number), ' of Diamond'] %#ok<NOPRT>
        end

    end

end
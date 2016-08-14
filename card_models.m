function [Mean, Invcors, Aprioris] = card_models()

[Props, Classes] = get_props();
[Mean, Invcors, Aprioris] = buildmodel(3, Props, 240, 4, Classes);

end
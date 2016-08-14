function save_models()

[M, I, A] = card_models(); %#ok<NASGU,ASGLU>
save('models.mat', 'M', 'I', 'A');

end
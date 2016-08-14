function [M, I, A] = load_models() %#ok<*STOUT>

% if exist('models.mat', 'file') ~= 2
%     'Error: Cannot load models - call save_models first!' %#ok<NOPRT>
%     return

M = []; %#ok<NASGU>
I = []; %#ok<NASGU>
A = []; %#ok<NASGU>
models = load('models.mat', 'M', 'I', 'A'); 
M = models.M;
I = models.I;
A = models.A;

end
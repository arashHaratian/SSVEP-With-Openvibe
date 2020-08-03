function box_out = CSPpros(box_in)
m = 1;
Rh = 0;
for i = 1:OV_getNbPendingInputChunk(box_in,1)
    
    
    [box_in, start_time, end_time, matrix_data] = OV_popInputBuffer(box_in, 1);
    
    
    
        % step 1: normal data
        for n = 1:size(matrix_data, 1)
            matrix_data(n, :) = matrix_data(n, :) - mean(matrix_data(n, :));
        end
        % step 1: normal data
        rh = (matrix_data*matrix_data')/trace((matrix_data*matrix_data'));
        Rh = Rh+ rh;
end
% step2: calculate Rh and Rf mean
%
Rf = 0;
for i = 1:OV_getNbPendingInputChunk(box_in, 2)
    [box_in, start_time, end_time, matrix_data] = OV_popInputBuffer(box_in, 2);
    box_in.outputs{1}.header = box_in.inputs{2}.header;
    % step 1: normal data
    for n = 1:size(matrix_data, 1)
        matrix_data(n, :) = matrix_data(n, :) - mean(matrix_data(n, :));
    end
    % step 1: normal data
    rf = (matrix_data*matrix_data')/trace((matrix_data*matrix_data'));
    Rf = Rf + rf;


%% step 3: generalized eigen value decomposition
[u, v] = eig(Rh, Rf);
v = diag(v);
[v, ind]= sort(v, 'descend');
u = u(:, ind);
w = [u(:, 1:m) , u(:, end-m+1:end) ];

box_out = OV_addOutputBuffer(box_in,1,start_time,end_time, w);
end

end
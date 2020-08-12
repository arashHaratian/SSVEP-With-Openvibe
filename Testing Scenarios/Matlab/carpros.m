function box_out = carpros(box_in)

for i = 1:OV_getNbPendingInputChunk(box_in,1)
    
    [box_in, start_time, end_time, matrix_data] = OV_popInputBuffer(box_in,1);
    box_in.outputs{1}.header = box_in.inputs{1}.header;
    mu = mean(matrix_data, 1);
    for j=1:size(matrix_data, 1)
        xi = matrix_data(j, :);
        matrix_data(j, :) = xi-mu;
    end

box_in = OV_addOutputBuffer(box_in,1,start_time,end_time,matrix_data);
end 
    box_out = box_in;
end
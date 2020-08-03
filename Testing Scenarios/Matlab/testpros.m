function box_out = testpros(box_in)


% for i = 1:OV_getNbPendingInputChunk(box_in,1)
% 
%     [box_in, start_time, end_time, matrix_data] = OV_popInputBuffer(box_in,1);
%     disp(size(matrix_data))
%     
    
    
for i = 1:OV_getNbPendingInputChunk(box_in,2)

    [box_in, start_time, end_time, matrix_data] = OV_popInputBuffer(box_in,2);
    disp(size(matrix_data))
    
    
%     box_in = OV_addOutputBuffer(box_in,1,start_time,end_time,matrix_data);
end
    
    box_out = box_in;
end
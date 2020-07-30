function box_out = butterpros(box_in)
%   Fs = 128;
%     FL = 8;
%     FH = 40;
for i = 1:OV_getNbPendingInputChunk(box_in,1)

    [box_in, start_time, end_time, matrix_data] = OV_popInputBuffer(box_in,1);
    box_in.outputs{1}.header = box_in.inputs{1}.header;
   
    Fs = box_in.settings(1).value;
    FL = box_in.settings(2).value;
    FH = box_in.settings(3).value;

    [b,a] = butter(3, [FL FH]/(Fs/2), 'bandpass');
    matrix_data = filtfilt(b, a, matrix_data);
    
    
    
    box_in = OV_addOutputBuffer(box_in,1,start_time,end_time,matrix_data);
end
    
    box_out = box_in;
end
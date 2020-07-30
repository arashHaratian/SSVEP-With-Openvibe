function[filtered_data] = mybutterfilter(input_data, FL, FH)
%%
Fs = 512;
size_m = size(input_data);

%% filtering
data = squeeze(input_data(1,:,:));
data = data';
data = double(data)*0.1;
[b,a] = butter(3, [FL FH]/(Fs/2), 'bandpass');
data= filtfilt(b, a, data);
filtered_data = data;

for trial= 2:size_m(1)
    data = squeeze(input_data(trial, :, :));
    data = data';
    data = double(data)*0.1;
    [b,a] = butter(3, [FL FH]/(Fs/2), 'bandpass');
    data = filtfilt(b, a, data);
    filtered_data = [filtered_data; data];
end
end

%Steps of Project:
%Step 1- Create 3 input frequencies
%Step 2- Create a signal that is a mixture of the 3 signals
%Step 3- Create a bandpass filter that selects the center frequency
%Step 4- Output filtered signal which contains only middle frequency
%Step 5- Plot in time/freq domain the original and filtered signal
%for butterworth order 1 and 15

fs = 8192; % Sampling frequency
dt = 1/fs;
StopTime = 0.25;
t = (0:dt:StopTime); % time vector for all time analysis plots
frequency_vector = [100 1500 3500]; % a vector of frequencies used
data1 = sin(2*pi*frequency_vector(1)*t);
data2 = sin(2*pi*frequency_vector(2)*t);
data3 = sin(2*pi*frequency_vector(3)*t);

data4 = data1 + data2 + data3; % summing of sinusoids

fc = [1200 1800]; % low and high frequency in bandpass filter
[b,a] = butter(15,fc/(fs/2), 'bandpass'); % creation of 15th order butterworth bandpass filter coefficients
[b2,a2] = butter(1, fc/(fs/2), 'bandpass');% creation of 1st order butterworth bandpass filter coefficients
data6 = filter(b2,a2, data4); % applying the filter to the summed sinusoid
data5 = filter(b,a, data4); % applying the filter to the summed sinusoid

% ALL BELOW IS PLOTTING OF THE TIME ANALYSIS, PERIODOGRAM, AND FREQUENCY
% ANALYSIS
figure('NumberTitle', 'off', 'Name', 'Time Analysis 1st Order Unfiltered Adam Christa')
plot(t, data4);
title('Time Analysis 15th Order Unfiltered Adam Christa'); xlabel('Time (s)'); ylabel('Magnitude');
figure('NumberTitle', 'off', 'Name', 'Periodogram Analysis 1st Order Unfiltered Adam Christa')
periodogram(data4)

figure('NumberTitle', 'off', 'Name', 'Time Analysis 1st Order Filtered Adam Christa')
plot(t, data6);
title('Time Analysis 15th Order Filtered Adam Christa'); xlabel('Time (s)'); ylabel('Magnitude');
figure('NumberTitle', 'off', 'Name', 'Periodogram Analysis 1st Order Filtered Adam Christa')
periodogram(data6)
figure('NumberTitle', 'off', 'Name', '1st Order Frequency Response Adam Christa')
freqz(b2,a2)


figure('NumberTitle', 'off', 'Name', 'Time Analysis 1st Order Unfiltered Adam Christa')
plot(t, data4);
title('Time Analysis 15th Order Unfiltered Adam Christa'); xlabel('Time (s)'); ylabel('Magnitude');
figure('NumberTitle', 'off', 'Name', 'Periodogram Analysis 15th Order Unfiltered Adam Christa')
periodogram(data4)

figure('NumberTitle', 'off', 'Name', 'Time Analysis 15th Order Filtered Adam Christa')
plot(t, data5);
title('Time Analysis 15th Order Filtered Adam Christa'); xlabel('Time (s)'); ylabel('Magnitude');
figure('NumberTitle', 'off', 'Name', 'Periodogram Analysis 15th Order Filtered Adam Christa')
periodogram(data5)
figure('NumberTitle', 'off', 'Name', '15th Order Frequency Response Adam Christa')
freqz(b,a)


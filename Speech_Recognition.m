% A SPEECH RECOGNITION (USES FFT) PERSONAL PROJECT STEPS
% Step 1- perform a frequency analysis of the audio of someone saying "Yes" or "No"
% Step 2- find the frequencies at local peaks in a periodogram
% Step 3- find the most dominant (peak) frequency of the local peaks
% Step 4- find the frequencies of the local peaks above a certain dB
% threshold
% Step 5- find the mean of the found frequencies
% Step 6- find the median of the found frequencies
% Step 7- (TESTING DONE BEFORE ACTUAL USE) I ran 10 tests of me saying "Yes" and "No" and recorded
% the data for the mean, median, and peak values and created an average
% mean, median, and peak frequency for "Yes" and "No"
% Step 8- create a score integer where if the values of an unknown are
% closer to the "YES" value, the score gains a point. If the value is
% closer to the "NO" value, the score loses a point. A positive score
% yields a "YES" determination. A negative score yields a "NO"
% determination

% the determined average values via tests
avg_yes_mean = 13854;
avg_no_mean = 3685;
avg_yes_median = 14034;
avg_no_median = 3535;
avg_yes_loud = 88.4;
avg_no_loud = 91.6; 

[voice, fs] = audioread('Test5.m4a');
%sound(voice, fs);
s = voice(:,1);

% frequency analysis of input audio
[Pxx, Fxx] = periodogram(s,rectwin(length(s)),length(s),fs);

[pks,locs_pks] = findpeaks(Pxx);

% finding peak audio frequency
[max_val, index_max_val] = max(Pxx);
loudest_freq = Fxx(index_max_val);

array_of_num_greater_than_threshold = [];

% determining frequency values above dB thershold
num_greater_than_threshold = 1;
for i = 1 : length(locs_pks)
    temp = 10 * log(Pxx(locs_pks(i))) * -1;
    
    if temp < 200
        array_of_num_greater_than_threshold(num_greater_than_threshold) = locs_pks(i);
        num_greater_than_threshold = num_greater_than_threshold + 1;
    end
end

% determining median and mean
total = 0;
median = 0;
for i = 1 : length(array_of_num_greater_than_threshold)
    total = total + array_of_num_greater_than_threshold(i);
    if (i == floor(length(array_of_num_greater_than_threshold) / 2))
        median = array_of_num_greater_than_threshold(i);
    end
end

mean = total / length(array_of_num_greater_than_threshold);
mean
median
loudest_freq

% calculating score using determined mean, median, and peak
score = 0;

if (abs(mean - avg_yes_mean) < abs(mean - avg_no_mean))
    score = score + 1;
else
    score = score - 1;
end

if (abs(median - avg_yes_median) < abs(median - avg_no_median))
    score = score + 1;
else
    score = score - 1;
end

if (abs(loudest_freq - avg_yes_loud) < abs(loudest_freq - avg_no_loud))
    score = score + 1;
else
    score = score - 1;
end

% is the audio a "YES" or a "NO"
if (score > 0)
    "YES"
else
    "NO"
end


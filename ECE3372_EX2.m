% STEPS OF PROJECT:
% Step 1- input an audio file that has been distorted by three 
% loud frequencies 
% Step 2- determine what these frequencies are
% Step 3- attempt to filter these frequencies out by using multiple
% notch filters in a cascaded fashion
% Step 4- listen to the final audio and output the frequency analyses

[signal, fs] = audioread('noisy_sound1.m4a');
%sound(y,Fs)


%Plotting frequencies of signal before filtering. Can use periodogram
%to find what frequencies to notch filter out
signal = signal(:,1);
figure(1)
periodogram(signal,rectwin(length(signal)),length(signal),fs);
xlim([0 1])

%The frequencies of noises (determined by periodogram) to filter out
s1 = 503.1;
s2 = 123;
s3 = 60;

%First filter
f = fdesign.notch('N,F0,BW',2,s1,10,fs);
h = design(f);

%First filter response
notchFilt1 = design(f, 'Systemobject', true);
figure(2)
fvtool(notchFilt1)
xlim([0 1])

%Second filter

f2 = fdesign.notch('N,F0,BW',2,s2,10,fs);
h2 = design(f2);

%Second filter response
notchFilt2 = design(f2, 'Systemobject', true);
figure(3)
fvtool(notchFilt2)
xlim([0 1])

%Third filter
f3 = fdesign.notch('N,F0,BW',2,s3,10,fs);
h3 = design(f3);

%Third Filter Response
notchFilt3 = design(f3, 'Systemobject', true);
figure(4)
fvtool(notchFilt3)
xlim([0 1])

%Cascading of filters
hd = dfilt.cascade(h, h2, h3);

%Filtering and sound production
final = filter(hd , signal);
%sound(final, fs)

final = final(:,1);

%Plotting frequency of signal after filtering
figure(5)
periodogram(final,rectwin(length(final)),length(final),fs);
xlim([0 1])

%Transcription of message after filtering
Transcription = 'Hello. This is just a test. Testing 1 2 3 4';




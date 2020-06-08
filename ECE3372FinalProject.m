% STEPS OF PROJECT:
% Step 1- import the impulse response of location and audio file recorded
% Step 2- convolve the impulse response and audio file
% Step 3- perform DFT on convolved output of Step 2 and impulse response
% Step 4- perform Inverse DFT on output divided by impulse response
% Step 5- use a chebyshev type 2 filter on output of Step 4 in order
% to eliminate background noise
% Step 6- output all the frequency analyses plots

[ir, fs] = audioread('lyd3_000_ortf_48k.wav'); % impulse response of st. andrews church (found on openairlib.net)
%sound(ir, fs);

[voice, fs2] = audioread('Home 2.m4a');   % original audio file  
%sound(voice, fs2);

s = voice(:,1);
t = ir(:,1);

dt = 1/fs2;
t2 = 0:dt:(length(s)*dt)-dt;

figure('Name', 'Original Signal Temporal Plot');
plot(t2,s); xlabel('Seconds'); ylabel('Amplitude');

figure('Name', 'Original Signal Spectrum Plot');
periodogram(s,rectwin(length(s)),length(s),fs2);

addedEcho = filter(t, 1, s);      % convolution of original signal and impulse response
%sound(addedEcho, fs2);

dt = 1/fs2;
t2 = 0:dt:(length(addedEcho)*dt)-dt;

figure('Name', 'Echo Signal Temporal Plot');
plot(t2, addedEcho); xlabel('Seconds'); ylabel('Amplitude');

figure('Name', 'Echo Signal Spectrum Plot');
periodogram(addedEcho,rectwin(length(addedEcho)),length(addedEcho),fs2);



N = length(s) + length(t) - 1;    % Number of zeros to padd

fftConv = fft(addedEcho, N);      % DFT of echo signal
FIR = fft(t, N);                  % DFT of impulse response


Inverse = ifft(fftConv./FIR);     % IDFT of Y(z)/H(z)
%sound(Inverse, fs2);


Fn = fs2/2;
Wp = 5000/Fn;                               % Passband Frequency (Normalised)
Ws = 5010/Fn;                               % Stopband Frequency (Normalised)
Rp = 1;                                     % Passband Ripple (dB)
Rs = 150;                                   % Stopband Ripple (dB)
[n,Ws] = cheb2ord(Wp,Ws,Rp,Rs);             % Filter Order
[z,p,k] = cheby2(n,Rs,Ws,'low');            % Filter Design
[soslp,glp] = zp2sos(z,p,k); 


filtered_sound = filtfilt(soslp, glp, Inverse);   % filtering using chebyshev type 2
%sound(filtered_sound, fs2);

dt = 1/fs2;
t2 = 0:dt:(length(filtered_sound)*dt)-dt;

figure('Name', 'Inverse Signal Temporal Plot');
plot(t2, filtered_sound); xlabel('Seconds'); ylabel('Amplitude');

figure('Name', 'Inverse Signal Spectrum Plot');
periodogram(filtered_sound,rectwin(length(filtered_sound)),length(filtered_sound),fs2);


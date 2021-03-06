close all; clear all;
%read .wav file----------------------------
[y_rec, Fs] = audioread('Orig_Input.wav');
%play audio files
soundsc(y_rec,Fs);
filename='melody1.wav';
%creating melody----------------------------

t = 0 : 1/Fs : 5;
f1 = 440; 
f2 = 2 * f1;
f3 = 3 * f1;
f4 = 4 * f1;
A1 = .3; A2 = A1/2; A3 = A1/3; A4 = A1/4;
w = 0; 

y1 = A1 * sin( 2 * pi * f1 * t + w );
y2 = A2 * sin( 2 * pi * f2 * t + w );
y3 = A3 * sin( 2 * pi * f3 * t + w );
y4 = A4 * sin( 2 * pi * f4 * t + w );
y_mel = [y1 y2 y3 y4];
sound( y_mel, Fs, 16 ); 
%mix melody---------------------------
y_rec = y_rec';
y_rec= imresize(y_rec,[1,882004]);
y_mix= y_rec + y_mel;
filename1 ='melody1.wav';
audiowrite(filename1,y_mix,85000);
%FFT---------------------------------
Y_mix=fft(y_mix);
plot(abs(Y_mix))
%Spectogram--------------------------
win = 128 % window length in samples
% number of samples between overlapping windows:
hop = win/2            

nfft = win % width of each frequency bin 
spectrogram(y_rec,win,hop,nfft,Fs,'yaxis')

% change the tick labels of the graph from scientific notation to floating point: 
yt = get(gca,'YTick');  
set(gca,'YTickLabel', sprintf('%.0f|',yt))

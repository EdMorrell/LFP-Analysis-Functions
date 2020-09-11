function [spectrum,freq,serr] = Run_Spec(LFP_Samples,timestamps1,timestamps2,...
    LFP_Timestamps,Fs,range,window,tapers)

% --- Run_Spec
%        - This function takes LFP samples and 2 timestamp arrays 
%          corresponding to runs in both direction. It computes a power 
%          spectrum from LFP between the timestamp arrays.
%          (Runs MTSpectrum.m from FMAToolbox)
% Inputs:
%        - LFP_Samples: LFP Signal (row vector)
%        - LFP_Timestamps (row vector)
%        - Fs: Sampling frequency of LFP_Timestamps
%        - range: Frequency range for Power Analysis (default [0 200])
%        - window: Time window for power analysis (default 5)
%        - tapers: Tapers in form [NW K]
% Outputs:
%        - spectrum: Power spectrum
%        - freq: Frequency Bins
%        - serr: Error
%
if nargin < 8
    tapers = [3 5];
end
if nargin < 7
    window = 5;
end
if nargin < 6
    range = [0 200];
end


%Combines LFP for all runs and then calculates Power Spec on combined LFP
LFP_Seg = [];
num_specs = 0;
for iTS = 1:size(timestamps1,1)
    s_Run = findClosestValue(LFP_Timestamps, timestamps1(iTS,1));
    e_Run = findClosestValue(LFP_Timestamps, timestamps1(iTS,2));
    
    lfp(1,:) = LFP_Samples(s_Run:e_Run);
    lfp(2,:) = LFP_Timestamps(s_Run:e_Run); 
        
    %Combines LFP segments
    LFP_Seg = [LFP_Seg lfp];

    clear lfp
      
end

for iTS = 1:size(timestamps2,1)
    s_Run = findClosestValue(LFP_Timestamps, timestamps2(iTS,1));
    e_Run = findClosestValue(LFP_Timestamps, timestamps2(iTS,2));
    
    lfp(1,:) = LFP_Samples(s_Run:e_Run);
    lfp(2,:) = LFP_Timestamps(s_Run:e_Run); 
            
    LFP_Seg = [LFP_Seg lfp];

    clear lfp
    
end
   
%Computes a power spec on combined LFP
LFP_Seg = LFP_Seg';
LFP_Seg = detrend(LFP_Seg);

[spectrum,freq,serr] = MTSpectrum([LFP_Seg(:,2) LFP_Seg(:,1)],...
    'frequency',Fs,'range',range,'window',window,'tapers',tapers,...
    'show' ,'off');

end
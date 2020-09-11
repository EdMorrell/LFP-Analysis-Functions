function [Frequency,Velocity] = Freq_v_RunSpeed(LFP_Samples,...
    LFP_Timestamps,Tracking,timestamps1,timestamps2,Fs,range,tapers)

% --- Run_Spec
%        - This function computes the Mean Power and Mean Running speed 
%          for individual track runs
% Inputs:
%        - LFP_Samples: LFP Signal (row vector)
%        - LFP_Timestamps (row vector)
%        - Tracking (form: [time(original units) x y time(secs)]
%        - timestamps(1&2): timestamps arrays corr to start and end of each
%                           run (1 and 2 are each run direction)
%        - Fs: Sampling frequency of LFP_Timestamps
%        - range: Frequency range for Power Analysis (default [0 200])
%        - tapers: Tapers in form [NW K]
% Outputs:
%        - Power: Mean Log Power array with each row corresponding to a run
%        - Velocity: Mean Running Speed (cm/s) with each row corresponding 
%                    to a run
%
if nargin < 8
    tapers = [3 5];
end
if nargin < 7
    range = [4 12];
end

%Params
params.tapers = tapers;
params.Fs = Fs;
params.fpass = range;

%Combines LFP for all runs and then calculates Power Spec on combined LFP
run_count = 1;
for iTS = 1:size(timestamps1,1)
    
    %Power Spec
    s_Run = findClosestValue(LFP_Timestamps, timestamps1(iTS,1));
    e_Run = findClosestValue(LFP_Timestamps, timestamps1(iTS,2));
    
    lfp(1,:) = LFP_Samples(s_Run:e_Run);
    lfp(2,:) = LFP_Timestamps(s_Run:e_Run); 
        
    [spectrum,freq]=mtspectrumc(lfp',params);
    
    [~,ispec] = max(spectrum(:,1));
    
    Peak_Freq = freq(ispec);
    
%     Peak_Freq = sum((spectrum(:,1).*freq'))/sum(spectrum(:,1));
    
    %Run Speed
    [i1,v1] = findClosestValue(Tracking(:,4),timestamps1(iTS,1));
    [i2,v2] = findClosestValue(Tracking(:,4),timestamps1(iTS,2));
    
    V = LinearVelocity([Tracking(i1:i2,4) Tracking(i1:i2,2),...
        Tracking(i1:i2,3)],2);
    
    Mean_Velocity = nanmean(V(:,2));
    %Converts to cm/s
    Mean_Velocity = (Mean_Velocity/750) * 175;
    
    clear lfp
    
    Frequency(run_count,1) = Peak_Freq;
    Velocity(run_count,1) = Mean_Velocity;
    run_count = run_count + 1;

    

    
%     Frequency(iTS,1) = Peak_Freq;
%     Velocity(iTS,1) = Mean_Velocity;
      
end

for iTS = 1:size(timestamps2,1)
    s_Run = findClosestValue(LFP_Timestamps, timestamps2(iTS,1));
    e_Run = findClosestValue(LFP_Timestamps, timestamps2(iTS,2));
    
    lfp(1,:) = LFP_Samples(s_Run:e_Run);
    lfp(2,:) = LFP_Timestamps(s_Run:e_Run); 
            
    [spectrum,freq]=mtspectrumc(lfp',params);
       
    [v,ispec] = max(spectrum(:,1));
    
    Peak_Freq = freq(ispec);
    
    %Run Speed
    [i1,v1] = findClosestValue(Tracking(:,4),timestamps2(iTS,1));
    [i2,v2] = findClosestValue(Tracking(:,4),timestamps2(iTS,2));
    
    V = LinearVelocity([Tracking(i1:i2,4) Tracking(i1:i2,2),...
        Tracking(i1:i2,3)],2);
    
    Mean_Velocity = nanmean(V(:,2));
    %Converts to cm/s
    Mean_Velocity = (Mean_Velocity/750) * 175;
    
    clear lfp
    
    Frequency(run_count,1) = Peak_Freq;
    Velocity(run_count,1) = Mean_Velocity;
    run_count = run_count + 1;

end
   
end
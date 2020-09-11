function [pacmat] = Run_PAC(LFP_Samples, LFP_Timestamps, timestamps1,...
    timestamps2,Fs,ph_fv,amp_fv,num_shf)

% --- Run_PAC
%        - This function takes LFP samples and timestamps and 2 timestamp 
%          arrays corresponding to runs in both direction. It computes a
%          PAC matrix from LFP between the timestamp arrays.
%          (Runs function from PAC toolbox in jolato)
% Inputs:
%        - LFP_Samples: LFP Signal (row vector)
%        - LFP_Timestamps (row vector)
%        - timestamps1 (and 2): 2 column vectors of timestamps (corr to 
%                               start and end of run)         
%        - Fs: Sampling frequency of LFP_Timestamps
%        - ph_fv: Vector of phase frequencies to compute PAC (default 1:20)
%        - amp_fv: Vector of amplitude frequencies to compute PAC (Default
%                  1:200)
%        - num_shf: Number of shuffles (Default 10)
% Outputs:
%        - pacmat: A PAC matrix

%Optional Vars
if nargin < 8
    num_shf = 10;
end
if nargin < 7
    amp_fv = 1:10:201;
end
if nargin < 6
    ph_fv = 1:1:21;
end
    
%Default Params
plt = 'n';
waitbar = 1;
width = 7;
nfft = 200;

%Combines LFP for all runs and then calculates PAC matrix on combined LFP
LFP_Seg = [];
for iTS = 1:size(timestamps1,1)
    s_Run = findClosestValue(LFP_Timestamps, timestamps1(iTS,1));
    e_Run = findClosestValue(LFP_Timestamps, timestamps1(iTS,2));
    
    iLFP_Seg = LFP_Samples(s_Run:e_Run);
    
    LFP_Seg = [LFP_Seg iLFP_Seg];
    
end

for iTS = 1:size(timestamps2,1)
    s_Run = findClosestValue(LFP_Timestamps, timestamps2(iTS,1));
    e_Run = findClosestValue(LFP_Timestamps, timestamps2(iTS,2));
    
    iLFP_Seg = LFP_Samples(s_Run:e_Run);
    
    LFP_Seg = [LFP_Seg iLFP_Seg];
    
end

LFP_Seg = detrend(LFP_Seg);

pacmat = find_pac_shf(LFP_Seg,Fs,'mi',LFP_Seg,ph_fv,amp_fv,plt,waitbar,...
     width,nfft,num_shf);
 
end
function [av_wf, ts] = RippleTrig_Av_LFP(f_name,window,filt,bpass)

%  ---  RippleTrig_Av_LFP
%       - Function finds the ripple-triggered average LFP of a signal
% Inputs:
%        - f_name: csc filename
%        - window: time-window of average LFP (default: [-0.5 0.5])
%        - filt: If 1 - filters the LFP signal between the range specified
%                by bpass
%        - bpass: Band-pass range for filtering in form [min max];
% Outputs:
%         - av_wf: Average waveform
%         - ts: Timestamps

if nargin < 2
    window = [-0.5 0.5];
end
if nargin < 3
    filt = 0;
end
if nargin >= 3 && nargin < 4
    error('Bandpass window not assigned')
end

opt.noiselim = 30;
opt.plt = 0;

%Check whether ripple structure already exists
Str_Index = strfind(f_name, '.ncs');
if ~isfile([f_name(1:Str_Index-1) '_ripple_stats.mat']) 
    [~,rip,~,~] = sw_run_ripple_LFP(f_name, opt);
else
    load([f_name(1:Str_Index-1) '_ripple_stats.mat'])
    rip = ev;
end

ts_rip_max=[rip.tsstart];

[LFP_Samples, LFP_Timestamps, Fs] = load_csc(f_name, 'all');

if filt == 1
    LFP_Samples = eegfilt(LFP_Samples', Fs, bpass(1), bpass(2));
end

[cscbits,~,ts]=cut_csc_event({LFP_Samples},{LFP_Timestamps},...
    Fs,window,{ts_rip_max},'av');

[av_wf,~]=mste(cscbits);

end


function [U] = NID_Input_Design_Info_get_ons(SPM,s,flag)
%%%%%%%%%%%%%%% refine by tfl 2013/07/03 %%%%%%%%%%%%%%%%%%
% returns input [designed effects] structures
% FORMAT [U] = spm_get_ons(SPM,s)
%
% s  - session number (used by batch system)
% flag - 0: display the model for comparison with NIRS time series
%      - 1: specify the model for design matrix; require uses to input
%      the "OnsetTime" and "Duration" by themselves.
%      - 2:automatically construct the model for design matrix; 
%
% U     - (1 x n)   struct array of (n) trial-specific structures
%
% 	U(i).name   - cell of names for each input or cause
% 	U(i).u      - inputs or stimulus function matrix
% 	U(i).dt     - time bin (seconds)
% 	U(i).ons    - onsets    (in SPM.xBF.UNITS)
% 	U(i).dur    - durations (in SPM.xBF.UNITS)
%	U(i).P      - parameter struct.
%
% 	    U(i).P(p).name - parameter name
% 	    U(i).P(p).P    - parameter vector
% 	    U(i).P(p).h    - order of polynomial expansion
% 	    U(i).P(p).i    - sub-indices of u pertaining to P
%_______________________________________________________________________
%
%
% SLICE TIMIING
%
% With longs TRs you may want to shift the regressors so that they are
% aligned to a particular slice.  This is effected by resetting the
% values of defaults.stats.fmri.t and defaults.stats.fmri.t0 in
% spm_defaults. defaults.stats.fmri.t is the number of time-bins per
% scan used when building regressors.  Onsets are defined
% in temporal units of scans starting at 0.  defaults.stats.fmri.t0 is
% the first time-bin at which the regressors are resampled to coincide
% with data acquisition.  If defaults.stats.fmri.t0 = 1 then the
% regressors will be appropriate for the first slice.  If you want to
% temporally realign the regressors so that they match responses in the
% middle slice then make defaults.stats.fmri.t0 =
% defaults.stats.fmri.t/2 (assuming there is a negligible gap between
% volume acquisitions. Default values are defaults.stats.fmri.t = 16
% and defaults.stats.fmri.t0 = 1.
%
%
%_______________________________________________________________________
% Copyright (C) 2005 Wellcome Department of Imaging Neuroscience

% Karl Friston
% $Id: spm_get_ons.m 444 2006-02-17 19:43:17Z klaas $


%-GUI setup
%-----------------------------------------------------------------------
% global OnsetTime;
% global Duration;

%
vector_onset = SPM.vector_onset;
[kk1 kk2] = size(vector_onset);
if kk2==1
    vector_onset = vector_onset';
end
index = find(vector_onset ~= 0);
ons = index(1:2:end);
ofs = index(2:2:end); 
dur = ofs - ons;
OnsetTime = ons;
Duration = dur;
%
%spm_help('!ContextHelp',mfilename)

% time units
%-----------------------------------------------------------------------
k     = SPM.nscan(s);
T     = SPM.xBF.T;
dt    = SPM.xBF.dt;
try
    UNITS = SPM.xBF.UNITS;
catch
    UNITS = 'scans';
end
switch UNITS

    case 'scans'
        %----------------------------------------------------------------
        TR = T*dt;

    case 'secs'
        %----------------------------------------------------------------
        TR = 1;
end

% get inputs and names (try SPM.Sess(s).U first)
%=======================================================================
try
    U   = SPM.Sess(s).U;
    v   = length(U);
catch

    %-prompt string
    %---------------------------------------------------------------
    %str = sprintf('Session %d: trial specification in %s',s,UNITS);
    %spm_input(str,1,'d')
    str = 'trail1';
    
    U   = {};
%     if flag == 0
%         v = 1;
%     elseif flag == 1
    if flag == 0 || flag == 1
        %v   = spm_input('number of conditions/trials',2,'w1');
        v=1;
    elseif flag == 2
        vector_onset = SPM.vector_onset;
        index = find(vector_onset ~= 0);
        v = max(vector_onset(index));
        % specifiy to my own experiment,with only one condition,mark=1;
        if v~=1
            vector_onset(index) = 1;
            v = 1;
        end
        %
    end

end

% get trials
%-----------------------------------------------------------------------
for i = 1:v

    % get names
    %---------------------------------------------------------------
    if flag == 1
        try
            Uname     = U(i).name(1);
        catch
           % str       = sprintf('name for condition/trial %d ?',i);
           % Uname     = {spm_input(str,3,'s',sprintf('trial %d',i))};
           Uname ={'trail1'};
            U(i).name = Uname;
        end
    elseif flag == 2
        Uname = {['Condition '  num2str(i)]};
        U(i).name = Uname;
    elseif flag == 0
        Uname = {['Condition '  num2str(i)]};
        U(i).name = Uname;
        spm_input(Uname{1},3,'d')
    end

    % get main [trial] effects
    %================================================================

    % onsets
    %---------------------------------------------------------------
    try
        ons = U(i).ons;                                                    % ons appear for the first time
        ons = ons(:);
    catch
        ons = [];
    end
    if ~length(ons)
        if flag == 0
            str = ['vector of onsets '];
            ons      = spm_input(str,4,'r',' ',[Inf 1]);
        elseif flag == 1
            str      = ['vector of onsets - ' Uname{1}];
            %ons      = spm_input(str,4,'r',' ',[Inf 1]);
            ons = OnsetTime';

        elseif flag == 2
            step = zeros(length(vector_onset)+1,1);
            index = find(vector_onset == i);
            step(index+1) = 1;
            diff_step = diff(step);
            index2 = find(diff_step == 1);
%             ons = index2-1;                                                % "ons" seems to be something wrong!!!!
            ons = index(1:2:end);    
        end
        U(i).ons = ons(:);
    end

    % durations
    %---------------------------------------------------------------
    try
        dur = U(i).dur;
        dur = dur(:);
    catch
        dur = [];
    end
    if ~length(dur)                                                        % if "dur==0",run next
        if flag == 0 || flag == 1
            str = 'duration[s] (events = 0)';
            while 1
                %dur = spm_input(str,5,'r',' ',[Inf 1]);
                dur =Duration';
                if length(dur) == 1
                    dur    = dur*ones(size(ons));
                end
                if length(dur) == length(ons), break, end
                str = sprintf('enter a scalar or [%d] vector',...
                    length(ons));
            end
        elseif flag == 2
%             step2= zeros(length(step)+1,1);
%             step2(2:end,1) = step(:,1);
%             diff_step2 = diff(step2);
%             index = find(diff_step2 == 1);
%             index2 = find(diff_step2 == -1);
%             dur = index2- index;
              ofs = index(2:2:end); 
              dur = ofs - ons;
        end
        U(i).dur = dur;
    end

    % peri-stimulus times {seconds}
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%% still not sure how to use it!!!!!
    %---------------------------------------------------------------
    pst   = [1:k]*T*dt - ons(1)*TR;
    for j = 1:length(ons)
        w      = [1:k]*T*dt - ons(j)*TR;
        v      = find(w >= -1);
        pst(v) = w(v);
    end


    % add parameters x trial interactions
    %================================================================

    % get parameter stucture xP
    %----------------------------------------------------------------
    try
        xP          = U(i).P;
        Pname       = xP(1).name;

        switch Pname

            case 'none'
                %------------------------------------------------
                xP.name  = 'none';
                xP.h     = 0;

        end

    catch

        % 		Pname       = {'none','time','other'};
        % 		Pname       = spm_input('parametric modulation',6,'b',Pname);
        Pname = 'none';
        switch Pname

            case 'none'
                %--------------------------------------------------------
                xP(1).name  = 'none';
                xP(1).h     = 0;

            case 'time'
                %--------------------------------------------------------
                xP(1).name  = 'time';
                xP(1).P     = ons*TR;
                xP(1).h     = spm_input('polynomial order',8,'n1',1);

            case 'other'
                %--------------------------------------------------------
                str   = ['# parameters (' Uname{1} ')'];
                for q = 1:spm_input(str,7,'n1',1);

                    % get names and parametric variates
                    %------------------------------------------------
                    str   = sprintf('parameter %d name',q);
                    Pname = spm_input(str,7,'s');
                    P     = spm_input(Pname,7,'r',[],[length(ons),1]);

                    % order of polynomial expansion h
                    %------------------------------------------------
                    h     = spm_input('polynomial order',8,'n1',1);

                    % sub-indices and inputs
                    %------------------------------------------------
                    xP(q).name  = Pname;
                    xP(q).P     = P(:);
                    xP(q).h     = h;

                end
        end % switch

    end % try

    % interaction with causes (u) - 1st = main effects
    %----------------------------------------------------------------
    u     = ons.^0;
    for q = 1:length(xP)
        xP(q).i = [1, ([1:xP(q).h] + size(u,2))];
        for   j = 1:xP(q).h
            u   = [u xP(q).P.^j];
            str = sprintf('%sx%s^%d',Uname{1},xP(q).name,j);
            Uname{end + 1} = str;
        end
    end

    % orthogonalize inputs
    %---------------------------------------------------------------
    u          = spm_orth(u);

    % and scale so sum(u*dt) = number of events, if event-related
    %---------------------------------------------------------------
    if ~any(dur)
        u  = u/dt;
    end

    % create stimulus functions (32 bin offset)
    %===============================================================
    ton       = round(ons*TR/dt) + 32;			% onsets
    tof       = round(dur*TR/dt) + ton + 1;			% offset
    sf        = sparse((k*T + 128),size(u,2));
    ton       = max(ton,1);
    tof       = max(tof,1);
    for j = 1:length(ton)
        if numel(sf)>ton(j),
            sf(ton(j),:) = sf(ton(j),:) + u(j,:);
        end;
        if numel(sf)>tof(j),
            sf(tof(j),:) = sf(tof(j),:) - u(j,:);
        end;
    end
    sf        = cumsum(sf);					% integrate
    sf        = sf(1:(k*T + 32),:);				% stimulus

    % place in ouputs structure
    %---------------------------------------------------------------
    if flag == 1 || flag == 2
        U(i).name = Uname;		% - input names
    elseif flag == 0
        U(i).name = {''};
    end
    U(i).dt   = dt;			% - time bin {seconds}
    U(i).u    = sf;			% - stimulus function matrix
    U(i).pst  = pst;		% - pst (seconds)
    U(i).P    = xP;			% - parameter struct

end % (v)

function design_hrf = NID_Input_Design_Info_creat_DesignBlock(handles,timeOn,timeDu)
%%
obj = findobj('Tag','NIRS_ICA_Denoiser');
OpenHandles = guihandles(obj);
nirs_data = get(OpenHandles.NIRS_ICA_Denoiser,'Userdata');
nirs_data = nirs_data.nirs_data;
% hrftype
hrftype = 1;
%%
SPM.nscan = size(nirs_data.oxyData,1);
SPM.xY.RT = nirs_data.T;
SPM.xBF.T = 1/nirs_data.T;                                                            %Sampling rate or Period ????
SPM.xBF.T0 = 1;
SPM.xBF.dt = SPM.xY.RT/SPM.xBF.T;
SPM.xBF.UNITS = 'scans';
%
rep     = 0;
SPM.xBF = NID_Input_Design_Info_creat_hrf(hrftype,SPM.xBF);  
%%
V = 1;
SPM.xBF.Volterra = V; % model interactions (Volterra) : no

Xx    = [];
Xb    = [];
Xname = {};
Bname = {};
%%
for s = 1:length(SPM.nscan)
    if (s == 1) | ~rep
        k = SPM.nscan(s);
        bf = SPM.xBF.bf;
        tSPM = SPM;
        % vector_onset
        vector_onset = create_vector_onset(timeOn,timeDu,SPM.nscan);
        %
        tSPM.vector_onset = vector_onset;
        U = NID_Input_Design_Info_get_ons(tSPM, s, 1);
        [X,Xn,Fc] = spm_Volterra(U,bf,V);
        X = X([0:(k - 1)]*SPM.xBF.T + SPM.xBF.T0 + 32,:);
    end
end
design_hrf = X';
end

function design = create_vector_onset(timeOn,timeDu,dataLength)
ndesign = length(timeOn);
design = zeros(1,dataLength);
    if ~isempty(timeDu) && timeDu(1) > 0  % block design
        if length(timeDu) == 1 && timeDu ~= 0
            timeDu = ones(1,ndesign)*timeDu;
        end
        for i = 1:ndesign
%             design(timeOn(i):timeOn(i)+timeDu(i)) = ones(1,timeDu(i)+1);
            design([timeOn(i),timeOn(i)+timeDu(i)]) = 1;
        end
    else
        if isempty(timeDu) || timeDu == 0  % Event-related design
            for i = 1:ndesign
                design(timeOn(i)) = 1;
            end
        end
    end
end
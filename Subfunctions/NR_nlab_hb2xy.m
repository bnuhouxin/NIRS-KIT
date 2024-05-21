function [ nirs_data ] = NR_nlab_hb2xy(path_file)
% Convert data format from shimadu '*.txt' to HB
% revised from nirs_spm by zhaochen 20130718
N=0;Ch=0;
fid = fopen(path_file);      
        h_wait = waitbar(0, 'Data loading... ');
        while 1
            tline = fgetl(fid);                       % get a line
            nindex = find(tline == ',');              
            tline(nindex) = ' ';                     
            [token, remain] = strtok(tline);          % 
            if strncmp(tline, 'Total Points',12) == 1   % sample number
                [token, remain] = strtok(remain);
                N = str2num(remain);                 
            end
            if strncmp(tline, 'Time Range',10) == 1   % line 32, get time
                [token remain] = strtok(remain);
                [token remain] = strtok(remain);
                stt = str2num(token);                 % start time
                [token remain] = strtok(remain);
                stp = str2num(token);                 % end time 
            end
            if strncmp(token, 'ch-',3) == 1   % line 32£¬get time
                nindex = find(tline == 'c');  tline(nindex) = ''; 
                nindex = find(tline == 'h');  tline(nindex) = ''; 
                nindex = find(tline == '-');  tline(nindex) = ''; 
                Ch = max(str2num(tline));
            end
            if(N>0 && Ch>0)
                nirs_data.oxyData = zeros(N,Ch);
                nirs_data.dxyData = zeros(N,Ch);
                nirs_data.totalData = zeros(N,Ch);
            end
            if strcmp(token, 'Time(sec)') == 1        % line 35
                index = 1;                            % mark line
                while 1
                    tline2 = fgetl(fid);              % line 36
                    if ischar(tline2) == 0, break, end, % end circle
                    newlabel = strrep(tline2, 'Z', ''); % 
                    nindex = find(newlabel == ',');
                    newlabel = str2num(newlabel);       
                    nirs_data.oxyData(index, :) = newlabel(1,5:3:end-2);   % oxy data
                    nirs_data.dxyData(index, :) = newlabel(1,6:3:end-1);   % get dxy data
                    nirs_data.totalData(index, :) = newlabel(1,7:3:end);   % get total Hb
                    waitbar((newlabel(1,1)-stt)/(stp-stt), h_wait);
                    time(index,1) = newlabel(1,1);                         % get time
                    % get mraker
                    vector_onset(index, 1) = newlabel(1,2);
                    if newlabel(1,3) ~= 0 && newlabel(1,2) == 0
                        vector_onset(index, 1) = newlabel(1,3);
                    end
                    %
                    index = index + 1;
                end
                break
            end
        end
        close(h_wait);
        fclose(fid);
%         fs = 1./(mean(diff(time)));
%         nirs_data.fs = fs;  %
        nirs_data.T = mean(diff(time));  %
        nirs_data.nch = size(nirs_data.oxyData,2);                         %channel number
        nirs_data.vector_onset = vector_onset;
end
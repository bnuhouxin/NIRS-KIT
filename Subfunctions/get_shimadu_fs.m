function [ fs ] = get_shimadu_fs(path_file)
% test data type, shimadu or not
% revised from nirs_spm by zhaochen 2013-07-29
fs=-1;
fid = fopen(path_file); 
count=0;
        while 1
            count=count+1;
            if(count>100) return;end
            tline = fgetl(fid);                       %Reads a line of data in the file and discards the newline at the end of the line.
            nindex = find(tline == ',');              
            tline(nindex) = ' ';                      %replace ¡°£¬¡± with ¡° ¡±
            [token, remain] = strtok(tline);          %get the element of each line before "space"
            if strncmp(tline, 'Time Range',10) == 1   %go to line 32, get the running time
                [token remain] = strtok(remain);
                [token remain] = strtok(remain);
                stt = str2num(token);                 %start time
                [token remain] = strtok(remain);
                stp = str2num(token);                 % end time for presenting the progress of waitbar
            end
            %%%%'Time(sec)'
            if strcmp(token, 'Time(sec)') == 1        %go to line 35
                index = 1;                            %save line number of the matrix
                for i = 1:100
                    tline2 = fgetl(fid);              %go to line 36
                    if ischar(tline2) == 0, break, end, %string
                    newlabel = strrep(tline2, 'Z', ''); 
                    nindex = find(newlabel == ',');
                    newlabel = str2num(newlabel);       %str2num
                    time(index,1) = newlabel(1,1);                         %get time
                    %get mark. and task
                    vector_onset(index, 1) = newlabel(1,2);
                    %
                    index = index + 1;
                end
                break
            end
        end
        fclose(fid);
        fs = round(1./(mean(diff(time))));

end
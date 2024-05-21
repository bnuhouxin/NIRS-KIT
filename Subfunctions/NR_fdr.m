function NR_fdr(handles)

% multiple test, fdr

statpath = get(handles.statpath,'string');
q = str2num(get(handles.q,'string'));
load(statpath{1});
p_oxy = statsdata.p_oxy;
p_dxy = statsdata.p_dxy;
p_total = statsdata.p_total;
n = length(p_oxy);
result_oxy = NR_fdr_zc(p_oxy,q);
result_dxy = NR_fdr_zc(p_dxy,q);
result_total = NR_fdr_zc(p_total,q);
saveAsTxt('.\multipleTest.csv',...
    {'CH','t(oxy)','p','result','-','CH','t(oxy)','p','result','-','CH','t(total)','p','result'},...
    [[1:n]' statsdata.stats_oxy' p_oxy' result_oxy',...
    [1:n]' [1:n]' statsdata.stats_dxy' p_dxy' result_dxy',...
    [1:n]' [1:n]' statsdata.stats_total' p_total' result_total'],...
    [1,2,2,1,0,1,2,2,1,0,1,2,2,1]);
% saveAsTxt('.\multipleTest.csv',{'CH','t(oxy)','p','result'},[[1:n]' statdata.stat_oxy' p_oxy' result_oxy'],[1,2,2,1]);
try
    winopen('.\multipleTest.csv')
catch
    system('notepad multipleTest.csv&')
end
end

function isok = NR_fdr_zc(p,q)
%排序
[Y,index]=sort(p);
%重建对应i
N = length(p);
I=zeros(1,N);
for j = 1:length(index)
    I(index(j))=j;
end
%计算q
isok=zeros(1,N);
for i = 1:N
    qq=p(i)*N/I(i);
    if qq < q
        isok(i)=1;
    end
end

end


function saveAsTxt(filepath,strings,matx,intOfloat)
    fileID = fopen(filepath,'wt');
    %print column names
    for k=1:length(strings)-1
        if intOfloat(k)
            fprintf(fileID,'%s,   ',strings{k});
        else
            fprintf(fileID,',   ',strings{k});
        end
    end
    fprintf(fileID,'%s\n',strings{end});
    %print data
    for linen=1:size(matx,1)
        for k=1:length(strings)-1
            switch intOfloat(k)
                case 0
                    fprintf(fileID,',   ',matx(linen,k));
                case 1
                    fprintf(fileID,'%g,   ',matx(linen,k));
                case 2
                    fprintf(fileID,'%.4f,   ',matx(linen,k));
            end
        end
        switch intOfloat(end)
            case 0
                fprintf(fileID,'\n',matx(linen,end));
            case 1
                fprintf(fileID,'%g\n',matx(linen,end));
            case 2
                fprintf(fileID,'%.4f\n',matx(linen,end));
        end
    end
    fclose(fileID);
end

function saveAsTxt(filepath,strings,matx)
    fileID = fopen(filepath,'wt');
    %print column names
    fprintf(fileID,'%s\t',strings{1});
    for k=2:length(strings)-1
        fprintf(fileID,'%s\t',strings{k});
    end
    fprintf(fileID,'%s\n',strings{end});
    %print data
    for linen=1:size(matx,1)
        fprintf(fileID,'%g\t',matx(linen,1));
        for k=2:length(strings)-1
            fprintf(fileID,'%.4f\t',matx(linen,k));
        end
        fprintf(fileID,'%.4f\n',matx(linen,end));
    end
    fclose(fileID);
end



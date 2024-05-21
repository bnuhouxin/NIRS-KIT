function NR_generateReport(outpath)

% generate 2d report in word, oxy\dxy\total in 3 word file
%% oxy
files = dir(fullfile(outpath,'*.mat'));
load(fullfile(outpath,char(files(1).name)));
% if strcmp(indexdata.probeConfiguration, 'nonstandard') == 1
%     disp('Unable to generate report, because the probe configuration is not standard !')
%     return
% end
try
    % ��Word�������Ѿ��򿪣���������Word
    Word = actxGetRunningServer('Word.Application');
catch
    % ����һ��Microsoft Word�����������ؾ��Word
    Word = actxserver('Word.Application'); 
end
set(Word, 'Visible', 1);
Document = Word.Documents.Add;
Document.PageSetup.PageWidth=1200;
% ����Document��Content�ӿڵľ��
Content = Document.Content;
Content.Start = 0;    % �����ĵ����ݵ���ʼλ��
Content.Text = [indexdata.index_discription ': individual-level maps, calculated by oxy'];    % ������������
Content.Font.Size = 25 ;    % �����ֺ�
Content.Bold=1;    % �Ӵ�
Content.paragraphformat.Alignment = 'wdAlignParagraphCenter'; 
%����Word��������Selection�ӿڵľ��
Selection = Word.Selection; 
% ����ѡ���������ʼλ��Ϊ�ĵ����ݵ�ĩβ
Selection.Start = Content.end;    
Selection.TypeParagraph;    % �س�������һ��
Selection.TypeParagraph;
Content.Font.Size = 15 ;    % �����ֺ�
% ��ͼ 
% index oxy 
n = length(files);
for i=1:n
    load(fullfile(outpath,char(files(i).name)));
    Selection.Text = ['Subject ' num2str(i) ': ' indexdata.subject];    % ������������
    Selection.MoveDown;
    Selection.TypeParagraph;
    switch length(indexdata.index_oxy)
        case 12  % probe 3x3
        case 22  % probe 3x5
            figure;fosa_topomap_plot_3x5(indexdata.index_oxy(1:22),[],-10); 
            saveas(gcf,fullfile(outpath,'t_map_Probe1'),'bmp');set(gcf,'visible','off');
        case 24  
            if(probeNum==2)  % probe 3x3x2
            else % probe 4x4
            end
        case 52 % probe 3x11          
        case 44 % Probe 3x5x2
            h = figure('position',[300 100 1500 250]);
            fosa_topomap_plot_3x5x2(indexdata.index_dxy(1:22),indexdata.index_dxy(23:44),[],-100,-100); 
%           saveas(gcf,[outpath '\t_map_Probe1'],'bmp');set(gcf,'visible','off');
            
            
            hgexport(h, '-clipboard'); Selection.Paste;close(h);
        case 48 % Probe 4x4x2
        case 34 % Probe 3x3 + 3x5
        case 36 % Probe 3x3 + 4x4
        case 46 % Probe 3x5 + 4x4 
    end
    Selection.TypeParagraph;
end
Document.SaveAs2(fullfile(outpath,[indexdata.index_discription,'_oxy.docx']));
Document.Close;

%%  dxy
files = dir(fullfile(outpath,'*.mat'));
load(fullfile(outpath,char(files(1).name)));
try
    % ��Word�������Ѿ��򿪣���������Word
    Word = actxGetRunningServer('Word.Application');
catch
    % ����һ��Microsoft Word�����������ؾ��Word
    Word = actxserver('Word.Application'); 
end
set(Word, 'Visible', 1);
Document = Word.Documents.Add;
Document.PageSetup.PageWidth=1200;
% ����Document��Content�ӿڵľ��
Content = Document.Content;
Content.Start = 0;    % �����ĵ����ݵ���ʼλ��
Content.Text = [indexdata.index_discription ': individual-level maps, calculated by dxy'];    % ������������
Content.Font.Size = 25 ;    % �����ֺ�
Content.Bold=1;    % �Ӵ�
Content.paragraphformat.Alignment = 'wdAlignParagraphCenter'; 
%����Word��������Selection�ӿڵľ��
Selection = Word.Selection; 
% ����ѡ���������ʼλ��Ϊ�ĵ����ݵ�ĩβ
Selection.Start = Content.end;    
Selection.TypeParagraph;    % �س�������һ��
Selection.TypeParagraph;
Content.Font.Size = 15 ;    % �����ֺ�
% ��ͼ dxy
n = length(files);
for i=1:n
    load(fullfile(outpath,char(files(i).name)));
    Selection.Text = ['Subject ' num2str(i) ': ' indexdata.subject];    % ������������
    Selection.MoveDown;
    Selection.TypeParagraph;
    switch length(indexdata.index_dxy)
        case 12  % probe 3x3
        case 22  % probe 3x5
            figure;fosa_topomap_plot_3x5(indexdata.index_dxy(1:22),[],-10); 
            saveas(gcf,fullfile(outpath,'t_map_Probe1'),'bmp');set(gcf,'visible','off');
        case 24  
            if(probeNum==2)  % probe 3x3x2
            else % probe 4x4
            end
        case 52 % probe 3x11          
        case 44 % Probe 3x5x2
            h = figure('position',[300 100 1500 250]);
            fosa_topomap_plot_3x5x2(indexdata.index_dxy(1:22),indexdata.index_dxy(23:44),[],-100,-100); 
            hgexport(h, '-clipboard'); Selection.Paste;close(h);
        case 48 % Probe 4x4x2
        case 34 % Probe 3x3 + 3x5
        case 36 % Probe 3x3 + 4x4
        case 46 % Probe 3x5 + 4x4 
    end
    Selection.TypeParagraph;
end
Document.SaveAs2(fullfile(outpath,[indexdata.index_discription,'_dxy.docx']));
Document.Close;

%% ��ͼ total
files = dir(fullfile(outpath,'*.mat'));
load(fullfile(outpath,char(files(1).name)));
try
    % ��Word�������Ѿ��򿪣���������Word
    Word = actxGetRunningServer('Word.Application');
catch
    % ����һ��Microsoft Word�����������ؾ��Word
    Word = actxserver('Word.Application'); 
end
set(Word, 'Visible', 1);
Document = Word.Documents.Add;
Document.PageSetup.PageWidth=1200;
% ����Document��Content�ӿڵľ��
Content = Document.Content;
Content.Start = 0;    % �����ĵ����ݵ���ʼλ��
Content.Text = [indexdata.index_discription ': individual-level maps, calculated by total'];    % ������������
Content.Font.Size = 25 ;    % �����ֺ�
Content.Bold=1;    % �Ӵ�
Content.paragraphformat.Alignment = 'wdAlignParagraphCenter'; 
%����Word��������Selection�ӿڵľ��
Selection = Word.Selection; 
% ����ѡ���������ʼλ��Ϊ�ĵ����ݵ�ĩβ
Selection.Start = Content.end;    
Selection.TypeParagraph;    % �س�������һ��
Selection.TypeParagraph;
Content.Font.Size = 15 ;    % �����ֺ�
% ��ͼ dxy
n = length(files);
for i=1:n
    load(fullfile(outpath,char(files(i).name)));
    Selection.Text = ['Subject ' num2str(i) ': ' indexdata.subject];    % ������������
    Selection.MoveDown;
    Selection.TypeParagraph;
    switch length(indexdata.index_total)
        case 12  % probe 3x3
        case 22  % probe 3x5
            figure;fosa_topomap_plot_3x5(indexdata.index_total(1:22),[],-10); 
            saveas(gcf,fullfile(outpath,'t_map_Probe1'),'bmp');set(gcf,'visible','off');
        case 24  
            if(probeNum==2)  % probe 3x3x2
            else % probe 4x4
            end
        case 52 % probe 3x11          
        case 44 % Probe 3x5x2
            h = figure('position',[300 100 1500 250]);
            fosa_topomap_plot_3x5x2(indexdata.index_total(1:22),indexdata.index_total(23:44),[],-100,-100); 
            hgexport(h, '-clipboard'); Selection.Paste;close(h);
        case 48 % Probe 4x4x2
        case 34 % Probe 3x3 + 3x5
        case 36 % Probe 3x3 + 4x4
        case 46 % Probe 3x5 + 4x4 
    end
    Selection.TypeParagraph;
end
Document.SaveAs2(fullfile(outpath,[indexdata.index_discription,'_total.docx']));
Document.Close;
Word.Quit;

end

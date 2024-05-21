function NID_plot2d_spacialmap(ax_fig,data, probeSets, ylimit)
%%
    if nargin < 3 || ( nargin >= 3 && isempty(ylimit)) % 'auto',
        y_upper=max(abs(data(:)));
        y_lower=min(abs(data(:)));
    else
        y_upper=ylimit(2); 
        y_lower=ylimit(1);
    end
    y_absmax=max([abs(y_upper),abs(y_lower)]);
    % text
    texts{length(data)}=0;
    for i=1:length(data)
        texts{i}=num2str(i);
    end
    % rows & column
    rows = 1;
    column = rows+2;
    nch = length(data);

    while rows*column < nch
        rows = rows + 1;
        column = rows+2;
    end
    rows = rows - 1;
    if rows <= 0
        error('Invalid CH ...');
    end
    % maps
    map = zeros(rows,column);
    r = 1;
    c = 0;
    for i = 1:nch    
        c = c+1;
        map(r,c) = data(i);
        if mod(i,column)==0
            r = r+1;
            c = 0;
        end
    end
%%
if isempty(find(map < 0)) && any(map(:) >0)% probe were positive
    imagesc(map,'Parent',ax_fig,[y_lower,y_upper]);axis off;
    colormap(ax_fig,jet);
%     colorbar('EastOutside')
else % both positive and negtive
    imagesc(map,'Parent',ax_fig,[-y_upper,y_upper]);axis off;
     colormap(ax_fig,jet);
%     colorbar('EastOutside')
    set(ax_fig,'XTick',[],'YTick',[]);
end
%% text
xstart = 0.5*(1/column);
ystart = 1-0.5*(1/rows);
xstep = 1/column;
ystep = (1/rows);
start_ax = [xstart,ystart];
for i = 1:nch
    text('Parent',ax_fig,'String',texts{i},'Position',[xstart,ystart],'Color',[0 0 0],'unit','normalize');
%     text(xstart,ystart,)
    xstart = xstart + xstep;
    if mod(i,column) == 0
        xstart = start_ax(1);
        ystart = ystart - ystep;
    end
end
end
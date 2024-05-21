function MY_GRID_STATE_HANDLE=my_grid(axes1, mode, MY_GRID_STATE_HANDLE)
% debug
%     mode = 'on';
%     axes1 = subplot(1,1,1);
%     plot(axes1,[1,4,2,5]);
%     MY_GRID_STATE_HANDLE = [];
% end of debug
    old_hold=ishold(axes1);
    hold(axes1,'on');
    if (strcmp(mode, 'on'))
        MY_GRID_STATE_HANDLE = [];
        xs=get(axes1, 'XTick');
        ys=get(axes1, 'YTick');
        xlm=get(axes1, 'XLim');
        ylm=get(axes1, 'YLim');
        for x = xs
            MY_GRID_STATE_HANDLE(end+1)=plot(axes1,[x,x],ylm,'k:');
        end
        for y = ys
            MY_GRID_STATE_HANDLE(end+1)=plot(axes1,xlm,[y,y],'k:');
        end
    else
        delete(MY_GRID_STATE_HANDLE);
        MY_GRID_STATE_HANDLE = [];
    end
    if ~old_hold
        hold(axes1,'off');
    end
end
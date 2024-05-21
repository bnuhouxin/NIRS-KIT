function NID_PLOT_Clear_Screen(handles)
%% clear the screen displaying the component 
%%
fig_handle = get(handles.uipanel2,'Userdata');
if ~isempty(fig_handle)
    n = size(fig_handle.ax_fig,2);
    for i = 1:n
        delete(fig_handle.ax_fig(i))
    end
end
if ~isempty(fig_handle)
    n = size(fig_handle.checkbox_fig,2);
    for i = 1:n
        delete(fig_handle.checkbox_fig(i))
    end
end
if isfield(fig_handle,'detail_fig')
    if ~isempty(fig_handle.detail_fig)
        n = size(fig_handle.detail_fig,2);
        for i = 1:n
            delete(fig_handle.detail_fig(i))
        end
    end
end

set(handles.uipanel2,'Userdata',[]);
end
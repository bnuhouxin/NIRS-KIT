function fix_lighting(fig_handle,~)
% Set the light source of the selected figure (default: current figure) to
% originate from the viewing direction ("headlight"). If there is no light
% source, a new one is created. 

% Get figure handle
if nargin<1
    fig_handle = gcf;
end

% Find the light object
l_handle = findobj(fig_handle,'Type','light');

% If no light source, create one
if isempty(l_handle)
    l_handle = light;
end

% If there is more than one light source, take the last one
if length(l_handle) > 1
    l_handle = l_handle(end);
end

% Set the light at the camera position
camlight(l_handle,'headlight');

end


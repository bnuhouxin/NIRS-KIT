function [m]=triangles_extract(m, varargin)
% extracts the triangles
% deletes unused nodes and updates the node numbers
%
% USAGE:
%   m=triangles_extract(m, [,'OptionName',OptionValue,...]) 
%
%   m: input triangles
%  
%   Options are set using the option name followed by the value.

%   node_idx: indices of the nodes to keep 
%   tri_idx: indices of the triangles to keep


% standard settings

s.node_idx=[];
s.tri_idx=[];



if nargin<1
    error('at least one argument is needed');
end

names = fieldnames(s);

for i=1:2:nargin-1
    
    field_idx=find(strcmpi(varargin{i},names));
    if length(field_idx)~=1
        error(['option ' varargin{i} ' unclear']);
    end
    
    s = setfield(s,names{field_idx},varargin{i+1});
    
end

% determine what to keep
idx_kept_nodes=true(size(m.nodes,1),1);
idx_kept_tri=true(size(m.triangles,1),1);

if ~isempty(s.node_idx)
    
    if islogical(s.node_idx)&&length(s.node_idx)~=size(m.nodes,1)
        error('logical index must have same length as number of nodes')
    end
    if ~islogical(s.node_idx)
        idx_hlp=false(size(m.nodes,1),1);
        idx_hlp(s.node_idx)=true;
        s.node_idx=idx_hlp;
    end
    idx_kept_nodes = idx_kept_nodes&s.node_idx;
    
%     % delete affected triangles and tets
     idx_kept_tri=idx_kept_tri&(sum(idx_kept_nodes(m.triangles),2)==3);
end


if ~isempty(s.tri_idx)
    if islogical(s.tri_idx)&&length(s.tri_idx)~=size(m.triangles,1)
        error('logical index must have same length as number of triangles')
    end
    if ~islogical(s.tri_idx)
        idx_hlp=false(size(m.triangles,1),1);
        idx_hlp(s.tri_idx)=true;
        s.tri_idx=idx_hlp;
    end
    idx_kept_tri = idx_kept_tri&s.tri_idx;
end


% update node indices, delete unused nodes, triangles and tetrahedra
ab_map=zeros(size(m.nodes,1),1);
ab_map(idx_kept_nodes)=1:sum(idx_kept_nodes);

m.nodes=m.nodes(idx_kept_nodes,:);
m.triangles=ab_map(m.triangles(idx_kept_tri,:));


m.idx_kept_tri=idx_kept_tri;
m.idx_kept_nodes=idx_kept_nodes;



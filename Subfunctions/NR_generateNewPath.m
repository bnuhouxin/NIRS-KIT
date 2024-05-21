function newPath = NR_generateNewPath(oldPath)

index_dir = findstr(oldPath,filesep);
newPath = [oldPath(1:index_dir(end-2)) 'group' oldPath(index_dir(end-1):end) ];


function nfri_simple_plot(CM, DataFile, SimpleFlag)

switch nargin
  case 0
    nfri_mni_plot('jet', [], 'simple');
  case 1
    nfri_mni_plot(CM);
  case 2
    nfri_mni_plot(CM, DataFile);
  case 3
    nfri_mni_plot(CM, DataFile, 'simple');
end

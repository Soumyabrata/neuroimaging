% Regional differences.
clear all; clc;

load sample_slice_map.mat ;
% Cortical = 5; Sub-cortical = 3; Rest = 1

% Cortical
cortical_mask = zeros(240,256);
[findR, findC] = find(segm == 5);
indices = sub2ind(size(cortical_mask), findR, findC);
cortical_mask(indices) = 1;
cortical_M = [];
for t = 1:192   
    cortical_M = cat(3,cortical_M,cortical_mask);    
end


% Sub-cortical
sub_cortical_mask = zeros(240,256);
[findR, findC] = find(segm == 3);
indices = sub2ind(size(sub_cortical_mask), findR, findC);
sub_cortical_mask(indices) = 1;
sub_cortical_M = [];
for t = 1:192   
    sub_cortical_M = cat(3,sub_cortical_M,sub_cortical_mask);    
end


Files=dir('./images20/NII_images/*.*');
Files(1:2)=[] ;

cortical_volm_array = zeros(length(Files),1);
sub_cortical_volm_array = zeros(length(Files),1);

%for k=1:length(Files)
for k=11:20
    
   FileNames=Files(k).name;
   full_path = strcat('./images20/NII_images/',FileNames);
   
   disp (['Computing for ',FileNames]);
   
   vols = spm_vol(full_path);
   img = spm_read_vols(vols);
   
   [~,~,no_of_slices] = size(img);
   
   try 
        % Cortical volume
        cortical_volm = get_totals(full_path, -inf, cortical_M)
        cortical_volm_array(k,1) = cortical_volm;
        
        % Sub - cortical volume
        sub_cortical_volm = get_totals(full_path, -inf, sub_cortical_M)
        sub_cortical_volm_array(k,1) = sub_cortical_volm;
        
   catch
        disp('Could not be computed');
        cortical_volm_array(k) = [];
        sub_cortical_volm_array(k) = [];
   end
   
    
    
end

% Remove zeros
cortical_volm_array(cortical_volm_array==0)=[];
sub_cortical_volm_array(sub_cortical_volm_array==0)=[];

disp(['Mean of cortical volume = ',num2str(mean(cortical_volm_array))]);
disp(['Mean of sub-cortical volume = ',num2str(mean(sub_cortical_volm_array))]);



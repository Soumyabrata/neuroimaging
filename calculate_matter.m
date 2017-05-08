% To calculate global gray matter and global white matter for patients

addpath /home/soumya/Dropbox/MATLAB/NNI/spm8

[num, txt, raw] = xlsread('./Subject_list.xlsx');


Files=dir('./images20/c1/*.*');
Files(1:2)=[] ;


for k=1:length(Files)
    
   FileNames=Files(k).name;
   full_path = strcat('./images20/c1/',FileNames);
   try
       
        gray_matter = get_totals(full_path);
        disp (['Gray matter for ',FileNames,'=',num2str(gray_matter)]);
   catch
       
       disp (['Gray matter for ',FileNames,' could not be computed']);
       
   end
   
end


%%

Files=dir('./images20/c2/*.*');
Files(1:2)=[] ;


for k=1:length(Files)
    
   FileNames=Files(k).name;
   full_path = strcat('./images20/c2/',FileNames);
   try
       
        white_matter = get_totals(full_path);
        disp (['White matter for ',FileNames,'=',num2str(white_matter)]);
   catch
       
       disp (['White matter for ',FileNames,' could not be computed']);
       
   end
   
end

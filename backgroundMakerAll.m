function [] = backgroundMakerAll(part_num)

addpath('C:\Users\stweis\Documents\GitHub\Arrows_FMRI');
cd('C:\Users\stweis\SkyDrive\MVPA_ARROWS\FMRI_Materials\Behavioral_Exp v03\FINAL_24_SCHEMAS_WORDS_PNGS\');
files = dir('*png*');
temp = struct2cell(files);
names = temp(1,:)';

%To randomly assign backgrounds
cd('C:\Users\stweis\SkyDrive\MVPA_ARROWS\FMRI_Materials\Behavioral_Exp v03\FINAL_24_IMAGES\scrambled\');
files_b = dir('*jpg*');
temp_b = struct2cell(files_b);
names_b = temp_b(1,:)';
names_b = Shuffle(names_b);


subpath = horzcat('C:\Users\stweis\SkyDrive\MVPA_ARROWS\FMRI_Materials\Behavioral_Exp v03\FMRI_Experiment_Scripts\',num2str(part_num));
mkdir(subpath);
addpath(subpath);
cd(subpath);

for i=1:length(names)
    name = mat2str(cell2mat(names(i)));
    name = name(2:end-1);
    name_b = mat2str(cell2mat(names_b(i)));
    name_b = name_b(2:end-1);
    backgroundMaker('C:\Users\stweis\SkyDrive\MVPA_ARROWS\FMRI_Materials\Behavioral_Exp v03\FINAL_24_SCHEMAS_WORDS_PNGS\',name,name_b);
end

names = dir('*.jpg*');
names = {names(~[names.isdir]).name};

count = 0;

for i = 1:length(names)
    if mod(i-1,24) == 0
        count = 0;
    else
        count = count + 1;
    end
    orig = strsplit(names{i},'_');
    new = [orig{1},'_',orig{2},'_',num2str(count+1),'.jpg'];
    if strcmpi(names{i},new)
        continue
    else
        movefile(names{i},new);
    end
end


    
    
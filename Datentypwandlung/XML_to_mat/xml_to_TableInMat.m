filedir='C:\Users\y03li\Desktop\xml2analyse'; %change path to place where the loged files are  
file=dir(fullfile(filedir,'*.xml'));
mfiles=length(file);
S = cell(1,mfiles);
for x = 1: mfiles
    S{x}=xml2struct(fullfile(filedir,file(x).name));
    var = S{x};
    datapart=var.datafromroom.datapart;
    Head=var.datafromroom.Header;
    fields=fieldnames(datapart{1,1})';
    s=size(fields);
    s2=size(datapart);
    data = cell(s2(2),s(2)-1);
    for o =2:s(2)-1
        for i = 1: s2(2)
            C=getfield(datapart{1,i},fields{1,o},'Text');
            data{i,o}=str2double(C);
        end 
    end
    for i = 1: s2(2)
            C=getfield(datapart{1,i},fields{1,1},'Text');
            data{i,1}=datetime(C,'Format','yyyy-MM-dd-HH:mm:ss.SSS');
        end 
    Table=cell2table(data);
    Table.Properties.VariableNames = fields(1,1:s(2)-1);
    matfilename = file(x).name(1:end-4);
    save(matfilename,'Table');
end

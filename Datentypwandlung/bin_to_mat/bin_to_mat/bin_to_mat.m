filedir='C:\Users\LIYiz\Desktop\bin_to_mat'; %change path to place where the loged files are  
file=dir(fullfile(filedir,'*.txt'));
mfiles=length(file);
for x = 1: mfiles
    fileID=fopen(fullfile(filedir,file(x).name));
    A=fread(fileID,[11,100],'double');
    fclose(fileID);
    A=A.';
    s=size(A);
    data = cell(s(1),s(2));
    for n = 1:s(1)
        B=uint64(A(:,1));
        timestamp(n,1)=datetime(B(n,1),'ConvertFrom','ntfs','Format','yyyy-MM-dd HH:mm:ss.SSS');
        data{n,1}=timestamp(n,1);
        for m = 1:s(2)-1
            data{n,m+1}=A(n,m+1);
        end
    end

    fileID=fopen('TTITLETEST.txt');
    %A=fread(fileID,Inf,'*char')';
    Title=textscan(fileID,'%s','Delimiter',',');
    fclose(fileID);

    title=Title{1,1}';
    Table=cell2table(data);
    Table.Properties.VariableNames = title(1,:);

    matfilename = file(x).name(1:end-4);
    save(matfilename,'Table');
    %TTable=table2timetable(Table);
end
fileID=fopen('2020-07-27-10-59-31-046ATEST.txt');
    A=fread(fileID,[11,100],'*double');
    fclose(fileID);
    A=A.';
    
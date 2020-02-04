function [data] = loadJson(fpath)
    fid = fopen(fpath);
    raw = fread(fid,inf);
    str = char(raw');
    fclose(fid);

    data = jsondecode(str);
end
function b = loadbarcodes( filename )
%LOADBARCODES Load barcodes from a config file
%   Inputs:
%     filename (str)  - Filename of the file to load barcodes from
%   Outputs:
%     b (char matrix) - Nx4 matrix with barcodes, 1 barcode per line

b = char();
f = fopen(filename);
i = 1;
while ~feof(f)
    b(i,:) = fgetl(f);
    i = i + 1;
end

fclose(f);

end


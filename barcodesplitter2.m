function barcodesplitter2(Filename,BFilename,threshold)
% OPENFILE
%   Inputs:
%    Filename  - Sequence Text File
%    BFilname  - Barcode Text File
%    threshold - # of bases of barcode that must match

[path,name,ext] = fileparts(Filename);
b = loadbarcodes(BFilename);
Outputfile = [];
for i = 1:length(b)
    Outputfile(i) = fopen(sprintf('%s/%s_%s.txt',path,name,b(i,:)), 'w');
end
mismatched = fopen(sprintf('%s/%s_mismatches.txt',path,name), 'w');

%Sort the FASTQ reads by barcode
count = 0;
CHUNK_SIZE = 100000;
f = fopen(Filename);
while ~feof(f)
    fprintf('Processing reads %i-%i\n', count+1, count+CHUNK_SIZE);
    reads = getfastqreads(f, CHUNK_SIZE);
    for i = 1:length(reads)
        count = count + 1;
        [barcode, score] = matchbarcode(b, reads(i).Sequence);
        if score >= threshold
            writeFASTQRead(Outputfile(barcode), reads(i));
        else
            writeFASTQRead(mismatched, reads(i));
        end
    end
end

fprintf('Split %i reads\n', count);

for i = 1:length(b)
    fclose(Outputfile(i));
end
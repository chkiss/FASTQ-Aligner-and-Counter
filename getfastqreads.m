function [ reads ] = getfastqreads( fid, num_reads )
%GETFASTQREADS Get the next block of N reads from file fid
%   Inputs:
%     fid (file handle) - FASTQ file to get a block of reads from
%     N (int)           - Number of reads to get
%   Outputs:
%     reads (struct array) - array of FASTQStruct

% Get the required number of lines (4 lines per read)
lines = textscan(fid, '%s', 4*num_reads, 'delimiter', '\n');
lines = lines{:};
N = numel(lines);
if mod(N,4) ~= 0
    error('Missing Header, Sequence, or Quality in FASTQ file');
end

% Extract info from the lines
FASTQStruct = struct('Header',[],'Sequence',[],'Quality',[]);
reads = repmat(FASTQStruct, 1, floor(N/4));
[reads(1:floor(N/4)).Sequence] = lines{2:4:N};
[reads(1:floor(N/4)).Quality] = lines{4:4:N};
[reads(1:floor(N/4)).Header] = lines{1:4:N};

% Remove tag @ from header
h = regexprep({reads(:).Header}, '^@', '');
[reads(:).Header] = h{:};
     
end


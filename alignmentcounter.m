function [ counts, unmapped ] = alignmentcounter( sequences_file, reference_file, N, threshold )
%ALIGNMENTCOUNTER Counts the number of sequences that align to each
% position in a reference
%   Inputs:
%     sequences_file (string) - Filename of sequences
%     reference_file (string) - FASTA file with reference sequence
%     N (int)                 - Number of reads to process
%     threshold (double)      - Threshold score for mapping
%   Outputs:
%     counts (int vector)     - Counts of mapped sequences to reference
%     unmapped (int)          - Number of unmapped sequences

% Load the reference sequence
[~,refseq] = fastaread(reference_file);
fprintf('Loaded %i bases from reference sequence\n', length(refseq));

unmapped = 0;
counts = zeros(size(refseq));

f = fopen(sequences_file);

count = 0;
CHUNK_SIZE = 100000;

%Align and count the sequences
while ~feof(f)
    fprintf('Processing reads %i-%i\n', count+1, count+CHUNK_SIZE);
    reads = getfastqreads(f, CHUNK_SIZE);
    for i = 1:length(reads)
        r = reads(i);
        [score, alignment, pos] = swalign(r.Sequence(5:end), refseq);
        if score >= threshold && pos(2) ~= -1
            counts(pos(2)) = counts(pos(2)) + 1;
            count = count + 1;
        else
            unmapped = unmapped + 1;
        end
        
        if count >= N
            return;
        end
    end
end
end


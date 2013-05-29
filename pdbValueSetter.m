function pdbValueSetter( pdbInputFile, data, pdbOutputFile, offset )
%PDBVALUESETTER Sets values for residues in a PDB file from a data vector
% Will iterate through the residues in pdbInput, replacing each value with
% the data from the corresponding index in data, and write the results to
% pdbOutput
%   Inputs:
%     pdbInputFile (string)  - input PDB filename 
%     data (double vector)   - vector of data to substitute into the PDB
%     pdbOutputFile (string) - output PDB filename
%     offset (int)           - offset if the residue # doesn't match the
%                              indices in data

input = fopen(pdbInputFile);
output = fopen(pdbOutputFile, 'w');

while ~feof(input)
    line = fgets(input);
    
    if strcmpi(line(1:4), 'ATOM')
        residue = str2num(line(24:26));
        line(61:66) = sprintf('%6.2f', data(residue-offset));
    end
    
    fprintf(output, line);
end

fclose(input);
fclose(output);

end


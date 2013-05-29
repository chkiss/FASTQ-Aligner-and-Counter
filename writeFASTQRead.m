function writeFASTQRead(fid, r)
%WRITEFASTQREAD Write FASTQStruct r to file id fid

fprintf(fid, '@%s\n', r.Header);
fprintf(fid, '%s\n', r.Sequence);
fprintf(fid, '+%s\n', r.Header);
fprintf(fid, '%s\n', r.Quality);

end


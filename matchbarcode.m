function [barcode, score] = matchbarcode(barcodes, read)
% Input "read": a cell array containing four cells with line of data
% "barcodes": a vector containing the four barcodes
% Output "barcode": a string containing the barcode or a guess ending in ?

% Guess that the barcode is the first four characters of the sequence as-is
guess = read(1:4);
% Compare the guess to each barcode and pick the closest
for i = 1:4
    score(i)=sum(guess==barcodes(i,:));
end
[score,barcode] = max(score);
end
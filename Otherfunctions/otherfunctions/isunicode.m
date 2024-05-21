function isuc = isunicode(filename, varargin)
%ISUNICODE Checks if and which unicode header a file has.
%  ISUC = ISUNICODE(FILENAME)
%  ISUC = ISUNICODE('string', TEXTSTRING)
%  ISUC is true if the file / string contains unicode characters, otherwise
%  false. Exact Information about the encoding is also given.
%  ISUC == 0: No UTF Header
%  ISUC == 1: UTF-8
%  ISUC == 2: UTF-16BE
%  ISUC == 3: UTF-16LE
%  ISUC == 4: UTF-32BE
%  ISUC == 5: UTF-32LE
%
%  (c) Version 1.1 by Stefan Eireiner (<a href="mailto:stefan.eireiner@siemens.com?subject=isunicode">stefan.eireiner@siemens.com</a>)
%  last change 11.04.2006

isuc = false;
if(nargin == 2)
    if(strcmpi(filename, 'string'))
        firstLine = varargin{1}(1:4);
    end
end

if(~exist('firstLine', 'var'))
    fin = fopen(filename,'r');
    if (fin == -1) %does the file exist?
        error(['File ' filename ' not found!'])
        return;
    end
    fileInfo = dir(filename);
    if(fileInfo.bytes < 4) % a unicode file incl. header can't be smaller than 4 bytes if it shall display at least one char.
        return;
    end
    firstLine = fread(fin,4)';
end

% assign all possible headers to variables
utf8header    = [hex2dec('EF') hex2dec('BB') hex2dec('BF')];
utf16beheader = [hex2dec('FE') hex2dec('FF')];
utf16leheader = [hex2dec('FF') hex2dec('FE')];
utf32beheader = [hex2dec('00') hex2dec('00') hex2dec('FE') hex2dec('FF')];
utf32leheader = [hex2dec('FF') hex2dec('FE') hex2dec('00') hex2dec('00')];

% compare first bytes with header
if(strfind(firstLine, utf8header) == 1)
        isuc = 1;
elseif(strfind(firstLine, utf16beheader) == 1)
        isuc = 2;
elseif(strfind(firstLine, utf16leheader) == 1)
        isuc = 3;
elseif(strfind(firstLine, utf32beheader) == 1)
        isuc = 4;
elseif(strfind(firstLine, utf32leheader) == 1)
        isuc = 5;
end

if(~exist('firstLine', 'var'))
    fclose(fin);
end
function str_array = create_str_array(varargin)
%CREATE_STR_ARRAY Summary of this function goes here
%   Detailed explanation goes here


str_array = cell(1,nargin);

for i=1:nargin
    str_array{i} = varargin{i};
end

%str_array = cellstr(array);


end
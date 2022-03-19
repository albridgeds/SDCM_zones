function city_array = create_city_array(varargin)


for i=1:nargin
    [lat,long] = dbCity(varargin{i});
    city_array(i).lat = lat;
    city_array(i).long = long;
end
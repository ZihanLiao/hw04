function mySpatialFilt(image,filter)
    [r_filter,c_filter] = size(filter);
    [r_img,c_img] = size(image);
    hori_pad = floor(c_filter/2);
    vert_pad = floor(r_filter/2);
    if r_filter ~= c_filter
        padded_img = padarray(image,[hori_pad hori_pad],'replicate');
        [r_padded,c_padded] = size(padded_img);
        cache_img = zeros(r_img,c_padded);
        for r=1:r_padded
            for c=1:c_img
                subarray = padded_img(r,c:c+c_filter-1);
                cache = sum(double(subarray).*filter,'all');
                cache_img(r,c) = cache;
            end
        end
        filter = transpose(filter);
        [r_filter,c_filter] = size(filter);
%         cache_img = padarray(cache_img,[hori_pad vert_pad],'replicate');
        filtered_img = zeros(r_img,c_img);
        for r=1:r_img
            for c=1:c_img
                subarray = cache_img(r:r+r_filter-1,c);
                cache = sum(double(subarray).*filter,'all');
                filtered_img(r,c) = cache;
            end
        end
    else
        padded_img = padarray(image,[vert_pad hori_pad],'replicate');
        
        filtered_img = zeros(r_img, c_img);
        for r = 1:r_img
            for c = 1:c_img
                subarray = padded_img(r:r+r_filter-1,c:c+c_filter-1);
                cache = sum(double(subarray).*filter,'all');
                filtered_img(r,c) = cache;  
            end
        end
    end
% 
%     filtered_img = conv2(filter,transpose(filter),padded_img);
% else
%     filtered_img = conv2(padded_img,filter);
% end
    imshow(uint8(filtered_img));
end


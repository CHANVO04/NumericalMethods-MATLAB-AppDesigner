function [a2, a1] = HoiQuyTuyenTinh(x,y)
    n = length(x);
    sumx = sum(x);
    sumy = sum(y);
    sumxy = sum(x .* y);
    sumx2 = sum(x .^ 2);
    xm = sumx / n;
    ym = sumy / n;

    % H? s? a1 và a0
    a2 = (n * sumxy - sumx * sumy) / (n * sumx2 - sumx^2);
    a1 = ym - a2 * xm;
end
function result = calculate_derivative_backward(app, x, h, saiso)
    % Ki?m tra ?i?u ki?n ?i?n d? li?u X, Y ho?c Hàm s?
    if ~isempty(app.DulieuX_Daoham.Value) && ...
       ~isempty(app.DulieuY_Daoham.Value) && ...
       isempty(app.Hamso_Daoham.Value)
        % N?u dùng d? li?u X, Y: n?i suy tuy?n tính
        try
            X = str2num(app.DulieuX_Daoham.Value); %#ok<ST2NM>
            Y = str2num(app.DulieuY_Daoham.Value); %#ok<ST2NM>
            if length(X) ~= length(Y)
                result = "X và Y ph?i có cùng ?? dài!";
                return;
            end
            % Tính ??o hàm lùi t?i x
            result = (interp1(X, Y, x, 'linear', 'extrap') - interp1(X, Y, x - h, 'linear', 'extrap')) / h;
        catch
            result = "D? li?u X, Y không h?p l?!";
            return;
        end
    elseif ~isempty(app.Hamso_Daoham.Value) && ...
           isempty(app.DulieuX_Daoham.Value) && ...
           isempty(app.DulieuY_Daoham.Value)
        % N?u dùng hàm s?
        func_str = app.Hamso_Daoham.Value;
        try
            f = str2func(['@(x)' func_str]); % Chuy?n thành hàm MATLAB
        catch
            result = "Hàm không h?p l?!";
            return;
        end

        % Tính toán theo sai s?
        if saiso == 1 % Sai s? O(h)
            result = (f(x) - f(x - h)) / h; % ??o hàm lùi
        elseif saiso == 2 % Sai s? O(h²)
            result = (f(x - 2*h) - 4*f(x - h) + 3*f(x)) / (2*h); % ??o hàm lùi v?i sai s? O(h²)
        else
            result = "Sai s? không h?p l?!";
            return;
        end
    else
        % Tr??ng h?p không h?p l?
        result = "Vui lòng ?i?n X, Y ho?c Hàm s? (ch? ch?n m?t trong hai)!";
        return;
    end
end

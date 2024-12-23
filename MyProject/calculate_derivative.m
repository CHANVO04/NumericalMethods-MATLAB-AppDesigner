function result = calculate_derivative(app, x, h, saiso)
    % Ki?m tra ?i?u ki?n ?i?n d? li?u X, Y ho?c Hàm s?
    if ~isempty(app.DulieuX_DaohamEditField.Value) && ...
       ~isempty(app.DulieuY_DaohamEditField.Value) && ...
       isempty(app.Hamso_DaohamEditField.Value)
        % N?u dùng d? li?u X, Y: n?i suy tuy?n tính
        try
            X = str2num(app.DulieuX_DaohamEditField.Value); %#ok<ST2NM>
            Y = str2num(app.DulieuY_DaohamEditField.Value); %#ok<ST2NM>
            if length(X) ~= length(Y)
                result = "X và Y ph?i có cùng ?? dài!";
                return;
            end
            
            % Tính ??o hàm ti?n t?i x
            result = (interp1(X, Y, x + h, 'linear', 'extrap') - interp1(X, Y, x, 'linear', 'extrap')) / h;
        catch
            result = "D? li?u X, Y không h?p l?!";
            return;
        end
    elseif ~isempty(app.Hamso_DaohamEditField.Value) && ...
           isempty(app.DulieuX_DaohamEditField.Value) && ...
           isempty(app.DulieuY_DaohamEditField.Value)
        % N?u dùng hàm s?
        func_str = app.Hamso_DaohamEditField.Value;
        try
            f = str2func(['@(x)' func_str]); % Chuy?n thành hàm MATLAB
        catch
            result = "Hàm không h?p l?!";
            return;
        end

        % Tính toán theo sai s?
        if saiso == 1 % Sai s? O(h)
            result = (f(x + h) - f(x)) / h; % ??o hàm ti?n
        elseif saiso == 2 % Sai s? O(h²)
            result = (-f(x + 2*h) + 4*f(x + h) - 3*f(x)) / (2*h); % ??o hàm ti?n v?i sai s? O(h²)
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

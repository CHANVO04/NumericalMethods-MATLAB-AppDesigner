function result = calculate_derivative(app, x, h, saiso)
    % Ki?m tra ?i?u ki?n ?i?n d? li?u X, Y ho?c H�m s?
    if ~isempty(app.DulieuX_DaohamEditField.Value) && ...
       ~isempty(app.DulieuY_DaohamEditField.Value) && ...
       isempty(app.Hamso_DaohamEditField.Value)
        % N?u d�ng d? li?u X, Y: n?i suy tuy?n t�nh
        try
            X = str2num(app.DulieuX_DaohamEditField.Value); %#ok<ST2NM>
            Y = str2num(app.DulieuY_DaohamEditField.Value); %#ok<ST2NM>
            if length(X) ~= length(Y)
                result = "X v� Y ph?i c� c�ng ?? d�i!";
                return;
            end
            
            % T�nh ??o h�m ti?n t?i x
            result = (interp1(X, Y, x + h, 'linear', 'extrap') - interp1(X, Y, x, 'linear', 'extrap')) / h;
        catch
            result = "D? li?u X, Y kh�ng h?p l?!";
            return;
        end
    elseif ~isempty(app.Hamso_DaohamEditField.Value) && ...
           isempty(app.DulieuX_DaohamEditField.Value) && ...
           isempty(app.DulieuY_DaohamEditField.Value)
        % N?u d�ng h�m s?
        func_str = app.Hamso_DaohamEditField.Value;
        try
            f = str2func(['@(x)' func_str]); % Chuy?n th�nh h�m MATLAB
        catch
            result = "H�m kh�ng h?p l?!";
            return;
        end

        % T�nh to�n theo sai s?
        if saiso == 1 % Sai s? O(h)
            result = (f(x + h) - f(x)) / h; % ??o h�m ti?n
        elseif saiso == 2 % Sai s? O(h�)
            result = (-f(x + 2*h) + 4*f(x + h) - 3*f(x)) / (2*h); % ??o h�m ti?n v?i sai s? O(h�)
        else
            result = "Sai s? kh�ng h?p l?!";
            return;
        end
    else
        % Tr??ng h?p kh�ng h?p l?
        result = "Vui l�ng ?i?n X, Y ho?c H�m s? (ch? ch?n m?t trong hai)!";
        return;
    end
end

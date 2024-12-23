function [x0,n,check] = lap(fx, fp, a, b, saiso)
x0 = 0;
n = 0; % S? l?n l?p
check = 0;
fxi = str2func(['@(x)',fx]);

% Ki?m tra ?i?u ki?n l?p
syms x;
% Chuy?n chu?i h�m l?p th�nh bi?u th?c symbolic
fp_sym = str2sym(fp);
                    
% T�nh ??o h�m c?a h�m l?p
dfp_sym = diff(fp_sym, x);
                    
% Chuy?n ??o h�m v� h�m l?p th�nh function handle
dfp_func = matlabFunction(dfp_sym, 'Vars', x);
fpi = matlabFunction(fp_sym, 'Vars', x);
                
            
% Ki?m tra ?i?u ki?n |fp'(x)| < 1 tr�n ?o?n [a, b]
x_values = linspace(a, b, 100); % Chia ?o?n [a, b] th�nh 100 ?i?m ?? ki?m tra
dfp_values = abs(dfp_func(x_values)); % T�nh tr? tuy?t ??i ??o h�m t?i c�c ?i?m
            
if all(dfp_values < 1)
    check = 1;                    
    m = (a + b) / 2; % Gi� tr? gi?a
    if fxi(m) * fxi(a) < 0
        x0 = a;
    else
        x0 = b;
    end
            
    while true
        x1 = fpi(x0); % G?i h�m l?p
        n = n + 1;
        if abs(x1 - x0) < saiso
            break;
        end
        x0 = x1;
    end
end
end
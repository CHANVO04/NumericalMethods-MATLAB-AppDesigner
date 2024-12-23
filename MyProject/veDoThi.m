function veDoThi(app, fx)
    % H�m ?? v? ?? th? tr�n giao di?n app
    % app: ??i t??ng c?a ?ng d?ng ch?a UIAxes
    % fx: H�m s? c?n v?
    
    fxi = str2func(['@(x)',fx]);
    
    % R?i r?c h�a t�n hi?u x
    x_t2 = -15:1/1000:15;

    % T�nh c�c gi� tr? y theo x
    y_t2 = fxi(x_t2);

    % V? ?? th? tr�n UIAxes
    plot(app.UIAxes, x_t2, y_t2);
    grid(app.UIAxes, 'on');
end

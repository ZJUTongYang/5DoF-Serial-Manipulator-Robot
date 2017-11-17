function T = DH(alpha, a, d, theta)
    Dx_ai1 = [1 0 0 a;
                0 1 0 0;
                0 0 1 0;
                0 0 0 1];
    Rx_ai1 = [ 1 0 0 0;
                0 cosd(alpha) -sind(alpha) 0;
                0 sind(alpha) cosd(alpha) 0;
                0 0 0 1];
    Dz_di = [1 0 0 0;
                0 1 0 0;
                0 0 1 d;
                0 0 0 1];
    Rz_ti = [ cosd(theta) -sind(theta) 0 0;
            sind(theta) cosd(theta) 0  0;
            0 0 1 0;
            0 0 0 1];
    T = Dx_ai1*Rx_ai1*Dz_di*Rz_ti;
end
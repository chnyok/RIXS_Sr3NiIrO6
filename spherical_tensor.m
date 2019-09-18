function [jp,j0,jm] = spherical_tensor(j)
    m = -j:1:j-1;
    d = sqrt(j*(j+1) - m.*(m+1));
    jp = diag(d,1)/sqrt(2);
    jm = diag(d,-1)/sqrt(2);
    j0 = diag([m,j]);
end
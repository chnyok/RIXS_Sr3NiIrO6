function [V,E] = sorted_eig(M)
    [V,E] = eig(M);
    E = real(diag(E));
    [E,perm] = sort(E);
    V = V(:,perm);
    E = E - E(1);
end


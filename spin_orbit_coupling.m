function ls = spin_orbit_coupling(l)
    [sx,sy,sz] = cartesian_sph(0.5);
    [lx,ly,lz] = cartesian_sph(l);
    ls = kron(lx,sx) + kron(ly,sy) + kron(lz,sz);
end
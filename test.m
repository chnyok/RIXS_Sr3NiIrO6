run definitions % conv_d % p_in % p_out
soc_d = spin_orbit_coupling(2);
[~,~,sz] = cartesian_sph(0.5);
Hamiltonian = @(d,z,a) z*conv_d*soc_d*conv_d' + d*kron(diag([2 -1 -1])/3,eye(2)) + a*kron(eye(3),sz);

delta = [0.294 -0.218 0.594];
zeta  = [0.396  0.4172 0.196];

D = linspace(-0.3,1,200);
f= zeros(3,length(D));

R180 = diag([-1 -1 1]);



figure()
hold on
for root = 1:3
    
    [V,E] = sorted_eig(-Hamiltonian(delta(root),zeta(root),0));
    [Vi,Ei] = sorted_eig(-spin_orbit_coupling(1));
    Vi = Vi(:,1:4);


    kh1 = kramers_heisenberg_resonant(conv_d'*V,Vi,p_in,p_out);
    kh2 = kramers_heisenberg_resonant(conv_d'*V,Vi,R180*p_in,R180*p_out);

    E_T = - E*ones(1,6) + ones(6,1)*E';
    amp = kh1(1,:) +  kh1(2,:) + kh2(1,:) +  kh2(2,:);
    
    f(root,:) = broaden(D,E_T(1,:),amp,kron([0.02,0.05,0.05],[1,1]));
    
    plot(D,f(root,:))
end


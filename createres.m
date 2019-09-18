function [f,rawdat] = createres(D,PARAMS,POL,G,T,i0,voigt)
    
    if nargin<7
        voigt = 0;
    end
    run definitions % conv_d
    soc_d = spin_orbit_coupling(2);
    [~,~,sz] = cartesian_sph(0.5);
    Hamiltonian = @(d,z,a) z*conv_d*soc_d*conv_d' + d*kron(diag([2 -1 -1])/3,eye(2)) + a*kron(eye(3),sz);
    
    % Intermediate state
    [Vi,~] = sorted_eig(-spin_orbit_coupling(1));
    Vi = Vi(:,1:4);


    nroots = length(PARAMS);
    n = length(D);
    f = zeros(nroots,n);
    
    rawdat = cell(1,nroots);
    for iroot = 1:nroots
        
        [V,E] = sorted_eig(-Hamiltonian(PARAMS{iroot}(1),PARAMS{iroot}(2),PARAMS{iroot}(3)));
        kh = zeros(size(kramers_heisenberg_resonant(conv_d'*V,Vi,[0,0,1],[0,0,1])));
        for  ip = 1:length(POL)
            kh = kh + kramers_heisenberg_resonant(conv_d'*V,Vi,POL{ip}{1},POL{ip}{2});
        end
        
        E_T = - E*ones(1,6) + ones(6,1)*E';

        kT = T*8.61733e-5;
        %%
        %mu = (E(1) + E(2))/2;
        p = zeros(1,2);
        for i = 1:2
            %p(i) = 1/(1 + exp((E(i)-mu)/kT));
            p(i) = exp(-E(i)/kT);
        end
        p=p/sum(p);
        %%
        f(iroot,:) = p(1) * broaden(D,E_T(1,:),kh(1,:),kron(G,[1,1]),voigt) ...
            + p(2) * broaden(D,E_T(2,:),kh(2,:),kron(G,[1,1]),voigt);
        f(iroot,:) = f(iroot,:)/f(iroot,i0);
        rawdat{iroot} = {E_T(1:2,:),p*kh(1:2,:)};
    end
    
end
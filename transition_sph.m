function T = transition_sph(ll,lr,k)
    % Transition operator in spherical basis
    % k is transition magnetic number
    T = zeros(2*ll+1,2*lr+1);  
    
    for mr = -lr:lr % magnetic number on right (in domain)
        
        % As holes, both are conjugated, but left is conjugated again
        
        % sum rule : ml + k + -mr = 0
        ml = (mr - k);
        if (abs(ml)>ll); continue; end
        
        % index 1 refers to m = -l
        T(ml + ll +1, mr + lr + 1)  = (-1)^mr*Wigner3j([ll,lr,1],[ml,-mr,k]);
    end
end
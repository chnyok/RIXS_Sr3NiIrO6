function res = kramers_heisenberg_resonant(V,Vn,pin,pout)
    
%    pin  = [0.5583 -0.7757 0.2942]';
%    pout = [0.6486  0.6657 0.369 ]';


    r2=sqrt(2);
    C2S = [ 1 -1i 0
           -1 -1i 0 
            0  0  r2]/r2;
        
    pin  = C2S * pin(:);
    pout = C2S * pout(:);
    ln = round(size(Vn, 1) /2 - 1)/2; % Intermediate state quantum number L 
    lf = round(size(V , 1) /2 - 1)/2; % Final state quantum number L
    
    % Fundamental Amplitudes 
    Tm = -transition_sph(ln, lf,  1);
    Tp = -transition_sph(ln, lf, -1);
    T0 =  transition_sph(ln, lf,  0);
    
    %Tm_e = transition_sph(lf,ln,  1);
    %Tp_e = transition_sph(lf,ln, -1);
    %T0_e = transition_sph(lf,ln,  0);
        
    Tin  =     pin(1)  * Tm    +   pin(2)  * Tp    +     pin(3)  * T0;
    Tout =    -pout(1) * Tp'   +  -pout(2) * Tm'   +     pout(3) * T0';
    
    Tin  = kron(Tin ,eye(2));
    Tout = kron(Tout,eye(2));
    
    
    TVVT = Tout*(Vn*Vn')*Tin;
    
    nf = size(V,2);
    res = zeros(nf);
    for ii = 1:nf
        for fi = 1:nf
            res(ii,fi) = abs(conj(V(:,fi)')*TVVT*conj(V(:,ii)))^2;
        end
    end
end
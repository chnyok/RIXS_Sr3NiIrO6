function f = broaden(D,E,A,B,Voigt)

f=zeros(size(D));
n = length(E);

if (nargin > 4 && Voigt == 1)
    for i = 1:n
        f = f + A(i)*voigtprof(D,B(1,i),B(2,i),E(i));
    end
else
    
    for i = 1:n
        f = f + A(i)/sqrt(2*pi)/B(i)*exp(-(D-E(i)).^2/B(i)^2/2);
    end
end
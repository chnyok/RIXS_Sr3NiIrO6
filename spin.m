function f = spin(T,iroot,a_min,a_max,n,G,scale,D,i0)

run definitions % p_in % p_out %RS
po1 = (p_out + 1i*RS)/sqrt(2);
po2 = (p_out - 1i*RS)/sqrt(2);
R180 = vrrotvec2mat([0 0 1 pi/3]);
POL = {{p_in,po1},{p_in,po2},{R180*p_in,R180*po1},{R180*p_in,R180*po2}};

delta = [0.294 -0.218 0.594];
zeta  = [0.396  0.417 0.196];

a_mev = linspace(a_min,a_max,n);
PARAMS=cell(1,n);
legs = cell(1,n+1);
legs{1} = ['exp. T = ',num2str(T)];
for i = 1:n
    PARAMS{i} = [delta(iroot),zeta(iroot),1e-3*a_mev(i)];
    legs{i+1} = ['$ a_z = ',num2str(a_mev(i)),'$ meV'];
end
f = createres(D,PARAMS,POL,G,T,i0,1);

EXP = experimental_spect(T);
plot(EXP{:},'k.');
hold on
for i=1:n
    plot(D,scale*f(i,:))
end
xlim([-0.2,1])
xlabel('\omega (eV)')
ylabel('I (arb. units)')
legend(legs,'interpreter','latex')
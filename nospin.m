close all

savedir='../../Illustrations';

%% Overhead
%  Results from Quanty
mplet1e = importdata('../spin_amplitudes/mplet-1e-spect.csv');
mplet   = importdata('../spin_amplitudes/mplet-spect.csv');

% Domain for computational results
D = mplet(:,1);
i0 = 214;

fm1e = mplet1e(:,2:4)'./(ones(size(D))*mplet1e(i0,2:4))';
fm = mplet(:,2:4)'./(ones(size(D))*mplet(i0,2:4))';
clear mplet mplet1e

% Get experimental parameters

run definitions % p_in % p_out %RS
p_i  = p_in;
po1 = (p_out);%/sqrt(2);
po2 = (RS);%/sqrt(2);
R180 = vrrotvec2mat([0 0 1 pi]);


delta = [0.294  -0.218 0.594];
zeta  = [0.396   0.417 0.196];

%% No spin Amplitude
T = 300;

D  = linspace(D(1),1,601);
i0 = 427;


POL = {{p_in,po1},{p_in,po2},{R180*p_in,R180*po1},{R180*p_in,R180*po2}};
G = [0.045 0.11 0.11
     0.015 0.020 0.080];
PARAMS = cell(1,3);
for i = 1:3
    PARAMS{i} = [delta(i),zeta(i),0.0];
end

f_a0 = createres(D,PARAMS,POL,G,T,i0,1);
csvwrite(['nospin.dat'],[D;f_a0]')

figure()
EXP = experimental_spect(T);
plot(EXP{:},'k.')
hold on
plot(D,f_a0)
xlim([-0.2,1])
ylim([0,2.7])
legend('Exp.','+','-','R3')
ylabel('Intensity (arb. units)')
xlabel('Energy transfer (eV)')

print([savedir,'/nospin'],'-dpng')

%% W/ Spin 300 K

scale = [1 1 1
         1 1 1];
amin = [0    0];
amax = [100 80];

G = {[0.045 0.11 0.11
     0.010 0.020 0.070], ...
     [0.040 0.11 0.11
     0.015 0.020 0.080]};
Ts = [10,300];
param_str = {'+','-','3'};
%f=figure('units','normalized','outerposition',[0.1 0.1 0.8 0.9])
F = cell(2,3);
close all
for iroot = 1:3
    for iT=1:2
        f = figure();
        %subplot(3,2,(iroot-1)*2 + iT)
        T = Ts(iT);
        F{iT,iroot} = spin(T,iroot,amin(iT),amax(iT),6,G{iT},scale(iT,iroot),D,i0);
        %title(['T = ',num2str(T),' K, Parmetrization R',param_str{iroot}])
        %f = figure();
        %spin(T,iroot,amin(iT),amax(iT),4,G,scale(iT,iroot),D)
        print([savedir,'/spin-R',num2str(iroot),'-T',num2str(T)],'-dpng')
        close(f)
    end
end

%% Comparison of roots and to quanty
% 
% figure('units','normalized','outerposition',[0.1 0.1 0.8 0.9])
% colors = 'brg';
%  
% DS = {f,fm,fm1e};
 
% dset_titles = {'One-electron model' ... 
%     'Quanty full multiplet' ...
%     'Quanty One-electron approx.'};
% dat_titles = {'Exp.','+','-','R3'};
% 
% for fig_col = 1:2 
%     for fig_row = 1:3
%         subplot(3,2,(fig_row-1)*2 + fig_col)
%         plot(Xx,Xy,'k.');
%         hold on
%         for i = 1:3
%             if (fig_col==1)
%                 i_ds = fig_row;
%                 i_dat = i;
%             else
%                 i_ds = i;
%                 i_dat = fig_row;
%             end
%             ds = DS{i_ds};
%             plot(D,ds(i_dat,:),[colors(i),'-'])
%         end
%         xlim([-0.2,1])
%         ylim([0,3])
%         
% 
%         if fig_col==1 
%             title(dset_titles{fig_row})
%             if fig_row == 1; legend(dat_titles,'location','best'); end
%         else 
%             title(dat_titles{1+fig_row})
%             if fig_row == 1; legend({dat_titles{1},dset_titles{1:3}},'location','northeast'); end
%         end
%     end
% end
% 
% %% Illustrations for thesis - also seperated 
%  print('../../Illustrations/full_amplitude_comparison','-dpng')
%  close all
% %% Illustration for poster
% 
% figure()
% plot(Xx,Xy,'k.');
% hold on
% i10 = 40;
% plot(X10(1:i10),Y10(1:i10),'k-.');
% ds = DS{1};
% % plot(D,ds(1,:),'b-')
% % plot(D,ds(2,:),'r-')
% % plot(D,ds(3,:),'g-')
% % ds = DS{2};
% plot(D,ds(1,:),'b-')
% plot(D,ds(2,:),'r-')
% plot(D,ds(3,:),'g-')
% xlim([-0.2,1])
% set(gca,'Ytick',[])
% ylabel('Intensity (arb. units)')
% xlabel('\omega (eV)')
% legend('Experiment (300K)','Experiment (10K)','R+','R-','R3')

%% Further illustrations for thesis

%fnames = {'1EM' ... 
%    'Quanty_full_mplet' ...
%    'Quanty1Eapprox.'};
% 
% for fig_col = 1:2 
%     for fig_row = 1:3
%         figure()
%         plot(Xx,Xy,'k.');
%         hold on
%         for i = 1:3
%             if (fig_col==1)
%                 i_ds = fig_row;
%                 i_dat = i;
%             else
%                 i_ds = i;
%                 i_dat = fig_row;
%             end
%             ds = DS{i_ds};
%             plot(D,ds(i_dat,:),[colors(i),'-'])
%         end
%         xlim([-0.2,1])
%         ylim([0,3])
%         
% 
%         
%         if fig_col==1 
%             legend(dat_titles,'location','best')
%             print(['../../Illustrations/no_spin_comparison_',fnames{fig_row}],'-dpng')
%         else 
%             legend({dat_titles{1},dset_titles{1:3}},'location','northeast')
%             print(['../../Illustrations/no_spin_comparison_','R',dat_titles{1+fig_row}],'-dpng')
%         end
%         
%     end
% end
% close all

%% ANGULAR DEPENDENCE OF OVERALL ORIENTATION

T = 300;
nangs = 100;
angs = linspace(0,2*pi,nangs);
ratio1 = zeros(3,nangs);
ratio2 = zeros(3,nangs);

delta = [0.294 -0.218 0.594];
zeta  = [0.396  0.417 0.196];

G = [0.025 0.050 0.065];
PARAMS = cell(1,3);
for i = 1:3
    PARAMS{i} = [delta(i),zeta(i),0.0];
end
ROT180 = vrrotvec2mat([0,0,1,pi/3]);
for iang = 1:nangs
    Rot = vrrotvec2mat([0,0,1,angs(iang)]);
    POL = {{Rot*p_in,Rot*po1},{Rot*p_in,Rot*po2},{Rot*R180*p_in,Rot*R180*po1},{Rot*R180*p_in,Rot*R180*po2}};

    [f,dat] = createres(D,PARAMS,POL,G,T,i0);
    for root = 1:3        
        E_T = dat{root}{1}(1,[1,3,5]);
        I   = reshape(sum(dat{root}{2},1),[2,3])'*[1; 1];
        ratio1(root,iang) = I(2)/I(1);
        ratio2(root,iang) = I(3)/I(1);
    end 
end
clrs = 'brg';
figure()
for i=1:3
    plot(angs*180/pi,ratio1(i,:),[clrs(i),'-'])
    hold on
    plot(angs*180/pi,ratio2(i,:),[clrs(i),'-.'])
end
xlabel('$\phi$','interpreter','latex')
legend('+ ratio 1','+ ratio 2','- ratio 1','- ratio 2','R3 ratio 1','R3 ratio 2');
xlim(angs([1,end])*180/pi)
ylim([0.7,1.35])
print([savedir,'/angular-Z'],'-dpng')
close all

figure()
hold on
for i=1:3
    plot(angs*180/pi,ratio2(i,:)./ratio1(i,:),[clrs(i),'-'])
end
ylim([0.6,1.5])

xlabel('$\phi$','interpreter','latex')
legend('+','-','R3');
xlim(angs([1,end])*180/pi)
%print('../../Illustrations/angular-23','-dpng')

%% ANGULAR DEPENDENCE Sigma

T = 300;
nangs = 100;
angs = linspace(0,2*pi,nangs);
ratio1 = zeros(3,nangs);
ratio2 = zeros(3,nangs);

delta = [0.294 -0.218 0.594];
zeta  = [0.396  0.417 0.196];

G = [0.025 0.050 0.065];
PARAMS = cell(1,3);
for i = 1:3
    PARAMS{i} = [delta(i),zeta(i),0.0];
end
ROT180 = vrrotvec2mat([0,0,1,pi/3]);
for iang = 1:nangs
    Rot = vrrotvec2mat([0,0,1,angs(iang)]);
    POL = {{Rot*p_in,Rot*po1},{Rot*p_in,Rot*po2},{Rot*R180*p_in,Rot*R180*po1},{Rot*R180*p_in,Rot*R180*po2}};

    [f,dat] = createres(D,PARAMS,POL,G,T,i0);
    for root = 1:3        
        E_T = dat{root}{1}(1,[1,3,5]);
        I   = reshape(sum(dat{root}{2},1),[2,3])'*[1; 1];
        ratio1(root,iang) = I(2)/I(1);
        ratio2(root,iang) = I(3)/I(1);
    end 
end
clrs = 'brg';
figure()
for i=1:3
    plot(angs*180/pi,ratio1(i,:),[clrs(i),'-'])
    hold on
    plot(angs*180/pi,ratio2(i,:),[clrs(i),'-.'])
end
xlabel('$\phi$','interpreter','latex')
legend('+ ratio 1','+ ratio 2','- ratio 1','- ratio 2','R3 ratio 1','R3 ratio 2');
xlim(angs([1,end])*180/pi)
ylim([0.7,1.35])
print([savedir,'/angular-Z'],'-dpng')
close all

figure()
hold on
for i=1:3
    plot(angs*180/pi,ratio2(i,:)./ratio1(i,:),[clrs(i),'-'])
end
ylim([0.6,1.5])

xlabel('$\phi$','interpreter','latex')
legend('+','-','R3');
xlim(angs([1,end])*180/pi)
%print('../../Illustrations/angular-23','-dpng')
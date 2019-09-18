%% In-plane polarization vectors
%  Q:   momentum transfer in lattice units (colvec)
%  Ein: Incoming photon energy in keV ~Eout
%% 
% units are Å, keV

%%[Pin,Pout] = polarization_exp_t([10;-1; 7],[-0.6269;-0.0232;1.554]);

function [Pin,Pout,k,kp,RS] = polarization_exp(Q,Sigma,rotsig)
  Ein = 11.214;
  a = 9.608;
  c = 11.16;
  alpha = 2*pi/3;
  
  % define trigonal lattice
  lat = [a*[sin(alpha), cos(alpha),  0]', a*[0, 1, 0]',  c*[0, 0, 1]' ];
  ilat = 2*pi*(lat^-1)';
  
  % alpha = half the angle between k and k' = 'theta'  
  mom2E = 3e8*6.626e-34/2/pi*1e10/1.602e-19*1e-3; %conversion factor
  Etr = norm(ilat*Q)*mom2E; %Energy corresponding to Q
  
  alpha = (pi-acos(1 - Etr^2/2/Ein^2))/2;

  % now we find the direction of Q in real space 
  % (k and k' are both in real space), and Q defines a real lat. plane
  
  % cartesian coords. - Q points into the plane
  RQ = -ilat*Q;
  RQ =  RQ/norm(RQ);
  
  RS = ilat*Sigma;
  RS = RS/norm(RS);
  
  if (nargin>2)
      RS = vrrotvec2mat([RQ',rotsig])*RS;
  end
  
  k  = vrrotvec2mat([RS',  alpha])*RQ/norm(RQ);
  kp = vrrotvec2mat([RS', -alpha])*RQ/norm(RQ);
  
  % Polarization is in-plane, so the vector perpendicular to K, 
  % but also to KxR. Therefore Kx(RxK) = R - K(KR) gives us the direction
  % scaled by sin(alpha). The choice of sign is such that the polarization
  % vector points in the direction of Q
  
  Pin  = vrrotvec2mat([k' , -pi/2])*RS;
  Pout = vrrotvec2mat([kp',  pi/2])*RS;

end
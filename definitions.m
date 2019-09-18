%% With the cartesian basis such that the z-axis aligns with the c3 axis
%  we define the rotation matrix that takes us from the basis 
% Y2m x (-,+) -> (a_g,  e_g (t2_g) ) x (-,+)
% This is not square, since we ignore the higher lying e_g(e_g) shell

c = 1/sqrt(3);
f = 1/sqrt(6);
g = 1i*c;
v = 1i*f;
conv_d = [ 0  0  1  0  0
          -c -v  0 -v -c
          -g -f  0  f  g];

clear c f g v
      
conv_d = kron(conv_d,eye(2));

sigma = [-0.6269;-0.0232;1.554];
Q = [10;-1; 7];

[p_in,p_out,~,~,RS] = polarization_exp(Q,sigma);

clear Q sigma
%p_in  = [0.5583 -0.7757 0.2942]';
%p_out = [0.6486  0.6657 0.369 ]';



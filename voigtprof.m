function VP = voigtprof(x,sigma,gamma,e)

    % Voigt profile
    % Levi Keller, Helsinki University February 2019
    % Utilizes routine voigtf from https://arxiv.org/pdf/1504.00322.pdf
    
    % sigma and gamma are gaussian and lorentzian FWHM
    % e is the mode
    
    sigma = sigma/(2*sqrt(2*log(2))); % function expects st. dev.
    s = sqrt(2)*sigma;
    gamma = gamma/(2*s); % function expects HWHM
    VP = voigtf((x-e)/s,gamma)/(s*sqrt(pi));

end
function S = experimental_spect(T)

if T== 300
    T300 = importdata("lefrancois_300K.asc");
    X  = T300(:,1)-0.004;
    Xy = T300(:,2);
    Xy = (Xy-300);
    Y  = Xy/Xy(68);
else
    T10 = importdata("lefrancois_10K.asc");
    T10(T10(:,2)>300,:) = [];
    X = T10(:,1)-0.005;
    Y10 = T10(:,2);
    Y10 = (Y10-min(Y10));
    Y = Y10/Y10(74);
end

S = {X,Y};
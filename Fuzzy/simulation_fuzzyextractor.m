function [ error ] = simulation_fuzzyextractor( BP_IPIs,BP_IPIs_all,ECG_IPIs,ECG_IPIs_all,longitudClave)
 

warning('off','all');

ECG_IPIs = transpose(ECG_IPIs);
ECG_IPIs = ECG_IPIs(:);
ECG_IPIs = vec2mat(ECG_IPIs,127);


BP_IPIs = transpose(BP_IPIs);
BP_IPIs = BP_IPIs(:);
BP_IPIs = vec2mat(BP_IPIs,127);

[m,~] = size(ECG_IPIs);
[n,~] = size(BP_IPIs);
if m > n
    min = n;
else
    min = m;
end

SP = length (ECG_IPIs)-2;

RRinternal = [];
RRexternal = [];
D =[]; 

for j=1:min
    
    if longitudClave==8
        n = 31;     %% BCH parameter
        k = 26;     %% BCH parameter
    elseif longitudClave==17
        n = 57;     %% BCH parameter
        k = 26;     %% BCH parameter
    else
        n = 127;    %% BCH parameter
        k = 50;     %% BCH parameter
    end
    
    nwords = 1; % Number of words 
    RN2=[];
     
    RN2 = gf(randi([0 1],nwords,n));
    X=RN2;  
    Xb=X.x; 

    ECGint = gf(ECG_IPIs(j,:));
    
    Rg= ECGint+RN2;
    Rgb = Rg.x; 

    RN1 = gf(randi([0 1],1,k));
    aux = bchenc(RN1,n,k);

    S= ECGint + aux ;
    Sb=S.x; 

    ECGext =gf(BP_IPIs(j,:));

    paux = S + ECGext; 

    paux2 = bchdec(paux,n,k); 

    paux3 = bchenc(paux2,n,k); 

    paux4 = S + paux3; 

    Rr = paux4 + X; 
    Rrb= Rr.x; 

    %%% Distance generation vs reproduction 
    
    D(j) = diag(pdist2(Rgb,Rrb,'hamming'))'*size(Rgb,2); 
    RRinternal(j,:) = Rgb; 
    RRexternal(j,:) = Rrb; 
end

error = sum(D)/length(D);

end


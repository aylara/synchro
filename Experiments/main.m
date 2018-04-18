function [errorfuzzy, errorautomatafuzzy, npicos_antes_bp, npicos_antes_ecg, npicos_despues, globalerror, globalerrorMensaje, tiempo] = main( bbdd, file, name, frecuencia, longitudClave )
record_ECG = 'val(1,:)';
record_BP = 'val(2,:)';
load(char(file)); 
globalerror = 'false';
globalerrorMensaje = '';
tiempo = 0;

fs = frecuencia;
BP = eval(record_BP);
ECG = eval(record_ECG);

BP_sort = BP;
ECG_sort = ECG;

npicos_antes_bp = 0;
npicos_antes_ecg = 0;
npicos_despues = 0;

[pPeak,IPI_raw,IPI_sc,IPI_nor,picosECG] = getECGData(ECG_sort,fs); 
[pPeak2,BP_raw,BP_sc,BP_nor,picosBP] = getECGData(BP_sort,fs);

if nnz(ECG_sort) ~= 0 && nnz(BP_sort) ~= 0
    
    [BP_nor2,IPI_nor2,tiempo] = simulation_automata(BP_raw,IPI_raw,fs,longitudClave);

    npicos_antes_bp = length(BP_raw);
    npicos_antes_ecg = length(IPI_raw);
    npicos_despues = length(BP_nor2);

    BP_IPIs = [];
    BP_IPIs_all = [];
    ECG_IPIs = [];
    ECG_IPIs_all = [];
    nElementos = length(BP_nor2);
    if nElementos>0
        [BP_IPIs,BP_IPIs_all] = getIPIsSignal(BP_nor2);
        [ECG_IPIs,ECG_IPIs_all] = getIPIsSignal(IPI_nor2);
    end

    [BP_IPIs_old,BP_IPIs_all_old] = getIPIsSignal(BP_nor);
    [ECG_IPIs_old,ECG_IPIs_all_old] = getIPIsSignal(IPI_nor);

    errorfuzzy = simulation_fuzzyextractor( BP_IPIs_old,BP_IPIs_all_old,ECG_IPIs_old,ECG_IPIs_all_old,longitudClave);
    if (length(BP_IPIs)< longitudClave)
        errorautomatafuzzy = 0;
        globalerror = 'true';
        globalerrorMensaje = char(strcat('Number of peaks is less than ',int2str(longitudClave),' bits'));
    else
        errorautomatafuzzy = simulation_fuzzyextractor( BP_IPIs,BP_IPIs_all,ECG_IPIs,ECG_IPIs_all,longitudClave);
    end

else
  errorfuzzy = 0;
  errorautomatafuzzy = 0;
  globalerror = 'true';
  globalerrorMensaje = 'ECG or BP == 0';   


end


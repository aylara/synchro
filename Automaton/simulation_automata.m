function [BP_nor,IPI_nor,tiempo] = simulation_automata(BP_raw,IPI_raw,fs, longitudClave)

time_BP = BP_raw/fs;
time_ECG = IPI_raw/fs;

[ts,tc,tm] = simulation_getTimeLimitSignal(time_BP,time_ECG,128,fs);

[keyBP,keyIPI,success,tiempo] = simulation_stateMachineRun2(BP_raw,time_BP,IPI_raw,time_ECG,ts,tc,tm, longitudClave);
 IPI_sc= keyIPI/fs; 
 IPI_nor = IPI_sc/max(IPI_sc);
 
 BP_sc= keyBP/fs; 
 BP_nor = BP_sc/max(BP_sc);
end


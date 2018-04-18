function [keyBP,keyECG,success,tiempo] = simulation_stateMachineRun2(BP_IPIs,time_BP,ECG_IPIs,time_ECG,ts,tc,tm, longitudClave)
    state = 0;
    c1=0;
    c2=0;
    c3=0;
    keyBP = [];
    keyECG = [];

    BP_size_t = length(BP_IPIs);
    IPI_size_t = length(ECG_IPIs);
    min_t = BP_size_t;
    if BP_size_t>IPI_size_t
        min_t = IPI_size_t;
    end
    
    BP_IPIs = BP_IPIs(1:min_t);
    ECG_IPIs = ECG_IPIs(1:min_t);
    removePeak = [];
    signal = 0;
    while (state~=4)
        [state,keyBP,keyECG,removePeak,c1,c2,c3,signal] = simulation_statemachine(signal,state,ts,tc,tm,c1,c2,c3,BP_IPIs,ECG_IPIs,time_BP,time_ECG,keyBP,keyECG,removePeak,longitudClave);
    end
    tiempo=c1;
    success = true;
    
    
end



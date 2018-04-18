function [state,keyBP,keyECG,removePeak,c1,c2,c3,signal] = simulation_statemachine(signal,state,ts,tc,tm,c1,c2,c3,peak_BP,peak_ECG,time_BP,time_ECG,keyBP,keyECG,removePeak,longitudClave)
%E=0
if state==0
    signal = signal + 1;

    if time_BP(signal:signal)<time_ECG(signal:signal)
        [c1,c2,c3] = simulation_getRealTime(signal,time_BP,time_ECG);
        state = 1;
    elseif time_ECG(signal:signal)<=time_BP(signal:signal)
        [c1,c2,c3] = simulation_getRealTime(signal,time_ECG,time_BP);
        state = 2;
    end
    if c3>tc
        state = 0;
        removePeak = [removePeak;signal];
    end
    if c1>=ts
        state = 4;
    end
    if c3<=tc && c1<=ts
        c2 = 0;
        c3 = 0;
    end
%E1        
elseif state==1
    if time_BP(signal:signal)<time_ECG(signal:signal) 
        [c1,c2,c3] = simulation_getRealTime(signal,time_ECG,time_BP);
    end
    if c1>=ts
        state=4;
    elseif c2>tm
        state = 0;
        removePeak = [removePeak;signal];
    elseif c2<=tm
        state = 3;
        keyECG = [keyECG;peak_ECG(:,signal)];
        keyBP = [keyBP;peak_BP(:,signal)];
        if length(keyECG)==longitudClave && length(keyBP)==longitudClave
            state = 4;
        end
    end
% E2:
elseif state==2
    if time_ECG(signal:signal)<=time_BP(signal:signal)
        [c1,c2,c3] = simulation_getRealTime(signal,time_BP,time_ECG);
    end
    if c2>=ts
        state = 4;
    elseif c2>tm
        state = 0;
    elseif c2<=tm
        state = 3;
        keyECG = [keyECG;peak_ECG(:,signal)];
        keyBP = [keyBP;peak_BP(:,signal)];
        if length(keyECG)==longitudClave && length(keyBP)==longitudClave
            state = 4;
        end
    end
   % E3:
elseif state==3
    if c1>=ts
        state = 4;
    elseif c1<ts
        c3 = 0;
        state = 0;
    end
% E4:
elseif state==4
end


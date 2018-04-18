function [ts,tc,tm] = simulation_getTimeLimitSignal(BP_raw,IPI_sc,nbits,fs)
%   Tm: Acceptable diff between two matching peaks  
%   Tc: Acceptable time between two consecutives peaks
%   Ts: Max time fo sampling

    BP_size_t = length(BP_raw);
    IPI_size_t = length(IPI_sc);
    min_t = BP_size_t;
    if BP_size_t>IPI_size_t
        min_t = IPI_size_t;
    end
    
    IPI_Tc = max(IPI_sc);
    BP_Tc = max(BP_raw);
    tm = 1/fs;
    tc = max([BP_Tc,IPI_Tc]);
    disp(mean(IPI_Tc))
    ts = min_t-1;
end


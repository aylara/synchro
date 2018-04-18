function [pPeak,IPI_raw,IPI_sc,IPI_nor, qrs_i_raw] = getECGData(ECG_sort,fs)
    [qrs_amp_raw,qrs_i_raw,delay]=pan_tompkin(ECG_sort,fs,0);
    IPI_raw = diff(qrs_i_raw);    
    pPeak = qrs_i_raw/fs;
    IPI_sc= IPI_raw/fs; 
    IPI_nor = IPI_sc/max(IPI_sc);
end
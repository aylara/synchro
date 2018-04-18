function [ S1,S2 ] = getIPIsSignal(IPI_nor)
nb=8; 
IPI = IPI_nor - mean(IPI_nor) ; 
IPI = normcdf(IPI,0,std(IPI)); 
   
IPI = IPI*(2^nb) ; 
IPI (IPI==2^nb ) = 2^nb - 1; 
IPI = round(IPI) ; 
 
IPI_gray = dec2gc(IPI,nb);
S2 = IPI_gray;

IPI4 = IPI_gray(:,5:8); 
S1 = IPI4;

end


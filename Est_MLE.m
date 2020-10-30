function N11_est = Est_MLE(n11,n12,n21,n22,M1,M2,N,iter)

samples = n11 + n12 + n21 + n22;

x = (n11/samples)*N;
E(iter) = 0;
E(1) = x;

for i = 2:iter
    
    temp = x;
    gx = (n11/x) - (n12/(M1-x)) - (n21/(M2-x)) + (n22/(N-M1-M2+x));
    dgx = -(n11/(x^2)) - (n12/((M1-x)^2)) - (n21/((M2 - x)^2)) - (n22/((N-M1-M2+x)^2));
    x = x - (gx/dgx);
    E(i) = x;
end

N11_est = E;

end

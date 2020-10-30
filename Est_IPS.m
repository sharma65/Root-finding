function N11_est = Est_IPS( n11,n12,n21,n22,M1,M2,N,iter )

E11 = (M1*n11)/(n11+n12);
E12 = M1 - E11;
E21 = (N-M1)*n21/(n21+n22);
E22 = (N-M1)*n22/(n21+n22);

scalCol = M2/(E11+E21);
E11 = E11*scalCol;
E21 = E21*scalCol;
scalCol = (N-M2)/(E12+E22);
E12 = E12 * scalCol;
E22 = E22 * scalCol;

E(iter) = 0;
E(1) = E11;

for i = 2 : iter
    
    scalRow = M1/(E11+E12);
    E11 = E11*scalRow;
    E12 = E12*scalRow;
    scalRow = (N-M1)/(E21+E22);
    E21 = E21*scalRow;
    E22 = E22*scalRow;

    scalCol = M2/(E11+E21);
    E11 = E11*scalCol;
    E21 = E21*scalCol;
    scalCol = (N-M2)/(E12+E22);
    E12 = E12 * scalCol;
    E22 = E22 * scalCol;
    E(i) = E11;
    
end

N11_est = E;

end


function TestMultinomialSampling(Word1, Word2)
N = 2^16; W1 = zeros(N,1); W2 = zeros(N,1);
data = feval('load',[ Word1]); W1(data(:,2))=1;
data = feval('load',[ Word2]); W2(data(:,2))=1;
K = [10 20 30 50 80 100 150 200 300 400 500 600 800 1000];
for m = 1:10^3
    ind = randsample(N,max(K));
    S1 = W1(ind); S2 = W2(ind);
    
    for i = 1:length(K)
        s1 = S1(1:K(i));
        s2 = S2(1:K(i));
        n11 = sum (s1 == 1 & s2 == 1);
        n12 = sum (s1 == 1 & s2 == 0);
        n21 = sum (s1 == 0 & s2 == 1);
        n22 = sum (s1 == 0 & s2 == 0);
        n11 = n11+0.1;n12 = n12+0.1;
        n21 = n21+0.1;n22 = n22+0.1;
        n = n11+n12+n21+n22;
        M1 = sum(W1); M2 = sum(W2);
        ips = Est_IPS(n11,n12,n21,n22,M1,M2,N,20);
        IPS(m,i) = ips(end);
        MLE(m,i) = (M1*(2*n11 + n21) + M2*(2*n11 + n12) - sqrt(M1*(2*n11+ + n21) - M2*(2*n11 + n12)^2 + 4*M1*M2*n12*n21))/(2*(2*n11+n12+n21));
        MF(m,i) = (n11/n)*N;
    end
    
end
N11 = sum(W1.*W2);
IPS_mse = mean( (IPS - N11).^2);
MLE_mse = mean ((MLE - N11).^2);
MF_mse = mean((MF-N11).^2);
TH_mse(length(K)) = 0;
TH_mse = (N./K)/((1/N11) + (1/(M1-N11)) + (1/(M2-N11)) + (1/(N-M1-M2+N11)));
    
figure;
loglog(K, IPS_mse,'r-o','linewidth',2); hold on; grid on;
loglog(K, MLE_mse,'k','linewidth',2); hold on; grid on;
loglog(K, MF_mse,'b--','linewidth',2); hold on; grid on;
loglog(K, TH_mse,'g--','linewidth',2); 

set(gca,'FontSize',20,'YMinorGrid','off');
xlabel('Sample size');
ylabel('MSE');
text(20,2*10^4,[Word1 '--' Word2],'Color','r','FontWeight','Bold','FontSize',20);
legend('IPS', 'MLE', 'MF', 'Theoretical');
end
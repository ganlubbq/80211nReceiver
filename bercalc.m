%% Analisi delle prestazioni: BER e EVM

close all
clear all
clc

global cor;
global in1;
global in2;
global out1;
global out2;

SNRlist = 0:5:30;
correlazioni = [0 0.8];
Tsim = 2.076*100;


h = waitbar(0,'Status');

k = 1;
for j = 1:length(correlazioni),
    cor = correlazioni(j);
    for i = 1:length(SNRlist),
        count = 1;
        SNR = SNRlist(i);
        sim('ieee_80211n');
        BERlist(j,i) = prestaz(1);
        Clist(j,i) = (prestaz(3)-prestaz(2))/Tsim;
        waitbar(k/(length(SNRlist)*length(correlazioni)),h);
        I1 = reshape(in1,52,(length(in1)/52));
        I2 = reshape(in2,52,(length(in1)/52));
        O1 = reshape(out1,52,(length(out1)/52));
        O2 = reshape(out2,52,(length(out2)/52));
        for q = 1:size(I1,1),
            nume = mean((abs(I1(q,:)-O1(q,:))).^2);
            deno = mean((abs(I1(q,:))).^2);
            evm1(q) = sqrt((nume)/(deno));
            nume2 = mean((abs(I2(q,:)-O2(q,:))).^2);
            deno2 = mean((abs(I2(q,:))).^2);
            evm2(q) = sqrt((nume2)/(deno2));
        end
        EVM1 = mean(evm1);
        EVM2 = mean(evm2);
        EVM(j,i) = (EVM1 + EVM2)/2;     
        k = k+1;
    end
end

% Plot risultati
figure,hold on
title('MIMO 2x2 SYSTEM - BER CURVE');xlabel('SNR');ylabel('BER');
semilogy(SNRlist,BERlist(1,:),'b*-','MarkerSize',5),
semilogy(SNRlist,BERlist(2,:),'r*-','MarkerSize',5),
legend('\rho^{TX}=\rho^{RX}=0','\rho^{TX}=\rho^{RX}=0.8');
xlabel('SNR [dB]'); ylabel('BER');
grid on

figure,hold on
title('MIMO 2x2 SYSTEM - EVM CURVE nuovo');xlabel('SNR');ylabel('EVM');
plot(SNRlist,EVM(1,:),'b*-','MarkerSize',5),
plot(SNRlist,EVM(2,:),'r*-','MarkerSize',5),
legend('\rho^{TX}=\rho^{RX}=0','\rho^{TX}=\rho^{RX}=0.8');
xlabel('SNR [dB]'); ylabel('EVM');
grid on

figure,hold on
title('EVM vs SNR'),
plot(SNRlist,10*log10(EVM(1,:)),'b*-','MarkerSize',5)
plot(SNRlist,10*log10(EVM(2,:)),'r*-','MarkerSize',5)
legend('\rho^{TX}=\rho^{RX}=0','\rho^{TX}=\rho^{RX}=0.8');
xlabel('SNR [dB]'); ylabel('EVM [dB]');
grid on

figure,hold on
title('BER vs EVM');xlabel('EVM');ylabel('BER');
semilogy(flipud(EVM(1,:)),BERlist(1,:),'b*-','MarkerSize',5),
semilogy(flipud(EVM(2,:)),BERlist(2,:),'r*-','MarkerSize',5),
legend('\rho^{TX}=\rho^{RX}=0','\rho^{TX}=\rho^{RX}=0.8');
xlabel('EVM'); ylabel('BER')
grid on

figure,hold on
title('C vs SNR');ylabel('C');xlabel('SNR [dB]');
plot(SNRlist,Clist(1,:),'b*-','MarkerSize',5),
plot(SNRlist,Clist(2,:),'r*-','MarkerSize',5),
legend('\rho^{TX}=\rho^{RX}=0','\rho^{TX}=\rho^{RX}=0.8');
xlabel('SNR [dB]'); ylabel('C [bit/s]')
grid on
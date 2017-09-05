%% Costruzione matrice di canale MIMO

function [H0]=chan(Nt,Nr,sigmaw2,corrTX,corrRX)

C1=(sigmaw2/2)*eye(Nt*Nr*2);
realiz=chol(C1)*randn(2*Nt*Nr,1); 
for i=1:(Nt*Nr)
    w(:,i)=[realiz((i-1)*2+1);realiz(i*2)]; 
end

n=(w(1,:)+1i*w(2,:))';  

Rtx=corrTX*ones(Nt); %correlazione spaziale delle antenne in tx
    for jj=1:Nt
        Rtx(jj,jj)=1;
    end
Rrx=corrRX*ones(Nr); %correlazione spaziale delle antenne in rx
    for jj=1:Nr
        Rrx(jj,jj)=1;
    end

C=chol(kron(Rtx,Rrx));

Hv=C*n;

H0=reshape(Hv,Nt,Nr); %matrice di canale MIMO con ipotesi di flat fading

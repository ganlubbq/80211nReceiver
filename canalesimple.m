%% Modello di canale MIMO e filtraggio segnali trasmessi

function  rx = canalesimple(tx)

global cor;

Nt = 2;
Nr = 2;

%Creazione matrice di Canale MIMO
H = chan(Nt,Nr,1,cor,cor); 

% Creazione segnale ricevuto
rx = zeros(size(tx,1),Nr);
blocco=66;

for k=1:2
    for i=1:Nr
        for j=1:Nt
            rx((i-1)*blocco+1:i*blocco,k)=rx((i-1)*blocco+1:i*blocco,k)+H(i,j)*tx((k-1)*blocco+1:k*blocco,j);
        end
    end
end

end

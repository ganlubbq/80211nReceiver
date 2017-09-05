%% Ricombinazione Alamouti
%Ipotesi: canale noto al ricevitore

function rx2 = rxcombiner(rx)

Nt = 2;
Nr = 2;
h = rx(end-1:end,:);  
rx(end-1:end,:) = []; 
H = [h;conj(h(1,2)) -conj(h(1,1)); 
    conj(h(2,2))    -conj(h(2,1))];  
blocco = 66;
r=[rx(:,1); conj(rx(:,2))];

rx2= zeros(blocco*Nt,1);

for i = 1:blocco,
    d = r(i:blocco:3*blocco+i); 
    temp=pinv(H)*d;
    rx2(i,1)=temp(1);
    rx2(blocco+i,1)=temp(2);
end

end
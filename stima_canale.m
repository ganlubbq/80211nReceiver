function h = stima_canale(sig)

rx1 = sig(:,1);
rx2 = sig(:,2);
train = sig(:,3);
blocco = 66;
h_ = zeros(4,1);

for i=1:66
    S = [train(i)+eps               train(blocco+i)+eps                    zeros(1,2);...
        zeros(1,2)                  train(i)+eps                           train(blocco+i)+eps;...
        -conj(train(blocco+i))+eps  conj(train(i))+eps                     zeros(1,2);...
        zeros(1,2)                  -conj(train(blocco+i))+eps             conj(train(i))+eps];         
    temp = pinv(S)*[rx1(i)+eps;rx1(i+blocco)+eps;rx2(i)+eps;rx2(i+blocco)+eps];
    h_=h_+temp;
end

h_=h_/blocco;

h = [h_(1:2).' 0;h_(3:4).' 0];
end
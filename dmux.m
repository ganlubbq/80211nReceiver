%% Stream Deparser

function stream = dmux(in) 

i1 = in(:,1);
i2 = in(:,2);
k = 1:4:208;
blocco = 8;

for i = 1:length(k)
    stream((i-1)*blocco+1:i*blocco) = [i1(k(i):k(i)+3);i2(k(i):k(i)+3)];
end

stream = stream';

end
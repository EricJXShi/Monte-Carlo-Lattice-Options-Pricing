clc, clear, format short
%% Define Parameters
r = 0.02;       % Risk-free Rate
S0 = 100;       % Current underlying stock price
sigma = 0.25;   % Volatility
K = 105;        % Strike price
T = 2/12;       % Maturity
M = 1/52;       % Lattice Unit Time
m = 10;        % sample size

%% Calculate for the American Put
                         
u = exp(sigma*sqrt(M));             % Upper price
d = 1/u;                            % Lower price
p = (exp(r*M)-d)/(u-d);             % Probability of price increase
x = exp(r*M);
y = (x-d)/(u-d);
z = 1-y;

l_price = zeros(m);
l_put = zeros(m);

for i = 1:1:m
    if i == m
        for j = 1:1:m
            price1 = S0*(d^j)*(u^(i-j));
            l_price(j,i) = price1;
            if K>price1
                l_put(j,i) = K-price1;
            else
                l_put(j,i) = 0;

            end
        end
    
    elseif i ~= 1
        for j = 1:1:m
            price1 = S0*(d^j)*(u^(i-j));
            l_price(j,i) = price1;
            if K>price1
                put1 = K-price1;
            else
                put1 = 0;
            end
            put2 = (1/x)*(y*l_put(j,i+1)+z*l_put(j+1,i+1));
            l_put(j,i) = max(put1, put2);
        end
    
    else
        put3 = (1/x)*(y*l_put(j,i+1)+z*l_put(j+1,i+1));
        l_put(i, 1) = put3;
    end
    
end
l_price
l_put
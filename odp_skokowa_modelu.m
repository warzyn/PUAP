function ym = odp_skokowa_modelu(x,t)
    
    T = x(1);
    L = x(2);
    
    %step response
    ym = (1-exp(-(t-L)/T)).*heaviside(t-L);
        
end
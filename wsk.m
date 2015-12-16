function J = wsk(x,t,y)
    
    ym = odp_skokowa_modelu(x,t);
    J = y-ym; 
    J = sum(J.^2);
    
end
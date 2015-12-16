function a = find_a(x1,x2,y1,y2)

    syms x
    y = (y2-y1)/(x2-x1)*(x-x1)+y1;
    a = abs(subs(y,x,0));
    
end
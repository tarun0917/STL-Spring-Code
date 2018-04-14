% defining the parameters
r1 = .25;
r2 = .25;
period_length = 1;
n = 6;
count=1;
u_space=50;
v_space=50;

u=linspace(0, 2 * n * pi, u_space);
v=linspace(0, 2 * pi, v_space);

for i=1:v_space
    for j=1:u_space
        x(count) = (1 - r1 * cos(v(i))) * cos(u(j));
        y(count) = (1 - r1 * cos(v(i))) * sin(u(j));
        z(count) = r2 * (sin(v(i)) + period_length * u(j) / pi);
        count=count+1;
    end 
end
     
plot3(x,y,z);

du=(2*pi)/(u_space-1);
dv=(2*n*pi)/(v_space-1);
final=fopen('Sample12.stl','wt');
for j=1:u_space
    for i=1:v_space
        a(1) = (1 - r1 * cos(v(i))) * cos(u(j));
        b(1) = (1 - r1 * cos(v(i))) * sin(u(j));
        c(1) = r2 * (sin(v(i)) + period_length * u(j) / pi); 
        
        a(2) = (1 - r1 * cos(v(i))) * cos(u(j)+du);
        b(2) = (1 - r1 * cos(v(i))) * sin(u(j)+du);
        c(2) = r2 * (sin(v(i)) + period_length * (u(j)+du) / pi); 
        
        a(3) = (1 - r1 * cos(v(i)+dv)) * cos(u(j)+du);
        b(3) = (1 - r1 * cos(v(i)+dv)) * sin(u(j)+du);
        c(3) = r2 * (sin(v(i)+dv) + period_length * (u(j)+du) / pi); 
        
        d1 = [ a(2)-a(1) ; b(2)-b(1) ; c(2)-c(1) ];
        e1 = [ a(3)-a(1) ; b(3)-b(1) ; c(3)-c(1) ];
        n1 = [ d1(2)*e1(3)-d1(3)*e1(2) ;d1(3)*e1(1)-d1(1)*e1(3) ;d1(1)*e1(2)-d1(2)*e1(1) ];

        a(4) = (1 - r1 * cos(v(i))) * cos(u(j));
        b(4) = (1 - r1 * cos(v(i))) * sin(u(j));
        c(4) = r2 * (sin(v(i)) + period_length * u(j) / pi); 
        
        a(5) = (1 - r1 * cos(v(i)+dv)) * cos(u(j));
        b(5) = (1 - r1 * cos(v(i)+dv)) * sin(u(j));
        c(5) = r2 * (sin(v(i)+dv) + period_length * (u(j)) / pi); 
        
        a(6) = (1 - r1 * cos(v(i)+dv)) * cos(u(j)+du);
        b(6) = (1 - r1 * cos(v(i)+dv)) * sin(u(j)+du);
        c(6) = r2 * (sin(v(i)+dv) + period_length * (u(j)+du) / pi); 
        
        d2 = [ a(2)-a(1) ; b(2)-b(1) ; c(2)-c(1) ];
        e2 = [ a(3)-a(1) ; b(3)-b(1) ; c(3)-c(1) ];
        n2 = [ d2(2)*e2(3)-d2(3)*e2(2) ;d2(3)*e2(1)-d2(1)*e2(3) ;d2(1)*e2(2)-d2(2)*e2(1) ];
        
        formatSpec= 'facet normal %f %f %f\n  outerloop\n   vertex %f %f %f\n   vertex %f %f %f\n   vertex %f %f %f\n  endloop\n endfacet\n facet normal %f %f %f\n  outerloop\n   vertex %f %f %f\n   vertex %f %f %f\n   vertex %f %f %f\n  endloop\n endfacet\n';
        fprintf(final,formatSpec,n1(1),n1(2),n1(3),a(1),b(1),c(1),a(2),b(2),c(2),a(3),b(3),c(3),n2(1),n2(2),n2(3),a(4),b(4),c(4),a(5),b(5),c(5),a(6),b(6),c(6));
        end
end
fclose(final);
        

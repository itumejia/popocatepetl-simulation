%Proyecto Final: Simulaci�n de una erupci�n volc�nica en 2D

%Equipo 1
%Integrantes:
%Evelin Michelle Medel Jarillas
%Mitzy Selene Baltazar Hern�ndez
%Ituriel Mej�a Garita
%Jhonatan Yael Mart�nez Vargas
%Brenda Anett Le�n Cano
%Martin Hern�ndez Rivas


%-------------LADERA-------------------------------------------------------
%La ladera la graficamos a partir de 3 funciones. Capturamos datos de
%elevaci�n de Google Earth. Transcribimos estos datos a Excel y dividimos
%los datos en 3: cr�ter, curva de la ladera y falda del volc�n. A partir de
%esto sacamos l�neas de tendencia para poder graficar las 3 funciones de la
%ladera en Matlab

X=-450:25:250;
Y=(0.0008*(X.^2))+(0.0778*X)+4950;
plot(X,Y,'r');
hold on


X3=250.1:250:7000.1;
Y3=(0.00003*(X3.^2))-(0.4205*X3)+5111.2;
plot(X3,Y3,'r');
hold on


X2=7000:250:9000;
Y2=3640+X2*0;
plot(X2,Y2,'r');
hold on

title('Popocat�petl'), axis([0 inf 3600 6800]),xlabel('Distancia al cr�ter (metros)'),ylabel('Altura sobre el nivel del mar (metros)');

%------------PROYECTIL-----------------------------------------------------
%Primero le pedimos los datos al usuario. Como los datos deben tener un
%rango espec�fico, si el usuario no pone un dato en este rango se lo
%seguir� pidiendo hasta que lo escriba correctamente
fprintf('EL siguiente programa simular� como el volc�n Popocat�petl expulsa\npiroclastos con un radio de 0.4 metros y una masa de 90 kilogramos, \ntomando la ladera norte del volc�n')
na=0;
while na == 0
    ang=(input('\nDetermina el �ngulo (entre 41 y 48 grados): '));
    if 41<=ang && ang<=48
        break
    else
        fprintf('Intente de nuevo\n')
    end
end
while na == 0
    vi=(input('Determina la velocidad inicial (entre 110 y 250 m/s): '));
    if 110<=vi && vi<=250
        break
    else
        fprintf('Intente de nuevo\n')
    end
end
while na == 0
    b=(input('Determina el valor de resistencia al aire (entre 0.0000037 y 0.0000044): '));
    if 0.0000037<=b && b<=0.0000044
        break
    else
        fprintf('Intente de nuevo\n')
    end
end
h=4950;
e=2.71828;
viy=vi*sind(ang);
vix=vi*cosd(ang);
hl=0;
%Ya que tenemos todas las variables necesarias, empezamos a graficar la
%trayectoria del proyectil. Utilizamos un 'for' que graficara la posici�n
%del volc�n cada 0.5 segundos, considerando resistencia al aire
for i=0:0.5:100
    y2=(((1/b)*((9.8/b)+viy)*(1-e^(-b*i)))-((9.8/b)*i))+h;
    x2=(vix/b)*(1-(e^(-b*i)));
    vx=vix*(e^(-b*i));
    vy=(e^(-b*i))*((9.8/b)+viy)-(9.8/b);
    vel=sqrt(vx^2+vy^2);
    %Antes de graficar cada punto, se utiliar�n los siguientes 'if's para
    %saber la altura de la ladera en ese punto y verificar que la posici�n
    %del proyectil este arriba de la ladera
    if (250<=x2) && (x2<7000)
        hl=(0.00003*(x2.^2))-(0.4205*x2)+5111.2;
    end
    if 7000<=x2
        hl=3640;
    end
    if y2<=hl
        time = i;
        xfin = x2;
        yfin = y2;
        vfin = vel;
        break
    end
    hold on
    %Tambi�n se estar� mostrando continuamente la posici�n y la velocidad
    %en cada instante de la trayectoria con lo siguiente:
    str = ['Posici�n: (',num2str(x2),'m,',num2str(y2),'m)'];
    t= text(4600,6500,str);
    str2 = ['Velocidad instant�nea: ',num2str(vel),'m/s'];
    t2= text(4600,6300,str2);
    pause(0.5);
    figure(1),plot(x2,y2,'or');
    delete(t);
    delete(t2);
end

%Esto �ltimo mostrar� cuadros de texto con los par�metros iniciales y los
%valores finales de la trayectoria
dim2=[.25 .6 .3 .3];
str2= {'�ngulo (grados): ',num2str(ang),'Velocidad inicial(m/s): ',num2str(vi),'Coeficiente de resistencia al aire:',num2str(b)};
a2 = annotation('textbox',dim2,'String',str2,'FitBoxToText','on');

dimtiempo=[.67 .8 .5 .1];
strtiempo={'El tiempo fue',num2str(time),'segundos'};
atiempo = annotation('textbox',dimtiempo,'String',strtiempo,'FitBoxToText','on');

dimpos=[.67 .6 .9 .1];
strpos= {'Posici�n final x (m): ',num2str(xfin),'Posici�n final y (m): ',num2str(yfin)};
apos = annotation('textbox',dimpos,'String',strpos,'FitBoxToText','on');

dimvel=[.67 .4 .5 .1];
strvel={'Velocidad final(m/s): ',num2str(vfin)};
avel = annotation('textbox',dimvel,'String',strvel,'FitBoxToText','on');

% Sistemas de Control 1 
% Alumnos:
% Cabero, Mauro Ezequiel.
% López, Franco Gabriel.
% El siguiente script posee el modelado con el controlador implementado.
clc; clear; close all;

% --- PARÁMETROS FÍSICOS DE LA CÁMARA DE FRÍO ---
e = 0.1;               % [m] espesor aislante
k = 0.025;             % [W/m.K] conductividad térmica
A = 49;                % [m²] área superficial
R = e / (k * A);       % [K/W] resistencia térmica

rho = 1.2;             % [kg/m³] densidad del aire
V = 20;                % [m³] volumen de la cámara
cp = 1005;             % [J/kg.K] calor específico
C = rho * V * cp;      % [J/K] capacidad térmica

% --- SISTEMA DE TRANSFERENCIA (PLANTA) ---
s = tf('s');
G = 1 / (R*C*s + 1);   % Planta térmica

% --- TIEMPO DE ESTABLECIMIENTO DESEADO ---
Ts_deseado = 3600;                  % [s] tiempo de establecimiento (1 hora)
wn = 4 / Ts_deseado;                % Frecuencia natural no amortiguada
s1 = -wn;                           % Punto deseado en el eje real

fprintf("Frecuencia wn = %.7f rad/s\n", wn);
fprintf("Polo deseado en s = %.7f\n", s1);

% --- CÁLCULO DE Kp USANDO LA CONDICIÓN DE MÓDULO ---
Kp = abs(1 / evalfr(G, s1));       % |1/G(s1)|

fprintf("Ganancia Kp necesaria = %.5f\n", Kp);

% --- RESPUESTA DEL SISTEMA CON ESA Kp ---
G_cl = feedback(Kp * G, 1);

figure;
step(G_cl);
title('Respuesta al escalón con controlador proporcional');
ylabel('Temperatura [K]');
xlabel('Tiempo [s]');
grid on;

% --- LUGAR DE RAÍCES ---
figure;
rlocus(G); grid on;
hold on;
plot(real(s1), imag(s1), 'ro', 'MarkerSize', 10, 'LineWidth', 2);
title('Lugar de raíces con polo deseado');
legend('Lugar de raíces', 'Polo deseado');

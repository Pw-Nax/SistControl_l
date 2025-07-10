clc; clear; close all;

% --- PARTE 1: Parámetros físicos del sistema de frío ---
s = tf('s');

% Parámetros del aislamiento
e = 0.1;              % [m] espesor del aislante
k = 0.025;            % [W/m·K] conductividad térmica
A = 49;               % [m^2] superficie total de la cámara

R = e / (k * A);      % [K/W] Resistencia térmica (igual para °C/W)

% Parámetros del aire
rho = 1.2;            % [kg/m^3]
V = 20;               % [m^3] volumen de la cámara
cp = 1005;            % [J/kg·K]
C = rho * V * cp;     % [J/°C] capacidad térmica

tau = 1 / (R * C);

% Función de transferencia de la planta (sigue siendo válida)
G = minreal(R / (C * R * s + 1))   % Planta térmica

% --- Simulación en °C ---
T_ini = 25;           % °C
deltaT = -30;         % Cambio deseado (por ejemplo, bajar 30 °C)
T_set = T_ini + deltaT;

Gs_sensor = 0.01;
Gs_ampli = 100;
FdTLC = minreal(feedback(G, Gs_sensor*Gs_ampli))

% Simulación
t = linspace(0, 20000, 1000);
[y, t_out] = step(deltaT * FdTLC, t);  % Respuesta a escalón negativo
y = y + T_ini;                     % Ajuste para arrancar desde T_ini

figure;
plot(t_out, y, 'b', 'LineWidth', 1.5); hold on;
yline(T_ini, '--k', sprintf('Inicial (%d°C)', T_ini));
yline(T_set, '--r', sprintf('Setpoint (%d°C)', T_set));
xlabel('Tiempo [s]');
ylabel('Temperatura [°C]');
title('Respuesta en °C - Planta térmica sin controlador');
grid on;


figure(2);
step(30*FdTLC)
grid on;

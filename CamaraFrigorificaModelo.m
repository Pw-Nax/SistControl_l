clc; clear; close all;

%--- Sistema: Cámara frigorífica ---
s = tf('s');

% Parámetros físicos (cambiados desde el modelo teórico)
R = 0.0816;              % [°C/W]
C = 24120;               % [J/°C]
G_planta = 1/(C*R) / (s + 1/(C*R));   % Función de transferencia térmica

% Parámetros del sensor
Gs_sensor = 10;          % [mV/°C] -> suponemos linealidad
G_total = G_planta * Gs_sensor;

%--- Diseño del controlador PI ---
polo = pole(G_total);        % Extraer el polo dominante
Ti = -1 / polo;              % Tiempo de integración para cancelar el polo
PI = (s + 1/Ti) / s;

% Ganancia del controlador por condición de módulo
s1 = -0.002;                 % Punto deseado en el lugar de raíces
G_eval = evalfr(G_total * PI, s1);
Kp = 1 / abs(G_eval);

% Controlador completo
PI = Kp * PI;

%--- Sistema con PI ---
FdTLApi = PI * G_total;
FdTLCpi = minreal(feedback(FdTLApi, 1));    % Sistema a lazo cerrado

%--- Simulación ---
t = linspace(0, 2e4, 1000);         % Tiempo [s]
T_ini = 25;                         % Temperatura inicial [°C]
T_set = -5;                         % Setpoint deseado [°C]
deltaT = T_set - T_ini;

[y, t_out] = step(deltaT * FdTLCpi, t);
y = y + T_ini;                      % Ajustamos respuesta para que parta de T_ini

%--- Gráfico ---
figure;
plot(t_out, y, 'b', 'LineWidth', 1.5); hold on;
yline(T_ini, '--k', 'Inicial (25°C)', 'LabelHorizontalAlignment','left');
yline(T_set, '--r', 'Setpoint (-5°C)', 'LabelHorizontalAlignment','left');
xlabel('Tiempo [s]');
ylabel('Temperatura [°C]');
title('Respuesta del sistema con controlador PI');
grid on;

clc; clear; close all;

% --- PARÁMETROS FÍSICOS ---
e = 0.1;
k = 0.025;
A = 49;
R = e / (k * A);

rho = 1.2;
V = 20;
cp = 1005;
C = rho * V * cp;

s = tf('s');
G = 1 / (R*C*s + 1);

% --- Controlador PI ---
Kp = 1.8;
PI = Kp * (1 + 1/(s * 1820.5));

% --- Sistema cerrado ---
G_PI_CL = feedback(PI * G, 1)

% --- Escalón de -30 + offset inicial de 25 ---
delta_T = -30;   % cambio de temperatura deseado
T_ini = 25;      % temperatura inicial
[y, t_out] = step(delta_T * G_PI_CL);
y_total = y + T_ini;  % respuesta desde 25 hasta -5

% --- Graficar ---
figure;
plot(t_out, y_total, 'b', 'LineWidth', 1.5); hold on;
yline(-5, '--m', 'Setpoint (-5°C)', 'LabelHorizontalAlignment','left', 'LabelVerticalAlignment','bottom');
xlabel('Tiempo [s]');
ylabel('Temperatura [°C]');
title('Respuesta con PI - Enfriamiento desde 25°C a -5°C');
legend('Respuesta del sistema', 'Setpoint');
grid on;

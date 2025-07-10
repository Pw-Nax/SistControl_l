
---

## 🎯 Objetivos

- Modelar el comportamiento térmico de una cámara de frío como un sistema de primer orden.
- Diseñar un controlador PI que reduzca el error en estado estacionario y mejore el tiempo de respuesta.
- Validar el diseño mediante simulaciones en MATLAB y Simulink.
- Evaluar el desempeño del sistema con y sin control.

---

## ⚙️ Características del modelo

- **Planta:** Sistema de primer orden.
- **Controlador diseñado:** PI
- **Condición inicial:** temperatura de 25 °C
- **Salida esperada:** tiempo de establecimiento ≤ 3600 s, error estacionario ≈ 0 °C

---

## 🧪 Resultados

La simulación en Simulink muestra que:

- El controlador PI logra una respuesta monótona y sin sobrepasos.
- El error en estado estacionario es prácticamente nulo.
- El sistema responde de manera estable y eficiente ante un cambio brusco de consigna.


---

## 📦 Requisitos

- MATLAB R2025b o superior
- Simulink instalado

---

## 👨‍🔧 Autores

- Mauro E. Cabero.
- Franco G. López.
- FCEFyN – Universidad Nacional de Córdoba  
- Materia: Sistemas de Control I

---



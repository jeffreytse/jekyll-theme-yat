---
layout: post
title: CESE project plan
subtitle: Development of mobile robot for monocular SLAM
author: Gonzalo G. Fernandez
categories: plan
# banner:
#   video: https://vjs.zencdn.net/v/oceans.mp4
#   loop: true
#   volume: 0.8
#   start_at: 8.5
#   image: https://bit.ly/3xTmdUP
#   opacity: 0.618
#   background: "#000"
#   height: "100vh"
#   min_height: "38vh"
#   heading_style: "font-size: 4.25em; font-weight: bold; text-decoration: underline"
#   subheading_style: "color: gold"
tags: cese project-planning
top: 1
sidebar: []
---

*Esta planificación fue realizada en el curso de Gestión de proyectos entre el 25 de abril de 2023 y el 13 de junio de 2023*

## Descripción técnica conceptual del proyecto a realizar

La navegación autónoma ha sido un tema de investigación activo durante décadas, pero
recientemente ha ganado una atención sin precedentes gracias a los avances en tecnologı́as
como la inteligencia artificial y la robótica.

La navegación autónoma se refiere a la capacidad de un sistema para planificar y ejecutar sus
propias acciones de manera autónoma, sin la necesidad de una intervención humana constante.
La capacidad de un sistema para tomar decisiones en forma autónoma en su navegación a través
del entorno es crucial para una amplia variedad de aplicaciones, desde los vehı́culos autónomos y
los drones, hasta los robots industriales y los sistemas de logı́stica.

La investigación de técnicas de bajo costo es importante para permitir que la tecnologı́a sea
accesible para un mayor número de aplicaciones y usuarios. Esto es especialmente importante
en paı́ses en desarrollo o en áreas con recursos limitados, donde los sistemas de navegación
autónoma pueden ser prohibitivamente costosos.

La restricción económica en el desarrollo de nuevas técnicas también puede mejorar la eficiencia
y la efectividad de los sistemas de navegación autónoma, al permitir que los recursos sean
utilizados de manera más efectiva y maximizar la vida útil de los componentes del sistema.
La odometrı́a visual es una técnica de localización y navegación que se utiliza en robótica
para estimar la posición y orientación de un robot en su entorno, en función de la información
visual capturada por sus cámaras. La información de las imágenes capturadas permite estimar
la cantidad de movimiento y la dirección del vehı́culo, permitiendo calcular su posición y
orientación en relación con su posición inicial.

Las técnicas de odometrı́a visual son particularmente útiles en entornos donde el movimiento
del robot es predominantemente lateral. Además, se pueden utilizar en combinación con otras
técnicas de localización y navegación, como la odometrı́a inercial o la SLAM (Simultaneous
Localization and Mapping), para mejorar la precisión y la fiabilidad de la localización del robot.
La SLAM es una técnica de visión por computadora que permite a un robot móvil construir un
mapa del entorno en el que se encuentra, mientras estima en simultaneo su propia posición y
orientación en ese entorno. En el caso de SLAM monocular, se utiliza una única cámara para
capturar imágenes del entorno.

La Fundación Fulgor realiza diversas actividades de investigación. Dentro del campo de
navegación autónoma, una de las ramas de interés es la de algoritmos de SLAM monocular
en conjunto con la odometrı́a inercial, por las diferentes ventajas que presenta sobre otros
métodos. Es por esto que se han realizado experimentos en el marco de la Práctica Profesional
Supervisada de la estudiante de grado Evangelina Castellano, implementando y analizando el
desempeño de diferentes algoritmos en entornos de simulación.

Actualmente, uno de los objetivos en esta lı́nea de investigación es poder migrar los algoritmos estudiados en un entorno virtual a un sistema fı́sico, para evaluar su desempeño en un entorno real. La experimentación en entornos virtuales se llevó a cabo con el framework ROS 2 (Robot Operating System 2 ). Dada la naturaleza modular de este framework, la migración consiste en el reemplazo de un módulo encapsulado que contenga el algoritmo.

## Identificación y análisis de los interesados

| Rol | Nombre y Apellido | Organización | Puesto |
|-----|-------------------|--------------|--------|
| Cliente | Ing. Leandro Borgnino | Fundación Fulgor | Investigador |
| Responsable | Ing. Gonzalo Gabriel Fernandez | FIUBA | Estudiante |
| Orientador | Dr. Ing. Fabio Ardiani | Nimble One | Director de Trabajo Final |
| Equipo | Evangelina Castellano | Universidad Nacional de Córdoba | Pasante |
| Equipo | Fabio Gazzoni | Universidad Nacional de Córdoba | Pasante |
| Usuario final | Grupos de investigación | Fundación Fulgor | - |

- **Cliente:**

El Ing. Leandro Borgnino realizando su doctorado en la Fundación Fulgor y posee conocimiento sobre los algoritmos utilizados para navegación autónoma a alto nivel. Domina el área de aplicación y puede resolver dudas específicas sobre los requerimientos funcionales que debe cumplir el proyecto.

- **Orientador:**

El Dr. Ing. Fabio Ardiani finalizó en el año 2022 su doctorado en Mecatrónica, Robótica e Ingeniería de Automatización en Isae-Supaero, Toulouse, Francia. Actualmente se encuentra trabajando en Nimble One como investigador especialista en locomoción robótica. Se encuentra ubicado en Tolouse, Fracia. Se mantendrán reuniones una a uno cada dos semanas y reuniones con todo el equipo cuando se considere necesario y de acuerdo a su disposición. La periodicidad de las reuniones se ajustará segun lo demanden las actividades del proyecto y la disponibilidad del responsable y el orientador.

- **Equipo:**

Los estudiantes Evangelina Castellano y Fabio Gazzoni se encuentran realizando su Práctica Profesional Supervisada (PPS) en la Fundación Fulgor. Al finalizar su PPS continuarán en la institución para realizar su proyecto final de grado. Es necesario planificar teniendo en cuenta que la dedicación es simple, es decir, entre 4 y 5 horas diarias. Integrarán el equipo de trabajo junto con el responsable.

- **Usuario final:**

No esta representado por una persona particular. Una vez finalizado el proyecto el prototipo quedará disponible en la Fundación Fulgor para su uso de parte de grupos de investigación.

## Entregables principales del proyecto

Los entregables del proyecto son:
- Plataforma de hardware, es decir, un prototipo funcional del robot móvil. Esto incluye tanto electrónica como todos los componentes mecánicos para que el robot se desempeñe cumpliendo los requerimientos funcionales.
- Documentación del hardware e interconexión de los módulos componentes
- Código fuente del driver de la IMU
- Documentación del driver de la IMU
- Código fuente del driver de la cámara
- Docummentación del driver de la cámara
- Código fuente del firmware con el algoritmo de SLAM monocular y micro-ROS
- Código fuente del agente de ROS 2 utilizado
- Documentación y manual para configuración y uso del entorno de ROS 2
- Documentación del estado del arte de SLAM y del algoritmo seleccionado
- Manual de uso del hardware
- Informe final

## Desglose del trabajo en tareas

1. Planificación del proyecto (70 h)
    1. Identificación y contacto con los interesados (7 h)
    2. Definición del propósito y alcance del proyecto (10 h)
    3. Definición de los requerimientos y entregables (20 h)
    4. Desglose del trabajo en tareas y obtención del diagrama de Gantt (20 h)
    5. Análisis de riesgos, gestión de calidad y definición de procesos de cierre (13 h)
2. Definición técnica del robot móvil a diseñar
    1. Investigación del estado del arte de la robótica móvil
    2. Selección del tipo de robot móvil a desarrollar
    3. Descripción matemática del robot seleccionado
2. [Selección y documentación del hardware necesario]({% post_url 2023-12-30-hardware-selection %})
2. Diseño y fabricación del prototipo mecánico
    1. Diseño mecánico del chasis del prototipo de robot móvil mediante herramienta CAD.
    2. Adquisición de elementos mecánicos necesarios para la manufactura del prototipo como tornillos, tuercas, filamento plástico para impresión 3D y otros.
    3. Fabricación mediante impresión 3D.
    4. Montaje del prototipo mecánico y iteración para corregir errores de ser necesario.
2. Setup del entorno de trabajo para desarrollo del software necesario (5 h)
3. Implementación de micro-ROS en el sistema embebido (18 h)
    1. [Introducción a micro-ROS]({% post_url 2023-05-12-microROS-and-ROS-2 %}) (4 h)
    2. Incorporación de micro-ROS en el microcontrolador (8 h)
    3. Setup de agente de ROS 2 y comunicación con el sistema embebido (2 h)
    4. Documentación del proceso (4 h)
4. Desarrollo de driver para la IMU (40 h)
    1. Selección y adquisición de la IMU a utilizar (2 h)
    2. Implementación de driver en lenguaje C para el sistema embebido (30 h)
    3. Documentación del driver (8 h)
5. Integración de la IMU en el sistema (60 h)
    1. Integración del driver de la IMU con el sistema con micro-ROS (4 h)
    2. Repaso (e investigación) de técnicas de fusión sensorial (8 h)
    3. Implementación de algoritmos de fusión sensorial (30 h)
    4. Visualizacion de la información obtenida con la IMU mediante las herramientas de ROS 2 (10 h)
    5. Evaluación parcial y documentación de resultados (milestone) (8 h)
6. Desarrollo de driver para la cámara (53 h)
    1. Selección y adquisación de cámara a utilizar (3 h)
    2. Implementación de driver en lenguaje C para el sistema embebido (40 h)
    3. Documentación del driver (10 h)
7. Integración de la cámara en el sistema (26 h)
    1. Integración del driver de la cámara con el sistema con micro-ROS (6 h)
    2. Visualización de la información obtenida con la cámara mediante las herramientas de ROS 2 (12 h)
    3. Evaluación parcial y documentación de resultados (milestone) (8 h)
8. Implementación de algoritmo de SLAM monocular (305 h)
    1. Introducción a la navegación inercial y SLAM monocular, investigación de estado del arte (15 h)
    2. Investigación de algoritmos de SLAM monocular y selección de uno de ellos (30 h)
    3. Implementación del algoritmo seleccionado en un entorno de simulación (40 h)
    4. Optimización del algoritmo implementado en el entorno de simulación (40 h)
    5. Evaluación integral de los componentes del sistema (20 h)
    6. Implementación del algoritmo seleccionado en el sistema embebido (40 h)
    7. Optimización del algoritmo implementado en el sistema embebido (40 h)
    8. Evaluación final de resultados (milestone) (40 h)
    9. Documentación técnica del algoritmo sleccionado y resumen del estado del arte (40 h)
9. Proceso de cierre (91 h)
    1. Análisis de cumplimiento de objetivos y requerimientos con el director (2 h)
    2. Análisis de cumplimiento del plan original (diagrama de Gantt) (2 h)
    3. Análisis de cumplimiento de objetivos y requerimientos con el cliente (2 h)
    4. Capacitación del cliente sobre el prototipo realizado
    5. Elaboración de memoria técnica (40 h)
    6. Corrección de memoria técnica (20 h)
    7. Preparación de defensa pública (20 h)
    8. Defensa pública (2 h)
    9. Reunión de cierre con el director (1 h)
    10. Reunión de cierre con el cliente y el equipo de trabajo (2 h)

Cantidad total de horas: 668 h

## Diagrama de Activity On Node

Las tareas expuestas en el diagrama de *Activity On Node*, se encuentran detalladas en la siguiente tabla, con su código, duración y tareas predecesoras.

| Código | Predecesora | Descripción | Duración |
|--------|-------------|-------------|----------|
| 1 | | Planificación del proyecto | 70 h |


## Proceso de cierre

Una vez finalizado el proyecto se realizarán las siguientes actividades:

- Análisis del grado de cumplimiento de los objetivos y requerimientos junto con el Dr. Ing. Fabio Ardiani.
- Análisis de cumplimiento de la versión original del plan de trabajo, contrastando el registro de actividades realizadas con el diagrama de Gantt original.
- Análisis del grado de cumplimiento de los objetivos y requerimientos junto con el cliente, el Ing. Leandro Borgnino.
- Elaboración de un documento con todos los problemas que surgieron durante el desarrollo del proyecto y las soluciones encontradas.
- Elaboración de un documento con las actividades que no se alcanzaron a realizar en el tiempo estimado y todas aquellas actividades realizadas que no se contemplaron en el plan original.
- Elaboración de un documento con el trabajo a futuro, que sirva como base de un plan de proyecto que continue la misma línea de investigación y desarrollo.
- Defensa pública del proyecto por parte del responsable.
- Reunión privada con el equipo de trabajo para compartir *feedback* sobre la experiencia obtenida en el lapso del proyecto.
- Reunión virtual, organizada por el responsable, con el Dr. Ing. Fabio Ardiani como acto de agradecimiento.
- Reunión con el Ing. Leandro Borgnino y el equipo de trabajo, organizada por el responsable, para dar un cierre al proyecto y evaluar los próximos proyectos y actividades a realizar en conjunto.


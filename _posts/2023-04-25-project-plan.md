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
---

_Esta planificación fue realizada en el curso de Gestión de proyectos entre el 25 de abril de 2023 y el 13 de junio de 2023_

## Descripción técnica conceptual del proyecto a realizar #WIP

La Fundación Fulgor es una organización argentina que trabaja con la misión de generar oportunidades de desarrollo y formación en áreas estratégicas para el futuro de Argentina. Su búsqueda tiene como objetivo colaborar para que Argentina sea competitiva internacionalmente en áreas tecnológicas.

Las principales herramientas de la Fundación Fulgor para cumplir su misión son el vínculo con universidades e instituciones educativas y la generación de oportunidades de capacitación, por ejemplo, a través de becas de grado y posgrado en temas estratégicos como:

-   el procesamiento digital de señales
-   los sistemas de comunicación y protocolos de transporte de datos
-   el diseño e implementación de circuitos digitales en FPGA y circuitos integrados
-   el diseño e implementación de circuitos analógicos
-   la inteligencia artificial con aplicación en navegación autónoma y visión artificial
-   el procesamiento de señales de radar y lidar
-   la fusión sensorial y el control en vehículos aéreos y terrestres

La navegación autónoma se refiere a la capacidad de un sistema para planificar y ejecutar sus propias acciones de forma autónoma, sin la necesidad de una intervención humana constante. Esta capacidad es crucial en una gran variedad de aplicaciones, desde los vehı́culos autónomos para transporte de personas y los drones, hasta los robots industriales y los sistemas de logı́stica.

Dentro de los campos de la inteligencia artificial con aplicación en navegación autónoma, de la la fusión sensorial y del control de robots móviles, uno de los temas estudiados en Fundación Fulgor es la odometría visual-inercial (VIO por sus siglas en inglés) con algoritmos de SLAM (_Simultaneous Localization and Mapping_) monocular. Uno de los motivos por el cuál esta técnica es de interés, es su bajo costo económico en comparación con otros métodos donde los sensores son más complejos, inaccesibles y costosos.

La investigación de técnicas de bajo costo es importante para permitir que la tecnologı́a sea accesible a un mayor número de aplicaciones y usuarios. Esto es especialmente importante en paı́ses en desarrollo o en áreas con recursos limitados, donde los sistemas de navegación autónoma pueden ser prohibitivamente costosos. Además, la restricción económica en el desarrollo de nuevas técnicas también colabora en mejorar la eficiencia de los sistemas de navegación autónoma, al permitir que los recursos sean utilizados de manera más efectiva y maximizar la vida útil de los componentes del sistema.

La odometría visual-inercial es una técnica de localización y navegación utilizada en la robótica para estimar la posición y orientación del robot móvil, en base a la información visual capturada por una o más cámaras y la información inercial obtenida por una o más unidades de medición inercial (IMU por sus siglas en inglés).

Por su parte, la SLAM es una técnica de visión por computadora que permite a un robot móvil construir un mapa del entorno en el que se encuentra, mientras estima en simultaneo su propia posición y orientación en ese entorno. En el caso de SLAM monocular, se utiliza una única cámara para capturar imágenes del entorno.

En esta línea de investigación, un eqipo de trabajo de Fundación Fulgor ha realizado experiencias mediante simulación, donde se han implementado y evaluado el desempeño de diferentes algoritmos en entornos virtuales utilizando ROS 2 (_Robot Operating System 2_).

El entorno ROS es un framework de software libre y de código abierto diseñado para permitir el desarrollo de aplicaciones robóticas distribuidas. Este framework proporciona un conjunto de herramientas para la creación, gestión, depuración y análisis de sistemas robóticos.

Actualmente, uno de los objetivos del equipo de trabajo es migrar los algoritmos estudiados en un entorno virtual a un sistema fı́sico, para evaluar su desempeño en un entorno real. Es esta necesidad la que se propone resolver con el proyecto analizado en el presente documento.

Por lo tanto, el proyecto propone el desarrollo de un robot móvil terrestre que permita evaluar el funcionamiento de los algoritmos de SLAM monocular en un entorno real, aplicar optimizaciones especificas para el sistema embebido utilizado y ofrecer una herramienta a Fundación Fulgor escalable a otros grupos de investigación vinculados con la robótica.

Este tipo de plataformas robóticas móviles ya existen tanto de forma comercial con robots como _Spot_ de BostonDynamics, como en la comunidad _open source_ y _open hardware_ con robots como el TurtleBot de OpenRobotics. Su complejidad varía ampliamente, desde un punto de vista mecánico, de su electrónica, de sus sensores y actuadores y más. La planificación del proyecto contempla el diseño y selección de todos los aspectos que comprenden un robot móvil terrestre.

![Spot de BostonDynamics](/assets/images/spot-bostondynamics.jpg)

![TurtleBot 4 de OpenRobotics](/assets/images/turtlebot4.jpg)

## Identificación y análisis de los interesados

A continuación se detallan las personas e instituciones involucradas en el proyecto:

| Rol           | Nombre y Apellido              | Organización                    | Puesto                    |
| ------------- | ------------------------------ | ------------------------------- | ------------------------- |
| Cliente       | Ing. Leandro Borgnino          | Fundación Fulgor                | Investigador              |
| Responsable   | Ing. Gonzalo Gabriel Fernandez | FIUBA                           | Estudiante                |
| Orientador    | Dr. Ing. Fabio Ardiani         | Nimble One                      | Director de Trabajo Final |
| Equipo        | Evangelina Castellano          | Universidad Nacional de Córdoba | Pasante                   |
| Equipo        | Fabio Gazzoni                  | Universidad Nacional de Córdoba | Pasante                   |
| Usuario final | Grupos de investigación        | Fundación Fulgor                | -                         |

-   **Cliente:**

El Ing. Leandro Borgnino realizando su doctorado en la Fundación Fulgor y posee conocimiento sobre los algoritmos utilizados para navegación autónoma a alto nivel. Domina el área de aplicación y puede resolver dudas específicas sobre los requerimientos funcionales que debe cumplir el proyecto.

-   **Orientador:**

El Dr. Ing. Fabio Ardiani finalizó en el año 2022 su doctorado en Mecatrónica, Robótica e Ingeniería de Automatización en Isae-Supaero, Toulouse, Francia. Actualmente se encuentra trabajando en Nimble One como investigador especialista en locomoción robótica. Se encuentra ubicado en Tolouse, Fracia. Se mantendrán reuniones una a uno cada dos semanas y reuniones con todo el equipo cuando se considere necesario y de acuerdo a su disposición. La periodicidad de las reuniones se ajustará segun lo demanden las actividades del proyecto y la disponibilidad del responsable y el orientador.

-   **Equipo:**

Los estudiantes Evangelina Castellano y Fabio Gazzoni se encuentran realizando su Práctica Profesional Supervisada (PPS) en la Fundación Fulgor. Al finalizar su PPS continuarán en la institución para realizar su proyecto final de grado. Es necesario planificar teniendo en cuenta que la dedicación es simple, es decir, entre 4 y 5 horas diarias. Integrarán el equipo de trabajo junto con el responsable.

-   **Usuario final:**

No esta representado por una persona particular. Una vez finalizado el proyecto el prototipo quedará disponible en la Fundación Fulgor para su uso de parte de grupos de investigación.

## Propósito del proyecto

[//]: # "Project goal: provide a brief description of the business need that the project will address or the reason for starting it"

El prósito del proyecto es el desarrollo de un robot móvil terrestre que permita evaluar en un entorno real el funcionamiento de algoritmos de SLAM monocular previamente simulados en un entorno virtual. El sistema físico también permite estudiar optimizaciones del algoritmo orientadas específicamente al sistema embebido y la electrónica utilizada.

Además, el objetivo es brindar una herramienta a Fundación Fulgor escalable a otros grupos de investigación que trabajen sobre temáticas como:

-   el procesamiento digital de la información recibida a través de los sensores del robot
-   la optimización de algoritmos de navegación autónoma mediante el diseño e implementación de circuitos digitales en FPGA o SoCs.
-   la aplicación de inteligencia artificial para resolver problemas como la navegación autónoma y la visión artificial del robot
-   el estudio e implementación de técnicas modernas de fusión sensorial y control sobre el robot

Se propone finalizar el proyecto con un primer prototipo funcional del robot móvil terrestre, con la capacidad de ejecutar una demostración de un algoritmo de SLAM monocular y odometría inercial.

## Alcance del proyecto

[//]: # "Scope description: describe the desired final product, service or result."

El proyecto incluye:

-   El diseño mecánico y fabricación del robot móvil
-   El estudio del modelo matemático de la configuración de robot seleccionada
-   La selección y adquisición de los actuadores y sensores del sistema
-   La selección y adquisión de la fuente de alimentación del sistema
-   La selección y adquisión del microcontrolador, FPGA o SoC a utilizar como sistema de supervisión y control del robot móvil
-   El desarrollo de los driver de los actuadores y sensores del sistema
-   El diseño del sistema de control de los actuadores
-   La implementación de técnicas de fusión sensorial que permitan adaptar la información obtenida de los sensores al algoritmo de SLAM monocular de un tercero
-   La capacitación en el framework ROS 2
-   El desarrollo del software necesario para hacer al sistema compatible con ROS 2
-   La documentación y comunicación del proyecto
-   La planificación, coordinación y ejecución de Prácticas Profesionales Supervisadas y Proyecto Final de Estudio del equipo de colaboradores

El proyecto no incluye:

-   El análisis matemático dinámico del robot desarrollado.
-   El desarrollo de algoritmos de navegación autónoma asociados a la planificación y ejecución de trayectorias del sistema
-   El desarrollo de un algoritmo nuevo de SLAM, ni su implementación desde cero sobre el sistema.
-   La optimización de algoritmos de fusión sensorial, de control o de SLAM utilizados
-   El desarrollo ni la utilización de simulaciones en entornos virtuales del sistema
-   El diseño y fabricación de una PCB específica para el robot móvil
-   El diseño y fabricación de brazos manipuladores o herramientas externas al robot móvil

## Supestos del proyecto

[//]: # "Assumptions: explain the key assumptions made that are expected to be true as the work progresses"

En la planificación del proyecto se considera los siguientes supuestos:

-   La adquisición de materiales no tendrá demoras meyores a una semana, asumiendo que el mercado local posee los materiales requeridos para la fabricación del prototipo y que las compras en el exterior serán recibidas en tiempo y forma.
-   No habrá cambios en el equipo de trabajo en el periodo de tiempo que comprende la planificación del proyecto.
-   El responsable del proyecto puede dedicar una cantidad mínima de 25 horas semanales a las actividades del plan.
-   El responsable del proyecto estará ausente durante dos semanas de Julio del año 2023, con fecha a definir.
-   No habrá cambios en los objetivos principales del proyecto ni nuevos requerimientos funcionales de parte del cliente.
-   Se dispondrá de documentación sobre la simulación en ROS 2 realizada previamente para la evaluación del algoritmo de SLAM.

## Requerimientos

1. Requerimientos funcionales:
    1. El movimiento del prototipo desarrollado debe respetar, bajo los correpondientes márgenes de error, el modelo matemático propuesto.
    2. Los sensores del robot móvil deben ser los necesarios para poder ejecutar un algoritmo de SLAM monocular con odometría inercial.
    3. El sistema de control de los actuadores debe ser invisible al usuario del robot.
    4. El sistema de control de los actuadores debe permitir cumplir con las consignas de velocidad que el usuario envíe al robot.
    5. El sistema desarrollado debe ser compatible con el entorno de trabajo de ROS 2.
    6. El robot móvil debe soportar comunicación inalámbrica mediante un protocolo a definir, que le permita desplazarse libremente en su entorno.
    7. El robot móvil debe poseer una fuente de alimentación que le permita desplazarse libremente en su entorno.
    8. Dado que el usuario trabajará sobre el algoritmo de navegación autónoma del robot móvil, la configuración mecánica del mismo no debe impactar en sus actividades.
    9. El sistema embebido del robot móvil debe permitir el uso de lógica programable (hardware dedicado) para una futura optimización de los algoritmos de navegación autónoma.
2. Requerimientos de documentación:
    1. Documentación del análisis geométrico y cinemático del robot.
    2. Lista de materiales para fabricación (BOM).
    3. Planos mecánicos de todas las piezas diseñadas como parte del proyecto.
    4. Manual de montaje del sistema macánico del robot móvil.
    5. Documentación técnica y manual de usuario de los drivers del sistema sensorial del robot.
    6. Documentación técnica y manual de usuario de los drivers de los actuadores del robot.
    7. Documentación del sistema de control de los actuadores.
    8. Documentación del sistema de fusión sensorial.
    9. Lista y documentación ténica de los sensores, actuadores y electrónica utilizada.
    10. Documentación de la arquitectura de comunicación con ROS 2
    11. Instrucciones para la integración de módulos desarrollados en la lógica programable en el sistema embebido
3. Requerimientos de testing:
4. Requerimientos de la interfaz:
    1. La interfaz que da al sistema compatibilidad con ROS 2 debe ser parte de los entregables del proyecto
    2. La interfaz debe permiter la reconfiguración de parámetros del sistema _on-the-fly_
    3. La interfaz debe permitir la operación remota del robot móvil
    4. La interfaz debe ofrecer la visualización adecuada de la información necesaria para evaluar el algoritmo se SLAM monocular

## Entregables principales del proyecto

[//]: # "Deliverables: list and describe all products, services, results that the project work will produce. If there are ambiguities, describe also what is NOT going to be part of the work and final output"

Los entregables del proyecto son:

-   Documentación de análisis matemático del robot:
    -   Documentación del modelo geométrico.
    -   Documentación del modelo cinemático.
-   Estructura mecánica del robot:
    -   Primer prototipo fabricado y funcional.
    -   Lista de materiales para fabricación (BOM).
    -   Archivos con modelos mecánicos para fabricación aditiva (impresión 3D).
    -   Planos mecánicos de las piezas diseñadas.
    -   Documento con instrucciones para el montaje.
-   Sistema sensorial del robot:
    -   Módulos con los sensores seleccionados.
    -   Diagrama de conexión de los sensores.
    -   Especificación técnica de los sensores.
    -   Software/hardware driver desarrollado para los sensores.
    -   Software/hardware con algoritmo de fusión sensorial.
    -   Documentación técnica y manual de usuario de los drivers.
    -   Documentación del algoritmo de fusión sensorial,
-   Sistema motor del robot móvil:
    -   Actuadores seleccionados.
    -   Diagrama de conexión de los actuadores.
    -   Especificación técnica de los actuadores.
    -   Software/hardware driver desarrollado para los actuadores.
    -   Software/hardware con sistema de control de los actuadores.
    -   Documentación técnica y manual de usuario de los drivers.
    -   Documentación del sistema de control de los actuadores.
-   Sistema de supervisión y control embebido:
    -   Especificación técnica del sistema embebido seleccionado.
    -   Software/hardware supervisor del robot.
    -   Documentación sobre el sistema operativo utilizado.
    -   Documentación de la arquitectura del sistema.
    -   Documentación sobre comunicación con ROS 2.
    -   Especificación de Requerimientos de Software (ERS)
-   Sistema de alimentación del robot
    -   Especificación técnica de la fuente de alimentación seleccionada.
    -   Diagrama de conexión de la fuente de alimentación.
-   Sistema de señalización e interacción física:
    -   Selección de elementos de señalización e interacción física y retroalimentación al usuario.
    -   Software/ hardware del sistema de señalización e interacción física.
    -   Documentación del sistema de señalización e interacción física.
    -   Diagrama de conexión del sistema de señalización e interacción física con el sistema embebido.
-   Agente de ROS 2 ejemplo:
    -   Software de agente ROS 2 ejemplo para interacción con el sistema.
    -   Documentación sobre configuración y uso del agente de ROS 2 ejemplo.
-   Informe final

## Desglose del trabajo en tareas

1. Planificación del proyecto.
    1. Identificación y contacto con los interesados.
    2. Definición del propósito y alcance del proyecto.
    3. Definición de los requerimientos y entregables.
    4. Desglose del trabajo en tareas y obtención del diagrama de Gantt.
    5. Análisis de riesgos, gestión de calidad y definición de procesos de cierre.
2. Investigación del estado del arte de la odometría visual-inercial y SLAM monocular.
3. Configuración de herramientas y entorno de trabajo.
    1. Configuración de herramientas para la gestión del proyecto y la coordinación del equipo de trabajo (ej. Jira).
    2. Creación y configuración de la estructura de repositorios del proyecto donde se mantendrá el software y documentación producido.
    3. Setup del entorno de trabajo para desarrollo del software necesario.
4. Definición técnica del robot móvil a diseñar.
    1. Investigación del estado del arte de la robótica móvil.
    2. Selección del tipo de robot móvil a desarrollar.
    3. Descripción matemática del robot seleccionado.
    4. Documentación del análisis matemático del robot.
5. Diseño y fabricación del prototipo mecánico.
    1. Diseño mecánico del robot móvil mediante herramienta CAD.
    2. Adquisición de elementos mecánicos necesarios para la manufactura del prototipo.
    3. Producción de piezas mecánicas mediante fabricación aditiva.
    4. Montaje del prototipo fabricado.
    5. Iteración para corrección de errores.
    6. Generación de planos mecánicos de las piezas diseñadas.
    7. Generación de la lista de materiales (BOM) para la construcción del prototipo.
    8. Generación de manual de instrucciones para el montaje.
6. Diseño del sistema sensorial del robot móvil.
    1. Selección y adquisición de la IMU.
    2. Conexión de la IMU al sistema embebido.
    3. Desarrollo de software driver de la IMU sobre el microcontrolador.
    4. Adquisición de datos obtenidos con la IMU desde el sistema ROS 2.
    5. Integración del driver de la IMU con el algoritmo de fusión sensorial.
    6. Migración del driver de la IMU para el microcontrolador al SoC.
    7. Generación de documentación del driver de la IMU.
    8. Selección y adquisión de cámara digital.
    9. Conexión de la cámara digital al sistema embebido.
    10. Desarrollo del software driver de la cámara digital sobre el microcontrolador.
    11. Adquisición de datos obtenidos con la cámara digital desde el sistema ROS 2.
    12. Investigación y selección de técnica de fusión sensorial.
    13. Implementación del algoritmo de fusión sensorial seleccionado.
    14. Migración del driver de la cámara digital para el microcontrolador al SoC.
    15. Generación de documentación del driver de la cámara digital.
    16. Generación de diagramas de conexión de la IMU, la cámara digital y el sistema embebido.
7. Diseño del sistema motor del robot móvil.
    1. Selección y adquisición de los actuadores y drivers de potencia.
    2. Conexión de los actuadores y drivers al sistema embebido.
    3. Desarrollo de software driver de los actuadores sobre el microcontrolador.
    4. Diseño del sistema de control de los actuadores.
    5. Integración del driver de los actuadores con el sistema de control de los mismos.
    6. Control y monitoreo de los actuadores desde el sistema ROS 2.
    7. Migración del driver de los actuadores para microcontrolador al SoC.
    8. Migración del sistema de control de los actuadores al SoC.
    9. Generación de documentación del driver de los actuadores.
    10. Generación de docuemtnación del sistema de control de los actuadores.
    11. Generación de diagramas de conexión de los actuadores, sus drivers y el sistema embebido.
8. Diseño del sistema de supervisión y control embebidos.
    1. Elaboración del documento de Especificación de Requerimientos de Software (ERS)
    2. Diseño de la arquitectura del sistema supervisor.
    3. Selección y adquisición del microcontrolador (placa de desarrollo) a utilizar.
    4. Selección e incorporación del sistema operativo de tiempo real a utilizar (o selección de modalidad _bare metal_).
    5. Implementación del sistema supervisor en el microcontrolador.
    6. Integración del sistema sensorial en el sistema supervisor.
    7. Integración del sistema motor en el sistema supervisor.
    8. Capacitación sobre el uso de ROS 2 en sistemas embebidos.
    9. Implementación de interfaz del sistema supervisor con el agente de ROS 2.
    10. Selección y adquisición del SoC (placa de desarrollo) a utilizar.
    11. Migración del sistema supervisor al SoC.
    12. Documentación de la arquitectura del sistema supervisor.
9. Diseño del sistema de alimentación
    1. Selección y adquisición de la fuente de alimentación.
    2. Conexión de la fuente de alimentación al sistema.
    3. Documentación del sistema de alimentación.
    4. Generación de diagramas de conexión de la fuente de alimentación y el sistema embebido.
10. Diseño del sistema de señalización e interacción física.
    1. Diseño de señales e interacción del sistema con usuario y su significado.
    2. Selección de elementos que brindarán las señales y la posibilidad de interacción con el sistema.
    3. Conexión de los elementos de señalización e interacción física con el sistema embebido.
    4. Desarrollo de software para el sistema de señalización e interacción física.
    5. Integración del sistema de señalización e interacción física con el sistema supervisor.
    6. Migración del sistema de señalización e interacción física al SoC.
    7. Generación de documentación del sistema de señalización e interacción física.
    8. Generación de diagramas de conexión del sistema de señalización e interacción física y el sistema embebido.
11. Desarrollo de agente de ROS 2 ejemplo.
    1. Setup de agente de ROS 2 y comunicación con el sistema embebido
    2. Generación de documentación sobre la configuración y uso del agente.
12. Proceso de cierre
    1. Análisis de cumplimiento de objetivos y requerimientos con el director
    2. Análisis de cumplimiento del plan original (diagrama de Gantt)
    3. Análisis de cumplimiento de objetivos y requerimientos con el cliente
    4. Capacitación del cliente sobre el prototipo realizado
    5. Elaboración de memoria técnica
    6. Corrección de memoria técnica
    7. Preparación de defensa pública
    8. Defensa pública
    9. Reunión de cierre con el director
    10. Reunión de cierre con el cliente y el equipo de trabajo

Cantidad total de horas: \_\_\_

## Diagrama de Activity On Node

Las tareas expuestas en el diagrama de _Activity On Node_, se encuentran detalladas en la siguiente tabla, con su código, duración y tareas predecesoras.

| Código | Predecesora | Descripción                | Duración | Asignado          |
| ------ | ----------- | -------------------------- | -------- | ----------------- |
| 1      |             | Planificación del proyecto | 70 h     | Gonzalo Fernandez |

## Gestión de riesgos

[//]: # "Challenges / Constraints: briefly explain the key limitations of the project and how will they be managed."

1. Identificación de los riesgos y estimación de sus consecuencias
2. Tabla de gestión de riesgos
3. Plan de mitigación de los riesgos que exceden el RPN máximo establecido

## Gestión de calidad

[//]: # "Acceptance criteria: explain what are the success factors required, to acquire the approval for completing the project at the end. Specify who will be the Approver"

## Proceso de cierre

Una vez finalizado el proyecto se realizarán las siguientes actividades:

-   Análisis del grado de cumplimiento de los objetivos y requerimientos junto con el Dr. Ing. Fabio Ardiani.
-   Análisis de cumplimiento de la versión original del plan de trabajo, contrastando el registro de actividades realizadas con el diagrama de Gantt original.
-   Análisis del grado de cumplimiento de los objetivos y requerimientos junto con el cliente, el Ing. Leandro Borgnino.
-   Elaboración de un documento con todos los problemas que surgieron durante el desarrollo del proyecto y las soluciones encontradas.
-   Elaboración de un documento con las actividades que no se alcanzaron a realizar en el tiempo estimado y todas aquellas actividades realizadas que no se contemplaron en el plan original.
-   Elaboración de un documento con el trabajo a futuro, que sirva como base de un plan de proyecto que continue la misma línea de investigación y desarrollo.
-   Defensa pública del proyecto por parte del responsable.
-   Reunión privada con el equipo de trabajo para compartir _feedback_ sobre la experiencia obtenida en el lapso del proyecto.
-   Reunión virtual, organizada por el responsable, con el Dr. Ing. Fabio Ardiani como acto de agradecimiento.
-   Reunión con el Ing. Leandro Borgnino y el equipo de trabajo, organizada por el responsable, para dar un cierre al proyecto y evaluar los próximos proyectos y actividades a realizar en conjunto.

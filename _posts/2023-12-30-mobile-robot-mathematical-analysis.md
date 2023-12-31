---
layout: post
title: Wheeled mobile robot mathematical analysis
subtitle: Wheeled robot mathematical description
author: Gonzalo G. Fernandez
categories: cese
excerpt_image: /assets/images/stm32-429zi.jpg
# banner:
#   video: https://vjs.zencdn.net/v/oceans.mp4
#   loop: true
#   volume: 0.8
#   start_at: 8.5
#   image: images/banners/ROS-Industrial-Logo.png
#   opacity: 0.618
#   background: "#000"
#   height: "100vh"
#   min_height: "38vh"
#   heading_style: "font-size: 4.25em; font-weight: bold; text-decoration: underline"
#   subheading_style: "color: gold"
tags: cese robotics mobile-robotics
sidebar: []
---

## Introduction

#TODO: Dar clasificación de robot móviles

El principal objetivo en el diseño mecánico del robot móvil a desarrollar como solución para la fundación fulgor es obtener una configuración de robot móvil terrestre mecánicamente sencilla, con baja complejidad en su control tal que permita enfocar el esfuerzo en el desarrollo y evaluación de algoritmos de SLAM sin que los aspectos mencionados previamente representen un obstáculo.

Wheeled robots comprise one or more driven wheels and haave optional passive or caster wheels and possibly steered wheels. Most designs require two motors for driving (and steering) a mobile robot.

![wheeled-robots](/assets/images/wheeled-robots.png)

The design on the left-hand side of the figure has a single driven wheel that is also steered. It requires two motors, one for driving the wheel and one for turning. A disadvantage of this design is that the robot cannot turn on the spot, since the driven wheel is not located at its center. Therefore, the trajectory planning can be more complex than the one for a different configuration.

The robot design in the middle is called *differential drive* and is one of the most commonly used mobile robot designs. The combination of two driven wheels allows the robot to be driven straight, in a curve, or to turn on the spot. Another advantage of this design is that motors and wheels are in fixed positions and do not need to be turned as in the previous design. This simplifies the robot mechnics considerably.

Finally, on the right-hand side of the figure is the so-called *Ackermann Steering*, which is the standard drive and steering system of a rear-driven passenger car. It has one motor for driving both rear wheels via a differential box and one motor for combined steering of both front wheels.

A special case of a wheeled robot is the omni-directional *Mecanum drive* robot, but it is discarded due to the cost and accesibility of such wheels.

One disadvantage of all wheeled robots is that they require a flat surface for driving. Tracked robots are more flexible and can navigate over rough terrain. The main disadvantage, and the reason for not being considered for the project, is that they cannot navigate as accurately as a wheeled robot.

Legged robots are the final category of land-based mobile robots. Like tracked robots, they can navigate over rough terrain, There are many different designs for legged robots, depending on their number of legs. The general rule is: the more legs, the easier to balance. These kind of robots are not considered for the project for being highly complex both mecanically and their control.

The configuration selected for the project is the differential drive, being the most mechanically simple and versatile.
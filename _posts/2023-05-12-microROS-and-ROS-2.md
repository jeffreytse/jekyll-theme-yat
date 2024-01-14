---
layout: post
title: microROS and ROS 2
subtitle: Development of mobile robot for monocular SLAM
author: Gonzalo G. Fernandez
categories: cese
excerpt_image: /assets/images/ros-humble.jpg
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
tags: cese microROS ROS2
sidebar: []
---

![banner](/assets/images/banners/ROS-Industrial-Logo.png)

## Introducción

El entorno ROS es un framework de software libre y de código abierto diseñado para permitir el desarrollo de aplicaciones robóticas distribuidas. Este framework proporciona un conjunto de herramientas para la creación, gestión, depuración y análisis de sistemas robóticos.

La segunda versión de la herramienta, denominada ROS 2, fue desarrollada por la comunidad con el objetivo de mejorar la escalabilidad, la fiabilidad y la seguridad del software. Una de sus principales caracterı́sticas es que está diseñado para ser modular y extensible, lo que significa que los desarrolladores pueden elegir los componentes que necesitan para sus aplicaciones y utilizarlos de manera flexible. También se enfoca en proporcionar una abstracción de hardware más clara y permitir el uso de diferentes sistemas operativos y arquitecturas.

La herramienta micro-ROS es una implementación de ROS 2 diseñada especı́ficamente para sistemas embebidos y de tiempo real. A diferencia de ROS 2, que se ejecuta en sistemas operativos de propósito general, micro-ROS se ejecuta en sistemas operativos de tiempo real (como NuttX y FreeRTOS), lo que permite el desarrollo de sistemas robóticos en entornos de baja potencia y recursos limitados.

Como puede observarse en la figura 2, micro-ROS proporciona una capa de abstracción que permite la comunicación entre los sistemas embebidos y los nodos de ROS 2 en otros sistemas. Esto significa que los desarrolladores pueden crear sistemas robóticos distribuidos, que utilicen tanto sistemas embebidos como sistemas de propósito general y que todos ellos puedan comunicarse a través de la misma plataforma.

![micro-ROS architecture](/assets/images/micro-ROS_architecture.png)

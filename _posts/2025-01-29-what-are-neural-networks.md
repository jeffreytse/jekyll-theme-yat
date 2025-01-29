---
layout: post
title: Neural Networks! -  A Beginner’s Overview for Undergraduates
subtitle: Unlocking the Power of AI
author: Sebastián A. Cruz Romero
categories: education
banner:
  video:
  loop: true
  volume: 0.8
  start_at: 8.5
  image: https://media.licdn.com/dms/image/v2/C4D12AQEwyvEnLPlPRQ/article-cover_image-shrink_720_1280/article-cover_image-shrink_720_1280/0/1616944778816?e=2147483647&v=beta&t=hIY1hJLrQt1w8YBiIycN1zH1TAqN0nFE0jr4OfX-5Bo
  opacity: 0.618
  background: "#000"
  height: "100vh"
  min_height: "38vh"
  heading_style: "font-size: 4.25em; font-weight: bold; text-decoration: underline"
  subheading_style: "color: gold"
tags: education, artificial-intelligence
top: 1
sidebar: []
---

## What is a Neural Network?

A **neural network** is a machine learning model that **mimics the human brain**. It consists of **artificial neurons** arranged in **layers** to recognize patterns, classify data, and make predictions.

![Basic Neural Network](https://upload.wikimedia.org/wikipedia/commons/e/e4/Artificial_neural_network.svg)

Neural networks power applications like:
- **Voice assistants** (Siri, Alexa)  
- **Image recognition** (Face ID, Google Lens)  
- **Autonomous driving** (Tesla, Waymo)  
- **Language translation** (Google Translate, ChatGPT)  

## How Do Neural Networks Work?

Neural networks operate using a **mathematical framework** similar to the **human brain**. Each neuron processes inputs and passes them through **layers** until a final decision is made. Some of the key components include:

1. **Input Layer** – Receives raw data.  
2. **Hidden Layers** – Processes data with **weights and activation functions**.  
3. **Output Layer** – Produces a final decision or classification.

Each **neuron** follows this equation:

$$
y = f\left( \sum_{i=1}^{n} w_i x_i + b \right)
$$

Where:
- $ x_i $ are inputs,
- $ w_i $ are weights (importance factors),
- $ b $ is the bias,
- $ f $ is the activation function.

## Training a Neural Network: Forward & Backpropagation

Neural networks improve their accuracy through **training**, which consists of **forward propagation** and **backpropagation**.

### **Forward Propagation**
1. Inputs are multiplied by weights.
2. The sum is passed through an **activation function**.
3. The output **feeds into the next layer** until a final prediction is made.

![Forward Propagation](https://miro.medium.com/v2/resize:fit:788/1*jILe1kjXleRFWMBw4TSOuA.gif)

### **Backpropagation (Learning Process)**
During training, the network **adjusts weights** using **gradient descent**, minimizing the error.

1. **Cost function** – Measures the error between predicted and actual values.
2. **Gradient descent** – Optimizes the weights to **minimize errors** over time.

![Backpropagation](https://miro.medium.com/v2/resize:fit:2000/1*dZNUK-2Zt80rWGM0eP0iEg.gif)

This iterative process allows the neural network to **learn and improve**.

## Types of Neural Networks

Neural networks come in various architectures, each optimized for different tasks.

### **1. Perceptron (The First Neural Network)**
- Created by **Frank Rosenblatt** in 1958.
- A simple binary classifier (e.g., yes/no decisions).
  
![Perceptron](https://miro.medium.com/v2/resize:fit:1400/0*X03zdxThIvCf957x.png)

### **3. Convolutional Neural Networks (CNNs)**
- Specialized for **image recognition and pattern detection**.
- Each layer detects features like **edges, textures, and shapes**.

![CNN Example](https://miro.medium.com/v2/resize:fit:1400/1*063g4OHKvoowq8s_SKXDMQ.gif)

### **4. Recurrent Neural Networks (RNNs)**
- Designed for **sequential data** (e.g., speech and time series analysis).
- Includes **feedback loops** to remember past information.

![RNN Example](https://upload.wikimedia.org/wikipedia/commons/b/b5/Recurrent_neural_network_unfold.svg)

MIT researchers emphasize that **CNNs power most AI breakthroughs** today, from **computer vision** to **autonomous robotics**.

<!-- ---

## Neural Networks vs. Deep Learning

Neural networks are a **subset of machine learning**, but deep learning takes them further. The **difference lies in the depth of layers**.

| Feature | Neural Networks | Deep Learning |
|---------|---------------|--------------|
| Layers | 2-3 layers | Many layers (often 10+) |
| Data Processing | Works with structured data | Can process raw, unstructured data |
| Use Cases | Simple pattern recognition | Advanced AI (e.g., ChatGPT, self-driving cars) |

Deep learning has revolutionized AI, thanks to **GPUs** that enable **deep, multi-layered architectures**. -->

## Building a Neural Network in Python

Here’s a simple **Python** example using **TensorFlow** to create a **feedforward neural network**:

```python
import tensorflow as tf
from tensorflow import keras

# Define a simple model
model = keras.Sequential([
    keras.layers.Dense(8, activation='relu', input_shape=(4,)),
    keras.layers.Dense(3, activation='softmax')
])

# Compile the model
model.compile(optimizer='adam', loss='categorical_crossentropy', metrics=['accuracy'])

print(model.summary())
```

This network has:

- 4 input neurons,
- One hidden layer with 8 neurons,
- An output layer with 3 neurons.

This is the foundation for advanced AI models used in **image classification**, **speech recognition**, and **natural language processing**.

## The Future of Neural Networks

Neural networks are reshaping the future, with breakthroughs in:
- Generative AI – Chatbots (ChatGPT, Bard), image generators (DALL·E, Midjourney).
- Medical Research – AI-assisted drug discovery, cancer detection.
- Autonomous Systems – Self-driving cars, AI-powered robotics.
- Quantum AI – MIT & IBM are developing quantum-enhanced neural networks.

MIT's Center for Brains, Minds & Machines predicts that AI will soon integrate deeper with neuroscience, leading to human-like cognitive AI.

## At the end of the day...
Neural networks are at the heart of modern AI. They power everything from Google Search to autonomous robots, and their potential is limitless. If you're an aspiring AI engineer, data scientist, or researcher, now is the best time to dive into neural networks.

Are you ready to explore AI? 🚀 Start building your first neural network today!

🔗 Learn more:
- 📌 IBM’s Neural Network Guide
- 📌 MIT’s Neural Network Research

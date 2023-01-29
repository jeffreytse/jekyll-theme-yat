---
layout: post
title: Video Compression
subtitle: Understanding the rate control modes
categories: ComputerNetworks
tags: [Codecs, compression]
---

The difference between two adjacent frames in a video could either be large or same, hence a possible way to save on the number of bits to be sent could be to just send delta to encode the differences. High spatial details and complex textures would definitely take more bits as delta would be greater but even in worst case we are just sending at most bits equal to  maximum size of frame and in expected case save bits sending over network.

The compression mode greatly depends on the use case as use case dictates the encoding scheme and tolerable loss in compression. Major use cases are as following:

1. Archival - storing the files to archive. Since files are to be store on disk or network storage, they should be space sensitive
2. Streaming - Like Netflix or other content provided data. Here the videos are streamed on demand over HTTP and may have to maintain Adaptive Streaming.
3. Live Streaming - Instead of video-on-demand, video is consumed in real-time (FaceTime or Live sports streaming). Here time of essence and hence should be very fast without any prior knowledge of encoding.
4. Encoding for devices - transferring/copying files one storage type to other. Here the compression should be as lossless possible.

**Constant QP (CQP)**

Quantization is a lossy technique to compress frames at a block level  (usually 8*8).  Quantization parameter controls the amount of compression. Since quantization values used are mostly static, resulting bitrate is strongly dependent on these values , hence should be avoided. It can be highly useful if we are aware of the frame by frame encoding as good quantization parameters could be chosen for compression and is the reason why Netflix use fixed-QP encoding for its per-shot encoding optimization.

**Average BitRate (ABR)**

This declares the target bitrate ahead of time without consideration for data ahead and hence is not suitable for compression. It throttles after reaching the target bitrate. It is a Variable Bitrate mode and there are variation within short segments. 

Constant Bitrate on the other hand forces the encoder to always use a certain bitrate. Even if there are not much bits to encode, it still maintains its constant bitrate which leads to BW wastage. It could be useful in streaming use case but is not suitable for archival.

**2-Pass Average Bitrate (2 - Pass ABR)**

Makes use of 2 passes to ensure output quality is best under certain bitrate constraint.

The encoder is “dumb” when used in 1-pass mode and cannot predict the complexity and motion of a future frame, which eventually leads to blocking and other weird effects, unless you give it a bitrate high enough to eliminate these issues, but then you’ll be wasting bits. Not so when using 2-pass mode since the first pass will be used to store information of every frame to a log file and then when the second pass starts, the encoder will read the log file with the frame/motion/complexity information for each frame and base its decision how much bitrate to allocate for each frame.

***From Reddit*** : *“Lossy encoders (like x264 and x265) have to decide how much information to throw away in each frame. This is represented by the quantization parameter (QP). The larger the QP for a given frame, the more information is thrown away.*

*x264 and x265 both have a rate control method called Constant Quantization Parameter (CQP). CQP does exactly what you think it does: it sets a constant QP for every frame in the video. It is the ultimate "constant quality" rate control, but it is somewhat inefficient because not every frame has the same importance in a video.*

*Constant Rate Factor (CRF) tries to address the inefficienty in CQP by increasing the QP in high-motion frames and decreasing it in low-motion frames. This works very well in most scenarios, but sometimes it doesn't. So, CRF is a "sort-of" constant quality rate control. It tries to achieve constant perceptual quality instead of absolute constant quality. CRF is the best "average use case" rate control.*

*2-pass also tries to achieve constant perceptual quality, but it does so with an additional constraint: average bitrate. It should yield videos with very consistent quality, and in some specific scenarios (very noisy and/or grainy clips) it is known to be more efficient than CRF.”*

This mode works well in most cases except when time is of essence (live streaming)

**Constant Quality (CQ) / Constant Rate Factor (CRF)**

One of the most general mode to obtain optimal quality under most cases except case when there are strict constraints on file size and/or bitrate. Under this we can specify a CRF without consideration for file size. 

**Constrained Encoding (VBV)**

Video Buffering Verifier constraints bitrate to a certain maximum. It can be used with CRF or 2-Pass ABR. It works well for steaming under BW constraints, live streaming, Video-on-Demand streaming but is not a good choice for archival.

Additional Resources:

[Toward A Practical Perceptual Video Quality Metric](https://netflixtechblog.com/toward-a-practical-perceptual-video-quality-metric-653f208b9652)
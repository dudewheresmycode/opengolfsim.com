---
parent: OpenGolfSim Desktop
title: Video
nav_order: 4
---

# Video

OpenGolfSim can use one or more connected webcams to automatically record short video clips of your shots and even provide on-screen instant replay.

<img src="/assets/replay-preview.jpg" width="100%" style="max-width: 300px;" />

## Webcam Compatibility

Virtually any standard PC webcam that connects over USB should be supported. As long as your system sees it as a web camera.

Here's a list of devices we've tested with and are known to work well:

| Camera | Compatible | Max Resolution | Max FPS |
| --- | --- | --- | --- |
| EMEET C960 | ✅ | 1080p | 30 |
| NexiGo N980P | ✅ | 1080p | 60 |
| Arducam Global Shutter OV9782 | ✅ | 1080p | 100 |
| ELP Global Shutter 90fps | ✅ | 1080p | 90 |

## Settings

You can configure some basic settings to fine tune your video recordings. 

- **Capture Duration:** The number of seconds of video to keep in-memory for video recordings (default is 10 seconds). When a shot is detected, we'll cut a new video clip with this recording length. If you find that the start of your swing is being cut off, you can adjust this value to capture more or less video for each shot.

- **Playback Speed:** The speed of the playback. To create slow motion replays, you can increase the FPS (frame rate) in the camera settings (See notes below on resolution and FPS limitations) and then lower the playback speed.

- **Resolution:** We try and detect all the supported resolutions. Each supported resolution should also display the maximum framerate the camera reports.

- **FPS:** The frame rate, or number of frames per second (FPS) for replay videos. This will depend on your web camera's detected capabilities.


{: .warning }
> Setting both high resolution and high FPS for captures will use a significant amount of system resources GPU memory! We strongly recommend using lower resolutions for high FPS captures.

### System Requirements

We capture and store raw, uncompressed video frames in memory until a shot is triggered. This means that setting a higher resolution and framerate will store a larger number of bigger frames in memory and require more system resources. For higher framerate captures (>=60fps), we recommend significantly lowering the selected resolution. (e.g. for a 120fps capture, we recommend a resolution of about 800x600)

### Hardware Decoding

For better performance on high framerate captures we try and determine if your system supports hardware-based decoding using CUDA (for nvidia systems). If CUDA support is not detected on your system, you may experience performance issues with higher frame rates or resolutions.

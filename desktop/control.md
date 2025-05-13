---
parent: OpenGolfSim Desktop
title: Control
thumbnail: /assets/appicon.svg
nav_order: 3
---

# Control

OpenGolfSim gives you two ways to control your golf sim gameplay: using the virtual control box in our mobile app or a physical control box or with a joystick or gamepad device you may have sitting around.

Whether you're taking a mulligan, adjusting aim, or triggering a drop, these methods give you quick access to core gameplay actions without walking over to your setup and fumbling for the keyboard.

---

## Mobile App

The fastest way to get started is with the OpenGolfSim mobile app. Got an old tablet lying around? Even an old phone duct-taped to the wall next to your sim beats fumbling with a keyboard. It’ll make gameplay faster, smoother, and way less frustrating.

Once installed, the app scans your local network for the PC running the OpenGolfSim Desktop software. As soon as it connects, any button presses you make in the app are instantly sent to GSPro.

You’ll have access to key gameplay actions like:

- Aim adjustments (left, right, center)
- Mulligans
- Rehit
- Drop
- Flyover
- Scorecard view

To get started, download the app from the [iOS App Store](https://apps.apple.com) or [Google Play](https://play.google.com), install it on your phone or tablet.

---

## Physical Control Box

Prefer tactile buttons over touchscreen taps? You can hook up a USB gamepad or joystick to your sim PC and use it as a physical control box—either off-the-shelf or DIY.

OpenGolfSim supports most generic USB controllers. Once connected, you can assign button presses to specific GSPro functions using your desktop app settings. This lets you build anything from a simple one-button mulligan box to a full-featured controller with aim, drop, flyover, almost anything you can do from a keyboard and mouse you will be able to program.

If you’re building your own, all you need is:

- A basic USB joystick or controller board (e.g. Arduino with joystick firmware, or a USB encoder)
- A few arcade-style buttons or toggles
- A case to mount it in

For our DIY build guides, see our GSPro DIY Button Box build [text](https://opengolfsim.com/2024/11/15/gspro-button-box.html)
---

## Physical Control Setup

Setting up a physical controller is quick and straightforward—just plug it in and map your buttons.

1. **Connect the device**  
   Plug in or pair your gamepad, joystick, or button box to your PC.

2. **Open OpenGolfSim Desktop**  
   Go to the **Control** section in the app. Your device should appear in the list.  
   If it doesn’t:
   - Close and reopen the desktop app.
   - Unplug the device and plug it back in.
   - Make sure your PC recognizes the device under Windows settings.

3. **Device appears in the control panel**  
   Once detected, the device will show up in controls page.

   <img src="/assets/OGS_Documentation/control-setup.png" width="100%" style="max-width: 400px;" />

4. **Set up the device**  
   Click **Setup Device**, then give it a name so you can easily identify it later.

5. **Assign buttons**  
   Choose an action from the list, click **Assign Button**, then press the button you want to map on your controller.

6. **Repeat as needed**  
   Continue assigning buttons for any actions you want—mulligans, aim adjustments, flyovers, etc.  
   Use whatever layout makes the most sense for your setup.

   <img src="/assets/OGS_Documentation/control-setup-options.png" width="100%" style="max-width: 400px;" />

7. **ENJOY**  
   Load up a course and start playing with your new control setup.

   
If something’s still not working on your setup, [contact us](/contact) and we’ll help you sort it out.

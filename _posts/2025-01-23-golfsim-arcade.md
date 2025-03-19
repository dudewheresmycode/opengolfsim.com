---
title: Golden Tee on the Sim
layout: post
# parent: Articles
last_modified_date: 2025-01-23
thumbnail: /assets/goldenpro/goldenpro_thumb.jpg
excerpt: Hacked together a way to play GoldenTee Classic on my simulator
---

<img width="640" src="/assets/goldenpro/goldenpro_screen.jpg" alt="Golden Tee Classic" />

I remember red plastic cups filled with Surge and hanging at the local pizza place playing arcade games. Flinging that greasy Golden Tee trackball as hard as I could, usually shanking the shot into the woods.

So as a fun nostalgia project, I decided to try and see if I could figure out a way to play Golden Tee Classic on my freshly built [DIY golf simulator]({{ site.baseurl }}{% link _posts/2024-10-01-diy-murphy-bed-golf-sim.md %}).

In past projects, I've played around with the [Mame](https://www.mamedev.org/) arcade video game emulator. You can download a variety of old games as ROMs and use Mame to play them on your PC. So I started by searching around for a ROM for the classic Golden Tee arcade game. A few visits to some quasi-sketchy ROM sites later, I was playing Golden Tee Classic on my PC using my keyboard! 🎉 Now for the fun part, hacking the shit out of it until I figure out how script trackball movements.

## Links

- [Github Project](https://github.com/dudewheresmycode/golden-pro-sim)
- [MAME](https://www.mamedev.org/)

## Required Equipment

- **Launch Monitor**

  I built this using my Approach R10 and the [gsp-r10-adapter](https://github.com/mholow/gsp-r10-adapter), but in theory any launch monitor that can connect to GSPro's OpenConnect API should work.

- **PC Computer**

  Literally any PC should work, as it's just running an old arcade game.

## Software

- [Mame](https://www.mamedev.org/)

  For running Golden Tee arcade game ROM

- [GSPro-R10-Adapter](https://github.com/mholow/gsp-r10-adapter) - To communicate with the launch monitor

- [Node.js](https://nodejs.org/) - For glueing it all together

{: .note }

For legal reasons, I don't provide any guides or instructions for downloading the game ROM or setting up MAME. But there's plenty of information out there for getting that part setup.

### Scripting The Controls

Mame has a [Lua scripting interface](https://docs.mamedev.org/luascript/index.html) you can use to control and automate game-play. I was hoping I could leverage that to send shot data to the game, but I couldn't figure out any built-in way to do inter-process communication (IPC) to send commands to lua on demand when shots happen. Then I found that Mame has a cli option for an interactive Lua console (`-console`). I realized I could spawn mame as a child process from a node.js script, and then write Lua commands (like input control) to the stdin of the child process.

Since MAME plugins are written in Lua script, I wrote the bulk of the code to control the game as a plugin called `goldenpro`. For shots and button presses we invoke the plugin method in the console via stdin like so:

```javascript
child.stdin.write(
  `require('goldenpro').command('shot', ${trackballY}, ${trackballX})\n`
);
```

The actual

### Translating Launch Monitor Data

When a launch monitor detects a golf shot, it sends shot data to your golf simulator software. This shot data contains data points like ball speed, club speed, launch angles, and spin. These values are then used to compute the simulated physics of the golf shot in game.

As you can imagine, the classic Golden Tee is quite a bit more basic than modern day sim software like GSPro. It's only input for golf shots is the trackball. If you haven't played Golden Tee before, you essentially roll the trackball towards you for the upswing, and away from you for the downswing. So if you break it down, there's 2 core metrics that determine your shot result in Golden Tee. Shot power (or swing speed) is the back and forth motion of the trackball. The horizontal (right to left) angle of the trackball will dictate how straight your shot goes. So I needed some way of translating real-world golf shot data into Golden Tee trackball movement.

My starting point was allowing our Golden Tee shot script to take two variables. A `power` variable to represent the back and forth trackball speed/range, and an `angle` variable which represents the horizontal launch angle of the shot.

### `angle`

The HLS (Horizontal Launch Angle) tells us the right/left angle of the shot. We can essentially use this value directly since it works the same as the right-left movement of the trackball. The HLA values will range from `-45` to `45` degrees, and we can convert that as a percentage of our trackball range of `0` - `255`.

Using a simple convert range function, we can translate the HLA range to the trackball value.

```javascript
function convertRange(value, r1, r2) {
  return ((value - r1[0]) * (r2[1] - r2[0])) / (r1[1] - r1[0]) + r2[0];
}
const hla = 15; // 15 degree HLA
const trackballX = convertRange(hla, [-45, 45], [0, 255]);
```

### `power`

As for shot power, that's a bit trickier. Based on our shot power, we calculate two variables, the range of motion (i.e. how far you moved the trackball back and forward) and the speed of motion (i.e. how quickly you moved the trackball back and forth).

To keep things simple, ball speed is the only metric we use from the shot data to compute shot power.

After doing some test shots in my sim, my ball speeds tend to range from about ~10 mph to ~170 mph, I also used Trackman's report of [average PGA ball speeds](https://trackman.com/blog/golf/ball-speed) as a guide. We calculate the power as a percentage between the range 0-240. So a shot speed of 120 mph would equate to a shot power of 50%, and 110 would be a power of 50%, etc.

The actual simulation of the trackball movements are done using a couple simple animation loops. One for the backswing and one for the forward swing. One loop iterates from 0 to our power value and then a second loop back down to 0 again.

### Reading Club Selection & Target Distance

One challenge I found early on was that basing the power solely on ball speed would result in low power iron and wedge shots, since they have naturally lower ball speeds. But Golden Tee game play bases your power percentage on the club selection. So if an average approach shot ranges from 80-120 MPH, we would want to apply 100% power at 120MPH. While drives need 100% power at closer to 200 MPH. So for our shots to be (somewhat) accurate, we need to know what club Golden Tee has selected for us, and compare our shot data with a target for that yardage.

This is where things get super nerdy. It turns out, we can dig around inside the memory blocks of the game using [Mame's debugger](https://docs.mamedev.org/debugger/index.html). After about an hour or so of flipping through clubs and scrolling through hundreds of lines of hex codes, I found the block that stored the club selection as an integer from 0-13. Score!

For anyone that stumbles upon this article just looking for `gtclassc` memory block addresses:

#### Memory Addresses

| Address    | Data           |
| ---------- | -------------- |
| `0x001960` | Yardage        |
| `0x002480` | Club Selection |

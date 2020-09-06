# MasterDesktop
A modern minimalist desktop environment for Arch Linux

### Features
* Slim
* Opacity, shadows, and blurs
* Modern material themeing
* GAPS!
* Tiling
* Shortcut bar acts as a mini process manager
* Per monitor virtual desktops with indicator and bar
* Mobile phone integration
* Update indicator

### Drawbacks
Monitors are limited to 10 for now. Crazy right?! They are too static and config generation is required on install
to make it more flexible.

You need to currently configure that shortcut bar manually. For now.

The lock screen is sloooooooooow. It's the imagemagick nonsense thats going on because of how i3lock works. Will
need to address this in the code at some point. Possibly a fork.

No wifi controls yet.

### Install
The installer for this might not work yet. This has not been tested yet.

```
git clone https://github.com/eb3095/MasterDesktop
cd MasterDesktop
./install.sh
```

Silent Installation
```
git clone https://github.com/eb3095/MasterDesktop
cd MasterDesktop
./install.sh "Alt"
```
The argument is the i3 Mod key. Alt or Win. Case sensitive.

# Configuring
The following to config files are generally what you will be looking for.

~/.config/polybar/config
~/.config/i3/config

### Screenshots
![alt text](https://github.com/eb3095/MasterDesktop/blob/master/screenshots/DEScreen1.png "Desktop")
![alt text](https://github.com/eb3095/MasterDesktop/blob/master/screenshots/DEScreen2.png "Tiling, themeing, terminal, and file browser")
![alt text](https://github.com/eb3095/MasterDesktop/blob/master/screenshots/DEScreen3.png "Pixelated lock screen")

### Credits
[View the credits](https://github.com/eb3095/MasterDesktop/blob/master/CREDITS.md)

If your name is not listed in the above link or there is a violation of copyrights of some sort,
please reach out and I will do my best to sort it out quickly. There were a lot of moving peices
I have aquired over a good stretch of time. I think I reliably tracked down original sources, but
who knows!

# !!! WIP !!!
This is not ready for use and is being actively worked on. This section will be updated when
the project is further along, stable, and thoroughly tested.
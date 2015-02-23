---
layout: post
title: "To LXC and beyond"
date: 2015-02-23 20:05
comments: true
categories:
 - lxc
 - vagrant
 - docker
 - dev
 - containers
---
{% img http://i.imgur.com/g8wJ1ol.jpg containers %}

It's been a while since I've started using virtualization.

At first it was VirtualBox vms, then I discovered Vagrant and about half a year ago 
I've noticed LXC and weirdly before that about Docker.

One may ask - why do you need such things and I try to answer.

When I found out about VirtualBox I used computer with Windows7 at work and at home. 
Being PHP developer at that days meant that you mostly work with LAMP stack on server 
and with some HTML + CSS + Javascript on client. As you can see I had Linux server and 
development environment was set up on Windows machine.

It was ok most of the time, but this inconsistency had stub me in the back several times.
Then when I once again had fixed some weird bug I decided to start using Linux instead of Windows 
on my development machine. And before installing Linux as second os I wanted to try some Linux distribution
 without installing it and screwing all up, so I used VirtualBox for this.
 
Long term short I was using Ubuntu as my main os for development. Project after project tim goes by and
I started to notice some weird thing - after switching to new project some soft kept running in background
and number of processes in htop kept growing. Yeah, you may say - stop that process, remove it from upstart,
remove it from system or something else, but sometimes these projects may return to life and you would be
fixing bugs on them and you would need them kept in ready to go state pretty mach all the time.

This is when I returned to VirtualBox again. This time I installed Ubuntu Server on it and connected to the box
over ssh. I was able to install software I need without adding it to host machine, then I could stop and start the box
at any time - it was quite amazing. At that time I event wanted to buy bigger usb flash drive to bring my vm with me 
from work to home and vise versa.

This approach worked fine for a while, but it had some flaws. You could stop and start vm but if you destroy it
you are screwed - you need to remember what you did to vm to make your soft work and you need to reapply these changes.
This can be some sort of a shell script with installation commands or something more complicated. This same script also 
can be useful to your team members - they will setup theirs development environments just like you did. Also besides 
software installations VirtualBox has many setting and options you need to setup every time by hand 
or using not os friendly api. Having these problems I've started looking fo solution and after a while I've found one.
It was Vagrant.

Vagrant allows you to specify VirtualBox vm settings in Vagrantfile and also you can specify some provision for your box.
It can be simple shell script or maybe puppet manifetsts and modules or other provision tool. This way you need to setup
Vagrant and VirtualBox on you host machine and then all other soft will be installed inside vm using scripts stored
alongside your project files and therefore under version control. This way you won't forget your dev setup and it won't be lost.
Your team mates will be able to setup same development environment from scratch in minutes.
 
But as any super power this one comes with some downside. VirtualBox vm is resource consuming. You won't be able to run
Vagrant vm box in production and you can run only several of them on your development environment. Another common problem
is files haring between host and guest machines or synced folders. If you have large project syncing process may slow you down
and ide will destroy your nerves by even slower reindex (yes, I'm talking about you Php or WebStorm).

And it was exactly the time I've heard about LXC - Linux Containers. They are less heavy than VirtualBox vms and in general
provide same functionality. You can create container from a template, connect to it and work inside like in vm.
One new feature that can be done with containers is running everything inside it. And by everything I mean everything.
App soft, git, ide. Yeah, right - ide. I know, I know it sounds weird, but it works. Also running everything
app related in one place means disk operations are much faster, for example your ide will reindex project faster, 
changes to project will be applied fasted and in two ways.

Event If you feel sceptical about it you can try it out and then decide what to do next. Maybe you like it maybe not.

And some words about Docker. Docker can be compared to LXC but they decided to dot it other way. Docker container
is intended to run one app. For example if you have LAMP stack - all letters will be in separate containers. It is intended behavior.
You can run several apps in one container using something like supervisor. Also Docker provide way to specify your
container contents with Dockerfile and you can commit and push containers to repositories.

Thanks to [Mak-Di](https://github.com/Mak-Di) and [Vi](https://github.com/makarova) for pointing out to LXC and initial help.

Useful links:

1. [VirtualBox](https://www.virtualbox.org/)
2. [Vagrant](https://www.vagrantup.com/)
3. [Linux Containers](https://linuxcontainers.org/)
4. [Linux Containers introduction articles](https://linuxcontainers.org/lxc/articles/)
5. [Docker](https://www.docker.com/)
6. [Running desktop apps in docker container](https://blog.jessfraz.com/posts/docker-containers-on-the-desktop.html)
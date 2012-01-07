---
layout: post
title: "VirtualBox guest additions reinstall"
date: 2012-01-07 22:47
comments: true
categories:
- VirtualBox
---
{% img http://i.imgur.com/GubLdl.jpg %}

Software development obviously needs some environment. After some time spent working as developer i've got strong filling,
that this envirement should be separated from my desktop. At least vitrually.
<!-- more -->
So i am working with server inside VirtalBox. It's preaty hendy solution, but lack of exirience can couse some troubles.

For example i have computer with Windows7/Ubuntu 11.10 in dual boot and i really would like to work with
the same virtual mashine from each of the two operating systems. At the time of this writing i didn't manage to achieve
this useful functionality, so i keep using Windows more heavily than i want (Thanks Skyrim, shame on me).

Just today i tryed to use ubuntu server virtual mashine, configured to use with windows and encoutered some problems.

So handy advise if you want to use virtual mashine in different operating systes:

1. Don't forget to remove VBoxAdditions disk after additions intallation.
Paths in ubuntu and windows to that disk are equally not acceptable.

2. If you, like me, use two adapters to connect virtual mashine to internet (NAT) and to host (Hast only Network) you
probably would be surprized to know, VirtualBox have different names for second one in linux and windows. And, yes,
these names are incompatible too. So after OS chnge you shold go to VM settings and open window with Host only netwoerk
settings. After that name will be change to propper for current OS. (Why have they done this?)

After that if you have network properly set up - you shouldn't fill any differece. All work like clock.
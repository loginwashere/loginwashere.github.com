---
layout: post
title: "symbol 'grub_term_highlight_color' not found"
date: 2014-10-21 22:42
comments: true
categories: 
- ubuntu
---
Those lines from title wasn't exactly expected to appear after ubuntu 14.04 update.

It all started kinda from the wrong foot when I decided to finally update my home dual boot setup - ubuntu 13.04/win7.

During the update from 13.04 to 13.10 (it isn't possible to update from 13.04 to 14.04 - you need to go through all steps)
Dropbox failed to update and I noticed this only when I got home from work in the evening. Day wasted.

But I decided that it wasn't a big deal and I simply cancelled distro upgrade.
After reboot I noticed that I already have 13.10. That's cool I thought andmoved to upgrade to 14.04 after removing Dropbox.
All went fine and in the end I clicked Reboot now in the modal window.

And that is when I faced black screen with error from title. To make colors darker - I even couldn't get to bios when I pressed reboot like 10 times.
Strange behaviour. But then I switched computer off and on and was able to get to bios. Hooray.

Hopefully I have notebook and I was able to google solution for this inconvenience.
As it always happens first solution is to wipe all drives clean and reinstall everything. 

No way I said and kept searching.
After some time I found this [link](http://askubuntu.com/questions/449818/cant-find-boot-repair-package-for-the-newest-version-of-ubuntu) which helped me to solve my problem.

Basically all you need is:

* to create boot cd (wait what?) or flash stick
* boot from it
* select "Try ubuntu" option (I assume you created ubuntu boot cd/usb)
* install boot-repair

```
sudo add-apt-repository ppa:yannubuntu/boot-repair
sudo sh -c "sed -i 's/trusty/saucy/g' /etc/apt/sources.list.d/yannubuntu-boot-repair-trusty.list"
sudo apt-get update
sudo apt-get install -y boot-repair && (boot-repair &)
```

As you can see this helpful tool isn't available for 14.04 and you need to switch it's sources to previous ubuntu version.

* run

```
sudo boot-repair
```

When tool starts it is quite easy to understand what to do (I selected recommended repair)
After some time it said that all done and I was able to load both new ubuntu and good old win7. 
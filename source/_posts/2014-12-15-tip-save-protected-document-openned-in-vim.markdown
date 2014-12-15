---
layout: post
title: "Tip: Save document opened in vim without permissions"
date: 2014-12-15 19:47
comments: true
categories: 
- dev
- linux
- vim
---
This one can save some time for you. How much? It depends on how often you use vim and what you do with it.

Imagine you opened a document im vim and started making changes. Time goes by and you decide to save the document.
And guess what - you do not have permissions to do this. You opened some config in /etc/something but you did this as regular user.

At this point you have several ways to overcome this problem, but I only use this one lately.

All you need is instead of typing

```
:w
```

to save document, type

```
:w sudo tee  %
```

Well, I won't pretend, at the moment I do not know what this command do exactly, but it helps.
This way you can save document (if you know user password or user do not need one and if user can run sudo command)
---
layout: post
title: "Tip: ssh-copy-id alternative"
date: 2014-09-30 00:32
comments: true
categories:
- dev
- ssh
---
This one snippet also start to appear in my search results more often.

```
cat ~/.ssh/id_rsa.pub | ssh -o PubkeyAuthentication=no user@192.168.33.10 "mkdir ~/.ssh; cat >> ~/.ssh/authorized_keys"

```

The key part of this one liner is:

```
-o PubkeyAuthentication=no
```

 You can't specify it for ssh-copy-id and without it you get this error

```
$ Received disconnect from host: 2: Too many authentication failures for user
```

 Also other solutions can be found [here](http://superuser.com/questions/187779/too-many-authentication-failures-for-username)



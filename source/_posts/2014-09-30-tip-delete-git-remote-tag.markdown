---
layout: post
title: "Tip: Delete git remote tag"
date: 2014-09-30 00:12
comments: true
categories:
- git
- dev
---
For a quite long period of time I've been using this method to delete remote tag in git repository:

- Find myself in a situation when you totally need to remove that pushed tag
- Feel frustrated, because even after doing this more than 10 times I still fail to remember the command
- Google the command
- Click on that purple link - first in search results for "git delete remote tag"
- Look at the command and feel embarrassed again
- Copy paste the command to the terminal window.

Today  must admit that I have the problem and the first step to overcome it - add link to solution to this blog:

```
git tag -d 12345
git push origin :refs/tags/12345
```

[source](http://nathanhoad.net/how-to-delete-a-remote-git-tag)
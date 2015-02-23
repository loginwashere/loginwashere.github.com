---
layout: post
title: "Moving server to Virtual box or wildcard virtual domains"
date: 2012-01-01 00:15
published: false
comments: true
categories:
- ubuntu
- VirtualBox
---
{% img http://i.imgur.com/nAByQ.png %}

Currently i work with LAMP stack and therefore i'm used to creating virtual hosts for all projects, even small ones.
Assuming that development is going on Ubuntu, Virtual Host creation is quite quick and easy operation.
<!-- more -->
``` bash
# Create project public folder
mkdir /home/%username%/vhosts/%sitename%

# Create file, that will be containing virtual Host description
#
# In Ubuntu Virtual Host descriptions are stored in folder
# /etc/apache2/sites-available/ one host per file

sudo vi /etc/apache2/sites-available/%sitename%
```
ATTENTION:
If you don't like vi, vim or whatever
you can create and edit file with any editor you like.

If you started vi and don't know how to exit press <Esc> and then type :q and press <Enter>
```
# Add record describing Virtual Host
<VirtualHost *:80>
    ServerName %sitename%
    ServerAlias %sitename%
    DocumentRoot /home/lwh/vhosts/%sitename%
</VirtualHost&gt

# (Instead of creating you can copy default file and then edit it)
# sudo cp /etc/apache2/sites-avalable/default /etc/apache2/sites-available/%sitename%

# "Enabling site"
# Create link from /etc/apache2/sites-available/%sitename%
# to /etc/apache2/sites-enabled/%sitename%
sudo a2ensite %sitename%

# To apply changes reload or reboot apache with a command
sudo service apache reload

# Add sitename ofyoursite to hosts file
# 127.0.0.1 %sitename%
sudo vi /etc/hosts
```
Just five commands and you can access site on http://%sitename%.
But this proccess can be simplified.

Вроде бы ничего сложного, но когда создаешь н-адцатый проект, начинаешь задумываться об автоматизации и еще большем
упрощении процедуры. Можно создать скрипт, который сведет все к запуску скрипта и вводу названия проекта,
дополнительный параметров.

Кому-то это решение покажется достаточным, но я искал путь с еще меньшим количеством телодвижений.
При этом хотелось разделить сервер и рабочую машину и иметь возможность работать над проектами как из Ubuntu так и из Windows.
Так как компьютер у меня один, то для отделния сервера решил использовать Virtual Box.
Установив на виртуальную машину Ubuntu Server столкнулся с задачей доступа к виртуальным хостам виртуальной машины.
При поиске решения наткнулся на замечательную программу dnsmasq – простой в использовании и настройкt DNS и DHCP сервер.

Следует отметить, что сеть на виртуально машине у меня настроена так: NAT (Network Address Translation) для
доступа в интернет для всяких обновлений и установок новых пакетов (При этом подключении нет доступа из хоста к гостю)
и виртуальный адаптер хоста (Host-only Adapter) для обеспечения связи между хостом и гостем.
Для настройки сети сос стороны хоста я только отметил нужные пункты в настройках сети Virtual Box.
Затем, при запустке виртуальной машины на хосте создался адаптер с названием vboxnet0 в Ubuntu и
VirtualBox Host-Only Network в Windows. Это довольно неприятная особенность Virtual Box мешает легкому
использованию одной виртуальной машины на разных хостах если одним из адаперов является виртуальный адаптер хоста.
Также отличается ip адрес этого адаптера по умолчанию (В Windows назначается 192.168.137.1, в то время как в Ubuntu 192.168.56.1).
С чем связаны эти различия я не знаю, но нужно иметь их ввиду.
Для хоста я выбрал ip 192.168.137.1, для гостя – 192.168.137.3.

On the guest mashine NAT adapter recieves network automaticly over DHCP and works immediatly.

На госте NAT адаптер получает настройки сети автоматически и работает сразу из каробки.
Добавить адаптер для виртуального адаптера хоста на гость можно добавив настройки в файл /etc/network/interfaces
```
# eth0 - default unterface, used for NAT
# therefore for new interface i choose name eth1
# If you already have interface with that name - choose another name.
auto eth1
iface eth1 inet static
# guest ip
address 192.168.137.3
# host ip
gateway 192.168.137.1
netmask 255.255.255.0
```
If you want apply these settings you need to execute command
```
sudo /etc/init.d/networking restart
```
Install dnsmasq on virtual mashine
```
sudo apt-get install dnsmasq
```
и получаем DNS сервер, который будет обрабатывать запросы к виртуальной машине и отдавать виртуальные хосты.
По этой ссылке можно посмотреть настройки программы, их описание и некоторые примеры.

Among them we are interested in next settings:
```
# ip адрес - это ip адрес гостя
# Первый параметр посылает все запросы к *.site.local на 192.168.137.3
address=/site.local/192.168.137.3
# Второй - определяет запросы на какой адрес будет слушать DNS сервер
listen-address=192.168.137.3
```
Их нужно раскомментировать и заменить ip адрес на адрес виртуальной машины(192.168.137.3), и выбрать название для домена,
на котором у вас будут находиться локальные проекты(site.local).

Чтобы воспользоваться DNS сервером необходимо проинформировать о его существовании виртуальную машину.
Для этого на госте откроем файл
Open file on guest mashine
```
sudo vi /etc/resolv.conf
```
and add record about server
```
# This line should be placed in the beggining of file.
nameserver 192.168.137.3
```
Also you need to add new DNS server record on host


Теперь возмемся за apache. Для облегчения создания виртуальных хостов воспользуемся его модулем mod_vhost_alias.
Этот модуль позволит создавать виртуальный хост простым созданием директории. Включить его можно следующей командой
```
sudo a2enmod vhost_alias
```
Create Virtual Host. Your projects will be accessible on it's subdomains.
```
sudo vi /etc/apache2/sites-available/site.local
# Add next lines to this file
<VirtualHost *:80>
    ServerName site.local
    ServerAlias *.site.local
    VirtualDocumentRoot /home/%username%/vhosts/%1
</VirtualHost&gt
# Do not forget to reload or restsrt apache
sudo service apache reload
```
Lets check if everything works.
```
mkdir /home/%username%/vhosts/test
echo <h1>Hello Virtual Host</h1> > /home/%username%/vhosts/test/index.php
```
Now you can open in browser page http://test.site.local and see text: "Hello Virtual Host".
Congratulations - you've made your life a bit easier.

Links

1. dnsmasq settings explained
2. Мультидоменность в Apache без лишних хлопот на локальном хосте
3. http://httpd.apache.org/docs/2.0/mod/mod_vhost_alias.html
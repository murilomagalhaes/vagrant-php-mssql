#  VagrantBox with PHP, Apache, and Microsoft SQL Server.

This is a complete development environment for working with PHP and MS SQL Server. 
**Based on Ubuntu 20.04 (Focal)**  🐧



## Provisions
**This Box comes bundled with the following goodies**
- PHP 7.4.X (With common mods to work with modern MVC Frameworks, and the MS SQL Server Drivers)
- Composer (Latest Ver.)
- Apache 2 (With mod_rewrite enabled)
- Git
- NodeJS (10.x)
- Microsoft SQL Server 2019 (Dev. Edition)

## Requirements
**Make sure you have these installed and ready to go.**
- VirtualBox
- Vagrant
- Git

## Usage
- `mkdir desired_directory`
- `cd desired_directory`
- `git clone https://github.com/murilomagalhaes/vagrant-php-mssql.git .`
- `vagrant up`
- `Make yourself some coffe while it loads everything!` ☕

## Default configurations:
**MS SQL Server**
- User: `sa`
- Pass: `Mssql@vagrant`
- Port: `1434`

**Apache**

The Default apache public directory `/var/www/` is synced to the `apps` directory on the box's root. That's where your app(s) go! 

You can access them on your host machine via the ip `192.168.33.20`

**If you wish to change any of these default configurations, just edit the `VagrantFile` and run `vagrant reload`**

## Tips:
- To connect to your database on your host machine using MS SQL Management Studio, you need to inform `localhost, 1434` on the Server Name since I'm not using the default port.

- Connecting via HeidiSQL can be problematic. I couldn't make it work.

- If you're having problems connecting with the box on Windows 10 running `vagrant ssh`,
try to disable Windows 10's default ssh client. (This can be usually done under `Settings > Apps > Additional Resources`) 

- You can change the ammount of CPUs and RAM by changing it on the VagrantFile. By default, it is set to 1 CPU and 2GB.




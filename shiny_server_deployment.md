# Shiny Server Deployment for Ubuntu 12.04
*Mansun Kuo*

*2014-10-07*

## Dependency

### R

[Installing R](http://cran.rstudio.com/bin/linux/ubuntu/README.html)


```bash
sudo vim /etc/apt/sources.list
```

add:

```bash
# R
deb http://cran.rstudio.com/bin/linux/ubuntu precise/
deb-src http://cran.rstudio.com/bin/linux/ubuntu precise/
```

```bash
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
sudo apt-get update
sudo apt-get install r-base
```

### Curl

Install libcurl for package RCurl ([reference](http://www.omegahat.org/RCurl/FAQ.html)).

```
apt-get install curl libcurl4-openssl-dev
```

### Shiny Server

#### Install Shiny Server

You may need to set proxy to install R packages([ref](http://stackoverflow.com/questions/6467277/proxy-setting-for-r)).
In R command line, set th proxy using

```
Sys.setenv(http_proxy="your proxy")
```

Download [Shiny Server](http://www.rstudio.com/products/shiny/download-server/) 

You may also need [Rstudio Server](http://www.rstudio.com/products/rstudio/download-server/) for development purpose.

Related documents:

- [Administrator's Guide](http://rstudio.github.io/shiny-server/latest/)


#### Reverse Proxy

[Running with a Proxy](https://support.rstudio.com/hc/en-us/articles/200552326-Running-with-a-Proxy)

For apache on Ubuntu 12.04:

```
sudo apt-get install apache2
sudo apt-get install libapache2-mod-proxy-html
sudo apt-get install libxml2-dev
sudo a2enmod proxy
sudo a2enmod proxy_http
```

Setting of /etc/apache2/httpd.conf

```http
<VirtualHost *:80>

  <Proxy *>
    Allow from localhost
  </Proxy>

  ProxyPass        /rstudio/ http://localhost:8787/
  ProxyPassReverse /rstudio/ http://localhost:8787/
  RedirectMatch permanent ^/rstudio$ /rstudio/
  
  ProxyPass        /shiny/ http://localhost:3838/
  ProxyPassReverse /shiny/ http://localhost:3838/
  RedirectMatch permanent ^/shiny$ /shiny/

</VirtualHost>

```

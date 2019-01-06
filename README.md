<p align="center">
<a href="https://hub.docker.com/r/deercloud/gost">
<img src="https://user-images.githubusercontent.com/2666735/50733201-504d0d80-11c4-11e9-8f71-a096368f9778.png" />
</a>
</p>

<h1 align="center">gost</h1>

<p align="center">a simple tunnel written in golang.</p>

<p align=center>
<a href="https://hub.docker.com/r/deercloud/gost">Docker Hub</a> ·
<a href="https://github.com/ginuerzh/gost">Project Source</a> ·
<a href="https://t.me/linuxUpdate">Telegram Channel</a>
</p>

***

## latest version

|version|
|---|
|deercloud/gost:latest|
|deercloud/gost:current|
|deercloud/gost:2.7.0|


## environment variables

|name|value|
|---|---|
|SERVER_ADDR|0.0.0.0|
|SERVER_PORT|8080|
|**DNS**|8.8.8.8,8.8.4.4|
|**PROTOCOL**|socks5|
|**TRANSPORT**|tcp|
|**USERNAME**|-|
|**PASSWORD**|-|

***

### Pull the image

```bash
$ docker pull deercloud/gost
```

### Start a container

```bash
$ docker run -p 8080:8080 -p 8080:8080/udp -d \
  --restart always --name=gost deercloud/gost
```

### Display logs

```bash
$ docker logs gost

  HOST: 0.0.0.0
  PORT: 8080
  Protocol: socks5
  Transport: tcp

  gost start!
```

### Example of Shadowsocks

Server (example.com)

 > setting emcrypt-method in USERNAME

```bash
$ docker run -p 8838:8080 -p 8838:8080/udp -d \
  -e PROTOCOL=ss \
  -e USERNAME=chacha20 \
  -e PASSWORD=deercloud \
  --restart always --name=gost_shadowsocks deercloud/gost
```

Client (ss-local)

```bash
$ ss-local -s example.com -p 8838 -l 1080 -m chacha20 -k deercloud

2019-01-06 15:22:17 INFO: initializing ciphers... chacha20
2019-01-06 15:22:17 INFO: listening at 127.0.0.1:1080
```

Browser (curl)

```bash
$ curl -x socks5h://127.0.0.1:1080 http://www.google.com/ -I

HTTP/1.1 200 OK
Date: Sun, 06 Jan 2019 07:26:15 GMT
Expires: -1
Cache-Control: private, max-age=0
Content-Type: text/html; charset=ISO-8859-1
P3P: CP="This is not a P3P policy! See g.co/p3phelp for more info."
Server: gws
X-XSS-Protection: 1; mode=block
X-Frame-Options: SAMEORIGIN
Transfer-Encoding: chunked
Accept-Ranges: none
Vary: Accept-Encoding
```

or Client (Surge 3)*

![Surge 3](https://user-images.githubusercontent.com/2666735/50733403-f4848380-11c7-11e9-9073-585eac0ab0a8.png)


### Example of Socks5 over TLS

Server (example.com)

```bash
$ docker run -p 8838:8080 -p 8838:8080/udp -d \
  -e PROTOCOL=socks5 \
  -e TRANSPORT=tls \
  -e USERNAME=deercloud \
  -e PASSWORD=123456 \
  --restart always --name=gost_socks5_over_tls deercloud/gost
```

Client (gost)

```bash
$ gost -L=:1080 -F=socks5+tls://deercloud:123456@example.com:8838
```

Browser (curl)

```bash
$ curl -x socks5h://127.0.0.1:1080 http://www.google.com/ -I

HTTP/1.1 200 OK
Date: Sun, 06 Jan 2019 07:30:19 GMT
Expires: -1
Cache-Control: private, max-age=0
Content-Type: text/html; charset=ISO-8859-1
P3P: CP="This is not a P3P policy! See g.co/p3phelp for more info."
Server: gws
X-XSS-Protection: 1; mode=block
X-Frame-Options: SAMEORIGIN
Transfer-Encoding: chunked
Accept-Ranges: none
Vary: Accept-Encoding
```

Client (Surge 3)*

![Surge 3](https://user-images.githubusercontent.com/2666735/50733474-15010d80-11c9-11e9-97cc-888ebe5f6bd9.png)

How to add to KASM 
(These screenshots are from the Windsurf-based Kasm image, but they’re the same.)

Get Dockerfile from this repo to KASM machine and run
```
sudo docker build -t ubuntu-noble:cursor -f Dockerfile .
```

![image](https://somnitelnonookay.ucoz.net/kasm-config1.png)

Cursor thumbnail: 
```
https://upload.wikimedia.org/wikipedia/commons/e/e1/Cursor_logo.png
```

![image](https://somnitelnonookay.ucoz.net/kasm-config2.png)

Docker image: 
```ubuntu-noble:cursor```

![image](https://somnitelnonookay.ucoz.net/kasm-config3.png)

Persistent profile path example: 
```/mnt/data/kasm/profiles/{username}/{image_id}```
If you don’t specify a persistent profile, your login session won’t be saved between Kasm Workspace restarts.

Docker run override config: 
```
{
  "environment": {
    "KASM_PROFILE_FILTER": "null"
  }
}
```

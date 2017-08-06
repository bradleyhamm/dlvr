# dlvr
D-Link Video Recorder

## Summary
Downloads `n` consecutive `s`-second MJPEG videos from a networked D-Link camera and converts it to MP4.

## Usage
```
./dlvr.sh <username:password> <url> <seconds> <count> <outfile base>
```

### Example
(Creates 8 consecutive 1-hour videos, which will be named "output-YYYYMMDD-HHMMSS.mp4".)

```
./dlvr.sh user:pass http://192.168.1.23 3600 8 output
```

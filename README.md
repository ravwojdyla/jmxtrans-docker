To build:

```
docker build -t df-eye-jmxtrans .
```

To test:

```
docker run --rm --volumes-from jmx-config df-eye-jmxtrans
```

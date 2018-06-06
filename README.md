# DraftReferencingSourceInParentDir

## Draft Referencing Source in Parent Directory

The goal is to use `draft up` to deploy this application to a Kubernetes cluster. The challange is that the app is referencing a library from the parent directory. `draft up` cannot execute in the example-dotnet project directory since the `docker build` will return a `no such file or directory` error for the library project.

```
cd [App Root]\src\example-dotnet
docker build -t ivanfarkas/example-dotnet .
```

**Result**

```
Step 6/19 : COPY src/Lib/Lib.csproj src/Lib/
COPY failed: stat /var/lib/docker/tmp/docker-builder019484501/src/Lib/Lib.csproj: no such file or directory
```

`docker build` have to be called from the solution root directory to build a docker image and run it. This is demonstrated below. The app is working on docker following these steps.

```
cd [Solution Root]
docker build -t ivanfarkas/example-dotnet -f src/example-dotnet/Dockerfile .
docker run -p 8080:80 ivanfarkas/example-dotnet
```

Open a new console

```
curl localhost:8080
```

**Result**

```
Hello World! 2
```

## Question
How do I use `draft up` when the app is referencing a library from the parent directory?

#cd C:\Projects\Kubernetes\Draft\Test\DraftReferencingSourceInParentDir
#docker build -t ivanfarkas/draft-referencing-source-in-parent-dir -f src/example-dotnet/Dockerfile .
#docker run -p 8080:80 ivanfarkas/draft-referencing-source-in-parent-dir
#curl localhost:8080

FROM microsoft/dotnet:2.1-aspnetcore-runtime AS base
WORKDIR /app
EXPOSE 80

FROM microsoft/dotnet:2.1-sdk AS build
WORKDIR /src
COPY src/Lib/Lib.csproj src/Lib/
COPY src/example-dotnet/WebApplication.csproj src/example-dotnet/
RUN dotnet restore src/example-dotnet/WebApplication.csproj
COPY . .
WORKDIR /src/src/example-dotnet
RUN dotnet build WebApplication.csproj -c Release -o /app

FROM build AS publish
RUN dotnet publish WebApplication.csproj -c Release -o /app
RUN sed -n 's:.*<AssemblyName>\(.*\)</AssemblyName>.*:\1:p' *.csproj > __assemblyname
RUN if [ ! -s __assemblyname ]; then filename=$(ls *.csproj); echo ${filename%.*} > __assemblyname; fi

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "WebApplication.dll"]
#ENTRYPOINT dotnet $(cat /app/__assemblyname).dll
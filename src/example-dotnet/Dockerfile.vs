FROM microsoft/dotnet:2.1-aspnetcore-runtime AS base
WORKDIR /app
EXPOSE 80

FROM microsoft/dotnet:2.1-sdk AS build
WORKDIR /src
COPY src/example-dotnet/WebApplication.csproj src/example-dotnet/
COPY src/Lib/Lib.csproj src/Lib/
RUN dotnet restore src/example-dotnet/WebApplication.csproj
COPY . .
WORKDIR /src/src/example-dotnet
RUN dotnet build WebApplication.csproj -c Release -o /app

FROM build AS publish
RUN dotnet publish WebApplication.csproj -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "WebApplication.dll"]

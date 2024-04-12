#See https://aka.ms/customizecontainer to learn how to customize your debug container and how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/sdk:7.0-alpine AS builder

COPY . .

WORKDIR /src

RUN dotnet restore

RUN dotnet publish DotNetDevOps/DotNetDevOps.csproj -c Release -o /app

RUN dotnet test --logger "trx;LogFileName=./aspnetapp.trx"

FROM mcr.microsoft.com/dotnet/aspnet:7.0-alpine

COPY --from=builder /app .

ENTRYPOINT ["dotnet", "DotNetDevOps.dll"]
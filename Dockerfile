FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
EXPOSE 80


FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY ["DotNetDevOps/DotNetDevOps.csproj", "DotNetDevOps/"]
RUN dotnet restore "DotNetDevOps/DotNetDevOps.csproj"
COPY . .
WORKDIR "/src/DotNetDevOps"
RUN dotnet build "DotNetDevOps.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "DotNetDevOps.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "DotNetDevOps.dll"]
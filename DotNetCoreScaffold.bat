@echo 请修改批处理文件名后，如：Example.Core ，注释掉goto end，再执行脚本
pause
goto end
::goto end

set name=%~n0

mkdir %name%.Model
cd %name%.Model
dotnet new classlib --framework netcoreapp3.0
dotnet add package log4net
dotnet add package Newtonsoft.Json
dotnet add package Dapper
dotnet add package Oracle.EntityFrameworkCore
dotnet add package Oracle.ManagedDataAccess.Core
dotnet add package Microsoft.EntityFrameworkCore
dotnet add package Microsoft.EntityFrameworkCore.Relational
dotnet add package Microsoft.EntityFrameworkCore.Design
dotnet add package Microsoft.EntityFrameworkCore.Tools
cd ..

mkdir %name%.General
cd %name%.General
dotnet new classlib --framework netcoreapp3.0
dotnet add package log4net
dotnet add package Newtonsoft.Json
cd ..

mkdir %name%.DAL
cd %name%.DAL
dotnet new classlib --framework netcoreapp3.0
dotnet add package log4net
dotnet add package Newtonsoft.Json
dotnet add package Dapper
dotnet add package Oracle.EntityFrameworkCore
dotnet add package Oracle.ManagedDataAccess.Core
cd ..
dotnet add %name%.DAL/%name%.DAL.csproj reference %name%.Model/%name%.Model.csproj

mkdir %name%.BLL
cd %name%.BLL
dotnet new classlib --framework netcoreapp3.0
dotnet add package log4net
dotnet add package Newtonsoft.Json
cd ..
dotnet add %name%.BLL/%name%.BLL.csproj reference %name%.Model/%name%.Model.csproj
dotnet add %name%.BLL/%name%.BLL.csproj reference %name%.General/%name%.General.csproj
dotnet add %name%.BLL/%name%.BLL.csproj reference %name%.DAL/%name%.DAL.csproj

mkdir %name%.Api
cd %name%.Api
dotnet new webapi
dotnet add package log4net
dotnet add package Newtonsoft.Json
dotnet add package Autofac
dotnet add package Autofac.Extensions.DependencyInjection
dotnet add package AutoMapper
dotnet add package Dapper
dotnet add package Microsoft.Extensions.Options
dotnet add package Microsoft.Extensions.Caching.Abstractions
dotnet add package Microsoft.VisualStudio.Web.CodeGeneration.Design
dotnet add package Oracle.EntityFrameworkCore
dotnet add package Oracle.ManagedDataAccess.Core
dotnet add package Microsoft.EntityFrameworkCore
dotnet add package Microsoft.EntityFrameworkCore.Relational
dotnet add package Microsoft.EntityFrameworkCore.Design
dotnet add package Microsoft.EntityFrameworkCore.Tools
cd ..
dotnet add %name%.Api/%name%.Api.csproj reference %name%.Model/%name%.Model.csproj
dotnet add %name%.Api/%name%.Api.csproj reference %name%.General/%name%.General.csproj
dotnet add %name%.Api/%name%.Api.csproj reference %name%.BLL/%name%.BLL.csproj

goto :next

mkdir %name%.Web
cd %name%.Web
dotnet new mvc
dotnet add package log4net
dotnet add package Newtonsoft.Json
dotnet add package Autofac
dotnet add package Autofac.Extensions.DependencyInjection
dotnet add package AutoMapper
dotnet add package AutoMapper.Extensions.Microsoft.DependencyInjection
dotnet add package Dapper
dotnet add package Microsoft.Extensions.Options
dotnet add package Microsoft.Extensions.Caching.Abstractions
dotnet add package Microsoft.VisualStudio.Web.CodeGeneration.Design
dotnet add package Oracle.EntityFrameworkCore
dotnet add package Oracle.ManagedDataAccess.Core
dotnet add package Microsoft.EntityFrameworkCore
dotnet add package Microsoft.EntityFrameworkCore.Relational
dotnet add package Microsoft.EntityFrameworkCore.Design
dotnet add package Microsoft.EntityFrameworkCore.Tools
cd ..
dotnet add %name%.Web/%name%.Web.csproj reference %name%.Model/%name%.Model.csproj
dotnet add %name%.Web/%name%.Web.csproj reference %name%.General/%name%.General.csproj
dotnet add %name%.Web/%name%.Web.csproj reference %name%.BLL/%name%.BLL.csproj

:next

mkdir %name%.Test
cd %name%.Test
dotnet new console
dotnet add package log4net
dotnet add package Newtonsoft.Json
dotnet add package Dapper
dotnet add package Oracle.EntityFrameworkCore
dotnet add package Oracle.ManagedDataAccess.Core
cd ..
dotnet add %name%.Test/%name%.Test.csproj reference %name%.Model/%name%.Model.csproj
dotnet add %name%.Test/%name%.Test.csproj reference %name%.General/%name%.General.csproj
dotnet add %name%.Test/%name%.Test.csproj reference %name%.BLL/%name%.BLL.csproj
dotnet add %name%.Test/%name%.Test.csproj reference %name%.DAL/%name%.DAL.csproj

mkdir %name%.Tools
cd %name%.Tools
dotnet new winforms
dotnet add package log4net
dotnet add package Newtonsoft.Json
dotnet add package Dapper
dotnet add package Oracle.EntityFrameworkCore
dotnet add package Oracle.ManagedDataAccess.Core
cd ..
dotnet add %name%.Tools/%name%.Tools.csproj reference %name%.Model/%name%.Model.csproj
dotnet add %name%.Tools/%name%.Tools.csproj reference %name%.General/%name%.General.csproj
dotnet add %name%.Tools/%name%.Tools.csproj reference %name%.BLL/%name%.BLL.csproj
dotnet add %name%.Tools/%name%.Tools.csproj reference %name%.DAL/%name%.DAL.csproj

mkdir %name%.Service
cd %name%.Service
dotnet new grpc
dotnet add package log4net
dotnet add package Newtonsoft.Json
dotnet add package Dapper
dotnet add package Oracle.EntityFrameworkCore
dotnet add package Oracle.ManagedDataAccess.Core
dotnet add package Grpc
dotnet add package Grpc.Tools
dotnet add package Google.Protobuf
cd ..
dotnet add %name%.Service/%name%.Service.csproj reference %name%.Model/%name%.Model.csproj
dotnet add %name%.Service/%name%.Service.csproj reference %name%.General/%name%.General.csproj
dotnet add %name%.Service/%name%.Service.csproj reference %name%.BLL/%name%.BLL.csproj
dotnet add %name%.Service/%name%.Service.csproj reference %name%.DAL/%name%.DAL.csproj

:sln

::创建解决方案，并把所有工程项目加入解决方案
dotnet new sln -n %name%
for /d %%i in (*) do ( 
echo %%i
dotnet sln %name%.sln add %%i/%%i.csproj
)

::编译解决方案
dotnet build

:end

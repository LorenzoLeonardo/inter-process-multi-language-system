git submodule update --init --recursive

rem "start building the rust components........"
cd ipc-server
cargo build --release
cd ..
cd modern-auth-service
cargo build --release
cd ..
cd emailer-service
cargo build --release
cd ..

rem "start building the MFC C++ components........"
cd smtp-xoauth2
set MSBUILD_PATH="C:\Program Files\Microsoft Visual Studio\2022\Community\Msbuild\Current\Bin\MSBuild.exe"
set SOLUTION_FILE=smtp-xoauth2.sln
set BUILD_CONFIGURATION=Release
%MSBUILD_PATH% %SOLUTION_FILE% /t:Build /p:Configuration=%BUILD_CONFIGURATION%
cd ..

mkdir release

copy /Y ipc-server\target\release\ipc_server.exe release
copy /Y modern-auth-service\target\release\modern-auth-service.exe release
copy /Y emailer-service\target\release\emailer-service.exe release
copy /Y smtp-xoauth2\x64\Release\smtp-xoauth2.exe release
git submodule update --init --recursive

rem "start building the MFC C++ components........"
cd smtp-xoauth2
set MSBUILD_PATH="C:\Program Files\Microsoft Visual Studio\2022\Enterprise\Msbuild\Current\Bin\MSBuild.exe"
set SOLUTION_FILE=smtp-xoauth2.sln
set BUILD_CONFIGURATION=Release
%MSBUILD_PATH% %SOLUTION_FILE% /t:Build /p:Configuration=%BUILD_CONFIGURATION%
cd ..

rem "start building the rust components........"
cd remote-call
rmdir /s /q target
cargo build --release
cd ..

cd modern-auth-service
rmdir /s /q target
cargo build --release
cd ..

cd emailer-service
rmdir /s /q target
cargo build --release
cd ..

mkdir release

copy /Y remote-call\target\release\remote-call.exe release
copy /Y modern-auth-service\target\release\modern-auth-service.exe release
copy /Y emailer-service\target\release\emailer-service.exe release
copy /Y smtp-xoauth2\x64\Release\smtp-xoauth2.exe release
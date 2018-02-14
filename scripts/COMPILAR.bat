rem devenv /build Release Solution.sln

rem "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\Common7\IDE\devenv.exe" /build Debug  "C:\Users\Administrador\Documents\bdl\pronto\ProntoMVC.sln" 
rem "C:\Program Files (x86)\Microsoft Visual Studio 12.0\Common7\IDE\devenv.exe" /build Debug  "C:\Users\Administrador\Documents\bdl\ProntoCartaPorte.sln" 

rem This requires Visual Studio to be installed on the machine executing the build. msbuild is available with .net framework.


"C:\Windows\Microsoft.NET\Framework\v4.0.30319\msbuild"  "C:\Users\Mariano\Documents\pronto\ProntoMVC.sln"   /p:DeployOnBuild=true /p:PublishProfile=local /p:WarningLevel=0



rem "C:\Program Files (x86)\WinSCP\WinSCP.exe" "administrador@bdlconsultores.sytes.net" /synchronize /defaults  /nointeractiveinput /rawsettings .hg; web.config; elmah.sdf; \Error; \obj; \Reportes; \WebFormsViejo; DataBackupear; sgbak; SSRS; CVS


pause
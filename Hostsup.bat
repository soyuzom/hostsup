@echo off
mode con lines=31 cols=60
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit
cd /d "%~dp0"
set hostsfile="%SYSTEMROOT%\System32\Drivers\etc\hosts"
set dowhosts="%temp%\dowhosts.vbs"
set win7=::
if /i not exist "%SystemRoot%\System32\choice.exe" set win7=::
:: 下行为默认的HOSTS链接
set hosts0=https://github.com/Lerist/Go-Hosts/raw/master/hosts
set hosts0=https://coding.net/u/scaffrey/p/hosts/git/raw/master/hosts
set hosts0=https://coding.net/u/idoog/p/HOSTS/git/raw/master/hosts
set hosts1=https://github.com/vokins/yhosts/raw/master/hosts

title Hosts远程下载更新工具5.2
:main
mode con lines=31 cols=60
if /i not exist defined_hosts.txt goto defined_hosts >NUL 2>NUL
cls
color 5f
echo.
echo  √    √     √√√      √√√√  √√√√√    √√√√
echo  √    √   √      √  √      √  √  √  √  √      √
echo  √    √   √      √  √              √      √
echo  √√√√   √      √    √√          √        √√
echo  √    √   √      √        √        √            √
echo  √    √   √      √          √      √              √
echo  √    √   √      √  √      √      √      √      √
echo  √    √     √√√     √√√√       √       √√√√
echo.
echo.----------------------------------------------------------- 
echo. 360、电脑管家等安全软件提醒，请勾选信任允许和不再提醒！
echo.
echo. 如果自己修改过hosts信息，请复制到 defined_hosts.txt
echo.【defined_hosts.txt】文件可自定义hosts，更新会自动合并。
echo.
echo. 警告：执行该命令 您的 HOSTS 会将被自动替换覆盖！
echo.-----------------------------------------------------------
echo. 请选择使用：
echo.
echo. 
echo.  [1] 远程下载更新 HOSTS(默认)   [2] 打开 defined_hosts.txt
echo.  [3] 自定义 HOSTS 链接          [4] 恢复初始 HOSTS
echo.  [5] 打开系统 HOSTS 目录
echo.
:: https://coding.net/u/idoog/p/HOSTS/
echo.-------------------------------------------------idoog.me--
%win7%goto Choice
set choice=1
set /p choice=请输入选项(默认=1):

echo.
if /i %choice%==5 start "" explorer.exe /select,%hostsfile% && goto main
if /i %choice%==4 goto CL
if /i %choice%==3 goto customize
if /i %choice%==2 start "" explorer.exe /select,defined_hosts.txt && goto main
if /i %choice%==1 goto host DNS
cls
set choice=
echo.您输入有误，请重新选择。
ping 127.0.1 -n "4">nul
goto main

:Choice
choice /c 12345 /n /m "请输入您的选择："
if errorlevel 5 start "" explorer.exe /select,%hostsfile% && goto main
if errorlevel 4 goto CL
if errorlevel 3 goto customize
if errorlevel 2 start "" explorer.exe /select,defined_hosts.txt && goto main
if errorlevel 1 goto host DNS
cls
goto main

:host DNS
%win7%goto Choice2

set AD=n
set ADs=::
set /p AD=是否更新去广告源[Y/N](回车键=N):%=% 
::
if /i %AD%==y set ADs= && goto JJ
if /i %AD%==N goto JJ
goto JJ

:Choice2
choice /d 1 /t 6 /m "请输入您的选择(6s=Y):"
if errorlevel 2 set ADs= && goto JJ
if errorlevel 1 goto JJ

::
:jj
cls
echo.-----------------------------------------------------------
echo.
echo # 正在下载 HOSTS...
echo.
if /i exist host ( del /f /q host )
if /i exist host1 ( del /f /q host1 )
if /i exist host2 ( del /f /q host2 )
if /i exist host3 ( del /f /q host3 )
if /i exist hosts ( del /f /q hosts )
if /i exist %dowhosts% ( del /f /q %dowhosts% )
echo Sub download(url,target) > %dowhosts%
echo 	Const adTypeBinary = 1 >> %dowhosts%
echo 	Const adSaveCreateOverWrite = 2 >> %dowhosts%
echo 	Dim http,ado >> %dowhosts%
echo 	Set http = CreateObject("MSXML2.ServerXMLHTTP") >> %dowhosts%
echo 	http.open "GET",url,False >> %dowhosts%
echo 	http.send >> %dowhosts%
echo 	Set ado = createobject("Adodb.Stream") >> %dowhosts%
echo 	ado.Type = adTypeBinary >> %dowhosts%
echo 	ado.Open >> %dowhosts%
echo 	ado.Write http.responseBody >> %dowhosts%
echo 	ado.SaveToFile target >> %dowhosts%
echo 	ado.Close >> %dowhosts%
echo End Sub >> %dowhosts%
::
echo download "%hosts0%","%cd%\host" >> %dowhosts%
%ADs%echo download "%hosts1%","%cd%\host1" >> %dowhosts%
::
::
%dowhosts%
if /i not exist host goto nohost >NUL 2>NUL
type defined_hosts.txt>>hosts&&echo.>>hosts&&echo.>>hosts&&echo.>>hosts&&echo.>>hosts&&type host>>hosts
if /i exist host1 ( copy/ b /y hosts+host1 ) >NUL 2>NUL
::
::
::%customize%setlocal enabledelayedexpansion
::%customize%set line=0
::%customize%for /f "delims=*" %%i in (host) do (
::%customize%set /a line+=1
::%customize%if !line!==2 set A=%%i && set B=!A:~-20! && echo # HOSTS 更新时间： && echo !B!
::%customize%)
%ADs%setlocal enabledelayedexpansion
%ADs%set line=0
%ADs%for /f "delims=*" %%i in (host1) do (
%ADs%set /a line+=1
%ADs%if !line!==1 set A=%%i && set B=!A:~-13! && echo # 广告源更新时间: !B!
%ADs%)
%ADs%echo.
copy /y "hosts" %hostsfile% >NUL 2>NUL||takeown /f "%hostsfile%" && icacls "%hostsfile%" /grant administrators:F && attrib -r -h -s "%hostsfile%" && echo. && cls && copy /y "hosts" %hostsfile%
IF %ERRORLEVEL% == 1 GOTO ERROR
echo # HOSTS 更新时间:
findstr /ic:"# 2017" "C:\Windows\System32\drivers\etc\hosts"
findstr /ic:"# Last updated:" "C:\Windows\System32\drivers\etc\hosts"
echo.
echo.# 已替换HOSTS到系统。
echo.
ping 127.1 -n 2 >nul
::刷新 DNS 解析缓存
ipconfig /flushdns >NUL
ping 127.1 -n 1 >nul
echo.# 已成功刷新 DNS 解析缓存。
if /i exist host ( del /f /q host ) >NUL 2>NUL
if /i exist host1 ( del /f /q host1 ) >NUL 2>NUL
del /f /q hosts>NUL 2>NUL
del /f /q %dowhosts% >NUL 2>NUL
echo.-----------------------------------------------------------
echo.
echo  覆盖本地hosts并刷新本地DNS解析缓存成功!
echo  现在去打开Google、Twitter、Facebook、Gmail、谷歌学术吧！
echo. 谷歌这些网站记得使用https进行加密访问！
echo.
echo.  即：https://www.google.com
echo.
echo.  或者：https://www.google.com/ncr
echo.        https://www.google.com.hk/ncr
echo.
echo.-------------------------------------------------idoog.me--
echo.
goto end

:CL
cls
echo.-----------------------------------------------------------
echo.
(
echo # Localhost ^(DO NOT REMOVE^)
echo.
echo 127.0.0.1 localhost
echo.
)>%hostsfile%
ipconfig /flushdns >NUL
echo 恭喜您，hosts恢复初始成功!
echo.
echo.-------------------------------------------------idoog.me--
goto end

:end
echo 请按任意键退出。
Pause>nul
exit

:ERROR
mode con lines=31 cols=80
cls
echo.
echo.------------------------------------------------------------------------
echo 【配置hosts文件的所有者】
echo.
echo 请执行下面步骤：
echo.
echo 1) 右键hosts文件，点击“属性”菜单命令
echo 2) 在属性对话框里，选择“安全”选项卡，点下方的“高级”按钮
echo 3) 在出现的新窗口里，点击第二行“所有者”右边蓝色的“更改”文本链接
echo 4) 在“选择用户或组”对话框下面的文本框里输入“administrators”，点“确定”
echo 5) 回到其他窗口里，继续点“确定”完成配置
echo.
echo 提示：若看不见hosts文件，请选择主菜单的“6.显示隐藏文件”，然后刷新文件夹。
echo.
echo.--------------------------------------------------------------idoog.me--
ping 127.1 -n 2 >nul
start "" explorer.exe /select,%hostsfile%
echo.
echo 请按任意键返回
echo.
Pause>nul
goto main

:defined_hosts
(
echo #用户自定义hosts，建议使用notepad++编辑器编辑
echo #请在本行后填入自定义hosts
echo.
echo.
echo.
)>defined_hosts.txt
goto main

:nohost
cls
echo.-----------------------------------------------------------
echo.
echo.
echo  出错啦！未下载到最新的hosts，请重新编辑批处理内的默认链接。
echo.
echo.-------------------------------------------------idoog.me--
echo.
echo.
echo 请按任意键退出。
Pause>nul
exit

:customize
cls
echo.-----------------------------------------------------------
echo.
echo    底部输入自定义的HOSTS链接，可以输入任意链接，或：
echo.
echo.   回车后默认为：
echo.   https://coding.net/u/idoog/p/HOSTS/git/raw/master/hosts
echo.
echo.
echo.-------------------------------------------------idoog.me--
set hosts0=https://coding.net/u/idoog/p/HOSTS/git/raw/master/hosts
set /p hosts0= HOSTS地址^>^>%=%
set customize=::
GOTO host DNS


:gotodefined_hosts
start "" explorer.exe /select,defined_hosts.txt && goto main

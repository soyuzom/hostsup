@echo off
mode con lines=31 cols=60
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit
cd /d "%~dp0"
set hostsfile="%SYSTEMROOT%\System32\Drivers\etc\hosts"
set dowhosts="%temp%\dowhosts.vbs"
set "hoststwo=::"
set "TT=替换" & set "TT2=::"
title Hosts远程下载更新工具5.7
:main
mode con lines=31 cols=60
if /i not exist Defined_Hosts.txt goto Defined_Hosts >NUL 2>NUL
cls
color 5f
echo.-----------------------------------------------------------
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
echo. 如果自己修改过hosts信息，请复制到 Defined_Hosts.txt
echo. [Defined_Hosts.txt]文件可自定义hosts，更新会自动合并。
echo. 开源：https://coding.net/u/idoog/p/HOSTS
echo.
echo.-----------------------------------------------------------
echo. 请选择使用：
echo.
echo.  [1] 远程下载更新 HOSTS     [T] 设置更新方式:^<%TT%^>
echo.  [2] 自定义 HOSTS 链接      [3] 打开 Defined_Hosts.txt
echo.  [4] 恢复初始 HOSTS         [5] 打开系统 HOSTS 目录
echo.  [6] 创建桌面快捷方式
echo.
echo.-------------------------------------------------idoog.me--
set "choice=1
set /p choice=请输入选项(回车=1):
if /i %choice%==6 goto DesktopLnk
if /i %choice%==5 start "" explorer.exe /select,%hostsfile% && goto main
if /i %choice%==4 goto CL
if /i %choice%==2 goto customize
if /i %choice%==3 start "" explorer.exe /select,Defined_Hosts.txt && goto main
if /i %choice%==1 goto host DNS
%TT2%if /i %choice%==T set "TT=替换" & set "TT2=::" && goto main
if /i %choice%==T set "TT=叠加" & set "TT2=" && goto main
if /i %choice%==C ( copy /y "Defined_Hosts.txt" %hostsfile% >NUL 2>NUL||takeown /f "%hostsfile%" && icacls "%hostsfile%" /grant administrators:F && attrib -r -h -s "%hostsfile%" && echo. && cls && copy /y "Defined_Hosts.txt" %hostsfile% & set cc=:: & goto OKhosts )
set "choice="
echo. 输入有误，请重新选择。
ping 127.0.1 -n "3">nul
goto main


:host DNS
cls
echo.-----------------------------------------------------------
echo. 选择更新源：
echo.
echo.  [1] Go-Hosts           [2] Racaljk (稳定)
echo.  [3] Go-Hosts + Racaljk
echo.  [4] SY168   =^>[41]Google Play   =^>[42]YouTuBe
echo.  [5] Instagram + chaturbate
echo.
echo.  [C] 仅使用自定义的HOSTS (Defined_Hosts.txt)
echo.
echo.  [T] 设置更新方式:^<%TT%^>
echo.-------------------------------------------------idoog.me--
set ID=2
set /p ID=请输入选项(回车=2):
if /i %ID%==1 set "hosts0=https://coding.net/u/idoog/p/HOSTS/git/raw/master/hosts" && goto hostAD
if /i %ID%==2 set "hosts0=https://coding.net/u/scaffrey/p/hosts/git/raw/master/hosts-files/hosts" && goto hostAD
::if /i %ID%==2 set "hosts0=https://github.com/racaljk/hosts/raw/master/hosts" && goto hostAD
if /i %ID%==3 set "hoststwo=" & set "hosts0=https://coding.net/u/scaffrey/p/hosts/git/raw/master/hosts-files/hosts" & set "hosts1=https://coding.net/u/idoog/p/HOSTS/git/raw/master/hosts" && goto hostAD
::if /i %ID%==4 set "hosts0=https://github.com/sy618/hosts/raw/master/FQ" && goto hostAD
if /i %ID%==4 set "hosts0=https://raw.githubusercontent.com/sy618/hosts/master/FQ" && goto hostAD
if /i %ID%==41 set "hosts0=https://raw.githubusercontent.com/sy618/hosts/master/p" && goto hostAD
if /i %ID%==42 set "hosts0=https://raw.githubusercontent.com/sy618/hosts/master/y" && goto hostAD
if /i %ID%==5 set "hosts0=https://coding.net/u/idoog/p/HOSTS/git/raw/master/IG" && goto hostAD
if /i %ID%==6 set "hosts0=https://raw.githubusercontent.com/googlehosts/hosts/master/hosts-files/hosts" && goto hostAD
if /i %ID%==C ( copy /y "Defined_Hosts.txt" %hostsfile% >NUL 2>NUL||takeown /f "%hostsfile%" && icacls "%hostsfile%" /grant administrators:F && attrib -r -h -s "%hostsfile%" && echo. && cls && copy /y "Defined_Hosts.txt" %hostsfile% & set cc=:: & goto OKhosts )

%TT2%if /i %ID%==T set "TT=替换" & set "TT2=::" && goto host DNS
if /i %ID%==T set "TT=叠加" & set "TT2=" && goto host DNS
goto host DNS
:hostAD
set "hosts2=https://github.com/vokins/yhosts/raw/master/hosts"
echo.-----------------------------------------------------------
echo.
set "AD=n"
set "ADs=::"
set /p AD=是否更新去广告源[Y/N](回车键=N):%=% 
::
if /i %AD%==y set "ADs=" && goto JJ
if /i %AD%==N goto JJ
goto JJ

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
%hoststwo%echo download "%hosts1%","%cd%\host1" >> %dowhosts%
%ADs%echo download "%hosts2%","%cd%\host2" >> %dowhosts%
::
::
%dowhosts%
if /i not exist host goto nohost >NUL 2>NUL
%TT2%type %hostsfile%>>hosts
type Defined_Hosts.txt>>hosts&&echo.>>hosts&&echo.>>hosts&&echo.>>hosts&&echo.>>hosts&&type host>>hosts&&del /f /q host
if /i exist host1 ( copy/ b /y hosts+host1 && del /f /q host1 ) >NUL 2>NUL
if /i exist host2 ( copy/ b /y hosts+host2 && del /f /q host2 ) >NUL 2>NUL
if /i exist host3 ( copy/ b /y hosts+host3 && del /f /q host3 ) >NUL 2>NUL
::


copy /y "hosts" %hostsfile% >NUL 2>NUL||takeown /f "%hostsfile%" && icacls "%hostsfile%" /grant administrators:F && attrib -r -h -s "%hostsfile%" && echo. && cls && copy /y "hosts" %hostsfile%
IF %ERRORLEVEL% == 1 GOTO ERROR
::
%ADs%echo # 广告源更新时间:
%ADs%findstr /ic:"#version" "C:\Windows\System32\drivers\etc\hosts"
%ADs%echo.
echo # HOSTS 更新时间:
findstr /ic:"# 2017" "C:\Windows\System32\drivers\etc\hosts" & findstr /ic:"# Last updated:" "C:\Windows\System32\drivers\etc\hosts"
echo.
echo.# 已替换HOSTS到系统。
echo.
ping 127.1 -n 2 >nul
::刷新 DNS 解析缓存
:OKhosts
ipconfig /flushdns >NUL
ping 127.1 -n 1 >nul
echo.# 已成功刷新 DNS 解析缓存。
del /f /q hosts>NUL 2>NUL
del /f /q %dowhosts% >NUL 2>NUL
%cc%echo.-----------------------------------------------------------
echo.
echo  覆盖本地hosts并刷新本地DNS解析缓存成功!
%cc%echo  现在去打开Google、Twitter、Facebook、Gmail、谷歌学术吧！
%cc%echo. 谷歌这些网站记得使用https进行加密访问！
%cc%echo.
%cc%echo.  即：https://www.google.com
%cc%echo.
%cc%echo.  或者：https://www.google.com/ncr
%cc%echo.        https://www.google.com.hk/ncr
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

:Defined_Hosts
(
echo #用户自定义hosts，建议使用notepad++编辑器编辑
echo #请在本行后填入自定义hosts
echo.
echo.
echo.
)>Defined_Hosts.txt
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
echo 请按任意键返回
echo.
Pause>nul
goto main
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
echo.   输入:T   设置更新方式:^<%TT%^>
echo.
echo.-------------------------------------------------idoog.me--
set hostsX=https://coding.net/u/idoog/p/HOSTS/git/raw/master/hosts
set /p hostsX=HOSTS地址^>^>%=%
%TT2%if /i %hostsX%==T set "TT=替换" & set "TT2=::" && goto customize
if /i %hostsX%==T set "TT=叠加" & set "TT2=" && goto customize
set hosts0=%hostsX%
goto hostAD


:gotoDefined_Hosts
start "" explorer.exe /select,Defined_Hosts.txt && goto main

:DesktopLnk
mshta VBScript:Execute("Set a=CreateObject(""WScript.Shell""):Set b=a.CreateShortcut(a.SpecialFolders(""Desktop"") & ""\Hosts远程下载更新工具.lnk""):b.TargetPath=""%~dp0Hostsup.bat"":b.WorkingDirectory=""%~dp0"":b.Save:close")&echo. &echo.   完成!&&ping 127.1 -n 2 >nul&&GOTO main

@echo off
mode con lines=31 cols=60
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit
cd /d "%~dp0"
set hostsfile="%SYSTEMROOT%\System32\Drivers\etc\hosts"
set dowhosts="%temp%\dowhosts.vbs"
set "hoststwo=::"
set "TT=�滻" & set "TT2=::"
title HostsԶ�����ظ��¹���5.7
:main
mode con lines=31 cols=60
if /i not exist Defined_Hosts.txt goto Defined_Hosts >NUL 2>NUL
cls
color 5f
echo.-----------------------------------------------------------
echo.
echo  ��    ��     �̡̡�      �̡̡̡�  �̡̡̡̡�    �̡̡̡�
echo  ��    ��   ��      ��  ��      ��  ��  ��  ��  ��      ��
echo  ��    ��   ��      ��  ��              ��      ��
echo  �̡̡̡�   ��      ��    �̡�          ��        �̡�
echo  ��    ��   ��      ��        ��        ��            ��
echo  ��    ��   ��      ��          ��      ��              ��
echo  ��    ��   ��      ��  ��      ��      ��      ��      ��
echo  ��    ��     �̡̡�     �̡̡̡�       ��       �̡̡̡�
echo.
echo.----------------------------------------------------------- 
echo. 360�����ԹܼҵȰ�ȫ������ѣ��빴ѡ��������Ͳ������ѣ�
echo.
echo. ����Լ��޸Ĺ�hosts��Ϣ���븴�Ƶ� Defined_Hosts.txt
echo. [Defined_Hosts.txt]�ļ����Զ���hosts�����»��Զ��ϲ���
echo. ��Դ��https://coding.net/u/idoog/p/HOSTS
echo.
echo.-----------------------------------------------------------
echo. ��ѡ��ʹ�ã�
echo.
echo.  [1] Զ�����ظ��� HOSTS     [T] ���ø��·�ʽ:^<%TT%^>
echo.  [2] �Զ��� HOSTS ����      [3] �� Defined_Hosts.txt
echo.  [4] �ָ���ʼ HOSTS         [5] ��ϵͳ HOSTS Ŀ¼
echo.  [6] ���������ݷ�ʽ
echo.
echo.-------------------------------------------------idoog.me--
set "choice=1
set /p choice=������ѡ��(�س�=1):
if /i %choice%==6 goto DesktopLnk
if /i %choice%==5 start "" explorer.exe /select,%hostsfile% && goto main
if /i %choice%==4 goto CL
if /i %choice%==2 goto customize
if /i %choice%==3 start "" explorer.exe /select,Defined_Hosts.txt && goto main
if /i %choice%==1 goto host DNS
%TT2%if /i %choice%==T set "TT=�滻" & set "TT2=::" && goto main
if /i %choice%==T set "TT=����" & set "TT2=" && goto main
if /i %choice%==C ( copy /y "Defined_Hosts.txt" %hostsfile% >NUL 2>NUL||takeown /f "%hostsfile%" && icacls "%hostsfile%" /grant administrators:F && attrib -r -h -s "%hostsfile%" && echo. && cls && copy /y "Defined_Hosts.txt" %hostsfile% & set cc=:: & goto OKhosts )
set "choice="
echo. ��������������ѡ��
ping 127.0.1 -n "3">nul
goto main


:host DNS
cls
echo.-----------------------------------------------------------
echo. ѡ�����Դ��
echo.
echo.  [1] Go-Hosts           [2] Racaljk (�ȶ�)
echo.  [3] Go-Hosts + Racaljk
echo.  [4] SY168   =^>[41]Google Play   =^>[42]YouTuBe
echo.  [5] Instagram + chaturbate
echo.
echo.  [C] ��ʹ���Զ����HOSTS (Defined_Hosts.txt)
echo.
echo.  [T] ���ø��·�ʽ:^<%TT%^>
echo.-------------------------------------------------idoog.me--
set ID=2
set /p ID=������ѡ��(�س�=2):
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

%TT2%if /i %ID%==T set "TT=�滻" & set "TT2=::" && goto host DNS
if /i %ID%==T set "TT=����" & set "TT2=" && goto host DNS
goto host DNS
:hostAD
set "hosts2=https://github.com/vokins/yhosts/raw/master/hosts"
echo.-----------------------------------------------------------
echo.
set "AD=n"
set "ADs=::"
set /p AD=�Ƿ����ȥ���Դ[Y/N](�س���=N):%=% 
::
if /i %AD%==y set "ADs=" && goto JJ
if /i %AD%==N goto JJ
goto JJ

::
:jj
cls
echo.-----------------------------------------------------------
echo.
echo # �������� HOSTS...
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
%ADs%echo # ���Դ����ʱ��:
%ADs%findstr /ic:"#version" "C:\Windows\System32\drivers\etc\hosts"
%ADs%echo.
echo # HOSTS ����ʱ��:
findstr /ic:"# 2017" "C:\Windows\System32\drivers\etc\hosts" & findstr /ic:"# Last updated:" "C:\Windows\System32\drivers\etc\hosts"
echo.
echo.# ���滻HOSTS��ϵͳ��
echo.
ping 127.1 -n 2 >nul
::ˢ�� DNS ��������
:OKhosts
ipconfig /flushdns >NUL
ping 127.1 -n 1 >nul
echo.# �ѳɹ�ˢ�� DNS �������档
del /f /q hosts>NUL 2>NUL
del /f /q %dowhosts% >NUL 2>NUL
%cc%echo.-----------------------------------------------------------
echo.
echo  ���Ǳ���hosts��ˢ�±���DNS��������ɹ�!
%cc%echo  ����ȥ��Google��Twitter��Facebook��Gmail���ȸ�ѧ���ɣ�
%cc%echo. �ȸ���Щ��վ�ǵ�ʹ��https���м��ܷ��ʣ�
%cc%echo.
%cc%echo.  ����https://www.google.com
%cc%echo.
%cc%echo.  ���ߣ�https://www.google.com/ncr
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
echo ��ϲ����hosts�ָ���ʼ�ɹ�!
echo.
echo.-------------------------------------------------idoog.me--
goto end

:end
echo �밴������˳���
Pause>nul
exit

:ERROR
mode con lines=31 cols=80
cls
echo.
echo.------------------------------------------------------------------------
echo ������hosts�ļ��������ߡ�
echo.
echo ��ִ�����沽�裺
echo.
echo 1) �Ҽ�hosts�ļ�����������ԡ��˵�����
echo 2) �����ԶԻ����ѡ�񡰰�ȫ��ѡ������·��ġ��߼�����ť
echo 3) �ڳ��ֵ��´��������ڶ��С������ߡ��ұ���ɫ�ġ����ġ��ı�����
echo 4) �ڡ�ѡ���û����顱�Ի���������ı��������롰administrators�����㡰ȷ����
echo 5) �ص���������������㡰ȷ�����������
echo.
echo ��ʾ����������hosts�ļ�����ѡ�����˵��ġ�6.��ʾ�����ļ�����Ȼ��ˢ���ļ��С�
echo.
echo.--------------------------------------------------------------idoog.me--
ping 127.1 -n 2 >nul
start "" explorer.exe /select,%hostsfile%
echo.
echo �밴���������
echo.
Pause>nul
goto main

:Defined_Hosts
(
echo #�û��Զ���hosts������ʹ��notepad++�༭���༭
echo #���ڱ��к������Զ���hosts
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
echo  ��������δ���ص����µ�hosts�������±༭�������ڵ�Ĭ�����ӡ�
echo.
echo.-------------------------------------------------idoog.me--
echo.
echo.
echo �밴���������
echo.
Pause>nul
goto main
echo �밴������˳���
Pause>nul
exit

:customize
cls
echo.-----------------------------------------------------------
echo.
echo    �ײ������Զ����HOSTS���ӣ����������������ӣ���
echo.
echo.   �س���Ĭ��Ϊ��
echo.   https://coding.net/u/idoog/p/HOSTS/git/raw/master/hosts
echo.
echo.   ����:T   ���ø��·�ʽ:^<%TT%^>
echo.
echo.-------------------------------------------------idoog.me--
set hostsX=https://coding.net/u/idoog/p/HOSTS/git/raw/master/hosts
set /p hostsX=HOSTS��ַ^>^>%=%
%TT2%if /i %hostsX%==T set "TT=�滻" & set "TT2=::" && goto customize
if /i %hostsX%==T set "TT=����" & set "TT2=" && goto customize
set hosts0=%hostsX%
goto hostAD


:gotoDefined_Hosts
start "" explorer.exe /select,Defined_Hosts.txt && goto main

:DesktopLnk
mshta VBScript:Execute("Set a=CreateObject(""WScript.Shell""):Set b=a.CreateShortcut(a.SpecialFolders(""Desktop"") & ""\HostsԶ�����ظ��¹���.lnk""):b.TargetPath=""%~dp0Hostsup.bat"":b.WorkingDirectory=""%~dp0"":b.Save:close")&echo. &echo.   ���!&&ping 127.1 -n 2 >nul&&GOTO main

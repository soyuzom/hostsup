@echo off
mode con lines=31 cols=60
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit
cd /d "%~dp0"
set hostsfile="%SYSTEMROOT%\System32\Drivers\etc\hosts"
set dowhosts="%temp%\dowhosts.vbs"
set win7=::
if /i not exist "%SystemRoot%\System32\choice.exe" set win7=::
:: ����ΪĬ�ϵ�HOSTS����
set hosts0=https://github.com/Lerist/Go-Hosts/raw/master/hosts
set hosts0=https://coding.net/u/scaffrey/p/hosts/git/raw/master/hosts
set hosts1=https://github.com/vokins/yhosts/raw/master/hosts

title HostsԶ�����ظ��¹���5.2
:main
mode con lines=31 cols=60
if /i not exist defined_hosts.txt goto defined_hosts >NUL 2>NUL
cls
color 5f
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
echo. ����Լ��޸Ĺ�hosts��Ϣ���븴�Ƶ� defined_hosts.txt
echo.��defined_hosts.txt���ļ����Զ���hosts�����»��Զ��ϲ���
echo.
echo. ���棺ִ�и����� ���� HOSTS �Ὣ���Զ��滻���ǣ�
echo.-----------------------------------------------------------
echo. ��ѡ��ʹ�ã�
echo.
echo. 
echo.  [1] Զ�����ظ��� HOSTS(Ĭ��)   [2] �� defined_hosts.txt
echo.  [3] �Զ��� HOSTS ����          [4] �ָ���ʼ HOSTS
echo.  [5] ��ϵͳ HOSTS Ŀ¼
echo.
echo.-------------------------------------------------idoog.me--
%win7%goto Choice
set choice=1
set /p choice=������ѡ��(Ĭ��=1):

echo.
if /i %choice%==5 start "" explorer.exe /select,%hostsfile% && goto main
if /i %choice%==4 goto CL
if /i %choice%==3 goto customize
if /i %choice%==2 start "" explorer.exe /select,defined_hosts.txt && goto main
if /i %choice%==1 goto host DNS
cls
set choice=
echo.����������������ѡ��
ping 127.0.1 -n "4">nul
goto main

:Choice
choice /c 12345 /n /m "����������ѡ��"
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
set /p AD=�Ƿ����ȥ���Դ[Y/N](�س���=N):%=% 
::
if /i %AD%==y set ADs= && goto JJ
if /i %AD%==N goto JJ
goto JJ

:Choice2
choice /d 1 /t 6 /m "����������ѡ��(6s=Y):"
if errorlevel 2 set ADs= && goto JJ
if errorlevel 1 goto JJ

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
::%customize%if !line!==2 set A=%%i && set B=!A:~-20! && echo # HOSTS ����ʱ�䣺 && echo !B!
::%customize%)
%ADs%setlocal enabledelayedexpansion
%ADs%set line=0
%ADs%for /f "delims=*" %%i in (host1) do (
%ADs%set /a line+=1
%ADs%if !line!==1 set A=%%i && set B=!A:~-13! && echo # ���Դ����ʱ��: !B!
%ADs%)
%ADs%echo.
copy /y "hosts" %hostsfile% >NUL 2>NUL||takeown /f "%hostsfile%" && icacls "%hostsfile%" /grant administrators:F && attrib -r -h -s "%hostsfile%" && echo. && cls && copy /y "hosts" %hostsfile%
IF %ERRORLEVEL% == 1 GOTO ERROR
echo # HOSTS ����ʱ��:
findstr /ic:"# 2017" "C:\Windows\System32\drivers\etc\hosts"
findstr /ic:"# Last updated:" "C:\Windows\System32\drivers\etc\hosts"
echo.
echo.# ���滻HOSTS��ϵͳ��
echo.
ping 127.1 -n 2 >nul
::ˢ�� DNS ��������
ipconfig /flushdns >NUL
ping 127.1 -n 1 >nul
echo.# �ѳɹ�ˢ�� DNS �������档
if /i exist host ( del /f /q host ) >NUL 2>NUL
if /i exist host1 ( del /f /q host1 ) >NUL 2>NUL
del /f /q hosts>NUL 2>NUL
del /f /q %dowhosts% >NUL 2>NUL
echo.-----------------------------------------------------------
echo.
echo  ���Ǳ���hosts��ˢ�±���DNS��������ɹ�!
echo  ����ȥ��Google��Twitter��Facebook��Gmail���ȸ�ѧ���ɣ�
echo. �ȸ���Щ��վ�ǵ�ʹ��https���м��ܷ��ʣ�
echo.
echo.  ����https://www.google.com
echo.
echo.  ���ߣ�https://www.google.com/ncr
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

:defined_hosts
(
echo #�û��Զ���hosts������ʹ��notepad++�༭���༭
echo #���ڱ��к������Զ���hosts
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
echo  ��������δ���ص����µ�hosts�������±༭�������ڵ�Ĭ�����ӡ�
echo.
echo.-------------------------------------------------idoog.me--
echo.
echo.
echo �밴������˳���
Pause>nul
exit

:customize
cls
echo.-----------------------------------------------------------
echo.
echo    �ײ������Զ����HOSTS���ӣ����������������ӣ���
echo.
echo.   �س���Ĭ�ϣ�http://idoog.me/hosts (Go HostsԴ)
echo.
echo.
echo.-------------------------------------------------idoog.me--
set hosts0=http://idoog.me/hosts
set /p hosts0= HOSTS��ַ^>^>%=%
set customize=::
GOTO host DNS


:gotodefined_hosts
start "" explorer.exe /select,defined_hosts.txt && goto main

@rem THIS BATCH FILE REQUIRES MANUAL EDIT
@rem SERVICE INSTALL IS COMMENTED TO PREVENT SCRIPT KIDDIES FROM DAMAGING THEIR SYSTEMS WITHOUT KNOWING HOW TO RECOVER
@rem ЭТОТ ФАЙЛ ТРЕБУЕТ РЕДАКТИРОВАНИЯ
@rem УСТАНОВКА СЛУЖБЫ ЗАКОММЕНТИРОВАНА, ЧТОБЫ ОГРАДИТЬ НИЧЕГО НЕ ПОНИМАЮЩИХ НАЖИМАТЕЛЕЙ НА ВСЕ ПОДРЯД ОТ ПРОБЛЕМ, КОТОРЫЕ ОНИ НЕ В СОСТОЯНИИ РЕШИТЬ
@rem ЕСЛИ НИЧЕГО НЕ ПОНИМАЕТЕ - НЕ ТРОГАЙТЕ ЭТОТ ФАЙЛ, ОТКАЖИТЕСЬ ОТ ИСПОЛЬЗОВАНИЯ СЛУЖБЫ. ИНАЧЕ БУДЕТЕ ПИСАТЬ ПОТОМ ВОПРОСЫ "У МЕНЯ ПРОПАЛ ИНТЕРНЕТ , КАК ВОССТАНОВИТЬ"

set ARGS=^
--wf-tcp=443 --wf-udp=443 ^
--filter-tcp=443 --hostlist="%~dp0files\list-youtube.txt" --dpi-desync=multidisorder --dpi-desync-split-pos=1,midsld --dpi-desync-repeats=11 --dpi-desync-fooling=md5sig --dpi-desync-fake-tls-mod=rnd,dupsid,sni=www.google.com --new ^
--filter-tcp=443 --hostlist-exclude="%~dp0files\list-exclude.txt" --dpi-desync=split2 --dpi-desync-repeats=2 --dpi-desync-split-seqovl=681 --dpi-desync-split-pos=1 --dpi-desync-fooling=badseq,hopbyhop2 --dpi-desync-split-seqovl-pattern="%~dp0files\tls_clienthello_iana_org.bin" --new ^
--filter-udp=443 --hostlist="%~dp0files\list-youtube.txt" --dpi-desync=fake --dpi-desync-repeats=11 --dpi-desync-fake-quic="%~dp0files\quic_initial_www_google_com.bin" --new ^
--filter-udp=443 --hostlist-exclude="%~dp0files\list-exclude.txt" --dpi-desync=fake --dpi-desync-repeats=6 --dpi-desync-fake-quic="%~dp0files\quic_initial_www_google_com.bin"
call :srvinst winws1
set ARGS=--wf-raw=@\"%~dp0windivert.filter\windivert.discord_media+stun.txt\" ^
--filter-l7=discord,stun --dpi-desync=fake
call :srvinst winws2
goto :eof

:srvinst
net stop %1
sc delete %1
sc create %1 binPath= "\"%~dp0winws.exe\" %ARGS%" DisplayName= "zapret DPI bypass : %1" start= auto
sc description %1 "zapret DPI bypass software"
sc start %1

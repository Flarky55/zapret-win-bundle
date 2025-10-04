start "zapret: me" /min "%~dp0winws.exe" ^
--wf-tcp=443 --wf-udp=443 ^
--filter-tcp=443 --hostlist="%~dp0files\list-youtube.txt" --dpi-desync=multidisorder --dpi-desync-split-pos=1,midsld --dpi-desync-repeats=11 --dpi-desync-fooling=md5sig --dpi-desync-fake-tls-mod=rnd,dupsid,sni=www.google.com --new ^
--filter-tcp=443 --hostlist-exclude="%~dp0files\list-exclude.txt" --dpi-desync=split2 --dpi-desync-repeats=2 --dpi-desync-split-seqovl=681 --dpi-desync-split-pos=1 --dpi-desync-fooling=badseq,hopbyhop2 --dpi-desync-split-seqovl-pattern="%~dp0files\tls_clienthello_iana_org.bin" --new ^
--filter-udp=443 --hostlist="%~dp0files\list-youtube.txt" --dpi-desync=fake --dpi-desync-repeats=11 --dpi-desync-fake-quic="%~dp0files\quic_initial_www_google_com.bin" --new ^
--filter-udp=443 --hostlist-exclude="%~dp0files\list-exclude.txt" --dpi-desync=fake --dpi-desync-repeats=6 --dpi-desync-fake-quic="%~dp0files\quic_initial_www_google_com.bin"
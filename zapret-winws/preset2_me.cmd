@rem DO NOT FORGET TO RUN enable_timestamps.cmd

start "zapret2: me" /min "%~dp0winws2.exe" --debug ^
--wf-tcp-out=80,443 ^
--lua-init=@"%~dp0lua\zapret-lib.lua" --lua-init=@"%~dp0lua\zapret-antidpi.lua" ^
--lua-init="fake_default_tls = tls_mod(fake_default_tls,'rnd,rndsni')" ^
--blob=quic_google:@"%~dp0files\quic_initial_www_google_com.bin" ^
--wf-raw-part=@"%~dp0windivert.filter\windivert_part.discord_media.txt" ^
--wf-raw-part=@"%~dp0windivert.filter\windivert_part.stun.txt" ^
--wf-raw-part=@"%~dp0windivert.filter\windivert_part.quic_initial_ietf.txt" ^
--filter-tcp=443 --filter-l7=tls --hostlist="%~dp0files\list-youtube.txt" ^
  --payload=tls_client_hello ^
   --lua-desync=hostfakesplit:host=google.com:tcp_ts=-600000 ^
  --new ^
--filter-tcp=443 --filter-l7=tls --ipset="%~dp0files\ipset-include.txt" ^
  --payload=tls_client_hello ^
    --lua-desync=fakedsplit:pos=sniext+1:tcp_seq=-3000 ^
  --new ^
--filter-udp=443 --filter-l7=quic --hostlist="%~dp0files\list-youtube.txt" ^
  --payload=quic_initial ^
   --lua-desync=fake:blob=quic_google:repeats=11 ^
  --new ^
--filter-udp=443 --filter-l7=quic ^
  --payload=quic_initial ^
   --lua-desync=fake:blob=quic_google:repeats=11 ^
  --new ^
--filter-l7=stun,discord ^
  --payload=stun,discord_ip_discovery ^
   --lua-desync=fake:blob=quic_google:repeats=3
#!/bin/bash

PLAYER="mpv"

TITLES=(
  "RTP 1"
  "RTP 2"
  "SIC"
  "TVI"
  "RTP 3"
  "SIC Noticias"
  "TVI24"
  "SIC Radical"
  "SIC K"
  "RTP Memoria"
  "RTP Internacional"
  "RTP Madeira"
  "RTP Acores"
  "RTP Africa"
  "ARTV"
  "Porto Canal"
  "Euronews"
  "Kuriakos TV"
)

STREAMS=(
  "$PLAYER --referrer http://www.rtp.pt https://streaming-live.rtp.pt/liverepeater/smil:rtp1.smil/playlist.m3u8"
  "$PLAYER --referrer http://www.rtp.pt https://streaming-live.rtp.pt/liverepeater/smil:rtp2.smil/playlist.m3u8"
  "$PLAYER http://live.impresa.pt/live/sic/sic540p.m3u8"
  "$PLAYER $(wget http://tviplayer.iol.pt/direto/TVI -O - -o /dev/null | grep videoUrl\ = |cut -d\" -f2|head -n 1)"
  "$PLAYER --referrer http://www.rtp.pt https://streaming-live.rtp.pt/livetvhlsDVR/rtpndvr.smil/playlist.m3u8"
  "$PLAYER http://live.impresa.pt/live/sicnot/sicnot540p.m3u8"
  "$PLAYER $(wget http://tviplayer.iol.pt/direto/TVI24 -O - -o /dev/null | grep videoUrl\ = |cut -d\" -f2|head -n 1)"
  "$PLAYER http://live.impresa.pt/live/sicrad/sicrad540p.m3u8"
  "$PLAYER http://live.impresa.pt/live/sick/sick540p.m3u8"
  "$PLAYER --referrer http://www.rtp.pt https://streaming-live.rtp.pt/liverepeater/smil:rtpmem.smil/playlist.m3u8"
  "$PLAYER --referrer http://www.rtp.pt https://streaming-live.rtp.pt/liverepeater/smil:rtpi.smil/playlist.m3u8"
  "$PLAYER --referrer http://www.rtp.pt https://streaming-live.rtp.pt/liverepeater/smil:rtpmadeira.smil/playlist.m3u8"
  "$PLAYER --referrer http://www.rtp.pt https://streaming-live.rtp.pt/liverepeater/smil:rtpacores.smil/playlist.m3u8"
  "$PLAYER --referrer http://www.rtp.pt https://streaming-live.rtp.pt/liverepeater/smil:rtpafrica.smil/playlist.m3u8"
  "$PLAYER http://193.126.16.68:1935/livenlin4/mp4:2liveplncleanpub/playlist.m3u8"
  "$PLAYER rtmp://213.13.26.13/live/portocanal"
  "$PLAYER http://euronews-pt-p7-cdn.hexaglobe.net/94ce3a040643007dd3c2950436603334/5a2f43b0/euronews/euronews-euronews-website-web-responsive-2/ewnsabrptpri_por.smil/playlist.m3u8"
  "$PLAYER http://195.22.11.11:1935/ktv/ktv2/playlist.m3u8"
)

# check if dependencies exist
type $PLAYER &>/dev/null || { echo "$PLAYER is not installed"; exit 1; }

PS3="Which TV channel do you want to watch? "
select choice in "${TITLES[@]}";
do
  if [[ -n $choice ]]; then
    for i in ${!TITLES[@]}
    do
      if [ "${TITLES[i]}" = "$choice" ]; then
        eval ${STREAMS[i]}
        break
      fi
    done
  else
    echo "Invalid selection."
  fi
done

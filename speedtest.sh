#!/bin/sh

## Variablen Deklaration
#  Testdateien
testurl1=http://mirror.de.leaseweb.net/speedtest/10mb.bin
testurl2=http://fra36-speedtest-1.tele2.net/100MB.zip
testurl3=http://ipv4.download.thinkbroadband.com/10MB.zip

#  Textausgabe
printf_format='%19s %12s %12s %12s\n'
printf_title='Messergebnisse der Download-Geschwindigkeit zu defninierten Testquellen'

#  Logging
log_file_path=/var/log/speedtest
log_file_name=speedtest.log

# download_sample laed die URL und uebergibt die Downloadrate in Mb/s
# tr wandelt alle ASCII-Zeichen groesser als 126 (Steuerzeichen und Binaerkram) >
# in Satzpunkte damit grep sie weiter verarbeiten kann
function download_sample () {
  wget --report-speed=bits --delete-after -O - \
  $1 2>&1 \
  | tr '[\000-\011\013-\037\177-\377]' '.' \
  | grep -o '.[0-9][,][0-9] Mb/s'
}

function print_log_header () {
  printf '%s\n\n\n' \
  "$printf_title
  Quelle1: $testurl1
  Quelle2: $testurl2
  Quelle3: $testurl3"
  printf "$printf_format" \
  'Datum:' 'Quelle1:' 'Quelle2:' 'Quelle3:'
}

function generate_output_line () {
  printf "$printf_format" \
  "`date +"%Y-%m-%d_%T"`" \
  "`download_sample $testurl1`" \
  "`download_sample $testurl2`" \
  "`download_sample $testurl3`"
}

function write_log_file () {
  if ! grep -q "$printf_title" $1
  then
    print_log_header > $1
  fi
  generate_output_line >> $1
}

write_log_file $log_file_path/$log_file_name
exit $?

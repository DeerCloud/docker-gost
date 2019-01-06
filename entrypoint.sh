#!/bin/sh

launch() {

  if [ ! -z "$USERNAME" ] && [ ! -z "$PASSWORD" ]; then
    AUTH="$USERNAME:$PASSWORD"
  else
    AUTH=""
  fi

  echo ""
  echo -e "\033[32m  HOST:\033[0m ${SERVER_HOST}"
  echo -e "\033[32m  PORT:\033[0m ${SERVER_PORT}"
  echo -e "\033[32m  Protocol:\033[0m ${PROTOCOL}"
  echo -e "\033[32m  Transport:\033[0m ${TRANSPORT}"
  if [ ! -z "$USERNAME" ] && [ ! -z "$PASSWORD" ]; then
    echo -e "\033[32m  Username:\033[0m ${USERNAME}"
    echo -e "\033[32m  Password:\033[0m ${PASSWORD}"
  fi
  echo ""

  echo -e "\033[33m  gost start!\033[0m"
  gost -L "$PROTOCOL+$TRANSPORT://$AUTH@$SERVER_HOST:$SERVER_PORT?dns=$DNS"
}


if [ -z "$@" ]; then
  launch
else
  exec "$@"
fi

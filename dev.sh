#!/usr/bin/env bash

source "./.env"
case $@ in
  c)
    iex -S mix
    ;;

  *)
    iex -S mix phx.server
    ;;
esac
#!/usr/bin/env bash

set -e

last_instance_id=""

build_counter() {
  local id=$(uuidgen)
  id="obj_${id//-/}"


  tmpl="
    ${id}_current=0

    $id.increment() {
      ${id}_current=\$((${id}_current+1))
    }

    ${id}.get_count() {
      echo \$${id}_current
    }
  "

  eval "$tmpl"
  last_instance_id="$id"
}

get_counter() {
  if [ -z "$last_instance_id" ]; then
    echo "No counter found. Call build_counter before calling get_counter"
    return 1
  fi

  echo "$last_instance_id"
  last_instance_id=""
}

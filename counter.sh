#!/usr/bin/env bash
#/ This file demonstrates a technique for simulating objects within Bash.
#/ THESE ARE NOT REAL OBJECTS. They are an illusion. That being said, I
#/ will refer to them as "objects" for simplicity sake.
#/
#/ Usage:
#/  source counter.sh
#/
#/  # instantiate a new counter
#/  build_counter
#/  my_counter=$(get_counter)
#/
#/  # make calls against the counter
#/  $my_counter.increment
#/  $my_counter.increment
#/  $my_counter.get_count

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

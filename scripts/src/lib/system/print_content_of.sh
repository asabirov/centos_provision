#!/usr/bin/env bash
#





print_content_of(){
  local filepath="${1}"
  if [ -f "$filepath" ]; then
    if [ -s "$filepath" ]; then
      echo "Content of '${filepath}':\n$(cat "$filepath" | add_indentation)"
    else
      echo "File '${filepath}' is empty"
    fi
  else
    echo "Can't show '${filepath}' content - file does not exist"
  fi
}

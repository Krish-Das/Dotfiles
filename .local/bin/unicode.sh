#!/bin/bash

# Check if an input is passed
if [ $# -eq 0 ]; then
  echo "Plese provide an unicode endpoint"
  exit 1
fi

echo -e "\u$1"

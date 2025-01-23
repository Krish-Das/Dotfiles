#!/bin/bash

# for ((i=0; i<=255; i++)); do
#     printf "U+%04X: %s\n" $i "$(printf "\\u$(printf '%04x' $i)")"
# done


# for ((i=655361; i<=1048560; i++)); do
#     printf "U+%05X: %s\n" $i "$(printf "\\U$(printf '%08x' $i)")"
# done

# for ((i=61440; i<=63231; i++)); do
#     printf "U+%04X: %s\n" $i "$(printf "\\u$(printf '%04x' $i)")"
# done


# for ((i=61440; i<=63231; i++)); do
#     printf "%s \\" "$(printf "\\u$(printf '%04x' $i)")"
# done

for ((i=61440; i<=63231; i++)); do
    printf "%s\n" "$(printf "\\u$(printf '%04x' $i)")"
done


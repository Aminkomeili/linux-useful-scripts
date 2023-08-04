#!/bin/bash

output_file="linux-info.txt"

# Run dmidecode and save the output to the file
sudo dmidecode > "$output_file"

echo "linux-info output has been saved to '$output_file'."

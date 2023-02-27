#!/bin/bash

# جستجوی عبارت در تمامی فایل‌ها و دایرکتوری‌های سیستم
read -p "Enter search term: " term
read -p "Enter starting directory: " dir

echo "Searching for \"$term\" in \"$dir\"..."

# استفاده از دستور find برای جستجو
find "$dir" -type f -print0 | xargs -0 grep -i "$term" /dev/null


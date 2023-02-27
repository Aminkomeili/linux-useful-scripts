#!/bin/bash

# الگوی جستجو را دریافت کنید
read -p "Enter the search pattern: " pattern

# جستجو در تمام فایل ها و دایرکتوری های سیستم عامل لینوکس
# -iname: جستجو برای الگویی با نام فایل ها/دایرکتوری ها، بدون توجه به حروف بزرگ/کوچک
# -type f: جستجو در فایل ها (به جای دایرکتوری ها)
# -type d: جستجو در دایرکتوری ها (به جای فایل ها)
# 2>/dev/null: خطاهای سیستم عامل را به نادیده بگیرید
# | less: نتایج جستجو را به یک صفحه از طریق less نمایش دهید
sudo find / -iname "*$pattern*" -type f 2>/dev/null | less
sudo find / -iname "*$pattern*" -type d 2>/dev/null | less


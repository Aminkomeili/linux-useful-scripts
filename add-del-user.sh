#!/bin/bash

# پرسیدن نام کاربر
read -p "نام کاربری را وارد کنید: " username

# پرسیدن سطح دسترسی
read -p "سطح دسترسی (0 برای root و 1 برای کاربر): " userlevel

# بررسی وجود کاربر در سیستم
if id "$username" >/dev/null 2>&1; then
  # حذف کاربر
  echo "کاربر $username حذف می‌شود..."
  userdel "$username"
else
  # ایجاد کاربر
  echo "کاربر $username ایجاد می‌شود..."
  useradd -m -s /bin/bash -U -G sudo "$username"
fi

# تغییر سطح دسترسی
if [ $userlevel -eq 0 ]; then
  usermod -aG sudo "$username"
else
  usermod -aG sudo "$username"
  usermod -aG www-data "$username" # به عنوان مثال می‌توانید گروه دیگری را هم اضافه کنید
fi

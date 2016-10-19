#!/bin/bash

# Desc:shell script for sending mail with mail command through STMP
# 该脚本有点疑惑 这里的smtp配置没有用其实还是使用的系统配置中的smtp

# must be same with STMP account addr
from="a@qq.com"
# more receiver like a@example.com b@example.com ...
to="b@qq.com"
subject="Your email title"
#you can also read content from the file just use $(cat yourfile)
body="This is body content of your email"

declare -a attachments
attachments=( "a.pdf" "b.zip" )

#deal with attachment args
declare -a attargs
for att in "${attachments[@]}"; do
   [ ! -f "$att" ] && echo "Warning: attachment $att not found, skipping" >&2 && continue	
  attargs+=( "-a"  "$att" )
done

# smtp server info
smtpserver="smtp.qq.com"
smtpport="25"
user="a@qq.com"
password="xxxxxxxx"

mail -s "$subject" -r "$from" -S smtp="smtp://${smtpserver}:${smtpport}" \
                              -S smtp-auth=login \
                              -S smtp-auth-user="$user" \
                              -S smtp-auth-password="$password" \
                              -S sendwait \
                              "${attargs[@]}" "$to" <<< "$body"
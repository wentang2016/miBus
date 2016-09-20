#!/bin/bash

find /Users/baixiong/Documents/gitHub/wechat.msekko.com/resources/views/temp  -name '*.html' -type f  -exec rename 's/\.html$/.blade.php/'  {} \;

rm -rf /Users/baixiong/Documents/gitHub/wechat.msekko.com/public/jrctpublic
rm -rf /Users/baixiong/Documents/gitHub/wechat.msekko.com/resources/views/jrctviews


mv jrctviews  ../
mv jrctpublic  ../../../public
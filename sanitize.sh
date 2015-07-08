#!/bin/bash

cat $1 | sed '/^$/d;s/[[:blank:]]//g' > sanitized_tmp && mv sanitized_tmp $1
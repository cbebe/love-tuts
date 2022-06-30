#!/bin/bash

! [[ -f "main.lua" ]] && echo "ERROR: Missing main.lua" && exit 1
! [[ -f "conf.lua" ]] && echo "ERROR: Missing conf.lua" && exit 1

zip -9 -r $1.love .

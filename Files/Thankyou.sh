#!/bin/bash
  title="Thank you to my donators!"
  contributors="Thank you to the contributors"
  clear
  ast="*********************************************************"
  columns=$(tput cols)
  y=$((($columns-${#ast})/2))
  x=0
  tput clear
  tput cup $x $y
  echo "${ast}"
  echo ""
  sleep .5
  y=$((($columns-${#title})/2))
  x=1
  tput cup $x $y
  echo "${title}"
  echo ""
  sleep .5
  y=$((($columns-${#ast})/2))
  x=2
  tput cup $x $y
  echo "${ast}"
  echo ""
  sleep .5
  y=$((($columns-6)/2))
  x=3
  tput cup $x $y
  echo "Marlin"
  sleep 3
  clear
  y=$((($columns-${#ast})/2))
  x=0
  tput cup $x $y
  echo "${ast}"
  echo ""
  sleep .5
  y=$((($columns-${#contributors})/2))
  x=1
  tput cup $x $y
  echo "${contributors}"
  echo ""
  sleep .5
  y=$((($columns-${#ast})/2))
  x=2
  tput cup $x $y
  echo "${ast}"
  echo ""
   sleep .5
  y=$((($columns-12)/2))
  x=3
  tput cup $x $y
  echo "Redblueflame"
  sleep .5
  y=$((($columns-12)/2))
  x=4
  tput cup $x $y
  echo "Lord Bob Ross"
  echo ""
  read -n 1 -s -r -p "Press any key to continue"

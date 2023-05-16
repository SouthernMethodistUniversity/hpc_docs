#!/bin/bash
# BASH shell script example
# Dan Reynolds
# May 2013

# define the "odd" function, takes one argument
odd() {
   echo "$1 is odd"
}

# define the "even" function, takes one argument
even() {
   echo "$1 is even"
}

# define the "other" function, takes one argument
other() {
   echo "$1 is neither even nor odd"
}

# loop over some integers, checking even/odd
for i in {1..20}; do
   m=$(($i % 2))
   if [ $m -eq 0 ]; then
      even $i
   elif [ $m -eq 1 ]; then
      odd $i
   else
      other $i
   fi
done

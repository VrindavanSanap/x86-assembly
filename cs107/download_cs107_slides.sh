#!/bin/bash
for i in $(seq 1 18); do
    if [ $i -lt 10 ]; then
        wget "https://web.stanford.edu/class/archive/cs/cs107/cs107.1248/lectures/0$i/Lecture$i.pdf"
    else
        wget "https://web.stanford.edu/class/archive/cs/cs107/cs107.1248/lectures/$i/Lecture$i.pdf"
    fi
done

#!/usr/bin/env fish
for i in (seq 1 18)
    if test $i -lt 10
        wget "https://web.stanford.edu/class/archive/cs/cs107/cs107.1248/lectures/0$i/Lecture$i.pdf"
    else
        wget "https://web.stanford.edu/class/archive/cs/cs107/cs107.1248/lectures/$i/Lecture$i.pdf"
    end
end

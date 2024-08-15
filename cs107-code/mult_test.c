#include <stdio.h>
#include <stdlib.h>

// Computers use a limited number of bits for numbers
int main(){
    int a = 200;
    int b = 300;
    int c = 400;
    int d = 500;

    int ans = a * b * c * d;
    printf("%d", (int)sizeof(ans));
    printf("%d", ans);
    return 0;
}

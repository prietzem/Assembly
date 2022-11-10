#include <stdio.h>

int main(){
    int x = 2;
    switch ( x ) {
        case 1:
            x += 100;
            printf("1");
        case 2:
            printf("2");
            x -= 20;
        case 10:
            printf("3");
            x *= 10;
        default :
            printf("4");
            x /= 5;
    }
    printf("x = %d\n" , x);
    return 0;
}
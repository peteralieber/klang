#include <stdio.h>

/* Fibonacci sequence in K language */

mI' fib(mI' n) {
    chugh (n <= 1)
        chegh n;
    chegh fib(n-1) + fib(n-2);
}

mI' wa'DIch(pagh) {
    mI' i;
    cha'("Fibonacci sequence:\n");
    vay' (i = 0; i < 10; i++) {
        cha'("fib(%d) = %d\n", i, fib(i));
    }
    chegh 0;
}

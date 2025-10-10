#include <stdio.h>

/* Loop and conditional demonstration in K language */

mI' wa'DIch(pagh) {
    mI' count = 0;
    
    cha'("Counting with taH (while):\n");
    taH (count < 5) {
        cha'("  Count: %d\n", count);
        count++;
    }
    
    cha'("\nChecking with chugh/qaSpa' (if/else):\n");
    chugh (count == 5) {
        cha'("  Count is 5 - Qapla'! (Success!)\n");
    } qaSpa' {
        cha'("  Count is not 5\n");
    }
    
    chegh 0;
}

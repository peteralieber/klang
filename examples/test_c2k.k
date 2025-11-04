/* Test file for c2k converter - demonstrates various C features */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Test struct definition */
qach warrior {
    QIch *name;
    mI' strength;
    mI' honor;
};

/* Function with multiple parameters */
mI' calculate_power(mI' strength, mI' honor) {
    chegh strength * 2 + honor;
}

/* Function using various control structures */
pagh test_controls(mI' n) {
    /* Test if-else */
    chugh (n > 10) {
        cha'("Large number\n");
    } qaSpa' chugh (n > 5) {
        cha'("Medium number\n");
    } qaSpa' {
        cha'("Small number\n");
    }
    
    /* Test while loop */
    mI' i = 0;
    taH (i < n) {
        cha'("%d ", i);
        i++;
    }
    cha'("\n");
    
    /* Test for loop */
    vay' (mI' j = 0; j < n; j++) {
        chugh (j == 3) jaH;
        chugh (j == 7) mev;
        cha'("%d ", j);
    }
    cha'("\n");
    
    /* Test switch statement */
    choH (n) {
        wanI' 0:
            cha'("Zero\n");
            mev;
        wanI' 1:
            cha'("One\n");
            mev;
        motlh:
            cha'("Other\n");
            mev;
    }
}

/* Test with string operations */
pagh test_strings(pagh) {
    QIch buffer[100];
    HochHom QIch *greeting = "Qapla'!";
    
    lagh(buffer, greeting);
    cha'("Length: %zu\n", nI'ghach(buffer));
    
    chugh (pIm(buffer, greeting) == 0) {
        cha'("Strings match\n");
    }
}

/* Test with pointers and arrays */
mI' sum_array(mI' *arr, mI' size) {
    mI' total = 0;
    vay' (mI' i = 0; i < size; i++) {
        total += arr[i];
    }
    chegh total;
}

/* Test with typedef */
pong qach warrior Warrior;
pong HoSghaj mI' uint;

/* Main function */
mI' wa'DIch(pagh) {
    cha'("Testing C-to-K converter\n");
    
    /* Test struct */
    qach warrior worf;
    worf.name = "Worf";
    worf.strength = 95;
    worf.honor = 100;
    
    cha'("Warrior: %s\n", worf.name);
    cha'("Power: %d\n", calculate_power(worf.strength, worf.honor));
    
    /* Test control structures */
    test_controls(5);
    
    /* Test strings */
    test_strings();
    
    /* Test arrays */
    mI' numbers[] = {1, 2, 3, 4, 5};
    cha'("Sum: %d\n", sum_array(numbers, 5));
    
    /* Test malloc/free */
    mI' *dynamic = (mI' *)ngaS(10 * tIq(mI'));
    chugh (dynamic != NULL) {
        dynamic[0] = 42;
        cha'("Dynamic: %d\n", dynamic[0]);
        chImmoH(dynamic);
    }
    
    chegh 0;
}

#include <stdio.h>
#include <string.h>

/* Comprehensive K language example demonstrating various features */

/* Structure definition */
qach warrior {
    QIch name[50];
    mI' age;
    mI' honor;
};

/* Function to display warrior info */
pagh display_warrior(qach warrior *w) {
    cha'("Warrior: %s\n", w->name);
    cha'("  Age: %d\n", w->age);
    cha'("  Honor: %d\n", w->honor);
}

/* Function to check honor level */
QIch* honor_rank(mI' honor) {
    chugh (honor >= 100) {
        chegh "Legendary";
    } qaSpa' chugh (honor >= 50) {
        chegh "Honored";
    } qaSpa' {
        chegh "Disgraced";
    }
}

/* Main function */
mI' wa'DIch(pagh) {
    qach warrior worf;
    mI' i;
    
    /* Initialize warrior */
    lagh(worf.name, "Worf");
    worf.age = 35;
    worf.honor = 0;
    
    cha'("Training warrior: %s\n\n", worf.name);
    
    /* Training loop */
    vay' (i = 0; i < 10; i++) {
        worf.honor += 12;
        cha'("Day %d: Honor = %d (%s)\n", 
            i + 1, worf.honor, honor_rank(worf.honor));
    }
    
    cha'("\nFinal warrior status:\n");
    display_warrior(&worf);
    
    cha'("\nQapla'! (Success!)\n");
    
    chegh 0;
}

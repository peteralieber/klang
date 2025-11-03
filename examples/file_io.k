#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Example demonstrating file I/O with Klingon stdlib functions */

mI' wa'DIch(pagh) {
    cha'("=== File I/O Test in K Language ===\n\n");
    
    /* Create and write to a file */
    cha'("1. Writing to file...\n");
    FILE *file = poSmoH("/tmp/klingon_test.txt", "w");  /* fopen */
    chugh (!file) {
        cha'("Error: Could not open file for writing\n");
        chegh 1;
    }
    
    cha'De'(file, "Qo'noS - Klingon Homeworld\n");  /* fprintf */
    cha'De'(file, "Population: %d million\n", 42);
    pol("Warriors: Worf, Martok, Gowron\n", file);  /* fputs */
    SoQmoH(file);  /* fclose */
    
    /* Read from the file */
    cha'("\n2. Reading from file...\n");
    file = poSmoH("/tmp/klingon_test.txt", "r");  /* fopen */
    chugh (!file) {
        cha'("Error: Could not open file for reading\n");
        chegh 1;
    }
    
    QIch line[256];
    taH (Suq(line, tIq(line), file) != NULL) {  /* while fgets */
        cha'("   %s", line);
    }
    SoQmoH(file);  /* fclose */
    
    /* Test binary file operations */
    cha'("\n3. Testing binary file operations...\n");
    file = poSmoH("/tmp/klingon_binary.dat", "wb");  /* fopen */
    chugh (file) {
        mI' data[] = {1701, 1764, 1864, 74656};
        ghItlhmoH(data, tIq(mI'), 4, file);  /* fwrite */
        SoQmoH(file);  /* fclose */
        cha'("   Wrote %lu integers to binary file\n", tIq(data) / tIq(mI'));
    }
    
    file = poSmoH("/tmp/klingon_binary.dat", "rb");  /* fopen */
    chugh (file) {
        mI' read_data[4];
        qabHom(read_data, 0, tIq(read_data));  /* memset */
        laD(read_data, tIq(mI'), 4, file);  /* fread */
        SoQmoH(file);  /* fclose */
        
        cha'("   Read integers: ");
        vay' (mI' i = 0; i < 4; i++) {
            cha'("%d ", read_data[i]);
        }
        cha'("\n");
    }
    
    cha'("\n=== Qapla'! File operations successful! ===\n");
    chegh 0;
}

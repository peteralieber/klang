# K Language Specification

K is a programming language that is semantically identical to C, but uses Klingon terms for keywords and common programming constructs.

## Keyword Mappings

The following table shows the mapping between C keywords and K (Klingon) keywords:

| C Keyword | K Keyword | Klingon Meaning |
|-----------|-----------|-----------------|
| `int` | `mI'` | number |
| `char` | `QIch` | character |
| `float` | `bu'` | floating |
| `double` | `chID` | thick (double) |
| `void` | `pagh` | nothing |
| `if` | `chugh` | if |
| `else` | `qaSpa'` | otherwise |
| `while` | `taH` | continue |
| `for` | `vay'` | each/iteration |
| `return` | `chegh` | return |
| `struct` | `qach` | structure |
| `typedef` | `pong` | name |
| `sizeof` | `tIq` | size |
| `break` | `mev` | stop |
| `continue` | `jaH` | go |
| `switch` | `choH` | change |
| `case` | `wanI'` | case |
| `default` | `motlh` | usual |
| `const` | `HochHom` | unchanging |
| `static` | `tlhegh` | static |
| `extern` | `latlh` | external |
| `auto` | `mong` | automatic |
| `register` | `ghItlh` | register |
| `volatile` | `choq` | volatile |
| `unsigned` | `HoSghaj` | powerful (positive) |
| `signed` | `mI'ghach` | numbered |
| `long` | `tIq` | long |
| `short` | `puS` | short |
| `enum` | `patlh` | rank |
| `union` | `boq` | alliance |
| `goto` | `ghoS` | approach/go |
| `do` | `ta'` | do |

## Standard Library Functions

Common C standard library functions also have Klingon equivalents:

### stdio.h (Input/Output Functions)

| C Function | K Function | Klingon Meaning |
|------------|------------|-----------------|
| `printf` | `cha'` | show |
| `scanf` | `Qoy'` | hear/listen |
| `fprintf` | `cha'De'` | show to file |
| `sprintf` | `cha'tlhegh` | show string |
| `fopen` | `poSmoH` | open (file) |
| `fclose` | `SoQmoH` | close (file) |
| `fread` | `laD` | read |
| `fwrite` | `ghItlhmoH` | write |
| `fgets` | `Suq` | acquire/get |
| `fputs` | `pol` | put |
| `getchar` | `SuqQIch` | get character |
| `putchar` | `polQIch` | put character |
| `puts` | `ngh` | output/emit |

### string.h (String Manipulation Functions)

| C Function | K Function | Klingon Meaning |
|------------|------------|-----------------|
| `strlen` | `nI'ghach` | length |
| `strcpy` | `lagh` | copy |
| `strcmp` | `pIm` | compare |
| `strcat` | `chel` | add/concatenate |
| `strncpy` | `laghboq` | copy (limited) |
| `strncmp` | `pImboq` | compare (limited) |
| `strchr` | `tu'QIch` | find character |
| `strrchr` | `tu'Qav` | find last |
| `strstr` | `tu'tlhegh` | find string |
| `strtok` | `SIH` | separate/tokenize |
| `memcpy` | `laghHom` | copy memory |
| `memmove` | `choHHom` | move memory |
| `memset` | `qabHom` | set memory |
| `memcmp` | `pImHom` | compare memory |

### stdlib.h (General Utility Functions)

| C Function | K Function | Klingon Meaning |
|------------|------------|-----------------|
| `malloc` | `ngaS` | allocate |
| `free` | `chImmoH` | free/release |
| `calloc` | `ngaSchu'` | allocate clear |
| `realloc` | `ngaSchIm` | reallocate |
| `exit` | `mej` | leave/exit |
| `abort` | `mevmoH` | abort/stop |
| `atoi` | `toDmI'` | parse number |
| `atof` | `toDbu'` | parse float |
| `atol` | `toDtIq` | parse long |
| `rand` | `nap` | random |
| `srand` | `qawmoH` | seed |
| `qsort` | `wegh` | sort |
| `bsearch` | `nejchu'` | binary search |

### math.h (Mathematical Functions)

| C Function | K Function | Klingon Meaning |
|------------|------------|-----------------|
| `sqrt` | `boqHa'mI'` | square root |
| `pow` | `HoS` | power |
| `abs` | `jompatlh` | absolute value |
| `fabs` | `jombu'` | floating absolute |
| `sin` | `maghwI'` | sine |
| `cos` | `maghwI'cha'` | cosine |
| `tan` | `maghwI'wej` | tangent |
| `exp` | `jen` | exponential |
| `log` | `naH` | logarithm |
| `floor` | `bID` | floor |
| `ceil` | `joq` | ceiling |

### ctype.h (Character Handling Functions)

| C Function | K Function | Klingon Meaning |
|------------|------------|-----------------|
| `isalpha` | `qaQIchQach` | is letter |
| `isdigit` | `qaQIchmI'` | is digit |
| `isalnum` | `qaQIchboq` | is alphanumeric |
| `isspace` | `qaQIchpegh` | is space |
| `isupper` | `qaQIchtIn` | is uppercase |
| `islower` | `qaQIchmach` | is lowercase |
| `toupper` | `QIchtIn` | to uppercase |
| `tolower` | `QIchmach` | to lowercase |

### time.h (Time Functions)

| C Function | K Function | Klingon Meaning |
|------------|------------|-----------------|
| `time` | `poH` | time |
| `clock` | `poHmI'` | clock/time measure |
| `difftime` | `poHpIm` | time difference |
| `strftime` | `poHcha'` | time format |

### Special Functions

| C Function | K Function | Klingon Meaning |
|------------|------------|-----------------|
| `main` | `wa'DIch` | first/primary |

## Example Programs

### Hello World in K

```k
#include <stdio.h>

mI' wa'DIch(pagh) {
    cha'("qo'noS!\n");
    chegh 0;
}
```

This is equivalent to the C program:

```c
#include <stdio.h>

int main(void) {
    printf("qo'noS!\n");
    return 0;
}
```

### Fibonacci in K

```k
#include <stdio.h>

mI' fib(mI' n) {
    chugh (n <= 1)
        chegh n;
    chegh fib(n-1) + fib(n-2);
}

mI' wa'DIch(pagh) {
    mI' n = 10;
    cha'("Fibonacci(%d) = %d\n", n, fib(n));
    chegh 0;
}
```

## Compiler Usage

The K compiler (`klang`) translates K source code to C source code, which can then be compiled with a standard C compiler.

```bash
klang input.k -o output.c
gcc output.c -o program
./program
```

## Implementation Notes

The K language compiler is a simple source-to-source translator that:
1. Reads K source code
2. Replaces K keywords with their C equivalents
3. Outputs valid C source code

The semantic behavior is identical to C since K is simply a lexical transformation of C.

## Identifier Naming

### Apostrophes in Identifiers

Klingon language uses the apostrophe (`'`) character in many words, and several K keywords contain apostrophes (e.g., `mI'`, `cha'`, `qaSpa'`). While these are valid in K source code, C does not allow apostrophes in identifiers.

The compiler handles this by:
- **Keywords with apostrophes**: Translated to their C equivalents (e.g., `mI'` → `int`, `cha'` → `printf`)
- **User-defined identifiers with apostrophes**: Apostrophes are replaced with underscores (`_`) in the C output

### Examples

**K source code:**
```k
mI' count' = 10;
mI' war'rior = 42;
cha'("count = %d, warrior = %d\n", count', war'rior);
```

**Generated C code:**
```c
int count_ = 10;
int war_rior = 42;
printf("count = %d, warrior = %d\n", count_, war_rior);
```

This allows K programmers to use apostrophes naturally in their identifier names while ensuring the generated C code compiles correctly. The apostrophe character is preserved in string literals and comments.

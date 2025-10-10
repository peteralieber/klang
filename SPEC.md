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

| C Function | K Function | 
|------------|------------|
| `printf` | `cha'` |
| `scanf` | `Qoy'` |
| `malloc` | `ngaS` |
| `free` | `chImmoH` |
| `strlen` | `nI'ghach` |
| `strcmp` | `pIm` |
| `strcpy` | `lagh` |
| `main` | `wa'DIch` |

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

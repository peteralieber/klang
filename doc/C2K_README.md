# c2k - C to K Language Converter

`c2k` is a tool that converts standard C source code to K language source code. It performs the reverse operation of the `klang` compiler, making it easy to translate existing C codebases into K.

## Features

- **Automatic Keyword Translation**: Converts all C keywords to their K (Klingon) equivalents
- **Standard Library Support**: Translates 60+ C standard library functions to K equivalents
- **Comment Preservation**: Preserves all comments exactly as they appear in the source
- **String Literal Preservation**: String contents remain unchanged
- **Written in K**: The converter itself is written in K language, demonstrating K's text processing capabilities

## Building

The c2k tool is built automatically when you run `make`:

```bash
make
```

Or build just the c2k tool:

```bash
make c2k
```

## Usage

Convert a C source file to K:

```bash
./c2k input.c -o output.k
```

If you don't specify an output file, it defaults to `output.k`:

```bash
./c2k input.c
```

Check the version:

```bash
./c2k --version
```

## Examples

### Basic Conversion

**Input (hello.c):**
```c
#include <stdio.h>

int main(void) {
    printf("Hello, World!\n");
    return 0;
}
```

**Output (hello.k):**
```k
#include <stdio.h>

mI' wa'DIch(pagh) {
    cha'("Hello, World!\n");
    chegh 0;
}
```

### Fibonacci Example

**Input (fib.c):**
```c
#include <stdio.h>

int fib(int n) {
    if (n <= 1)
        return n;
    return fib(n-1) + fib(n-2);
}

int main(void) {
    for (int i = 0; i < 10; i++) {
        printf("fib(%d) = %d\n", i, fib(i));
    }
    return 0;
}
```

**Output (fib.k):**
```k
#include <stdio.h>

mI' fib(mI' n) {
    chugh (n <= 1)
        chegh n;
    chegh fib(n-1) + fib(n-2);
}

mI' wa'DIch(pagh) {
    vay' (mI' i = 0; i < 10; i++) {
        cha'("fib(%d) = %d\n", i, fib(i));
    }
    chegh 0;
}
```

## Roundtrip Conversion

You can convert C to K and back to C:

```bash
# Convert C to K
./c2k program.c -o program.k

# Convert K back to C
./klang program.k -o program_roundtrip.c

# Compile and run
gcc program_roundtrip.c -o program
./program
```

The roundtrip produces semantically equivalent C code.

## Testing

Test the c2k converter:

```bash
make test-c2k
```

This will convert a C example to K, then back to C, compile it, and run it to verify correctness.

## Keyword Mappings

The c2k tool uses the reverse mapping of klang's keyword table. Here are some common translations:

| C Keyword | K Keyword | Klingon Meaning |
|-----------|-----------|-----------------|
| `int` | `mI'` | number |
| `void` | `pagh` | nothing |
| `if` | `chugh` | if |
| `else` | `qaSpa'` | otherwise |
| `while` | `taH` | continue |
| `for` | `vay'` | each/iteration |
| `return` | `chegh` | return |
| `printf` | `cha'` | show |
| `main` | `wa'DIch` | first/primary |

For a complete list of keyword and function mappings, see [SPEC.md](../doc/SPEC.md).

## Limitations

1. **Macro Expansion**: Macros are preserved as-is, not expanded
2. **Preprocessor Directives**: `#include`, `#define`, etc. are preserved unchanged
3. **Comments**: Comments remain in their original language (not translated to Klingon)
4. **Type Names**: Custom type names are preserved (only C keywords are translated)

## Implementation Notes

The c2k tool is implemented entirely in K language (`c2k.k`). It demonstrates that K is capable of handling complex text processing tasks like source code translation.

The tool works by:
1. Reading the C source file
2. Parsing character by character while tracking state (strings, comments, character literals)
3. Matching C keywords and functions at word boundaries
4. Replacing matches with K equivalents
5. Writing the transformed output to a K source file

## See Also

- [C2K_DESIGN.md](C2K_DESIGN.md) - Detailed design documentation
- [SPEC.md](SPEC.md) - K language specification
- [README.md](../README.md) - Main klang documentation

## Qapla'!

May your C code be successfully translated to glorious Klingon!

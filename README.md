# klang - The K Programming Language

K is a programming language that is semantically identical to C, but uses Klingon terms for keywords and common programming constructs. It's perfect for Klingon warriors who want to write code in their native tongue!

## Overview

The K language compiler (`klang`) is a source-to-source translator that converts K language code to standard C code, which can then be compiled with any C compiler.

## Features

- **Semantically Identical to C**: K programs behave exactly like C programs
- **Klingon Keywords**: All C keywords replaced with Klingon equivalents
- **Easy to Use**: Simple command-line interface
- **Compatible**: Generates standard C code that works with any C compiler

## Installation

Build the compiler using make:

```bash
make
```

This creates the `klang` executable.

### K Language Version

A version of the compiler written in K language itself (`klang.k`) is included in the repository. However, due to a limitation in the compiler's handling of escaped single quotes in character literals (e.g., `'\''`), the K version cannot currently be bootstrapped to compile itself. This is a known issue that would require enhancing the escape sequence handling in the translator.

The `klang.k` file serves as a comprehensive example of K language syntax and demonstrates that the language is capable of expressing complex programs like compilers.

## Usage

Translate a K source file to C:

```bash
./klang input.k -o output.c
```

Then compile the generated C file:

```bash
gcc output.c -o program
./program
```

## Example: Hello World

**hello.k**:
```k
#include <stdio.h>

mI' wa'DIch(pagh) {
    cha'("qo'noS! (Hello from the Klingon homeworld!)\n");
    chegh 0;
}
```

Compile and run:
```bash
./klang hello.k -o hello.c
gcc hello.c -o hello
./hello
```

## Quick Reference

Some common keyword translations:

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

For a complete list of keywords and more examples, see [SPEC.md](SPEC.md).

## Identifier Naming

Klingon uses apostrophes (`'`) in many words. In K language, you can use apostrophes in your own identifier names (e.g., `my'variable`, `count'`), and the compiler will automatically convert them to underscores in the C output to ensure valid C code. Klingon keywords with apostrophes (like `mI'`, `cha'`) are always translated to their C equivalents.

**Example:**
```k
mI' warrior'count = 5;  // Becomes: int warrior_count = 5;
```

See [SPEC.md](doc/SPEC.md) for more details.

## Examples

The `examples/` directory contains sample K programs:
- `hello.k` - Hello World
- `fib.k` - Fibonacci sequence
- `loops.k` - Loops and conditionals

Run all examples with:
```bash
make test
```

## Language Specification

See [SPEC.md](SPEC.md) for the complete language specification.

## License

MIT License - see [LICENSE](LICENSE) file for details.

## Qapla'!

May your code compile successfully and your programs run without bugs!

## Disclaimer

This is a non-commercial, fan-created work inspired by the Klingon language and the Star Trek universe. All related trademarks and copyrights remain the property of their respective owners. No ownership is claimed, and use is intended under fair use principles.

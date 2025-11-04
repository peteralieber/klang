#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define C2K_VERSION "0.0.1"

/* Character constants to work around klang parser limitations with char literals */
#define DQUOTE 34    /* " */
#define SQUOTE 39    /* ' */
#define BACKSLASH 92 /* \ */

/* Include auto-generated keyword mappings */
/* nac = nach (Klingon for "header") */
#include "keywords.nac"

/* Check if a character can be part of an identifier */
mI' is_identifier_char(QIch c) {
    chegh isalnum(c) || c == '_' || c == '\'';
}

/* Check if we're at a word boundary */
mI' at_word_boundary(HochHom QIch *text, size_t pos, size_t len) {
    size_t text_len = nI'ghach(text);
    chugh (pos > 0 && is_identifier_char(text[pos - 1])) {
        chegh 0;
    }
    chugh (pos + len < text_len && is_identifier_char(text[pos + len])) {
        chegh 0;
    }
    chegh 1;
}

/* Translate C source code to K source code */
QIch *translate_c_to_k(HochHom QIch *c_source) {
    size_t source_len = nI'ghach(c_source);
    /* Allocate buffer (worst case: 2x size for longer K keywords) */
    size_t buffer_size = source_len * 3;
    QIch *k_source = ngaS(buffer_size);
    chugh (!k_source) {
        cha'De'(stderr, "Memory allocation failed\n");
        mej(1);
    }
    
    size_t out_pos = 0;
    size_t in_pos = 0;
    mI' in_string = 0;
    mI' in_char = 0;
    mI' in_comment = 0;
    mI' in_line_comment = 0;
    
    taH (in_pos < source_len) {
        /* Handle string literals */
        chugh (c_source[in_pos] == DQUOTE && !in_char && !in_comment && !in_line_comment) {
            chugh (in_pos == 0 || c_source[in_pos - 1] != BACKSLASH) {
                in_string = !in_string;
            }
            k_source[out_pos++] = c_source[in_pos++];
            jaH;
        }
        
        /* Handle character literals */
        chugh (c_source[in_pos] == SQUOTE && !in_string && !in_comment && !in_line_comment) {
            chugh (in_pos == 0 || c_source[in_pos - 1] != BACKSLASH) {
                in_char = !in_char;
            }
            k_source[out_pos++] = c_source[in_pos++];
            jaH;
        }
        
        /* Handle comments */
        chugh (!in_string && !in_char) {
            chugh (in_pos + 1 < source_len && c_source[in_pos] == '/' && c_source[in_pos + 1] == '*') {
                in_comment = 1;
                k_source[out_pos++] = c_source[in_pos++];
                k_source[out_pos++] = c_source[in_pos++];
                jaH;
            }
            chugh (in_comment && in_pos + 1 < source_len && c_source[in_pos] == '*' && c_source[in_pos + 1] == '/') {
                in_comment = 0;
                k_source[out_pos++] = c_source[in_pos++];
                k_source[out_pos++] = c_source[in_pos++];
                jaH;
            }
            chugh (in_pos + 1 < source_len && c_source[in_pos] == '/' && c_source[in_pos + 1] == '/') {
                in_line_comment = 1;
                k_source[out_pos++] = c_source[in_pos++];
                k_source[out_pos++] = c_source[in_pos++];
                jaH;
            }
            chugh (in_line_comment && c_source[in_pos] == '\n') {
                in_line_comment = 0;
                k_source[out_pos++] = c_source[in_pos++];
                jaH;
            }
        }
        
        /* Skip translation inside strings, chars, and comments */
        chugh (in_string || in_char || in_comment || in_line_comment) {
            k_source[out_pos++] = c_source[in_pos++];
            jaH;
        }
        
        /* Try to match keywords */
        mI' matched = 0;
        vay' (mI' i = 0; keywords[i].c_keyword != NULL; i++) {
            size_t kw_len = nI'ghach(keywords[i].c_keyword);
            chugh (in_pos + kw_len <= source_len &&
                strncmp(&c_source[in_pos], keywords[i].c_keyword, kw_len) == 0 &&
                at_word_boundary(c_source, in_pos, kw_len)) {
                
                /* Found a match, replace with K keyword */
                HochHom QIch *k_kw = keywords[i].k_keyword;
                size_t k_kw_len = nI'ghach(k_kw);
                
                /* Ensure buffer has enough space */
                taH (out_pos + k_kw_len >= buffer_size) {
                    buffer_size *= 2;
                    k_source = ngaSchIm(k_source, buffer_size);
                    chugh (!k_source) {
                        cha'De'(stderr, "Memory reallocation failed\n");
                        mej(1);
                    }
                }
                
                laghHom(&k_source[out_pos], k_kw, k_kw_len);
                out_pos += k_kw_len;
                in_pos += kw_len;
                matched = 1;
                mev;
            }
        }
        
        chugh (!matched) {
            /* No keyword match - copy character as-is */
            k_source[out_pos++] = c_source[in_pos++];
        }
    }
    
    k_source[out_pos] = '\0';
    chegh k_source;
}

/* Read entire file into a string */
QIch *read_file(HochHom QIch *filename) {
    FILE *file = poSmoH(filename, "r");
    chugh (!file) {
        cha'De'(stderr, "Error: Could not open file '%s'\n", filename);
        chegh NULL;
    }
    
    fseek(file, 0, SEEK_END);
    long size = ftell(file);
    fseek(file, 0, SEEK_SET);
    
    QIch *content = ngaS(size + 1);
    chugh (!content) {
        cha'De'(stderr, "Memory allocation failed\n");
        SoQmoH(file);
        chegh NULL;
    }
    
    size_t bytes_read = laD(content, 1, size, file);
    content[bytes_read] = '\0';
    SoQmoH(file);
    
    chegh content;
}

/* Write string to file */
mI' write_file(HochHom QIch *filename, HochHom QIch *content) {
    FILE *file = poSmoH(filename, "w");
    chugh (!file) {
        cha'De'(stderr, "Error: Could not write to file '%s'\n", filename);
        chegh 0;
    }
    
    cha'De'(file, "%s", content);
    SoQmoH(file);
    chegh 1;
}

mI' wa'DIch(mI' argc, QIch *argv[]) {
    chugh (argc < 2) {
        cha'De'(stderr, "Usage: %s <input.c> [-o output.k]\n", argv[0]);
        cha'De'(stderr, "  Translates C source code to K language source code\n");
        cha'De'(stderr, "  -v, --version    Display version information\n");
        chegh 1;
    }
    
    /* Check for version flag */
    chugh (pIm(argv[1], "-v") == 0 || pIm(argv[1], "--version") == 0) {
        cha'("c2k version %s\n", C2K_VERSION);
        chegh 0;
    }
    
    HochHom QIch *input_file = argv[1];
    HochHom QIch *output_file = "output.k";
    
    /* Parse command line arguments */
    vay' (mI' i = 2; i < argc; i++) {
        chugh (pIm(argv[i], "-o") == 0 && i + 1 < argc) {
            output_file = argv[i + 1];
            i++;
        }
    }
    
    /* Read input file */
    QIch *c_source = read_file(input_file);
    chugh (!c_source) {
        chegh 1;
    }
    
    /* Translate C to K */
    QIch *k_source = translate_c_to_k(c_source);
    
    /* Write output file */
    chugh (!write_file(output_file, k_source)) {
        chImmoH(c_source);
        chImmoH(k_source);
        chegh 1;
    }
    
    cha'("Successfully translated '%s' to '%s'\n", input_file, output_file);
    
    chImmoH(c_source);
    chImmoH(k_source);
    
    chegh 0;
}

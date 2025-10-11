/*
 * klang.k - K Language Compiler (Self-Hosting Version)
 * 
 * This is a direct translation of klang.c from C to K language.
 * 
 * LIMITATION: This code CANNOT be compiled by the current K translator due to
 * a known issue with character literal handling. The translator does not 
 * correctly handle escaped single quotes in character literals (e.g., '\''). 
 * 
 * The problem occurs on lines that contain comparisons with single quote
 * characters, such as:
 *   chugh (k_source[in_pos] == '\'' && ...)
 * 
 * When the translator encounters '\'' (escaped single quote), it incorrectly
 * enters a character literal state and fails to translate subsequent keywords.
 * This prevents the K version from being bootstrapped until the escape sequence
 * handling in the translator is fixed.
 * 
 * This file serves as:
 * 1. A demonstration that K can express complex programs like compilers
 * 2. A comprehensive example of K language syntax
 * 3. A reference for the self-hosting version once the limitation is resolved
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

/* Keyword mapping structure */
pong qach {
    HochHom QIch *k_keyword;
    HochHom QIch *c_keyword;
} KeywordMap;

/* Keyword mappings from K to C */
tlhegh HochHom KeywordMap keywords[] = {
    {"mI'", "int"},
    {"QIch", "char"},
    {"bu'", "float"},
    {"chID", "double"},
    {"pagh", "void"},
    {"chugh", "if"},
    {"qaSpa'", "else"},
    {"taH", "while"},
    {"vay'", "for"},
    {"chegh", "return"},
    {"qach", "struct"},
    {"pong", "typedef"},
    {"tIq", "sizeof"},
    {"mev", "break"},
    {"jaH", "continue"},
    {"choH", "switch"},
    {"wanI'", "case"},
    {"motlh", "default"},
    {"HochHom", "const"},
    {"tlhegh", "static"},
    {"latlh", "extern"},
    {"mong", "auto"},
    {"ghItlh", "register"},
    {"choq", "volatile"},
    {"HoSghaj", "unsigned"},
    {"mI'ghach", "signed"},
    {"puS", "short"},
    {"patlh", "enum"},
    {"boq", "union"},
    {"ghoS", "goto"},
    {"ta'", "do"},
    {"cha'", "printf"},
    {"Qoy'", "scanf"},
    {"ngaS", "malloc"},
    {"chImmoH", "free"},
    {"nI'ghach", "strlen"},
    {"pIm", "strcmp"},
    {"lagh", "strcpy"},
    {"wa'DIch", "main"},
    {NULL, NULL}
};

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

/* Translate K source code to C source code */
QIch *translate_k_to_c(HochHom QIch *k_source) {
    size_t source_len = nI'ghach(k_source);
    /* Allocate buffer (worst case: same size as input) */
    size_t buffer_size = source_len * 2;
    QIch *c_source = ngaS(buffer_size);
    chugh (!c_source) {
        fprintf(stderr, "Memory allocation failed\n");
        exit(1);
    }
    
    size_t out_pos = 0;
    size_t in_pos = 0;
    mI' in_string = 0;
    mI' in_char = 0;
    mI' in_comment = 0;
    mI' in_line_comment = 0;
    
    taH (in_pos < source_len) {
        /* Handle string literals */
        chugh (k_source[in_pos] == '"' && !in_char && !in_comment && !in_line_comment) {
            chugh (in_pos == 0 || k_source[in_pos - 1] != '\\') {
                in_string = !in_string;
            }
            c_source[out_pos++] = k_source[in_pos++];
            jaH;
        }
        
        /* Handle character literals */
        /* LIMITATION: The line below contains '\'' which causes the translator to fail.
         * This prevents klang.k from being compiled until the escape handling is fixed.
         * The comparison checks if the current character is a single quote (').
         */
        chugh (k_source[in_pos] == '\'' && !in_string && !in_comment && !in_line_comment) {
            chugh (in_pos == 0 || k_source[in_pos - 1] != '\\') {
                in_char = !in_char;
            }
            c_source[out_pos++] = k_source[in_pos++];
            jaH;
        }
        
        /* Handle comments */
        chugh (!in_string && !in_char) {
            chugh (in_pos + 1 < source_len && k_source[in_pos] == '/' && k_source[in_pos + 1] == '*') {
                in_comment = 1;
                c_source[out_pos++] = k_source[in_pos++];
                c_source[out_pos++] = k_source[in_pos++];
                jaH;
            }
            chugh (in_comment && in_pos + 1 < source_len && k_source[in_pos] == '*' && k_source[in_pos + 1] == '/') {
                in_comment = 0;
                c_source[out_pos++] = k_source[in_pos++];
                c_source[out_pos++] = k_source[in_pos++];
                jaH;
            }
            chugh (in_pos + 1 < source_len && k_source[in_pos] == '/' && k_source[in_pos + 1] == '/') {
                in_line_comment = 1;
                c_source[out_pos++] = k_source[in_pos++];
                c_source[out_pos++] = k_source[in_pos++];
                jaH;
            }
            chugh (in_line_comment && k_source[in_pos] == '\n') {
                in_line_comment = 0;
                c_source[out_pos++] = k_source[in_pos++];
                jaH;
            }
        }
        
        /* Skip translation inside strings, chars, and comments */
        chugh (in_string || in_char || in_comment || in_line_comment) {
            c_source[out_pos++] = k_source[in_pos++];
            jaH;
        }
        
        /* Try to match keywords */
        mI' matched = 0;
        vay' (mI' i = 0; keywords[i].k_keyword != NULL; i++) {
            size_t kw_len = nI'ghach(keywords[i].k_keyword);
            chugh (in_pos + kw_len <= source_len &&
                strncmp(&k_source[in_pos], keywords[i].k_keyword, kw_len) == 0 &&
                at_word_boundary(k_source, in_pos, kw_len)) {
                
                /* Found a match, replace with C keyword */
                HochHom QIch *c_kw = keywords[i].c_keyword;
                size_t c_kw_len = nI'ghach(c_kw);
                
                /* Ensure buffer has enough space */
                taH (out_pos + c_kw_len >= buffer_size) {
                    buffer_size *= 2;
                    c_source = realloc(c_source, buffer_size);
                    chugh (!c_source) {
                        fprintf(stderr, "Memory reallocation failed\n");
                        exit(1);
                    }
                }
                
                lagh(&c_source[out_pos], c_kw);
                out_pos += c_kw_len;
                in_pos += kw_len;
                matched = 1;
                mev;
            }
        }
        
        chugh (!matched) {
            c_source[out_pos++] = k_source[in_pos++];
        }
    }
    
    c_source[out_pos] = '\0';
    chegh c_source;
}

/* Read entire file into a string */
QIch *read_file(HochHom QIch *filename) {
    FILE *file = fopen(filename, "r");
    chugh (!file) {
        fprintf(stderr, "Error: Could not open file '%s'\n", filename);
        chegh NULL;
    }
    
    fseek(file, 0, SEEK_END);
    long size = ftell(file);
    fseek(file, 0, SEEK_SET);
    
    QIch *content = ngaS(size + 1);
    chugh (!content) {
        fprintf(stderr, "Memory allocation failed\n");
        fclose(file);
        chegh NULL;
    }
    
    size_t bytes_read = fread(content, 1, size, file);
    content[bytes_read] = '\0';
    fclose(file);
    
    chegh content;
}

/* Write string to file */
mI' write_file(HochHom QIch *filename, HochHom QIch *content) {
    FILE *file = fopen(filename, "w");
    chugh (!file) {
        fprintf(stderr, "Error: Could not write to file '%s'\n", filename);
        chegh 0;
    }
    
    fprintf(file, "%s", content);
    fclose(file);
    chegh 1;
}

mI' wa'DIch(mI' argc, QIch *argv[]) {
    chugh (argc < 2) {
        fprintf(stderr, "Usage: %s <input.k> [-o output.c]\n", argv[0]);
        fprintf(stderr, "  Translates K language source code to C source code\n");
        chegh 1;
    }
    
    HochHom QIch *input_file = argv[1];
    HochHom QIch *output_file = "output.c";
    
    /* Parse command line arguments */
    vay' (mI' i = 2; i < argc; i++) {
        chugh (pIm(argv[i], "-o") == 0 && i + 1 < argc) {
            output_file = argv[i + 1];
            i++;
        }
    }
    
    /* Read input file */
    QIch *k_source = read_file(input_file);
    chugh (!k_source) {
        chegh 1;
    }
    
    /* Translate K to C */
    QIch *c_source = translate_k_to_c(k_source);
    
    /* Write output file */
    chugh (!write_file(output_file, c_source)) {
        chImmoH(k_source);
        chImmoH(c_source);
        chegh 1;
    }
    
    cha'("Successfully translated '%s' to '%s'\n", input_file, output_file);
    
    chImmoH(k_source);
    chImmoH(c_source);
    
    chegh 0;
}

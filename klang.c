#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define KLANG_VERSION "1.0.0"

/* Keyword mapping structure */
typedef struct {
    const char *k_keyword;
    const char *c_keyword;
} KeywordMap;

/* Keyword mappings from K to C */
static const KeywordMap keywords[] = {
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
    /* Standard library function mappings */
    /* stdio.h functions */
    {"cha'", "printf"},
    {"Qoy'", "scanf"},
    {"poSmoH", "fopen"},
    {"SoQmoH", "fclose"},
    {"laD", "fread"},
    {"ghItlhmoH", "fwrite"},
    {"cha'De'", "fprintf"},
    {"cha'tlhegh", "sprintf"},
    {"Suq", "fgets"},
    {"pol", "fputs"},
    {"SuqQIch", "getchar"},
    {"polQIch", "putchar"},
    {"ngh", "puts"},
    /* string.h functions */
    {"nI'ghach", "strlen"},
    {"lagh", "strcpy"},
    {"pIm", "strcmp"},
    {"chel", "strcat"},
    {"laghboq", "strncpy"},
    {"pImboq", "strncmp"},
    {"tu'QIch", "strchr"},
    {"tu'Qav", "strrchr"},
    {"tu'tlhegh", "strstr"},
    {"SIH", "strtok"},
    {"laghHom", "memcpy"},
    {"choHHom", "memmove"},
    {"qabHom", "memset"},
    {"pImHom", "memcmp"},
    /* stdlib.h functions */
    {"ngaS", "malloc"},
    {"chImmoH", "free"},
    {"ngaSchu'", "calloc"},
    {"ngaSchIm", "realloc"},
    {"mej", "exit"},
    {"mevmoH", "abort"},
    {"toDmI'", "atoi"},
    {"toDbu'", "atof"},
    {"toDtIq", "atol"},
    {"nap", "rand"},
    {"qawmoH", "srand"},
    {"wegh", "qsort"},
    {"nejchu'", "bsearch"},
    /* math.h functions */
    {"boqHa'mI'", "sqrt"},
    {"HoS", "pow"},
    {"jompatlh", "abs"},
    {"jombu'", "fabs"},
    {"maghwI'", "sin"},
    {"maghwI'cha'", "cos"},
    {"maghwI'wej", "tan"},
    {"jen", "exp"},
    {"naH", "log"},
    {"bID", "floor"},
    {"joq", "ceil"},
    /* ctype.h functions */
    {"qaQIchQach", "isalpha"},
    {"qaQIchmI'", "isdigit"},
    {"qaQIchboq", "isalnum"},
    {"qaQIchpegh", "isspace"},
    {"qaQIchtIn", "isupper"},
    {"qaQIchmach", "islower"},
    {"QIchtIn", "toupper"},
    {"QIchmach", "tolower"},
    /* time.h functions */
    {"poH", "time"},
    {"poHmI'", "clock"},
    {"poHpIm", "difftime"},
    {"poHcha'", "strftime"},
    /* main function */
    {"wa'DIch", "main"},
    {NULL, NULL}
};

/* Check if a character can be part of an identifier */
int is_identifier_char(char c) {
    return isalnum(c) || c == '_' || c == '\'';
}

/* Check if we're at a word boundary */
int at_word_boundary(const char *text, size_t pos, size_t len) {
    size_t text_len = strlen(text);
    if (pos > 0 && is_identifier_char(text[pos - 1])) {
        return 0;
    }
    if (pos + len < text_len && is_identifier_char(text[pos + len])) {
        return 0;
    }
    return 1;
}

/* Translate K source code to C source code */
char *translate_k_to_c(const char *k_source) {
    size_t source_len = strlen(k_source);
    /* Allocate buffer (worst case: same size as input) */
    size_t buffer_size = source_len * 2;
    char *c_source = malloc(buffer_size);
    if (!c_source) {
        fprintf(stderr, "Memory allocation failed\n");
        exit(1);
    }
    
    size_t out_pos = 0;
    size_t in_pos = 0;
    int in_string = 0;
    int in_char = 0;
    int in_comment = 0;
    int in_line_comment = 0;
    
    while (in_pos < source_len) {
        /* Handle string literals */
        if (k_source[in_pos] == '"' && !in_char && !in_comment && !in_line_comment) {
            if (in_pos == 0 || k_source[in_pos - 1] != '\\') {
                in_string = !in_string;
            }
            c_source[out_pos++] = k_source[in_pos++];
            continue;
        }
        
        /* Handle character literals */
        /* Only treat ' as char literal if it's not part of an identifier */
        if (k_source[in_pos] == '\'' && !in_string && !in_comment && !in_line_comment) {
            int is_identifier_apostrophe = 0;
            
            /* If we're not already in a char literal, check if this is an identifier apostrophe */
            if (!in_char) {
                /* Check if this apostrophe is part of an identifier */
                int prev_is_ident = (in_pos > 0 && 
                                    (isalnum(k_source[in_pos - 1]) || k_source[in_pos - 1] == '_'));
                int next_is_ident = (in_pos + 1 < source_len && 
                                    (isalnum(k_source[in_pos + 1]) || k_source[in_pos + 1] == '_'));
                
                /* Apostrophe is part of identifier if:
                 * - It's in the middle: prev and next are identifier chars (x'y)
                 * - It's at the end: prev is identifier, next is not an apostrophe (var' = or var';)
                 */
                if (prev_is_ident && (in_pos + 1 >= source_len || k_source[in_pos + 1] != '\'')) {
                    if (next_is_ident) {
                        /* Middle of identifier: x'y */
                        is_identifier_apostrophe = 1;
                    } else {
                        /* Possibly at end of identifier: var' */
                        /* Make sure it's not the start of a char literal like = ' */
                        /* Check if previous non-whitespace is an identifier */
                        size_t prev_nonspace = in_pos - 1;
                        while (prev_nonspace > 0 && isspace(k_source[prev_nonspace])) {
                            prev_nonspace--;
                        }
                        if (isalnum(k_source[prev_nonspace]) || k_source[prev_nonspace] == '_') {
                            is_identifier_apostrophe = 1;
                        }
                    }
                }
            }
            
            if (!is_identifier_apostrophe) {
                /* This is a character literal delimiter */
                if (in_pos == 0 || k_source[in_pos - 1] != '\\') {
                    in_char = !in_char;
                }
                c_source[out_pos++] = k_source[in_pos++];
                continue;
            }
        }
        
        /* Handle comments */
        if (!in_string && !in_char) {
            if (in_pos + 1 < source_len && k_source[in_pos] == '/' && k_source[in_pos + 1] == '*') {
                in_comment = 1;
                c_source[out_pos++] = k_source[in_pos++];
                c_source[out_pos++] = k_source[in_pos++];
                continue;
            }
            if (in_comment && in_pos + 1 < source_len && k_source[in_pos] == '*' && k_source[in_pos + 1] == '/') {
                in_comment = 0;
                c_source[out_pos++] = k_source[in_pos++];
                c_source[out_pos++] = k_source[in_pos++];
                continue;
            }
            if (in_pos + 1 < source_len && k_source[in_pos] == '/' && k_source[in_pos + 1] == '/') {
                in_line_comment = 1;
                c_source[out_pos++] = k_source[in_pos++];
                c_source[out_pos++] = k_source[in_pos++];
                continue;
            }
            if (in_line_comment && k_source[in_pos] == '\n') {
                in_line_comment = 0;
                c_source[out_pos++] = k_source[in_pos++];
                continue;
            }
        }
        
        /* Skip translation inside strings, chars, and comments */
        if (in_string || in_char || in_comment || in_line_comment) {
            c_source[out_pos++] = k_source[in_pos++];
            continue;
        }
        
        /* Try to match keywords */
        int matched = 0;
        for (int i = 0; keywords[i].k_keyword != NULL; i++) {
            size_t kw_len = strlen(keywords[i].k_keyword);
            if (in_pos + kw_len <= source_len &&
                strncmp(&k_source[in_pos], keywords[i].k_keyword, kw_len) == 0 &&
                at_word_boundary(k_source, in_pos, kw_len)) {
                
                /* Found a match, replace with C keyword */
                const char *c_kw = keywords[i].c_keyword;
                size_t c_kw_len = strlen(c_kw);
                
                /* Ensure buffer has enough space */
                while (out_pos + c_kw_len >= buffer_size) {
                    buffer_size *= 2;
                    c_source = realloc(c_source, buffer_size);
                    if (!c_source) {
                        fprintf(stderr, "Memory reallocation failed\n");
                        exit(1);
                    }
                }
                
                memcpy(&c_source[out_pos], c_kw, c_kw_len);
                out_pos += c_kw_len;
                in_pos += kw_len;
                matched = 1;
                break;
            }
        }
        
        if (!matched) {
            /* Handle apostrophes in user-defined identifiers */
            /* Replace ' with _ if it's part of an identifier */
            char current_char = k_source[in_pos];
            if (current_char == '\'') {
                /* Check if this apostrophe is part of an identifier */
                /* It's an identifier apostrophe if preceded by alphanumeric/underscore */
                /* and followed by alphanumeric/underscore */
                int prev_is_ident = (in_pos > 0 && 
                                    (isalnum(k_source[in_pos - 1]) || k_source[in_pos - 1] == '_'));
                int next_is_ident = (in_pos + 1 < source_len && 
                                    (isalnum(k_source[in_pos + 1]) || k_source[in_pos + 1] == '_'));
                
                if (prev_is_ident && next_is_ident) {
                    /* Apostrophe in the middle of identifier */
                    c_source[out_pos++] = '_';
                    in_pos++;
                } else if (prev_is_ident && in_pos + 1 < source_len && 
                          !isalnum(k_source[in_pos + 1]) && k_source[in_pos + 1] != '_') {
                    /* Apostrophe at the end of identifier */
                    c_source[out_pos++] = '_';
                    in_pos++;
                } else {
                    /* Regular apostrophe (char literal, etc.) */
                    c_source[out_pos++] = k_source[in_pos++];
                }
            } else {
                c_source[out_pos++] = k_source[in_pos++];
            }
        }
    }
    
    c_source[out_pos] = '\0';
    return c_source;
}

/* Read entire file into a string */
char *read_file(const char *filename) {
    FILE *file = fopen(filename, "r");
    if (!file) {
        fprintf(stderr, "Error: Could not open file '%s'\n", filename);
        return NULL;
    }
    
    fseek(file, 0, SEEK_END);
    long size = ftell(file);
    fseek(file, 0, SEEK_SET);
    
    char *content = malloc(size + 1);
    if (!content) {
        fprintf(stderr, "Memory allocation failed\n");
        fclose(file);
        return NULL;
    }
    
    size_t bytes_read = fread(content, 1, size, file);
    content[bytes_read] = '\0';
    fclose(file);
    
    return content;
}

/* Write string to file */
int write_file(const char *filename, const char *content) {
    FILE *file = fopen(filename, "w");
    if (!file) {
        fprintf(stderr, "Error: Could not write to file '%s'\n", filename);
        return 0;
    }
    
    fprintf(file, "%s", content);
    fclose(file);
    return 1;
}

int main(int argc, char *argv[]) {
    if (argc < 2) {
        fprintf(stderr, "Usage: %s <input.k> [-o output.c]\n", argv[0]);
        fprintf(stderr, "  Translates K language source code to C source code\n");
        fprintf(stderr, "  -v, --version    Display version information\n");
        return 1;
    }
    
    /* Check for version flag */
    if (strcmp(argv[1], "-v") == 0 || strcmp(argv[1], "--version") == 0) {
        printf("klang version %s\n", KLANG_VERSION);
        return 0;
    }
    
    const char *input_file = argv[1];
    const char *output_file = "output.c";
    
    /* Parse command line arguments */
    for (int i = 2; i < argc; i++) {
        if (strcmp(argv[i], "-o") == 0 && i + 1 < argc) {
            output_file = argv[i + 1];
            i++;
        }
    }
    
    /* Read input file */
    char *k_source = read_file(input_file);
    if (!k_source) {
        return 1;
    }
    
    /* Translate K to C */
    char *c_source = translate_k_to_c(k_source);
    
    /* Write output file */
    if (!write_file(output_file, c_source)) {
        free(k_source);
        free(c_source);
        return 1;
    }
    
    printf("Successfully translated '%s' to '%s'\n", input_file, output_file);
    
    free(k_source);
    free(c_source);
    
    return 0;
}

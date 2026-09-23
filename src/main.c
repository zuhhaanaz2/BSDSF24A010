#include <stdio.h>
#include <stdlib.h>
#include "../include/mystrfunctions.h"
#include "../include/myfilefunctions.h"

int main() {
    printf("--- Testing String Functions ---\n");

    const char* sample = "Hello";
    printf("mystrlen(\"%s\") = %d\n", sample, mystrlen(sample));

    char dest1[50];
    mystrcpy(dest1, "Copied text");
    printf("mystrcpy result: %s\n", dest1);

    char dest2[50];
    mystrncpy(dest2, "Truncate this text", 9);
    printf("mystrncpy result (9 chars): %s\n", dest2);

    char dest3[50] = "Hello ";
    mystrcat(dest3, "World");
    printf("mystrcat result: %s\n", dest3);

    printf("\n--- Testing File Functions ---\n");

    FILE* fp = fopen("sample.txt", "r");
    if (fp == NULL) {
        printf("Error: could not open sample.txt\n");
        return 1;
    }

    int lines, words, chars;
    if (wordCount(fp, &lines, &words, &chars) == 0) {
        printf("wordCount -> Lines: %d, Words: %d, Chars: %d\n", lines, words, chars);
    }
    fclose(fp);

    fp = fopen("sample.txt", "r");
    if (fp == NULL) {
        printf("Error: could not reopen sample.txt\n");
        return 1;
    }

    char** matches;
    int match_count = mygrep(fp, "Hello", &matches);
    printf("mygrep found %d matching line(s) containing \"Hello\":\n", match_count);
    for (int i = 0; i < match_count; i++) {
        printf("  %s", matches[i]);
        free(matches[i]);
    }
    free(matches);
    fclose(fp);

    return 0;
}

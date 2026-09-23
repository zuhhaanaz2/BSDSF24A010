#include "../include/myfilefunctions.h"
#include <stdlib.h>
#include <string.h>

int wordCount(FILE* file, int* lines, int* words, int* chars) {
    if (file == NULL || lines == NULL || words == NULL || chars == NULL) {
        return -1;
    }

    *lines = 0;
    *words = 0;
    *chars = 0;

    int c;
    int in_word = 0;

    while ((c = fgetc(file)) != EOF) {
        (*chars)++;

        if (c == '\n') {
            (*lines)++;
        }

        if (c == ' ' || c == '\n' || c == '\t') {
            in_word = 0;
        } else if (in_word == 0) {
            in_word = 1;
            (*words)++;
        }
    }

    return 0;
}

int mygrep(FILE* fp, const char* search_str, char*** matches) {
    if (fp == NULL || search_str == NULL || matches == NULL) {
        return -1;
    }

    int capacity = 10;
    int count = 0;
    char** result = malloc(capacity * sizeof(char*));
    if (result == NULL) {
        return -1;
    }

    char line[1024];

    while (fgets(line, sizeof(line), fp) != NULL) {
        if (strstr(line, search_str) != NULL) {
            if (count >= capacity) {
                capacity *= 2;
                result = realloc(result, capacity * sizeof(char*));
                if (result == NULL) {
                    return -1;
                }
            }
            result[count] = malloc(strlen(line) + 1);
            if (result[count] == NULL) {
                return -1;
            }
            strcpy(result[count], line);
            count++;
        }
    }

    *matches = result;
    return count;
}

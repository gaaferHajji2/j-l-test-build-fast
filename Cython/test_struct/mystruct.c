#include "mystruct.h"
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

MyStruct* create_struct(int id, double value, const char* name) {
    MyStruct* s = (MyStruct*)malloc(sizeof(MyStruct));
    if (s != NULL) {
        printf("Creating the struct");
        s->id = id;
        s->value = value;
        strncpy(s->name, name, sizeof(s->name) - 1);
        s->name[sizeof(s->name) - 1] = '\0';
    }
    return s;
}

void free_struct(MyStruct* s) {
    if (s != NULL) {
        printf("Free the struct");
        free(s);
    }
}

void print_struct(MyStruct* s) {
    if (s != NULL) {
        printf("ID: %d, Value: %.2f, Name: %s\n", s->id, s->value, s->name);
    }
}
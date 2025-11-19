#ifndef MYSTRUCT_H
#define MYSTRUCT_H

typedef struct {
    int id;
    double value;
    char name[50];
} MyStruct;

// Function to create and initialize a struct
MyStruct* create_struct(int id, double value, const char* name);

// Function to free the struct
void free_struct(MyStruct* s);

// Function to print the struct
void print_struct(MyStruct* s);

#endif
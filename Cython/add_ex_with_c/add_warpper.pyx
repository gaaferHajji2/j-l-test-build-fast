cdef extern from "add.h":
    int add_integers(int a, int b)

def py_add(int a, int b):
    return add_integers(a, b)
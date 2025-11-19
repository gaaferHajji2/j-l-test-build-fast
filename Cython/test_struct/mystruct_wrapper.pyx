# cython: language_level=3
from libc.string cimport strncpy

# Import the C struct and functions
cdef extern from "mystruct.h":
    cdef struct MyStruct:
        int id
        double value
        char name[50]
    
    MyStruct* create_struct(int id, double value, const char* name)
    void free_struct(MyStruct* s)
    void print_struct(MyStruct* s)

# Python wrapper class
cdef class PyMyStruct:
    cdef MyStruct* s  # Hold a pointer to the C struct
    
    def __init__(self, int id=0, double value=0.0, name=""):
        """Initialize the C struct"""
        cdef bytes name_bytes = name.encode('utf-8')
        self.s = create_struct(id, value, name_bytes)
    
    def __dealloc__(self):
        """Free the C struct when Python object is destroyed"""
        if self.s != NULL:
            free_struct(self.s)
    
    # Properties to access struct members
    @property
    def id(self):
        return self.s.id if self.s != NULL else 0
    
    @id.setter
    def id(self, int value):
        if self.s != NULL:
            self.s.id = value
    
    @property
    def value(self):
        return self.s.value if self.s != NULL else 0.0
    
    @value.setter
    def value(self, double value):
        if self.s != NULL:
            self.s.value = value
    
    @property
    def name(self):
        if self.s != NULL:
            return self.s.name.decode('utf-8')
        return ""
    
    @name.setter
    def name(self, name):
        cdef bytes name_bytes = name.encode('utf-8')
        if self.s != NULL:
            strncpy(self.s.name, name_bytes, sizeof(self.s.name) - 1)
            self.s.name[sizeof(self.s.name) - 1] = b'\0'
    
    def print_struct(self):
        """Call the C function to print the struct"""
        if self.s != NULL:
            print_struct(self.s)
    
    def to_dict(self):
        """Convert struct to Python dict"""
        return {
            'id': self.id,
            'value': self.value,
            'name': self.name
        }

# Alternative: Direct struct usage (more efficient but less safe)
cdef class DirectStruct:
    cdef MyStruct s  # Stack-allocated struct
    
    def __init__(self, int id=0, double value=0.0, name=""):
        self.s.id = id
        self.s.value = value
        cdef bytes name_bytes = name.encode('utf-8')
        strncpy(self.s.name, name_bytes, sizeof(self.s.name) - 1)
        self.s.name[sizeof(self.s.name) - 1] = b'\0'
    
    @property
    def id(self):
        return self.s.id
    
    @id.setter
    def id(self, int value):
        self.s.id = value
    
    @property
    def value(self):
        return self.s.value
    
    @value.setter
    def value(self, double value):
        self.s.value = value
    
    @property
    def name(self):
        return self.s.name.decode('utf-8')
    
    @name.setter
    def name(self, name):
        cdef bytes name_bytes = name.encode('utf-8')
        strncpy(self.s.name, name_bytes, sizeof(self.s.name) - 1)
        self.s.name[sizeof(self.s.name) - 1] = b'\0'
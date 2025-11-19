from setuptools import setup, Extension
from Cython.Build import cythonize
import numpy

# Define the extension
extensions = [
    Extension(
        "mystruct_wrapper",
        sources=[
            "test_struct/mystruct_wrapper.pyx",
            "test_struct/mystruct.c"  # Include the C source file
        ],
        include_dirs=[  # Include directories for headers
            ".",
            numpy.get_include()  # If you need numpy headers
        ],
        language="c"
    )
]

setup(
    name="mystruct_wrapper",
    ext_modules=cythonize(
        extensions,
        compiler_directives={
            'language_level': 3,  # Python 3
            'embedsignature': True  # Include function signatures
        }
    ),
    zip_safe=False,
)
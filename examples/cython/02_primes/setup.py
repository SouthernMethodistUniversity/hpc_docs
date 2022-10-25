from setuptools import setup
from Cython.Build import cythonize

setup(
  ext_modules = cythonize(
    ["primes_python.py",
     "primes_cython.pyx",
     "primes_cython_cpp.pyx"])
)


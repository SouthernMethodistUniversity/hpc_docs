from pybind11.setup_helpers import Pybind11Extension
from setuptools import setup

setup(
  ext_modules = [Pybind11Extension("hello_world", ["hello_world.cpp"], cxx_std=17)]
)


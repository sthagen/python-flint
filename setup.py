import sys
import os

from distutils.core import setup
from distutils.extension import Extension
from Cython.Distutils import build_ext
from numpy.distutils.system_info import default_include_dirs, default_lib_dirs

from distutils.sysconfig import get_config_vars

if sys.platform == 'win32':
    libraries = ["arb", "flint", "mpir", "mpfr", "pthreads"]
else:
    libraries = ["arb", "flint"]
    (opt,) = get_config_vars('OPT')
    os.environ['OPT'] = " ".join(flag for flag in opt.split() if flag != '-Wstrict-prototypes')

default_include_dirs += [
    os.path.join(d, "flint") for d in default_include_dirs
]

ext_modules = [
    Extension(
        "flint._flint", ["src/flint/pyflint.pyx"],
        libraries=libraries,
        library_dirs=default_lib_dirs,
        include_dirs=default_include_dirs)
]

for e in ext_modules:
    e.cython_directives = {"embedsignature": True}

setup(
    name='python-flint',
    cmdclass={'build_ext': build_ext},
    ext_modules=ext_modules,
    packages=['flint'],
    package_dir={'': 'src'},
    description='Bindings for FLINT and Arb',
    version='0.3.0',
    url='https://github.com/python-flint/python-flint',
    author='Fredrik Johansson',
    author_email='fredrik.johansson@gmail.com',
    license='MIT',
    classifiers=['Topic :: Scientific/Engineering :: Mathematics'])

all: primes_python primes_cython primes_cython_cpp primes

build:
	python3 setup.py build_ext --inplace

primes_python: build
	python3 -m timeit -s 'from primes_python import primes' 'primes(1000)'

primes_cython: build
	python3 -m timeit -s 'from primes_cython import primes' 'primes(1000)'

primes_cython_cpp: build
	python3 -m timeit -s 'from primes_cython_cpp import primes' 'primes(1000)'

primes:
	ln -s primes_python.py primes.py
	python3 -m timeit -s 'from primes import primes' 'primes(1000)'

clean:
	rm -rf primes.py __pycache__ build primes*.{c,so}


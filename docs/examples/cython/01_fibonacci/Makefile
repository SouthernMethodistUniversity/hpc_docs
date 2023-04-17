fib:
	python3 setup.py build_ext --inplace

fib_run: fib
	python3 -c "import fib; fib.fib(2000)"

clean:
	rm -rf build fib*.{c,so}


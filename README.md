# SMU HPC Documentation

## Building the Documentation

The SMU HPC documentation is built using [Jupyter
Book](https://jupyterbook.org). The following can be used to build the
documentation locally.

```sh
python3 -m venv ~/.venv/hpc_docs
. ~/.venv/hpc_docs/bin/activate
pip3 install -U pip wheel setuptools
pip3 install jupyter-book
jupyter-book build docs
open docs/_build/html/index.html
```

## Contributing

Pull requests for improvements are greatly appreciated.


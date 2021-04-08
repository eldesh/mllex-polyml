# MLLex for Poly/ML

MLLex for Poly/ML is a port of MLLex for Poly/ML.


## Requires

- Poly/ML
- pdflatex (for docs)


## Build

To build `mllex-polyml`, run the default target or `mllex-polyml`.

```sh
$ make
```

Or

```sh
$ make mllex-polyml
```

This command generates `bin/mllex-polyml`.


## Install

To install `mllex-polyml`, run the `install` or `install-nodocs` target.

```sh
$ make install
```

By default, the `install` target installs `mllex-polyml` to `/usr/local/polyml`.
It is possible to overwrite the install directory with `PREFIX` variable.

```sh
$ make install PREFIX=~/.sml/polyml/5.8.1
```


## How to use

`mllex-polyml` take `.lex` files and generates `.lex.sml` files for each input files.
For example, you pass `ml.lex` to this program, `ml.lex.sml` will be generated.

```sh
$ mllex-polyml ml.lex

Number of states = 418
Number of distinct rows = 290
Approx. memory size of trans. table = 593920 bytes
$ file ml.lex.sml 
ml.lex.sml: ASCII text
```

See `mllex-polyml.pdf` for details.


## Test

To run the test, run the `test` target.

```sh
mllex-polyml$ make test
bin/mllex-polyml ml.lex

Number of states = 418
Number of distinct rows = 290
Approx. memory size of trans. table = 593920 bytes
diff ml.lex.sml ml.lex.sml.exp
rm -f   ml.lex.sml
```


## Document

To generate a document `mllex-polyml.pdf`, run the `docs` target.

```sh
$ make docs
```


## License

see LICENSE file for details.


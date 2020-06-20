# MLLex for Poly/ML

## Requires

- Poly/ML
- pdflatex (for docs)


## Build

Perform `make` like below:

```sh
$ make mllex-polyml
```

`mllex-polyml` will be built.


## Use

`mllex-polyml` take `.lex` files and generates `.lex.sml` files for each input files.
For example, you pass `ml.lex` to this program, `ml.lex.sml` will be generated.

```sh
$ ./mllex-polyml ml.lex

Number of states = 418
Number of distinct rows = 290
Approx. memory size of trans. table = 593920 bytes
$ file ml.lex.sml 
ml.lex.sml: ASCII text
```

See `mllex-polyml.pdf` for details.


## Test

Perform `make test`.


## Document

`make docs` will generate `mllex-polyml.pdf`.


## License

see LICENSE file for details.



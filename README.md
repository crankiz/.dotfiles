# _**C**rankiz **A**utomatic **R**esin **B**ootstraping **S**cript_
 ## Installation:

On an Arch, Debian or Red Hat based distribution, run the following:

```
curl -fsSL https://raw.githubusercontent.com/crankiz/dotfiles/master/carbs.sh | bash
```

That's it.

## What is CARBS?

CARBS is a script that autoconfigures a linux enviroment.

It installs ZSH, starship pormpt and deploy all dotfiles.


### The `packages.csv` list

CARBS will parse the given programs list and install all given programs. Note
that the programs file must be a three column `.csv`.

The first column is a "tag" that determines how the program is installed, ""
(blank) for the main repository, `A` for via the AUR or `G` if the program is a
git repository that is meant to be `make && sudo make install`ed.


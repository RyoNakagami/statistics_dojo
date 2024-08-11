#!/bin/bash
Rscript -e "renv::repair()"
Rscript -e "renv::restore()"
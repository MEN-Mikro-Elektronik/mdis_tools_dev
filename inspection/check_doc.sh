#! /bin/bash

# get all dirs with index.html in it
dirs=$(find . -name "index.html" | sed -r 's/(\/[^\/]*){3}$//')


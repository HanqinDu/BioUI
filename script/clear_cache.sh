#!/bin/bash

find "$1" -mindepth 1 -maxdepth 1 -mmin "$2" -exec rm -rf {} \;


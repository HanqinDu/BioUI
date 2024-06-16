#!/bin/bash

mpstat 1 1| sed "s/  */<\/td><td>/g"

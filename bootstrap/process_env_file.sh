#!/bin/bash

# This takes my currently used .env file and replaces everything in quotes with the word test

sed 's/"[^"]*"/"test"/' .env > .env_sample

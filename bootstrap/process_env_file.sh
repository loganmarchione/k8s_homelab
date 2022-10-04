#!/bin/bash

sed 's/"[^"]*"/"test"/' .env > .env_sample

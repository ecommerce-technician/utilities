#!bin/bash
lsof -w -n -i tcp:3000
kill -9 }}pid{{

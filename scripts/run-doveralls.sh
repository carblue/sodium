#!/bin/bash
set -ev
if [ "${DC}" = "dmd" ]; then
	./doveralls
fi
 

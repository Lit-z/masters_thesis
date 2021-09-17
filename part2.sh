#!/bin/sh
awk 'NR-1{print $0-p}{p=$0}' nparticles.star > new.stars
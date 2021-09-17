#!/bin/sh
#files is a list of location of all the simulation steps
for step in `cat files`
    do
#creates an infile to be used with Robustdmpster whose 
#output from Robustdmpster will be put to tmp
    ln -s $step infile
    ./RobustDmpster < inp.nparticles > tmp
# greps the Nstar values and outputs this value to nparticles.star
# done by truncating the spaces to one space and cutting the value 
# of the fourth field marked by the spaces
    grep "N particles (gas,dark,star,tot):" tmp | sed 's/N particles 
    (gas,dark,star,tot)://' | tr -s ' ' | cut -d ' ' -f 4 >> nparticles.star
#removes infile and tmp created for the loop
    rm infile tmp
done
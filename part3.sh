#!/bin/sh

# initialises the counter, parts is a 1 to 100 list as a seperate file
# as there are 100 simulation steps
counter=1
for part in `cat parts`
do

# uses counter to find the information from the correct line in files2
# files2 is a list of the location of all the simulations
# increases the counter
    sed -n "${counter}p" files2 >> nsims
    counter=$((counter+1))
    for step in `cat nsims`
    do

# creates a symbolic link to the current simulation step to infile
# inputs the values 5, 6, 5 to recentre the galaxy correctly from 
# using the Robustdmpster menu 
        ln -s $step infile
        sed -n "4p" inp.angmom1 >> inp.angmom
        sed -n "5p" inp.angmom1 >> inp.angmom
        sed -n "4p" inp.angmom1 >> inp.angmom

# inputs 43 to run the angular momentum code
# obtains the value for the read star line within the ang. mom. code
        sed -n "2p" inp.angmom1 >> inp.angmom
        sed -n "${counter}p" new.stars >> inp.angmom

# inputs 100 to exit Robustdmpster menu
        sed -n "3p" inp.angmom1 >> inp.angmom

# runs Robustdmpster using the above input order just stored in inp.angmom
        ./RobustDmpster < inp.angmom

# copies the output files produced by ang. mom. code
# also gives them file names related to the counter so it's known
# which time step of simulation they represent
        cp ang.txt Results/angmom$((counter-1)).txt
        cp gal.txt Results/galid$((counter-1)).txt

# removes files that were created for the purpose of 1 run through the loop
        rm nsims
        rm inp.angmom
        rm infile
    done
done

# removes the reminding files that would be left there as excess
# produced by the ang. mom. code
rm ang.txt
rm gal.txt
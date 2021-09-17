c routine for outputting star properties as txt files
    subroutine Pancake

    include 'pinc/particles.f'
    include 'pinc/secondary.f'

    integer i
    real rad, tmin, tmax, rmin, rmax

c possible user inputs for defining limits on the data to retrieve
c particularly useful for looking at stars by ages, metallicity, 
c mass. But also useful for distance/ rad too (to identify stars still 
c close to the dwarf).
    print*, "Enter Age Range: tmin, tmax"
    read*, tmin, tmax
    print*, “Enter Radius Range: rmin, rmax”
    read*, rmin, rmax

c opens the files where the data will be wrote
    open (unit=10, file='vel.txt',action='write',status='replace')
    open (unit=20, file='pos.txt',action='write',status='replace')
    open (unit=30, file='met.txt',action='write',status='replace')

c loops over all stars
    do i = 1, Nstar
c possible if statements related to the inputs above, can be changed
c to suit the variables trying to filter
        if ((tform(i) .gt. tmin) .and. (tform(i) .le. tmax)) then
            rad = sqrt(x(i)*x(i)+y(i)*y(i)+z(i)*z(i))
                if ((rad .ge. rmin) .and. (rad .lt. rmax)) then
c writes the star properties specified to files
c i = Nstar, vx, vy, vc = components of velocity, ms = mass
c x, y, z = position, rad = distance to centre
c tform = formation time of the star
                    write (unit=10, fmt=*) i, vx(i), vy(i), vz(i), tform(i)
                    write (unit=20, fmt=*) x(i), y(i), z(i), rad
                    write (unit=30, fmt=*) metals(i), ms(i)
                else
                endif
        else
        endif
    end do
    close (unit=10)
    close (unit=20)
    close (unit=30)
    return
    end
c end of subroutine Pancake (for star property output)
c routine for calculating angular momentum and radius for stars
    subroutine Pancake

    include 'pinc/particles.f'
    include 'pinc/secondary.f'

    integer i, star, gal
    real rad, jx, jy, jz, jxy
    parameter (pi = 3.141592653589793238462643)
    character(len=20) arg

c sets galaxy idenfication to 0 before any checks are made
c reads the input value of star to determine the loop size later
    gal = 0
    read (*,*) star

c opens up files where the outputs will be produced 
    open (unit=10,file='gal.txt',action='write',status='replace')
    open (unit=20,file='ang.txt',action='write',status='replace') 
c angular momentum components and radius calculations
    do i = Nstar-star+1, NStar
        jx = y(i)*vz(i) - z(i)*vy(i)
        jy = z(i)*vx(i) - x(i)*vz(i)
        jz = x(i)*vy(i) - y(i)*vx(i)
        jxy = sqrt( jx*jx + jy*jy )
        rad = sqrt(x(i)*x(i) + y(i)*y(i) + z(i)*z(i))
c if radius is small then star is indentified as 1
c if radius is large then identified as 2 
        if (rad .le. 2) then 
        gal = 1
        else
            if (rad .ge. 20) then
            gal = 2
            else
c if radius is within 10 for the first 4929382 stars then also identified as 1
                if (Nstar .lt. 4929382 .and. rad .lt. 10) then
                    gal = 1
                else
c idenfication by comparing angular momentum, with potentially undecided stars
c if their Jz and Jxy angular momentums are equal
                    if (jxy .gt. abs(jz)) then
                        gal = 2
                    else
                        if (jxy .lt. abs(jz)) then
                            gal = 1
                        else 
                            gal = 0
                        endif
                    endif
                endif
            endif
        endif
c writes the outputs of idenfication (gal) to one opened file
c with the outputs of Nstar (i), radius, angular momentum components to another
        write (unit=10,fmt=*) gal
        write (unit=20,fmt=*)"N",i, rad, jx, jy, jxy, jz
    end do
    close (unit=10)
    close (unit=20)
    return
    end
c end of subroutine pancake (for angular mom. and rad calculations)
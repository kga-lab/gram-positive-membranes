!=======================================================================!
      Subroutine upperlower(N,Nt,xp,yp,zp,xc,yc,zc,xu,yu,zu,xl,yl,zl,
     +                      c1,c2)
                 implicit none
                 integer N,Nt,c1,c2,i
                 double precision xp(N),yp(N),zp(N),xc(N),yc(N),zc(N)
                 double precision zmid
                 double precision xu(N),yu(N),zu(N),xl(N),yl(N),zl(N)
               
!======================================================================!
                 zmid = 0.d0
                 do i=1,Nt 
                  zmid =zmid + zp(i)
                 enddo
                  zmid = zmid/dble(N)
                 do i=1,Nt
                   zp(i) = zp(i)- zmid
                   zc(i) = zc(i) - zmid
                 enddo
                  c1 = 0  !counters
                  c2 = 0
                do i=1,Nt
                   if(zp(i) .gt. zc(i))then
                    c1 = c1 + 1
                    xu(c1) = xp(i)
                    yu(c1) = yp(i)
                    zu(c1) = zp(i)
                   else
                    c2 = c2 + 1
                    xl(c2) = xp(i)
                    yl(c2) = yp(i)
                    zl(c2) = zp(i)
                  endif
                enddo

                ! write(*,*) 'c1=', c1, 'c2=',c2
               END SUBROUTINE                

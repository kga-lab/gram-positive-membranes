!=======================================================================!
!This program computes the structure factor S(q) data from heights of 
!membrane lipids. The CG beads GL0 in DAGX, P1 in CARDIOLIPIN and PO4 in 
!PG lipids are chosen as headgroups.
!=======================================================================!
              PROGRAM Structurefactor2D
                implicit none
                integer N,maxite,c1,c2,c,i,ite,Nt,j
                parameter (N =8192,maxite=20000) ! heads GL0
                double precision xp(N),yp(N),zp(N),xc(N),yc(N),zc(N)
                double precision Lx,Ly,Lz
                double precision xu(N),yu(N),zu(N),xl(N),yl(N),zl(N) 
                COMPLEX sumusk,sumlsk,sumsk
                integer k1,k2,k1max,k2max,kk2,nmodes 
                parameter (k1max = 16,k2max = 16,nmodes=405) 
                double precision kx,ky,theta,facx,facy,pi,Twopi
                double precision Sk(nmodes),Skavg(nmodes),q(nmodes)
                parameter (pi =  3.141592653589793d0)
                character*6 dummy,path
                character*8 resnam
                character*7 atom
                path = '../'
!=======================================================================!
!This program computes S(k) = < h(k) h(-k)> *A
!=======================================================================!
               Twopi = 2.d0*pi
            open(11,file='traj_heads.gro')!trajectory of lipid headgroups.
            open(12,file='traj_com.gro')!trajectory of com of individual lipid.

            open(21,file='Skavg-v4.dat')

!----------------------------------------------------------!
               Skavg(:) = 0.d0
                q(:) = 0.d0
             do ite=1,maxite
               read(11,*) dummy
               read(11,*) Nt
                do i=1,Nt
             read(11,'(a8,a7,i5,3f8.3)') resnam,atom,j,xp(i),yp(i),zp(i)
                enddo
                read(11,*) Lx,Ly,Lz

               read(12,*) dummy
               read(12,*) Nt
                do i=1,Nt
             read(12,'(a8,a7,i5,3f8.3)') resnam,atom,j,xc(i),yc(i),zc(i)
                enddo
               read(12,*) Lx,Ly,Lz
               facx = Twopi/Lx
               facy = Twopi/Ly
            !--------Separate lipids into upper and lower leaflets
        CALL upperlower(N,Nt,xp,yp,zp,xc,yc,zc,xu,yu,zu,xl,yl,zl,c1,c2) 
               write(*,*) c1,c2
            !-----x-y Fourier Transform ------!
                   c = 0;
                do k2 = -k2max,k2max
                  ky = facy*dble(k2)
                 do k1 = -k1max,k1max
                   kx = facx*dble(k1)
                   kk2 = (k1**2) + (k2**2)
                  if(kk2 .le. 128) then !this corresponds qmax 
                    c = c + 1
                    q(c) = dsqrt((kx**2) + (ky**2))
                   !----FT of zu----: sum zu*exp(i*2*pi*k/L * r)
                   !----FT of zl----: sum zl*exp(i*2*pi*k/L *r)
                  sumusk = cmplx(0.d0,0.d0)
                  sumlsk = cmplx(0.d0,0.d0)
                  do i=1,c1  !c1 no of lipids are in upperleaflet
                   theta = (kx*xu(i)) + (ky*yu(i))
                sumusk = sumusk + (zu(i)*cmplx(dcos(theta),dsin(theta)))
                  enddo
                  do i=1,c2  !c1 no of lipids are in lowerleaflet
                   theta = (kx*xl(i)) + (ky*yl(i))
                sumlsk = sumlsk + (zl(i)*cmplx(dcos(theta),dsin(theta)))
                  enddo
                   sumsk = 0.5d0*((sumusk/dble(c1))+(sumlsk/dble(c2))) 
                   Sk(c) = sumsk*conjg(sumsk)
                   !----- Time average -----!
                   Skavg(c) = Skavg(c) + Sk(c)
                  endif
               enddo !k1
              enddo !k2
                     write(*,*) 'c modes:', ite, c
             enddo !ite    
                   Skavg(:) =  Skavg(:)* (Lx*Ly/dble(maxite))
                 do i=1,nmodes
                    write(21,*) q(i), Skavg(i)
                  enddo
                  close(11)
                  close(12)
                  close(21)
               END PROGRAM
!=======================================================================!
               include 'upperlower.f'

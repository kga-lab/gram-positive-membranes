!!==============================================================
!!This Fortran Program computes the distances between pair of lipids, and arranges the distances in ascending order to compute nearest lipids and their types around a lipid type-A. The number of B-type of lipids is calculated from the first five nearest neighbors of A-type of lipid. This gives $\chi_{AB} defined in the manuscript.
!!=============================================================
  
            Program neighbors
              implicit none
              integer i,j,k,Nm,ite,N,maxit,c,i1,j1,ip,jp
              parameter (Nm=128)
              integer jnew(Nm,Nm),jmin,co(5,5),lip(5)
              parameter (maxit=5001)

              double precision Lx,Ly,Lz,x1,y1,z1,rx,ry,rij
              double precision x(Nm),y(Nm),z(Nm)
              double precision Ma(Nm,Nm),Stemp,dmin
              double precision fco(5,5),favgl(5,5),favgt(5,5)
              character*36 dummy
              character*8 resnam(Nm),resid,res2,atom2,btype,bres
              character*7 atom,beadtype
!======================================================================!
             open(12,file='traj-com-lower.gro',action='read') !trajectory for center-of-mass of each lipid in lower leaflet  
             open(23,file='neighborfractions-lower.dat')
             open(24,file='CDLA-timeline-neighborfractions-lower.dat')
             open(25,file='CDLD-timeline-neighborfractions-lower.dat')
             open(26,file='CDLE-timeline-neighborfractions-lower.dat')
             open(27,file='PGLA-timeline-neighborfractions-lower.dat')
             open(28,file='PILA-timeline-neighborfractions-lower.dat')


             favgt(:,:)=0.0
             do ite=1,maxit
               read(12,'(a)') dummy
               read(12,*) N
             c=0
             do i=1,Nm
                c=c+1
            read(12,'(i5,a4,a7,i5,3f8.3)')i1, res2,atom2,j1,x1,y1,z1
               resnam(i)=res2
               x(i)=x1
               y(i)=y1
               z(i)=z1
             enddo !i
              read(12,*) Lx,Ly,Lz
             !============!
             Ma(:,:)=100
            do i=1,Nm
             do j=i+1,Nm
               rx = x(i)-x(j)
               ry = y(i)-y(j)
                   !---MINIMUM IMAGE CONVENTION
                   rx = rx - (Lx* (ANINT(rx/Lx)))
                   ry = ry - (Ly* (ANINT(ry/Ly)))
                   !--------------
               rij = dsqrt((rx**2)+(ry**2))
               Ma(i,j)=rij
               Ma(j,i)=rij
             enddo !j
             enddo !i
              !========ascending order
              do k=1,Nm
                do i=1,Nm
                   dmin=Ma(k,i)
                  do j=i+1,Nm
                      if(Ma(k,j).lt.dmin) then
                        dmin=Ma(k,j)
                        jmin=j
                      endif
                 enddo !j
                      Stemp=Ma(k,i)
                      Ma(k,i)=Ma(k,jmin)
                      Ma(k,jmin)=Stemp
                      jnew(k,i)=jmin
                      jnew(k,jmin)=i
                  enddo !i
               enddo !k
                !==================compute nearest-neighbors
                 !! resnam=CDLA means 1
                 !! resnam=CDLD means 2
                 !! resnam=CDLE means 3
                 !! resnam=PGLA means 4
                 !! resname=PILA means 5 according to gro file
                 lip(:)=0
                 favgl(:,:)=0.0
             do k=1,Nm
                  co(:,:)=0
                 if((resnam(k).eq.'CDLA')) ip=1
                 if((resnam(k).eq.'CDLD')) ip=2
                 if((resnam(k).eq.'CDLE')) ip=3
                 if((resnam(k).eq.'PGLA')) ip=4
                 if((resnam(k).eq.'PILA')) ip=5
                 lip(ip)=lip(ip)+1
              do j=1,5
                 if((resnam(jnew(k,j)).eq.'CDLA')) jp=1
                 if((resnam(jnew(k,j)).eq.'CDLD')) jp=2
                 if((resnam(jnew(k,j)).eq.'CDLE')) jp=3
                 if((resnam(jnew(k,j)).eq.'PGLA')) jp=4
                 if((resnam(jnew(k,j)).eq.'PILA')) jp=5
                 co(ip,jp)=co(ip,jp)+1
               enddo!j
                 fco(ip,1)=co(ip,1)/5.0
                 fco(ip,2)=co(ip,2)/5.0
                 fco(ip,3)=co(ip,3)/5.0
                 fco(ip,4)=co(ip,4)/5.0
                 fco(ip,5)=co(ip,5)/5.0
                 favgl(ip,1)=favgl(ip,1)+fco(ip,1)
                 favgl(ip,2)=favgl(ip,2)+fco(ip,2)
                 favgl(ip,3)=favgl(ip,3)+fco(ip,3)
                 favgl(ip,4)=favgl(ip,4)+fco(ip,4)
                 favgl(ip,5)=favgl(ip,5)+fco(ip,5)
              enddo!k
                  favgl(1,:)=favgl(1,:)/lip(1) 
                  favgl(2,:)=favgl(2,:)/lip(2)
                  favgl(3,:)=favgl(3,:)/lip(3)
                  favgl(4,:)=favgl(4,:)/lip(4)
                  favgl(5,:)=favgl(5,:)/lip(5)

                  favgt(1,:) = favgt(1,:) + favgl(1,:)
                  favgt(2,:) = favgt(2,:) + favgl(2,:)
                  favgt(3,:) = favgt(3,:) + favgl(3,:)
                  favgt(4,:) = favgt(4,:) + favgl(4,:)
                  favgt(5,:) = favgt(5,:) + favgl(5,:)
                 
                  write(24,*) favgl(1,1),favgl(1,2),favgl(1,3),
     +                        favgl(1,4),favgl(1,5)
                  write(25,*) favgl(2,1),favgl(2,2),favgl(2,3),
     +                        favgl(2,4),favgl(2,5)             
                  write(26,*) favgl(3,1),favgl(3,2),favgl(3,3),
     +                        favgl(3,4),favgl(3,5)
                  write(27,*) favgl(4,1),favgl(4,2),favgl(4,3),
     +                        favgl(4,4),favgl(4,5)
                  write(28,*) favgl(5,1),favgl(5,2),favgl(5,3),
     +                        favgl(5,4),favgl(5,5)
                  write(*,*) ite
         enddo !ite
         favgt(1,:) = favgt(1,:)/dble(maxit)
         favgt(2,:) = favgt(2,:)/dble(maxit)
         favgt(3,:) = favgt(3,:)/dble(maxit)
         favgt(4,:) = favgt(4,:)/dble(maxit)
         favgt(5,:) = favgt(5,:)/dble(maxit)

             !write(*,*) favgl(1,1),favgl(1,2),favgl(1,3)
             write(23,*) favgt(1,1),favgt(1,2),favgt(1,3),favgt(1,4),
     +                   favgt(1,5)
             write(23,*) favgt(2,1),favgt(2,2),favgt(2,3),favgt(2,4),
     +                   favgt(2,5)        
             write(23,*) favgt(3,1),favgt(3,2),favgt(3,3),favgt(3,4),
     +                   favgt(3,5)
             write(23,*) favgt(4,1),favgt(4,2),favgt(4,3),favgt(4,4),
     +                   favgt(4,5)
             write(23,*) favgt(5,1),favgt(5,2),favgt(5,3),favgt(5,4),
     +                   favgt(5,5)
              close(12)
              close(23)
              close(24)
              close(25)
              close(26)
              close(27)
              close(28)
               END program

***,h2o                   !A title
r=1.85,theta=104          !set geometry parameters
geometry={O;              !z-matrix geometry input
          H1,O,r;
          H2,O,r,H1,theta}
basis=6-31g**             !use Pople basis set
hf                        !closed-shell scf
optg                      !do scf geometry optimization

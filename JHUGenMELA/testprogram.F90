PROGRAM TestProgram
use modHiggs
use modZprime
use modGraviton
use modHiggsJ
use modHiggsJJ
use modVHiggs
use modTTBH
implicit none
include './variables.F90'
integer, parameter :: LHA2M_PDF(-6:6) = (/-5,-6,-3,-4,-1,-2,0 ,2,1,4,3,6,5/)
real(8) :: helicity(9), mass(9,2),msq_MCFM(-5:5,-5:5),p_MCFM(14,4)
integer :: id(9), TopDecays
real(8) :: p(4,6),p5(4,5),p4(4,4),p9(4,9),p8(4,8),p13(4,13)
real(8) :: MatElSq,M_Reso,Ga_Reso,MatElSqPDF(-5:5,-5:5),check_vbf(-5:5,-5:5),check_sbf(-5:5,-5:5),check_hj(-5:5,-5:5),check_zh(-5:5,-5:5)
integer :: MY_IDUP(6:9)
! real(8),  parameter :: GeV=1d0/100d0
real(8),  parameter :: LHCEnergy=8000d0 * GeV
! real(8),  parameter :: alphas = 0.13229060d0
complex(8) :: Hggcoupl(1:3),Hzzcoupl(1:39),Hwwcoupl(1:32)
complex(8) :: Zqqcoupl(1:2),Zzzcoupl(1:2)
complex(8) :: Gggcoupl(1:5),Gqqcoupl(1:2),Gzzcoupl(1:10)
complex(8) :: TTBHcoupl(1:2)
integer :: i, j
real(8) :: lambdaBSM,lambda_z(4),lambda_w(4)


! input unit = GeV/100 such that 125GeV is 1.25 in the code
  M_Reso  = 125d0 * GeV
  Ga_Reso = 0.1d0 * GeV 
  Hggcoupl(1:3) = (/ (1d0,0d0), (0d0,0d0), (0d0,0d0) /)
  Hzzcoupl(1:4) = (/ (2d0,0d0), (0d0,0d0), (0d0,0d0), (0d0,0d0) /)
  Hzzcoupl(5:10)= (/ (1d0,0d0), (0d0,0d0), (0d0,0d0), (0d0,0d0), (0d0,0d0), (0d0,0d0)/) ! couplings for intermediate photons (ghzgs2,..,ghzgs4,ghgsgs2,..,ghgsgs4)
  Hzzcoupl(11:39)= (0d0,0d0) ! momentum dependent couplings (ghz1_prime,ghz1_prime2,..,ghz4_prime3,ghz4_prime4,ghz4_prime5,ghzgs1_prime2,ghz1_prime6,..,ghz4_prime7)
  Zqqcoupl(1:2) = (/ (1d0,0d0), (1d0,0d0) /)
  Zzzcoupl(1:2) = (/ (0d0,0d0), (1d0,0d0) /)
  Gggcoupl(1:5) = (/ (1d0,0d0), (0d0,0d0), (0d0,0d0), (0d0,0d0), (0d0,0d0) /)
  Gqqcoupl(1:2) = (/ (1d0,0d0), (1d0,0d0) /)
  Gzzcoupl(1:10)= (/ (1d0,0d0), (0d0,0d0), (0d0,0d0), (0d0,0d0), (1d0,0d0), (0d0,0d0), (0d0,0d0), (0d0,0d0), (0d0,0d0), (0d0,0d0) /)
 
 
! particle ID: +7=e+,  -7=e-,  +8=mu+,  -8=mu-
  MY_IDUP(6:9) = (/+7,-7,+8,-8/)

! p(1:4,i) = (E(i),px(i),py(i),pz(i))
! i=1,2: glu1,glu2 (outgoing convention)
! i=3,4: correspond to MY_IDUP(7),MY_IDUP(6)
! i=5,6: correspond to MY_IDUP(9),MY_IDUP(8)
  p(1:4,1) = (/         -0.0645264033200954d0,          0.0000000000000000d0,          0.0000000000000000d0,         -0.0645264033200954d0   /)
  p(1:4,2) = (/         -6.0537234356954572d0,          0.0000000000000000d0,          0.0000000000000000d0,          6.0537234356954572d0   /)
  p(1:4,3) = (/          4.7598878302889442d0,          0.4544925597087586d0,          0.0917597774970785d0,         -4.7372511874858247d0   /)
  p(1:4,4) = (/          0.8177159853499207d0,         -0.2768889802512220d0,         -0.0202805643015353d0,         -0.7691427851991084d0   /)
  p(1:4,5) = (/          0.3191706236713395d0,         -0.0470102494218651d0,         -0.0079466854602927d0,         -0.3155895651859249d0   /)
  p(1:4,6) = (/          0.2214753997053482d0,         -0.1305933300356715d0,         -0.0635325277352505d0,         -0.1672134945045036d0   /)


! note: numbers correspond to includeInterference=.false.
! spin-0 corresponds to SM Higgs; spin-2 has minimal couplings
  print *, "PS point 1"


   call EvalAmp_gg_H_VV(p(1:4,1:6),M_Reso,Ga_Reso,Hggcoupl,Hzzcoupl,MY_IDUP(6:9),MatElSq)
   MatElSq = MatElSq/4d0 !-- g1=2 -> g1=1
   print *, "Matr.el. squared (spin-0)",MatElSq
   print *, "result should be (spin-0)",0.0045682366425370D0
   print *, "ratio",MatElSq/0.0045682366425370D0
   print *, ""
   call EvalAmp_qqb_Zprime_VV(p(1:4,1:6),M_Reso,Ga_Reso,Zqqcoupl,Zzzcoupl,MY_IDUP(6:9),MatElSq)
   print *, "Matr.el. squared (spin-1)",MatElSq
   print *, "result should be (spin-1)",0.0020357978978982D0
   print *, "ratio",MatElSq/0.0020357978978982D0
   print *, ""
   call EvalAmp_gg_G_VV(p(1:4,1:6),M_Reso,Ga_Reso,Gggcoupl,Gzzcoupl,MY_IDUP(6:9),MatElSq)
   print *, "Matr.el. squared (gg spin-2)",MatElSq
   print *, "result should be (gg spin-2)",0.0307096869320374d0
   print *, "ratio",MatElSq/0.0307096869320374d0
   print *, ""
   call EvalAmp_qqb_G_VV(p(1:4,1:6),M_Reso,Ga_Reso,Gqqcoupl,Gzzcoupl,MY_IDUP(6:9),MatElSq)
   print *, "Matr.el. squared (qq spin-2)",MatElSq
   print *, "result should be (qq spin-2)",0.0004838377647021d0
   print *, "ratio",MatElSq/0.0004838377647021d0
   print *, ""




! this checks the decay rates without production dynamics
  print *, "PS point 3 (no production dynamics)"
  p(1:4,1) = (/   -1.2500000000000000d0,    0.0000000000000000d0,    0.0000000000000000d0,    0.0000000000000000d0   /)
  p(1:4,2) = (/    1.0000000000000000d9,    1.0000000000000000d9,    1.0000000000000000d9,    1.0000000000000000d9   /)  ! DUMMY
  p(1:4,3) = (/    0.5723124900092045d0,    0.2083223910863685d0,    0.1441561361468674d0,   -0.5131884410270751d0   /)
  p(1:4,4) = (/    0.3270364795109065d0,   -0.1343151455361828d0,    0.0368904244639839d0,    0.2958908535141779d0   /)
  p(1:4,5) = (/    0.0584259632074581d0,   -0.0206108978979021d0,   -0.0424960639382021d0,   -0.0343928570247043d0   /)
  p(1:4,6) = (/    0.2922250672724307d0,   -0.0533963476522836d0,   -0.1385504966726492d0,    0.2516904445376015d0   /)

  call EvalAmp_Zprime_VV(p(1:4,1:6),M_Reso,Ga_Reso,Zzzcoupl,MY_IDUP(6:9),MatElSq)
  print *, "Matr.el. squared (spin-1)",MatElSq
  print *, "result should be (spin-1)",5.25259158248293146d-010
  print *, "ratio",MatElSq/5.25259158248293146d-010
  print *, ""
  call EvalAmp_G_VV(p(1:4,1:6),M_Reso,Ga_Reso,Gzzcoupl,MY_IDUP(6:9),MatElSq)
  print *, "Matr.el. squared (spin-2)",MatElSq
  print *, "result should be (spin-2)",3.50330723427981412d-009
  print *, "ratio",MatElSq/3.50330723427981412d-009
  print *, ""


  MY_IDUP(6:9) = (/+7,-7,+8,-8/)
  print *, "PS point 4 (no production dynamics)"
  p(1:4,1) = (/   -1.2500000000000000d0,    0.0000000000000000d0,    0.0000000000000000d0,    0.0000000000000000d0   /)
  p(1:4,2) = (/    1.0000000000000000d9,    1.0000000000000000d9,    1.0000000000000000d9,    1.0000000000000000d9   /)  ! DUMMY
  p(1:4,3) = (/    0.5501955504289553d0,    0.1590232342830207d0,    0.1201521110389673d0,   -0.5128257256445587d0   /)
  p(1:4,4) = (/    0.1226104406534881d0,   -0.0150215063102395d0,   -0.1053277769957477d0,    0.0609404126877065d0   /)
  p(1:4,5) = (/    0.1283008077137973d0,   -0.0450661397083963d0,    0.1152711293482556d0,    0.0338039502214440d0   /)
  p(1:4,6) = (/    0.4488932012037591d0,   -0.0989355882643850d0,   -0.1300954633914751d0,    0.4180813627354082d0   /)

  call EvalAmp_Zprime_VV(p(1:4,1:6),M_Reso,Ga_Reso,Zzzcoupl,MY_IDUP(6:9),MatElSq)
  print *, "Matr.el. squared (spin-1)",MatElSq
  print *, "result should be (spin-1)",2.41036103083747314d-011
  print *, "ratio",MatElSq/2.41036103083747314d-011
  print *, ""
  call EvalAmp_G_VV(p(1:4,1:6),M_Reso,Ga_Reso,Gzzcoupl,MY_IDUP(6:9),MatElSq)
  print *, "Matr.el. squared (spin-2)",MatElSq
  print *, "result should be (spin-2)",1.68408821989468668d-010
  print *, "ratio",MatElSq/1.68408821989468668d-010
  print *, ''

  !-- CHECK HIGGS PLUS 1-JET AMPLITUDES
  p4(:,1)= (/ 9.826663842051664d0,  0.000000000000000d0,  0.000000000000000d0,  9.826663842051664d0 /) * GeV
  p4(:,2)= (/ 5.92963723700763d2,    0.000000000000000d0,  0.000000000000000d0,  -5.929637237007630d2 /) * GeV
  p4(:,3)= (/ 5.52029020989556d2,    0.208641889781122d2,  5.997269305284619d0, -5.37252043638601d2  /) * GeV
  p4(:,4)= (/ 0.507613665532589d2,  -0.208641889781122d2, -5.997269305284619d0, -0.458850162201107d2 /) * GeV

  print *, 'H+J, SM couplings'
  call EvalAmp_HJ(p4,MatElSqPDF)
  include './checkHJ_SM.dat'
  do i = -5,5
     do j = -5,5
        print *, 'i,j', i,j
        print *, 'Matr.el. squared, H+J',MatElSqPDF(i,j)
        print *, 'result should be, H+J',check_hj(i,j)
        print *, ''
     enddo
  enddo

  !-- CHECK HIGGS PLUS 2-JETS AMPLITUDES

  Hzzcoupl(1:4) = (/ (2d0,0d0), (0d0,0d0), (0d0,0d0), (0d0,0d0) /)
  Hzzcoupl(5:32)= (0d0,0d0) ! momentum dependent couplings (ghz1_prime,ghz1_prime2,..,ghz4_prime3,ghz4_prime4,ghz4_prime5,ghz1_prime6,..,ghz4_prime7)
  Hwwcoupl(1:32) = (0d0,0d0) ! only used in WBF: if all zero then WWH couplings are set equal to ZZH couplings



  p5(:,1) = LHCEnergy/2d0 * (/1d0,0d0,0d0,1d0/)
  p5(:,2) = LHCEnergy/2d0 * (/1d0,0d0,0d0,-1d0/)
  p5(:,3)= (/ 265.78337209227107d0, 53.577941071379172d0, 43.898955201800788d0, -256.59907802539107d0 /) * GeV
  p5(:,4)= (/ 65.134095396202554d0, 47.285375822916357d0, 16.204053233736069d0, -41.760894089631499d0 /) * GeV
  p5(:,5)= (/ 3113.9932387500899d0, -100.86331689429554d0, -60.103008435536857d0, -3109.2672948241925d0 /) * GeV

  print *, 'WBF, SM couplings'
  Hzzcoupl(1:4) = (/ (2d0,0d0), (0d0,0d0), (0d0,0d0), (0d0,0d0) /)
  call EvalAmp_WBFH(p5,Hzzcoupl(1:32),Hwwcoupl(1:32),MatElSqPDF)
  include './checkWBF_SM.dat'
  do i = -5,5
     do j = -5,5
        print *, 'Matr.el. squared, WBF',MatElSqPDF(i,j)
        print *, 'result should be, WBF',check_vbf(i,j)
        print *, ''
     enddo
  enddo

  print *, 'WBF, non standard couplings'
  Hzzcoupl(1:4) = (/ (1d0,2d0), (3d0,4d0), (5d0,6d0), (7d0,8d0) /)
  call EvalAmp_WBFH(p5,Hzzcoupl,Hwwcoupl(1:32),MatElSqPDF)
  include './checkWBF_1-8.dat'
  do i = -5,5
     do j = -5,5
        print *, 'Matr.el. squared, WBF',MatElSqPDF(i,j)
        print *, 'result should be, WBF',check_vbf(i,j)
        print *, ''
     enddo
  enddo

  print *, ''
  print *, 'SBF, SM couplings'
  Hggcoupl(1:3) = (/(1d0,0d0), (0d0,0d0), (0d0,0d0) /)
  call EvalAmp_SBFH(p5,Hggcoupl,MatElSqPDF)
  MatElSqPDF = MatElSqPDF * (2d0/3d0*alphas**2)**2 !-- (alphas/sixpi * gs^2)^2
  include './checkSBF_SM.dat'
  do i = -5,5
     do j = -5,5
        print *, 'i,j', i,j
        print *, 'Matr.el. squared, SBF',MatElSqPDF(i,j)
        print *, 'result should be, SBF',check_sbf(i,j)
     enddo
  enddo

  print *, ''
  print *, 'SBF, generic couplings'
  Hggcoupl(1:3) = (/(1d0,2d0), (0d0,0d0), (3d0,4d0) /)
  call EvalAmp_SBFH(p5,Hggcoupl,MatElSqPDF)
  MatElSqPDF = MatElSqPDF * (2d0/3d0*alphas**2)**2 !-- (alphas/sixpi * gs^2)^2
  include './checkSBF_1-4.dat'
  do i = -5,5
     do j = -5,5
        print *, 'i,j', i,j
        print *, 'Matr.el. squared, SBF',MatElSqPDF(i,j)
        print *, 'result should be, SBF',check_sbf(i,j)
     enddo
  enddo
  print *, ''

  !-- CHECK HIGGS PLUS Z AMPLITUDES
  p9(:,1)= (/ 307.006915483657d0,  0.000000000000000d0,  0.000000000000000d0,  307.006915483657d0 /) * GeV
  p9(:,2)= (/ 307.006915483657d0,  0.000000000000000d0,  0.000000000000000d0, -307.006915483657d0 /) * GeV
  p9(:,3)= (/ 614.013830967315d0,  0.000000000000000d0,  0.000000000000000d0,  0.000000000000000d0 /) * GeV
  p9(:,4)= (/ 301.227135255720d0,  189.793200249019d0,  21.0235633708835d0, -213.887554776503d0  /) * GeV
  p9(:,5)= (/ 312.786695711595d0, -189.793200249019d0, -21.0235633708835d0,  213.887554776503d0  /) * GeV
  p9(:,6)= (/ 208.998953735946d0,  160.376261395938d0,  38.7454165525643d0, -128.291894286234d0  /) * GeV
  p9(:,7)= (/ 92.2281815197731d0,  29.4169388530806d0, -17.7218531816808d0, -85.5956604902683d0  /) * GeV
  p9(:,8)= (/ 217.267213637600d0, -181.141761229703d0, -16.0543247336901d0,  118.890551002984d0  /) * GeV
  p9(:,9)= (/ 95.5194820739952d0, -8.65143901931573d0, -4.96923863719339d0,  94.9970037735190d0  /) * GeV
  print *, 'H+Z, Z > l- l+, H > b b~, SM couplings'
  helicity=(/ 1d0, -1d0,  0d0,  0d0,  0d0,  1d0, -1d0,  1d0,  1d0 /)
  id(3:9)=(/ 23, 23, 25, 11, -11, 5, -5 /)
  mass(5,1)=M_Reso
  mass(5,2)=Ga_Reso
  Hzzcoupl(1:4) = (/ (2d0,0d0), (0d0,0d0), (0d0,0d0), (0d0,0d0) /)
  include './checkZH_SM.dat'
  do i = -6,6
    j = -i
    !id(1:2) = (/LHA2M_PDF(i),LHA2M_PDF(j)/)
    id(1:2) = (/i,j/)
    if (abs(LHA2M_PDF(i)).ne.6 .and. abs(LHA2M_PDF(j)).ne.6. .and. i.ne.0)then
      call EvalAmp_VHiggs(id,helicity,p9,Hzzcoupl,mass,MatElSqPDF(i,j))
      print *, 'i,j', i,j
      print *, 'Matr.el. squared, H+Z',MatElSqPDF(i,j)
      print *, 'result should be, H+Z',check_zh(i,j)
      print *, ''
    endif
  enddo

  
  
  

  
   p13(1:4,1) = -(/   3.2772203957555925d0,        0.0000000000000000d0,        0.0000000000000000d0,        3.2772203957555925d0     /)
   p13(1:4,2) = -(/     2.8653204768734621d0,        0.0000000000000000d0,        0.0000000000000000d0,       -2.8653204768734621d0         /)
   p13(1:4,3) = +(/     2.0695031298922770d0,       -1.3995194639860060d0,       0.4309336522215461d0,      -0.74896506056107459d0     /)
   p13(1:4,4) = +(/     1.9107949309969310d0,       0.80690401116821620d0,      -3.12533731972295947d-002,  7.85265034749671742d-002    /) 
   p13(1:4,5) = +(/    2.1622428117398473d0,       0.59261545281778993d0,      -0.39968027902431658d0,        1.0823384759682382d0         /)  
   p13(1:4,6) = +(/    1.0151002823876631d0,       0.96306893538507010d0,       0.32070427775393112d0,      -8.69340152707267361d-003    /)
   p13(1:4,7) = +(/    0.26916769467215163d0,      -7.41472049268541988d-002,  0.24741337553749249d0,      -7.57631933183877115d-002    /)
   p13(1:4,8) = +(/    0.62652695393711610d0,      -8.20177192899996244d-002, -0.59937102648865326d0,       0.16298309832042757d0     /)
   p13(1:4,9) = +(/    0.63056238611088244d0,       0.18199675333260884d0,       0.53765938388191470d0,       0.27460606598900683d0         /)  
   p13(1:4,10) = +(/    0.34622959545354920d0,      -2.44789896017240799d-002, -0.32712245562490633d0,      -0.11075473290987667d0         /)
   p13(1:4,11) = +(/     1.1854508301754154d0,       0.43509768908690516d0,      -0.61021720728132500d0,       0.91848714288910793d0        /)
   
   TTBHcoupl(1) = (1d0,0d0)
   TTBHcoupl(2) = (0d0,0d0)

   m_Reso=125.6d0 * GeV  
   call InitProcess_TTBH(m_Reso,m_top)

   TopDecays = 0
      call EvalAmp_GG_TTBH(p13(1:4,1:13),TTBHcoupl,TopDecays,MatElSq)
      print *, 'Matr.el. squared,gg->ttbH',MatElSq,MatElSq/9.23970258835623247d-003
      call EvalAmp_QQB_TTBH(p13(1:4,1:13),TTBHcoupl,TopDecays,MatElSq)
      print *, 'Matr.el. squared,qqb->ttbH',MatElSq,MatElSq/5.00600468807961274d-002

   TopDecays = 1
      call EvalAmp_GG_TTBH(p13(1:4,1:13),TTBHcoupl,TopDecays,MatElSq)
      print *, 'Matr.el. squared,gg->ttbH',MatElSq,MatElSq/161.41857569536978d0
      call EvalAmp_QQB_TTBH(p13(1:4,1:13),TTBHcoupl,TopDecays,MatElSq)
      print *, 'Matr.el. squared,qqb->ttbH',MatElSq,MatElSq/597.73846213084539d0

  

  
  
  
  
   p13(1:4,1) = -(/         65d0,           0.0000000000000000d0, 0.0000000000000000d0,      65d0           /)
   p13(1:4,2) = -(/         65d0,           0.0000000000000000d0, 0.0000000000000000d0,     -65d0           /)
   p13(1:4,3) = +(/   6.79628253951573D+00, 1.29758889289226D+00, 1.98855121530119D-01, 6.54894190404910D+00/)
   p13(1:4,4) = +(/   8.02057729949695D+00,-9.39738864094046D-01, 4.03339563681613D-02, 7.77508998381888D+00/)
   p13(1:4,5) = +(/   9.08189711855313D+00,-3.57850028798210D-01,-2.39189077898280D-01, 8.90520562445848D+00/)
   p13(1:4,6) = +(/   2.79365080713737D+00,-9.80625343363889D-01, 1.48569777553347D-01, 2.61166341425718D+00/)
   p13(1:4,7) = +(/   1.68880159051215D+00,-7.72451937789290D-02, 3.29719340015230D-01, 1.65449966726329D+00/)
   p13(1:4,8) = +(/   3.53812490184744D+00, 1.18131673048772D-01,-4.37955161200415D-01, 3.50892690229841D+00/)
   p13(1:4,9) = +(/   2.78029950629618D+00,-6.95882820010260D-01, 2.30273514283367D-01, 2.68193708989322D+00/)
   p13(1:4,10)= +(/   4.48588997875963D-01, 1.90724210110648D-01, 8.03232373884203D-02, 3.98000681190967D-01/)
   p13(1:4,11)= +(/   5.85300861438099D+00, 1.47308581101401D-01,-5.49785829570067D-01, 5.82526785337429D+00/)
   
   
   TTBHcoupl(1) = (1d0,0d0)
   TTBHcoupl(2) = (0d0,0d0)

   call NNPDFDriver("./pdfs/NNPDF30_lo_as_0130.LHgrid",33)
   call NNinitPDF(0)
   call InitProcess_TTBH(m_Reso,m_top)! done above already

   TopDecays = 1
   call EvalXSec_PP_TTBH(p13(1:4,1:13),TTBHcoupl,TopDecays,2,MatElSq)
   print *, 'Matr.el. squared,PP->ttbH',MatElSq ,MatElSq/( 1849.90671287913d0 + 2842.07693611093d0 ) * 1.14594184663D0
   
   



    p8(1:4,1)=-(/   4.1980450031499998d0,        0.0000000000000000d0,        0.0000000000000000d0,        4.1980450031499998d0 /)
    p8(1:4,2)=-(/   27.836467868400000d0,        0.0000000000000000d0,        0.0000000000000000d0,       -27.836467868400000d0 /)
    p8(1:4,3)=+(/   3.8571535099599998d0,      -0.85263204716199992d0,       0.18796420827100002d0,        3.7570362319200004d0 /)
    p8(1:4,4)=+(/   25.323655213100000d0,        1.4870426681000002d0,        1.0734899416599999d0,       -25.257154170600003d0/)
    p8(1:4,5)=+(/  0.93253047945792955d0,       -6.8201413203919231d-002,    -0.48999386324721106d0,      -0.79048572176161769d0 /)
    p8(1:4,6)=+(/   8.0173857331794371d-002,   -6.0571242164806610d-002,      2.9004810490239452d-002,    -4.3791471365831884d-002 /)
    p8(1:4,7)=+(/   1.5158181532461399d0,      -0.18697831686662519d0,      -0.73614167277770559d0,       -1.3118071900735808d0/)
    p8(1:4,8)=+(/  0.32518165844413610d0,      -0.31865964870464902d0,       -6.4323424395323042d-002,    7.7794566910300844d-003/)
    
    p_MCFM(1:8,4)=p8(1,1:8) *100d0  ! E
    p_MCFM(1:8,1)=p8(2,1:8) *100d0  ! x
    p_MCFM(1:8,2)=p8(3,1:8) *100d0  ! y
    p_MCFM(1:8,3)=p8(4,1:8) *100d0  ! z
    

    lambdaBSM = 100d0
    Lambda_z(1) = 100d0
    Lambda_z(2) = 100d0
    Lambda_z(3) = 100d0
    Lambda_z(4) = 100d0
    HWWcoupl(:) = 0d0
    HWWcoupl(1) = 1d0
    HZZcoupl(1:32) = HWWcoupl(:)
    
    call qq_ZZqq(p_MCFM,msq_MCFM,HZZcoupl(1:32),HWWcoupl,LambdaBSM,Lambda_Q,Lambda_z)
    
    print *, "MCFM:"
    print *, msq_MCFM(1,-1)

  
END PROGRAM



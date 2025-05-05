;-| Button Remapping |-----------------------------------------------------
[Remap]
x = x
y = y
z = z
a = a
b = b
c = c
s = s

;-| Default Values |-------------------------------------------------------
[Defaults]
command.time = 16

;-| Dir |--------------------------------------------------------------
[Command]
name = "back"
command = B
time = 2
buffer.time = 2
[Command]
name = "fwd"
command = F
time = 2
buffer.time = 2
[Command]
name = "up"
command = U
time = 1
buffer.time = 1
[Command]
name = "down"
command = D
time = 1
buffer.time = 1

; all you ever do is blame
[Statedef -1]

;===========================================================================
;---------------------------------------------------------------------------
[State 0, AI Checks Hittable]
type = VarSet
trigger1 = Var(15)
v = 16
value = 1
[State 0, AI Checks Hittable]
type = VarSet
triggerall = Var(15)
trigger1 = EnemyNear,StateNo = [5100,5120]
trigger2 = EnemyNear,PrevStateNo = [5100,5120]
trigger3 = EnemyNear,StateType = L
v = 16
value = 0

;===========================================================================
;---------------------------------------------------------------------------
[State 0, AI Guard]
Type = ChangeState
Value = 120
triggerall = StateType != A
triggerall = (Ctrl || (StateNo = 100 || StateNo = 101))
trigger1 = StateNo = 100 && inguarddist && enemynear,movetype = A
trigger1 = (map(p_Bk)>0) && !Var(15)
trigger2 = Var(17) = 120 && Var(15)

;---------------------------------------------------------------------------
;AI Walk
[State -1, AI Walk]
type = ChangeState
value = 20
triggerall = ctrl && statetype = S
trigger1 = (Var(17) = 20 || Var(17) = 21) && Var(15)

;===========================================================================
;---------------------------------------------------------------------------
;Run Fwd
[State -1, Run Fwd]
type = ChangeState
value = 100
triggerall = ctrl
triggerall = statetype = S || statetype = C && Var(15)
trigger1 = (command="FF" || map(b_66)) && p2dist x >= -8 && !Var(15)
trigger2 = (command="BB" || map(b_44)) && p2dist x < -8 && !Var(15)
trigger3 = Var(17) = 100 && Var(15)

;---------------------------------------------------------------------------
;Run Back
[State -1, Run Back]
type = ChangeState
value = 105
triggerall = ctrl
triggerall = statetype = S || statetype = C && Var(15)
trigger1 = (command="FF" || map(b_66)) && p2dist x < -8 && !Var(15)
trigger2 = (command="BB" || map(b_44)) && p2dist x >= -8 && !Var(15)
trigger3 = Var(17) = 105 && Var(15)


;---------------------------------------------------------------------------
[State -1, Jump]
Type = ChangeState
value = 40
triggerall = Ctrl || StateNo = 100
triggerall = statetype != A
trigger1 = StateNo = 100
trigger1 = (map(p_Up)>0) && !ctrl && !Var(15)
trigger2 = Var(17) = 40 && Var(15)

;===========================================================================
;---------------------------------------------------------------------------
; Craze Collision
[State -1, QCF,A+B+X+Y]
type = ChangeState
value = 3200
triggerall = RoundState = 2
triggerall = Var(18) >= 1000 - Var(5) * 1000 * (StateNo = 3005)
triggerall = StateType != A
triggerall = Ctrl || StateNo = [200,800) && MoveContact || StateNo = [1000,2000) && MoveGuarded = [1,8] || (StateNo = [200,800] || StateNo = [900,1000)) && Time <= 2
triggerall = !MoveHit || StateNo = [200,800)
trigger1 = map(QCF) && map(b_a) && map(b_y) && map(b_x) && map(b_b) && !Var(15)
trigger2 = Var(17) = 3000 && Var(15)

;---------------------------------------------------------------------------
; Craze Blitz
[State -1, A+Y / X+B]
type = ChangeState
value = 3002
triggerall = RoundState = 2
triggerall = var(18) >= 3000 && !Map(CCDisable)
triggerall = !MoveGuarded && !Ctrl && !MoveReversed
triggerall = (StateNo = [200,800) || StateNo = 900 && MoveHit && (NumHelper(910) && Var(5) <=1 || NumHelper(920) && Var(5) >=2) || StateNo = [1000,1200) && StateNo != 1030 || StateNo = 1440) && MoveHit || StateNo = 965 && (NumHelper(967) || MoveType = I) & MoveHit || StateNo = 1030 && (NumHelper(1035) || MoveType = I) & MoveHit || StateNo = 1210 && Time > 37 || StateNo = 1215 && Time > 37 || StateNo = 1310 && Time > 22 || StateNo = 1315 && Time > 22 || StateNo = 1420 && Time > 47 || StateNo = 960 || StateNo = 885 && Time >= 37 && Name="BERK" || StateNo = 888 && Time >= 29 && Name="BERK" || StateNo = 891 && Time >= 32 && Name="BERK" || StateNo = 894 && Time >= 63 && Name="BERK" || StateNo = 1600 && (NumHelper(1610) || MoveType = I) && MoveHit
trigger1 = map(b_a) && map(b_y) && map(b_x) && map(b_b) && !Var(15)
trigger2 = Var(17) = 3000 && Var(15)

;---------------------------------------------------------------------------
; Craze Assault
[State -1, A+Y / X+B]
type = ChangeState
value = 3001
triggerall = RoundState = 2
triggerall = var(18) >= 2000 && !Map(CCDisable)
triggerall = StateNo = [200,2000) && !Ctrl && (!Var(51) || MoveType = I) && !MoveReversed
triggerall = StateNo != [800,910) && StateNo != 960 && StateNo != 965 && StateNo != 1030 && StateNo != 1210  && StateNo != 1215 && StateNo != [1300,1315] && StateNo != 1350 && StateNo != [1410,1420] && StateNo != 1600 || StateNo = 965 && (NumHelper(967) || MoveType = I) & MoveGuarded || StateNo = 900 && MoveGuarded && (NumHelper(910) && Var(5) <=1 || NumHelper(920) && Var(5) >=2) || StateNo = 1030 && (NumHelper(1035) || MoveType = I) && MoveGuarded || StateNo = 1600 && (NumHelper(1610) || MoveType = I) && MoveGuarded
triggerall = !MoveContact && !Var(51) || MoveGuarded
trigger1 = map(b_a) && map(b_y) && map(b_x) && map(b_b) && !Var(15)
trigger2 = Var(17) = 3000 && Var(15)

;---------------------------------------------------------------------------
; Craze Focus
[State -1, A+Y / X+B]
type = ChangeState
value = 3000
triggerall = RoundState = 2
triggerall = var(18) >= 1000 && !Map(CCDisable)
triggerall = StateNo != [3000,4000)
triggerall = (ctrl || StateNo < 120) && !Var(51) || StateNo = 900 && !MoveContact && (NumHelper(910) && Var(5) <=1 || NumHelper(920) && Var(5) >=2) || StateNo = 965 && (NumHelper(967) || MoveType = I) & !MoveContact || StateNo = 1030 && (NumHelper(1035) || MoveType = I) & !MoveContact || StateNo = 1600 && (NumHelper(1610) || MoveType = I) && !MoveContact
trigger1 = map(b_a) && map(b_y) && map(b_x) && map(b_b) && !Var(15)
trigger2 = Var(17) = 3000 && Var(15)

;===========================================================================
;---------------------------------------------------------------------------
; Save the Best for Bamboozle
[State -1, 2QCF,2p]
type = ChangeState
value = 2700
triggerall = statetype != A
triggerall = Name = "BERK"
triggerall = Power >= 3000
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && MoveContact || (StateNo = [200,800) || StateNo = 1100 || StateNo = 1110) && Time <= 2
trigger1 = map(QCFQC) && map(b_xy) && !Var(15)
trigger2 = (Var(17) = 1000 || Var(17) = 1200 || Var(17) = 1300) && Var(15) && Random < 350

;---------------------------------------------------------------------------
; Jailbird Jamboree
[State -1, 2QCF,2p]
type = ChangeState
value = 2300
triggerall = statetype != A
triggerall = Name != "BERK"
triggerall = Power >= 3000
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && MoveContact || (StateNo = [200,800) || StateNo = 1100 || StateNo = 1200) && Time <= 2
trigger1 = map(QCFQC) && map(b_xy) && !Var(15)
trigger2 = (Var(17) = 1200 || Var(17) = 1300) && Var(15) && Random < 350

;---------------------------------------------------------------------------
; Head Hound
[State -1, 2QCF,2k]
type = ChangeState
value = 2600
triggerall = statetype != A
triggerall = Name = "BERK"
triggerall = Power >= 2000 - 1000 * (StateNo = 2500)
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && MoveContact || (StateNo = [200,800) || StateNo = 1410 || StateNo = 2500) && Time <= 2
trigger1 = map(QCFQC) && map(b_ab) && !Var(15)
trigger2 = (Var(17) = 1200 || Var(17) = 1300) && Var(15) && Random < 350

;---------------------------------------------------------------------------
; Snap Crackle Hold the Pop EX
[State -1, 2QCF,2k]
type = ChangeState
value = 2200
triggerall = statetype != A
triggerall = Name != "BERK"
triggerall = Power >= 2000 - 1000 * (StateNo = 2100)
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && MoveContact || (StateNo = [200,800) || StateNo = 1410 || StateNo = 2100) && Time <= 2
trigger1 = map(QCFQC) && map(b_ab) && !Var(15)
trigger2 = (Var(17) = 1200 || Var(17) = 1300) && Var(15) && Random < 350

;---------------------------------------------------------------------------
; Hole in One (Shot)
[State -1, 2QCB,p]
type = ChangeState
value = 2800
triggerall = statetype != A
triggerall = Name = "BERN"
triggerall = Power >= 1000
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(QCBQC) && (map(b_x) || map(b_y)) && !Var(15)
trigger2 = Var(17) = 1000 && Var(15) && Random < 125

;---------------------------------------------------------------------------
; Snap Crackle Hold the Pop
[State -1, 2QCF,k]
type = ChangeState
value = ifelse(Name = "BERK",2500,2100)
triggerall = statetype != A
triggerall = Power >= 1000
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(QCFQC) && (map(b_a) || map(b_b)) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 350

;---------------------------------------------------------------------------
; Can't Fly From Reckoning
[State -1, 360,2p]
type = ChangeState
value = 2000
triggerall = statetype != A
triggerall = Name != "BERN"
triggerall = Power >= 1000
triggerall = ctrl || StateNo = 40 || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && MoveHit || (StateNo = [200,800) || StateNo = 1100 || StateNo = 1110 || StateNo = 1200 || StateNo = 1300) && Time <= 2
trigger1 = (map(HCB) || map(f360) || map(r360)) && map(b_xy) && !Var(15)
trigger2 = (Var(17) = 800 || Var(17) = 1300) && Var(15) && Random < 500
trigger2 = P2BodyDist X = [-8,const(size.ground.front)] && StateType != A && EnemyNear,StateType != A || P2BodyDist X <= 40 && !numtarget(860) && StateType = A && EnemyNear,StateType = A

;===========================================================================
;---------------------------------------------------------------------------
; CTech Predator Poised
[State -1, Y+B]
type = ChangeState
value = 970
triggerall = Name = "BERK"
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = Var(17) = 900 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; CTech Caddigan Catch
[State -1, Y+B]
type = ChangeState
value = 950
triggerall = Name = "BERX"
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveHit || StateNo = [200,800) && Time <= 2
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = Var(17) = 1300 && Var(15) && Random < 350

;---------------------------------------------------------------------------
; CTech Rambling Inventory
[State -1, Y+B]
type = ChangeState
value = 1000 + ((map(p_Fd)>0)||Var(43)>=500)
triggerall = Name = "BERN"
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = Var(17) = 900 && Var(15) && Random < 750

;---------------------------------------------------------------------------
; Need a Lift?
[State -1, d.X+A]
type = ChangeState
value = 880
triggerall = statetype != A
triggerall = Name = "BERX"
triggerall = ctrl || (StateNo = [100,101]) || StateNo = 800 && Time <= 2
triggerall = EnemyNear,StateNo = 5109 && P2Dist X = [-8,160] && (EnemyNear,sysvar(2) <= 4 || EnemyNear,sysvar(2) = 510)
trigger1 = (map(p_Dn)>0) && (map(b_x) && map(b_a) || map(b_xa)) && !Var(15)
trigger2 = Var(15) > random && Var(15)

;---------------------------------------------------------------------------
; Throw
[State -1, X+A]
type = ChangeState
value = ifelse(StateType=A,850,800)
;triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && Time <= 2 && PrevStateNo != [200,800) || StateNo = [600,800) && MoveHit
trigger1 = (map(b_x) && map(b_a) || map(b_xa)) && !Var(15)
trigger2 = Var(17) = 800 && Var(15) && (Random < 350 || Name = "BERN")
trigger2 = P2BodyDist X = [-8,const(size.ground.front)] && StateType != A && EnemyNear,StateType != A || P2BodyDist X <= 40 && !numtarget(860) && StateType = A && EnemyNear,StateType = A

;===========================================================================
;---------------------------------------------------------------------------
; SK Tobaccin' My Day
[State -1, QCB,b]
type = ChangeState
value = 962
triggerall = statetype != A
triggerall = Name = "BERX" && Var(44)
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(QCB) && map(b_b) && !Var(15)
trigger2 = (Var(17) = 1000 || Var(17) = 1600) && Var(15) && Random < 350

;---------------------------------------------------------------------------
; LK Tobaccin' My Day
[State -1, QCB,a]
type = ChangeState
value = 961
triggerall = statetype != A
triggerall = Name = "BERX" && Var(44)
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(QCB) && map(b_a) && !Var(15)
trigger2 = (Var(17) = 1000 || Var(17) = 1600) && Var(15) && Random < 350

;---------------------------------------------------------------------------
; SK Come...
[State -1, QCF,b]
type = ChangeState
value = 1401 + 200 * (Name="BERN")
triggerall = statetype != A
triggerall = Name != "BERN" || !NumHelper(1610)
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(QCF) && map(b_b) && !Var(15)
trigger2 = (Var(17) = 1200 || Var(17) = 1700) && Var(15) && Random < 350

;---------------------------------------------------------------------------
; LK Come...
[State -1, QCF,a]
type = ChangeState
value = 1400 + 200 * (Name="BERN")
triggerall = statetype != A
triggerall = Name != "BERN" || !NumHelper(1610)
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(QCF) && map(b_a) && !Var(15)
trigger2 = (Var(17) = 1200 || Var(17) = 1700) && Var(15) && Random < 350

;---------------------------------------------------------------------------
; SP Flip It My Way
[State -1, 360,y]
type = ChangeState
value = 1301
triggerall = statetype != A
triggerall = Name != "BERN"
triggerall = ctrl || StateNo = 40 || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || (StateNo = [200,800) || StateNo = 1100) && Time <= 2
trigger1 = (map(HCB) || map(f360) || map(r360)) && map(b_y) && !Var(15)
trigger2 = Var(17) = 800 && Var(15) && Random < 500
trigger2 = P2BodyDist X = [-8,const(size.ground.front)] && StateType != A && EnemyNear,StateType != A || P2BodyDist X <= 40 && !numtarget(860) && StateType = A && EnemyNear,StateType = A

;---------------------------------------------------------------------------
; LP Flip It My Way
[State -1, 360,x]
type = ChangeState
value = 1300
triggerall = statetype != A
triggerall = Name != "BERN"
triggerall = ctrl || StateNo = 40 || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || (StateNo = [200,800) || StateNo = 1100) && Time <= 2
trigger1 = (map(HCB) || map(f360) || map(r360)) && map(b_x) && !Var(15)
trigger2 = Var(17) = 800 && Var(15) && Random < 500
trigger2 = P2BodyDist X = [-8,const(size.ground.front)] && StateType != A && EnemyNear,StateType != A || P2BodyDist X <= 40 && !numtarget(860) && StateType = A && EnemyNear,StateType = A

;---------------------------------------------------------------------------
; SP Crashing Down
[State -1, DP,y]
type = ChangeState
value = 1201
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(DP) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1100 && Var(15) && Random < 350

;---------------------------------------------------------------------------
; LP Crashing Down
[State -1, DP,x]
type = ChangeState
value = 1200
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(DP) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1100 && Var(15) && Random < 350

;---------------------------------------------------------------------------
; SP Goldenjoyer
[State -1, QCF,y]
type = ChangeState
value = 1101 + 10 * (Name!="BERX")
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(QCF) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 350

;---------------------------------------------------------------------------
; LP Goldenjoyer
[State -1, QCF,x]
type = ChangeState
value = 1100 + 10 * (Name="BERK")
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(QCF) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 350

;---------------------------------------------------------------------------
; SK Gimme a Hand, Lee!
[State -1, QCB,b]
type = ChangeState
value = 903
triggerall = Name = "BERN"
triggerall = StateType != A
triggerall = Var(42) <= 0
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact
trigger1 = map(QCB) && map(b_b) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; LK Gimme a Hand, Lee!
[State -1, QCB,a]
type = ChangeState
value = 902
triggerall = Name = "BERN"
triggerall = StateType != A
triggerall = Var(42) <= 0
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact
trigger1 = map(QCB) && map(b_a) && !Var(15)
trigger2 = Var(17) = 1000 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; SK Gimme a Hand, Jimmy!
[State -1, QCB,y]
type = ChangeState
value = 901
triggerall = Name = "BERN"
triggerall = StateType != A
triggerall = Var(41) <= 0
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact
trigger1 = map(QCB) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1000 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; LK Gimme a Hand, Jimmy!
[State -1, QCB,x]
type = ChangeState
value = 900
triggerall = Name = "BERN"
triggerall = StateType != A
triggerall = Var(41) <= 0
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact
trigger1 = map(QCB) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 500

;===========================================================================
;---------------------------------------------------------------------------
; CN ju.d+SP
[State -1, ju.d+SP]
type = ChangeState
value = 615
triggerall = statetype = A
triggerall = Name = "BERK"
triggerall = StateNo != 615
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = 600 || StateNo = 610 || StateNo = 700 || StateNo = 710) && MoveContact
trigger1 = map(b_y) && (map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 205 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; CN df+SP
[State -1, cr.f+SP]
type = ChangeState
value = 415
triggerall = statetype != A
triggerall = Name = "BERX"
triggerall = StateNo != 415 && StateNo != 205 && StateNo != 225 && StateNo != 215
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(b_y) && (map(p_Fd)>0) && (map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; CN f+LP S-K
[State -1, st.f+LP]
type = ChangeState
value = 225
triggerall = statetype != A
triggerall = Name != "BERX"
triggerall = StateNo != 415 && StateNo != 205 && StateNo != 225 && StateNo != 215
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(b_x) && (map(p_Fd)>0) && !(map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 205 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; CN f+SP S-K
[State -1, st.f+SP]
type = ChangeState
value = 215 + (MoveHit=1&&!(map(p_Up)>0))
triggerall = statetype != A
triggerall = Name = "BERK"
triggerall = StateNo != 415 && StateNo != 205 && StateNo != 225 && StateNo != 215
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(b_y) && (map(p_Fd)>0) && !(map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 350

;---------------------------------------------------------------------------
; CN f+SP
[State -1, st.f+SP]
type = ChangeState
value = 205
triggerall = statetype != A
triggerall = Name != "BERK"
triggerall = StateNo != 415 && StateNo != 205 && StateNo != 225 && StateNo != 215
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(b_y) && (map(p_Fd)>0) && !(map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 205 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Standing LP
[State -1, st.LP]
type = ChangeState
value = 200
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = 300 || StateNo = 400 || StateNo = 500) && MoveContact && Map(LightChain)
trigger1 = map(b_x) && !(map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 200 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Standing HP
[State -1, st.HP]
type = ChangeState
value = 210
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = 200 || StateNo = 300 || StateNo = 400 || StateNo = 500) && MoveContact 
trigger1 = map(b_y) && !(map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 210 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Standing LK
[State -1, st.LK]
type = ChangeState
value = 300
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = 200 || StateNo = 400 || StateNo = 500) && MoveContact && Map(LightChain)
trigger1 = map(b_a) && !(map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 200 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Standing HK
[State -1, st.HK]
type = ChangeState
value = 310
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = 200 || StateNo = 300 || StateNo = 400 || StateNo = 500) && MoveContact 
trigger1 = map(b_b) && !(map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 210 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Crouch LP
[State -1, cr.LP]
type = ChangeState
value = 400
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = 200 || StateNo = 300 || StateNo = 500) && MoveContact && Map(LightChain)
trigger1 = map(b_x) && (map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 200 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Crouch SP
[State -1, cr.SP]
type = ChangeState
value = 410
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = 200 || StateNo = 300 || StateNo = 400 || StateNo = 500) && MoveContact
trigger1 = map(b_y) && (map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 210 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Crouch LK
[State -1, cr.LK]
type = ChangeState
value = 500
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = 200 || StateNo = 300 || StateNo = 400) && MoveContact && Map(LightChain)
trigger1 = map(b_a) && (map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 200 && Var(15) && Random < 500 && EnemyNear,StateType = S

;---------------------------------------------------------------------------
; Crouch SK
[State -1, cr.SK]
type = ChangeState
value = 510
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = 200 || StateNo = 300 || StateNo = 400 || StateNo = 500) && MoveContact
trigger1 = map(b_b) && (map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 510 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Jump LP
[State -1, j.LP]
type = ChangeState
value = 600
triggerall = statetype = A
triggerall = ctrl
trigger1 = map(b_x) && !Var(15)
trigger2 = Var(17) = 200 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Jump SP
[State -1, j.SP]
type = ChangeState
value = 610
triggerall = statetype = A
triggerall = ctrl || (StateNo = 600 || StateNo = 700) && MoveContact
trigger1 = map(b_y) && !Var(15)
trigger2 = Var(17) = 210 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Jump LK
[State -1, j.LK]
type = ChangeState
value = 700
triggerall = statetype = A
triggerall = ctrl
trigger1 = map(b_a) && !Var(15)
trigger2 = Var(17) = 200 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Jump SK
[State -1, j.SK]
type = ChangeState
value = 710
triggerall = statetype = A
triggerall = ctrl || (StateNo = 600 || StateNo = 700) && MoveContact
trigger1 = map(b_b) && !Var(15)
trigger2 = Var(17) = 210 && Var(15) && Random < 500

;---------------------------------------------------------------------------
;Taunt
[State -1, Taunt]
type = ChangeState
value = 165
triggerall = statetype != A
triggerall = ctrl
trigger1 = command = "s" && !Var(15)
trigger2 = Var(17) = 165 && Var(15)
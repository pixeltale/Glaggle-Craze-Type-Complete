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

; count on me im gonna win the race
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
[State 0, Guard]
Type = ChangeState
Value = 120
triggerall = StateType != A
triggerall = Ctrl
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
triggerall = (StateNo = [200,800) || StateNo = [1000,1300) || StateNo = [1600,1800)) && MoveHit || (StateNo = [900,905] && Time>=6 || StateNo = 1300 && NumHelper(4010) || StateNo = 1701 && MoveType = I || StateNo = 1751 && MoveType = I || StateNo = 1800 && MoveType = I) && MoveHit || StateNo = 1510 && Time >= 61
trigger1 = map(b_a) && map(b_y) && map(b_x) && map(b_b) && !Var(15)
trigger2 = Var(17) = 3000 && Var(15)

;---------------------------------------------------------------------------
; Craze Assault
[State -1, A+Y / X+B]
type = ChangeState
value = 3001
triggerall = RoundState = 2
triggerall = var(18) >= 2000 && !Map(CCDisable)
triggerall = StateNo = [200,2000) && !Ctrl && !MoveReversed
triggerall = StateNo != [800,900) && StateNo != [900,905] && StateNo != [1300,1400] && StateNo != [1500,1510] && StateNo != 1701 && StateNo != 1751 && StateNo != [1800,2000) || (StateNo = [900,905] && Time>=6 || StateNo = 1300 && NumHelper(4010) || StateNo = 1701 && MoveType = I || StateNo = 1751 && MoveType = I || StateNo = 1800 && MoveType = I) && MoveGuarded
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
triggerall = (ctrl || StateNo < 120) && !Var(51) || (StateNo = [900,905] && Time>=6 || StateNo = 1300 && NumHelper(4010) || StateNo = 1701 && MoveType = I || StateNo = 1751 && MoveType = I || StateNo = 1800 && MoveType = I) && !MoveContact
trigger1 = map(b_a) && map(b_y) && map(b_x) && map(b_b) && !Var(15)
trigger2 = Var(17) = 3000 && Var(15)

;===========================================================================
;---------------------------------------------------------------------------
; Raging River Current Smackdown
[State -1, 2QCF,2K]
type = ChangeState
value = 2900 + !!map(QCBQC)
;triggerall = statetype != A
triggerall = Power >= 3000
triggerall = Name = "CICK"
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = (map(QCFQC) || map(QCBQC)) && map(b_ab) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; In the Wake of Poseidon!
[State -1, 2QCF,2K]
type = ChangeState
value = 2500
triggerall = statetype != A
triggerall = Power >= 3000
triggerall = !(Name = "CICI" && NumHelper(4010)) && Name != "CICK"
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2) || StateNo = 1100 && Time <= 2
trigger1 = map(QCFQC) && map(b_ab) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Super Duper Scuba Scuba Scuba!
[State -1, 2QCB,2P]
type = ChangeState
value = 2800
triggerall = statetype != A
triggerall = Power >= 2000
triggerall = Name = "CICK" && !Map(CickPosBusy)
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = map(QCBQC) && map(b_xy) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Clamshell Combo EX
[State -1, 2QCB,2k]
type = ChangeState
value = 2300 + (Map(Puddle1Ctrl)&&Abs(Map(Puddle1Dist))<48||Map(Puddle2Ctrl)&&Abs(Map(Puddle2Dist))<48)
triggerall = statetype != A
triggerall = Name != "CICK"
triggerall = Power >= 2000 - 1000 * (StateNo = 2200)
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2) || (StateNo = 2200) && Time <= 2
trigger1 = map(QCBQC) && map(b_ab) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Catch of the Day
[State -1, 360,2p]
type = ChangeState
value = 2700 + 50 * !!NumHelper(4000)
triggerall = statetype != A
triggerall = Name = "CICK" && !Map(CickPosBusy) && Map(CickMoist) >= 3
triggerall = Power >= 1000
triggerall = ctrl || StateNo = 40 || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && MoveHit || (StateNo = [200,800) || StateNo = 1100 || StateNo = 1110 || StateNo = 1200 || StateNo = 1300) && Time <= 2
trigger1 = (map(HCB) || map(f360) || map(r360)) && map(b_xy) && !Var(15)
trigger2 = Var(17) = 800 && Var(15) && Random < 250 && !NumHelper(4000)
trigger2 = P2BodyDist X = [-8,const(size.ground.front)] && StateType != A && EnemyNear,StateType != A || P2BodyDist X <= 40 && !numtarget(860) && StateType = A && EnemyNear,StateType = A

;---------------------------------------------------------------------------
; Clamshell Combo
[State -1, 2QCB,k]
type = ChangeState
value = 2200 + (Map(Puddle1Ctrl)&&Abs(Map(Puddle1Dist))<48||Map(Puddle2Ctrl)&&Abs(Map(Puddle2Dist))<48)
triggerall = statetype != A
triggerall = Name != "CICK"
triggerall = Power >= 1000
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = map(QCBQC) && (map(b_a) || map(b_b)) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SP Pressure Geyser
[State -1, 2QCB,y]
type = ChangeState
value = 2100 + (Name="CICI")
triggerall = statetype != A
triggerall = Power >= 1000
triggerall = Name = "CICI" && NumHelper(4000) && Map(PuddlePos) > 0 && (Map(Puddle1Ctrl) || Map(Puddle2Ctrl)) || Name = "CICX"
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = map(QCBQC) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1300 && Var(15) && Random < 125

;---------------------------------------------------------------------------
; LP Pressure Geyser
[State -1, 2QCB,x]
type = ChangeState
value = 2100
triggerall = statetype != A
triggerall = Power >= 1000
triggerall = Name != "CICK"
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = map(QCBQC) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1300 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Bottom Feeder Blitz
[State -1, 2QCF,p]
type = ChangeState
value = 2000 + (Map(Puddle1Ctrl)&&Abs(Map(Puddle1Dist))<48||Map(Puddle2Ctrl)&&Abs(Map(Puddle2Dist))<48) + 600 * (Name="CICK")
triggerall = statetype != A
triggerall = Power >= 1000
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = map(QCFQC) && (map(b_x) || map(b_y)) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;===========================================================================
;---------------------------------------------------------------------------
; Sink Drink
[State -1, d.Y+B]
type = ChangeState
value = 940
triggerall = statetype != A
triggerall = Name = "CICK" && NumHelper(4000) && !Map(CickPosBusy) && Map(CickMoist) = 6
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && (map(p_Dn)>0) && !Var(15)

;---------------------------------------------------------------------------
; Water Displacement
[State -1, f.Y+B]
type = ChangeState
value = 935 + (map(p_Bk)<=0)
triggerall = statetype != A
triggerall = Name = "CICK" && NumHelper(4000) && !Map(CickPosBusy)
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && (map(p_Fd)>0||map(p_Bk)>0) && !Var(15)

;---------------------------------------------------------------------------
; Poseidon Recall
[State -1, Y+B]
type = ChangeState
value = 930
triggerall = statetype != A
triggerall = Name = "CICK" && NumHelper(4000) && !Map(CickPosBusy)
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && (map(p_Dn)<=0) && !Var(15)
trigger2 = Var(17) = 900 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Self-Containment
[State -1, Y+B]
type = ChangeState
value = 920
triggerall = statetype != A
triggerall = Name = "CICX" && !NumHelper(4010)
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = Var(17) = 900 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Super Backdash
[State -1, f.Y+B]
type = ChangeState
value = 111
triggerall = statetype != A
triggerall = Name = "CICI"
triggerall = Map(Puddle1Ctrl) && Abs(Map(Puddle1Dist)) < 48 ||Map(Puddle2Ctrl) && Abs(Map(Puddle2Dist)) < 48
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = (map(p_Bk)>0) && (map(b_y) && map(b_b) || map(b_yb)) && (map(p_Dn)<=0) && !Var(15)

;---------------------------------------------------------------------------
; Super Dash
[State -1, f.Y+B]
type = ChangeState
value = 110
triggerall = statetype != A
triggerall = Name = "CICI"
triggerall = Map(Puddle1Ctrl) && Abs(Map(Puddle1Dist)) < 48 ||Map(Puddle2Ctrl) && Abs(Map(Puddle2Dist)) < 48
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = (map(p_Fd)>0) && (map(b_y) && map(b_b) || map(b_yb)) && (map(p_Dn)<=0) && !Var(15)
trigger2 = Var(17) = 100 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Super Jump
[State -1, d.Y+B]
type = ChangeState
value = 112
triggerall = statetype != A
triggerall = Name = "CICI"
triggerall = Map(Puddle1Ctrl) && Abs(Map(Puddle1Dist)) < 48 ||Map(Puddle2Ctrl) && Abs(Map(Puddle2Dist)) < 48
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)

;---------------------------------------------------------------------------
; Current Rider
[State -1, ju.Y+B]
type = ChangeState
value = 905 + -3 * (map(p_Dn)>0) + 3 * (map(p_Up)>0) + 1 * (map(p_Fd)>0) + -1 * (map(p_Bk)>0)
triggerall = statetype = A && Var(1)
triggerall = Name != "CICK"
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = Var(17) = 100 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Puddle Position
[State -1, Y+B]
type = ChangeState
value = 900
triggerall = statetype != A
triggerall = Name = "CICI" || Name = "CICK" && !NumHelper(4000); && (Map(PuddleCtrl) || NumHelper(4000)<2)
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = Var(17) = 900 && Var(15)

;---------------------------------------------------------------------------
; Throw
[State -1, X+A]
type = ChangeState
value = ifelse(StateType=A,850,800)
;triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && Time <= 2 && PrevStateNo != [200,800) || StateNo = [600,800) && MoveHit
trigger1 = (map(b_x) && map(b_a) || map(b_xa)) && !Var(15)
trigger2 = Var(17) = 800 && Var(15) && (Random < 500 || Name != "CICX")
trigger2 = P2BodyDist X = [-8,const(size.ground.front)] && StateType != A && EnemyNear,StateType != A || P2BodyDist X <= 40 && !numtarget(860) && StateType = A && EnemyNear,StateType = A

;===========================================================================
;---------------------------------------------------------------------------
; Iceberg SP
[State -1, QCB,y]
type = ChangeState
value = 1801
triggerall = statetype != A
triggerall = Name = "CICK" && !Map(CickPosBusy) && Map(CickMoist) >= 3
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = map(QCB) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Iceberg LP
[State -1, QCB,x]
type = ChangeState
value = 1800
triggerall = statetype != A
triggerall = Name = "CICK" && !Map(CickPosBusy) && Map(CickMoist) >= 3
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = map(QCB) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Hydrodynamic SK
[State -1, QCB,b]
type = ChangeState
value = 1901
triggerall = Name = "CICK"
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveHit || StateNo = [200,800) && Time <= 2
trigger1 = map(QCB) && map(b_b) && !Var(15)
trigger2 = Var(17) = 1300 && Var(15) && Random < 125

;---------------------------------------------------------------------------
; Hydrodynamic LK
[State -1, QCB,a]
type = ChangeState
value = 1900
triggerall = Name = "CICK"
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveHit || StateNo = [200,800) && Time <= 2
trigger1 = map(QCB) && map(b_a) && !Var(15)
trigger2 = Var(17) = 1300 && Var(15) && Random < 125

;---------------------------------------------------------------------------
; Scuba Scuba Scuba S-K SP
[State -1, QCF,y]
type = ChangeState
value = 1751
triggerall = statetype != A
triggerall = Name = "CICK" && !Map(CickPosBusy) && Map(CickMoist) >= 3
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = map(QCF) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Scuba Scuba Scuba S-K LP
[State -1, QCF,x]
type = ChangeState
value = 1750
triggerall = statetype != A
triggerall = Name = "CICK"
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = map(QCF) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Bullcharge SK
[State -1, QCF,b]
type = ChangeState
value = 1701
triggerall = statetype != A
triggerall = Name = "CICK" && !Map(CickPosBusy) && Map(CickMoist) >= 3
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = map(QCF) && map(b_b) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Bullcharge LK
[State -1, QCF,a]
type = ChangeState
value = 1700
triggerall = statetype != A
triggerall = Name = "CICK"
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = map(QCF) && map(b_a) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SP Bubbly Burst
[State -1, DP,y]
type = ChangeState
value = 1601
triggerall = statetype != A
triggerall = Name = "CICX"
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = map(DP) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1300 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LP Bubbly Burst
[State -1, DP,x]
type = ChangeState
value = 1600
triggerall = statetype != A
triggerall = Name = "CICX"
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = map(DP) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SP Moist Malign
[State -1, QCB,y]
type = ChangeState
value = 1501
triggerall = statetype != A
triggerall = Name = "CICX"
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = map(QCB) && map(b_y) && !Var(15)
trigger2 = Var(17) = 800 && Var(15) && Random < 250
trigger2 = P2BodyDist X = [-8,const(size.ground.front)] && StateType != A && EnemyNear,StateType != A || P2BodyDist X <= 40 && !numtarget(860) && StateType = A && EnemyNear,StateType = A

;---------------------------------------------------------------------------
; LP Moist Malign
[State -1, QCB,x]
type = ChangeState
value = 1500
triggerall = statetype != A
triggerall = Name = "CICX"
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = map(QCB) && map(b_x) && !Var(15)
trigger2 = Var(17) = 800 && Var(15) && Random < 250
trigger2 = P2BodyDist X = [-8,const(size.ground.front)] && StateType != A && EnemyNear,StateType != A || P2BodyDist X <= 40 && !numtarget(860) && StateType = A && EnemyNear,StateType = A

;---------------------------------------------------------------------------
; Sea Spin B SK
[State -1, QCB,b]
type = ChangeState
value = 1103 + 4 * (Map(Puddle1Ctrl)&&Abs(Map(Puddle1Dist))<48||Map(Puddle2Ctrl)&&Abs(Map(Puddle2Dist))<48)
triggerall = statetype != A
triggerall = Name != "CICK"
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = map(QCB) && map(b_b) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 125

;---------------------------------------------------------------------------
; Sea Spin B LK
[State -1, QCB,a]
type = ChangeState
value = 1102 + 4 * (Map(Puddle1Ctrl)&&Abs(Map(Puddle1Dist))<48||Map(Puddle2Ctrl)&&Abs(Map(Puddle2Dist))<48)
triggerall = statetype != A
triggerall = Name != "CICK"
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = map(QCB) && map(b_a) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 125

;---------------------------------------------------------------------------
; Sea Spin F SK
[State -1, QCB,b]
type = ChangeState
value = 1101 + 4 * (Map(Puddle1Ctrl)&&Abs(Map(Puddle1Dist))<48||Map(Puddle2Ctrl)&&Abs(Map(Puddle2Dist))<48)
triggerall = statetype != A
triggerall = Name != "CICK"
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = map(QCF) && map(b_b) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Sea Spin F LK
[State -1, QCB,a]
type = ChangeState
value = 1100 + 4 * (Map(Puddle1Ctrl)&&Abs(Map(Puddle1Dist))<48||Map(Puddle2Ctrl)&&Abs(Map(Puddle2Dist))<48)
triggerall = statetype != A
triggerall = Name != "CICK"
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = map(QCF) && map(b_a) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Dunker Diver SP
[State -1, ju.QCB,y]
type = ChangeState
value = 1201
triggerall = statetype = A
triggerall = Name != "CICK"
triggerall = Vel Y >= -1 || Time >= 10
triggerall = ctrl || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = map(QCB) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Dunker Diver LP
[State -1, ju.QCB,x]
type = ChangeState
value = 1200
triggerall = statetype = A
triggerall = Name != "CICK"
triggerall = Vel Y >= -1 || Time >= 10
triggerall = ctrl || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = map(QCB) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Shora-Ora-Ora SP
[State -1, ju.QCF,y]
type = ChangeState
value = 1051
triggerall = statetype = A
triggerall = Name != "CICK"
triggerall = ctrl || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = map(QCF) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Shora-Ora-Ora LP
[State -1, ju.QCF,x]
type = ChangeState
value = 1050
triggerall = statetype = A
triggerall = Name != "CICK"
triggerall = ctrl || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = map(QCF) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Scuba Scuba Scuba SP
[State -1, QCF,y]
type = ChangeState
value = 1001 + 2 * (Map(Puddle1Ctrl)&&Abs(Map(Puddle1Dist))<48||Map(Puddle2Ctrl)&&Abs(Map(Puddle2Dist))<48)
triggerall = statetype != A
triggerall = Name != "CICK"
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = map(QCF) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Scuba Scuba Scuba LP
[State -1, QCF,x]
type = ChangeState
value = 1000 + 2 * (Map(Puddle1Ctrl)&&Abs(Map(Puddle1Dist))<48||Map(Puddle2Ctrl)&&Abs(Map(Puddle2Dist))<48)
triggerall = statetype != A
triggerall = Name != "CICK"
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = map(QCF) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Poseidon! Capture! SK
[State -1, DD,b]
type = ChangeState
value = 1401
triggerall = statetype != A
triggerall = Name = "CICI" && Map(PuddlePos) > 0 && !NumHelper(4010)
triggerall = Map(Puddle1Ctrl) || Map(Puddle2Ctrl)
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = map(DD) && map(b_b) && !Var(15)

;---------------------------------------------------------------------------
; Poseidon! Capture! LK
[State -1, DD,a]
type = ChangeState
value = 1400
triggerall = statetype != A
triggerall = Name = "CICI" && Map(PuddlePos) > 0 && !NumHelper(4010)
triggerall = Map(Puddle1Ctrl) || Map(Puddle2Ctrl)
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = map(DD) && map(b_a) && !Var(15)

;---------------------------------------------------------------------------
; Poseidon! Attack! SP
[State -1, DD,y]
type = ChangeState
value = 1301
triggerall = statetype != A
triggerall = Name = "CICI" && Map(PuddlePos) > 0 && !NumHelper(4010)
triggerall = Map(Puddle1Ctrl) || Map(Puddle2Ctrl)
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = map(DD) && map(b_y) && !Var(15)

;---------------------------------------------------------------------------
; Poseidon! Attack! LP
[State -1, DD,x]
type = ChangeState
value = 1300
triggerall = statetype != A
triggerall = Name = "CICI" && Map(PuddlePos) > 0 && !NumHelper(4010)
triggerall = Map(Puddle1Ctrl) || Map(Puddle2Ctrl)
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = map(DD) && map(b_x) && !Var(15)

;===========================================================================
;---------------------------------------------------------------------------
; CN ju.d+SP
[State -1, ju.d+SP]
type = ChangeState
value = 615
triggerall = statetype = A
triggerall = Name = "CICK"
triggerall = StateNo != 615
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && MoveContact || StateNo = 610 && Time <= 2
triggerall = Vel Y > const(velocity.jump.y)*0.5 || MoveContact
trigger1 = map(b_y) && (map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; CN f+SP
[State -1, st.f+SP]
type = ChangeState
value = 215 + 10 * (Name="CICK") + ((map(p_Up)>0)&&Name="CICK")
triggerall = statetype != A
triggerall = StateNo != 215 && StateNo != 225 && StateNo != 415
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = map(b_y) && (map(p_Fd)>0) && (map(p_Dn)<=0) && !Var(15)
trigger2 = Var(17) = 205 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; CN df+SP
[State -1, df+SP]
type = ChangeState
value = 415
triggerall = statetype != A
triggerall = Name != "CICK"
triggerall = StateNo != 215 && StateNo != 225 && StateNo != 415
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = 200 || StateNo = 210 || StateNo = 300 || StateNo = 310 || StateNo = 400 || StateNo = 410 || StateNo = 500) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(b_y) && (map(p_Fd)>0) && (map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 410 && Var(15) && Random < 500

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
value = 410 + 10 * (Name="CICK")
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
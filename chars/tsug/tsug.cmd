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

; we got the power, i can feel it comin
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
triggerall = Ctrl
trigger1 = StateNo = 100 && inguarddist && enemynear,movetype = A
trigger1 = map(p_Bk) && !Var(15)

;---------------------------------------------------------------------------
;AI Walk
[State -1, AI Walk]
type = ChangeState
value = 20
triggerall = ctrl && statetype != A
trigger1 = Var(17) = 20 && Var(15)

;===========================================================================
;---------------------------------------------------------------------------
[State 0, Unglued Off]
Type = ChangeState
Value = 2605
triggerall = StateType != A
triggerall = Var(41) = 1
trigger1 = Ctrl || StateNo = [200,3000) && StateNo != [810,900) && MoveType = I
trigger1 = !(StateNo = [1300,1400] && MoveHit && AnimTime <= -8)

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
trigger1 = (command="BB" || map(b_44)) && p2dist x >= -8 && !Var(15)
trigger2 = (command="FF" || map(b_66)) && p2dist x < -8 && !Var(15)
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
triggerall = (StateNo = [200,800) || StateNo = [1000,2000)) && MoveHit || StateNo = 1610 && Time >= 95 || StateNo = 1611 && Time >= 81
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
triggerall = StateNo != [800,900) && StateNo != [1600,1611] && !((StateNo = 1105 || StateNo = 1400 && Var(5)) && MoveGuarded)
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
triggerall = (ctrl || StateNo < 120) && !Var(51)
trigger1 = map(b_a) && map(b_y) && map(b_x) && map(b_b) && !Var(15)
trigger2 = Var(17) = 3000 && Var(15)

;===========================================================================
;---------------------------------------------------------------------------
; Still Remains
[State -1, 2QCF+2p]
type = ChangeState
value = 2800
triggerall = Name = "TSUK"
triggerall = statetype != A
triggerall = Power >= 3000
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || (StateNo = [200,800) || StateNo = 1300 && !Var(7) || StateNo = 2610) && Time <= 2
trigger1 = map(QCFQC) && map(b_xy) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Silvergun
[State -1, 2QCF,p]
type = ChangeState
value = 2610
triggerall = Name = "TSUK"
triggerall = statetype != A
triggerall = Var(41)
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || StateNo = [1000,2000)) && MoveContact || StateNo = [200,800) && Time <= 2 || StateNo = 1610 && Time >= 95
trigger1 = map(QCBQC) && (map(b_a) || map(b_b)) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Naked Sunday
[State -1, 2QCB,p]
type = ChangeState
value = 2700
triggerall = statetype != A
triggerall = Power >= 1000
triggerall = Name = "TSUK"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(QCBQC) && (map(b_x) || map(b_y)) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250 && Var(40) <= 1000

;---------------------------------------------------------------------------
; Unglued
[State -1, 2QCB,k]
type = ChangeState
value = 2600
triggerall = Name = "TSUK"
triggerall = statetype != A
triggerall = Power >= 2000 && !Var(41)
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(QCBQC) && map(b_ab) && !Var(15)

;---------------------------------------------------------------------------
; My Ultimate Move, the Raijin Break!
[State -1, 2QCB,2p]
type = ChangeState
value = 2400
triggerall = Name = "TSUX"
triggerall = statetype != A
triggerall = Power >= 3000
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || (StateNo = [200,800) || StateNo = [1200,1205]) && Time <= 2
trigger1 = map(QCBQC) && map(b_xy) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Feel My Power EX!
[State -1, 2QCF,2p]
type = ChangeState
value = 2300
triggerall = statetype != A
triggerall = Name != "TSUK"
triggerall = Power >= 2000 - 1000 * (StateNo = 2000)
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || (StateNo = [200,800) || StateNo = 2000) && Time <= 2
trigger1 = map(QCFQC) && map(b_xy) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 125

;---------------------------------------------------------------------------
; My Own Take on Exodus!
[State -1, 2QCF,k]
type = ChangeState
value = 2500
triggerall = Name != "TSUG"
triggerall = statetype != A
triggerall = Power >= 1000
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(QCFQC) && (map(b_a) || map(b_b)) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; I'm Not the Same Person I Once Was!
[State -1, 2QCB,k]
type = ChangeState
value = 2200
triggerall = Name != "TSUK"
triggerall = statetype != A
triggerall = Power >= 1000
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && Time <= 2 && PrevStateNo != [200,800) && Name = "TSUX" || StateNo = [200,800) && (MoveContact || Time <= 2) && Name = "TSUG"
trigger1 = map(QCBQC) && (map(b_a) || map(b_b)) && !Var(15)
trigger2 = Var(17) = 1300 && Var(15) && P2BodyDist X > 16 && Random < 100

;---------------------------------------------------------------------------
; To the Heavens You Go!
[State -1, 2QCF,k]
type = ChangeState
value = 2100
triggerall = Name = "TSUG"
triggerall = statetype != A
triggerall = Power >= 3000
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(QCFQC) && map(b_ab) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Feel My Power!
[State -1, 2QCF,p]
type = ChangeState
value = 2000
triggerall = statetype != A
triggerall = Power >= 1000
triggerall = Name != "TSUK"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(QCFx2) && (map(b_x) || map(b_y)) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;===========================================================================
;---------------------------------------------------------------------------
; OD
[State -1, Y+B]
type = ChangeState
value = 920
triggerall = statetype != A
triggerall = Name = "TSUK" && Var(40) >= 1000 && !Map(TsukOD) && !Var(41)
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveHit || StateNo = [200,800) && Time <= 2 && Var(51)
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = Var(17) = 100 && Var(15) && P2BodyDist X > 128 && Random < 250

;---------------------------------------------------------------------------
; Give It Your Best Shot!
[State -1, Y+B]
type = ChangeState
value = 910
triggerall = statetype != A
triggerall = Name = "TSUX"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveHit || StateNo = [200,800) && Time <= 2 && Var(51); || StateNo = [1000,1200) && MoveContact && !(StateNo=1105&&MoveGuarded); && (Var(5)>=4)
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = Var(17) = 900 && Var(15) && Random < 250 && (EnemyNear,MoveType != A && P2BodyDist X > 128 || EnemyNear,StateNo = [5100,5200))

;---------------------------------------------------------------------------
; F Duck and Weave
[State -1, Y+B]
type = ChangeState
value = 901
triggerall = statetype != A
triggerall = Name = "TSUG"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2 && Var(51) || StateNo = [1000,1300) && MoveContact && (Map(TsugStack)>=2 + 2 * !!MoveHit) && !(StateNo=1105&&MoveGuarded)
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && (map(p_Fd)>0) && !Var(15)
trigger2 = Var(17) = 100 && Var(15) && Random < 10 && EnemyNear,MoveType = A

;---------------------------------------------------------------------------
; B Duck and Weave
[State -1, Y+B]
type = ChangeState
value = 902
triggerall = statetype != A
triggerall = Name = "TSUG"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2 && Var(51) || StateNo = [1000,1300) && MoveContact && (Map(TsugStack)>=2 + 2 * !!MoveHit) && !(StateNo=1105&&MoveGuarded)
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && (map(p_Bk)>0) && !Var(15)
trigger2 = Var(17) = 100 && Var(15) && Random < 50 && EnemyNear,MoveType = A

;---------------------------------------------------------------------------
; N Duck and Weave
[State -1, Y+B]
type = ChangeState
value = 900
triggerall = statetype != A
triggerall = Name = "TSUG"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2 && Var(51) || StateNo = [1000,1300) && MoveContact && (Map(TsugStack)>=2 + 2 * !!MoveHit) && !(StateNo=1105&&MoveGuarded)
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = Var(17) = 100 && Var(15) && Random < 200 && EnemyNear,MoveType = A

;---------------------------------------------------------------------------
; Throw
[State -1, X+A]
type = ChangeState
value = ifelse(StateType=A,850,800)
;triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && Time <= 2 && PrevStateNo != [200,800) || StateNo = [600,800) && MoveHit
trigger1 = (map(b_x) && map(b_a) || map(b_xa)) && !Var(15)
trigger2 = Var(17) = 800 && Var(15) && (Random < 500 || Name != "TSUK")
trigger2 = P2BodyDist X = [-8,const(size.ground.front)] && StateType != A && EnemyNear,StateType != A || P2BodyDist X <= 40 && !numtarget(860) && StateType = A && EnemyNear,StateType = A

;===========================================================================
;---------------------------------------------------------------------------
; SK Fast As I Can
[State -1, 360,b]
type = ChangeState
value = 1600 + (Var(40)>=1000)
triggerall = statetype != A
triggerall = Name = "TSUK"
triggerall = ctrl || StateNo = 40 || StateNo = 55 || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && (MoveContact || Time <= 2) || StateNo = 1310 && Time <= 2
trigger1 = (map(HCB) || COMMAND = "HCB" || map(f360) || map(r360)) && map(b_b) && !Var(15)
trigger2 = Var(17) = 800 && Var(15) && Random < 250
trigger2 = P2BodyDist X = [-8,const(size.ground.front)] && StateType != A && EnemyNear,StateType != A || P2BodyDist X <= 40 && !numtarget(860) && StateType = A && EnemyNear,StateType = A


;---------------------------------------------------------------------------
; LK Fast As I Can
[State -1, 360,a]
type = ChangeState
value = 1600
triggerall = statetype != A
triggerall = Name = "TSUK"
triggerall = ctrl || StateNo = 40 || StateNo = 55 || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && (MoveContact || Time <= 2) || StateNo = 1310 && Time <= 2
trigger1 = (map(HCB) || COMMAND = "HCB" || map(f360) || map(r360)) && map(b_a) && !Var(15)
trigger2 = Var(17) = 800 && Var(15) && Random < 500
trigger2 = P2BodyDist X = [-8,const(size.ground.front)] && StateType != A && EnemyNear,StateType != A || P2BodyDist X <= 40 && !numtarget(860) && StateType = A && EnemyNear,StateType = A


;---------------------------------------------------------------------------
; Creep SK
[State -1, QCB,b]
type = ChangeState
value = 1501
triggerall = statetype != A
triggerall = Name = "TSUK"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = (map(p_Fd)>0) && map(b_ab) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 125

;---------------------------------------------------------------------------
; Creep LK
[State -1, QCB,a]
type = ChangeState
value = 1500
triggerall = statetype != A
triggerall = Name = "TSUK"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = (map(p_Bk)>0) && map(b_ab) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 50

;---------------------------------------------------------------------------
; Sour Girl SK
[State -1, DP,y]
type = ChangeState
value = 1401
triggerall = statetype != A
triggerall = Name = "TSUK"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(DD) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1300 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Sour Girl LK
[State -1, DP,x]
type = ChangeState
value = 1400
triggerall = statetype != A
triggerall = Name = "TSUK"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(DD) && map(b_x) && !Var(15)
trigger2 = (Var(17) = 1100 || Var(17) = 1300) && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Lounge Fly SP
[State -1, QCB,y]
type = ChangeState
value = 1321
triggerall = statetype != A
triggerall = Name = "TSUK"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(QCB) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 125

;---------------------------------------------------------------------------
; Lounge Fly LP
[State -1, QCB,x]
type = ChangeState
value = 1320
triggerall = statetype != A
triggerall = Name = "TSUK"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(QCB) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Big Empty SK
[State -1, QCF,b]
type = ChangeState
value = 1311
triggerall = statetype != A
triggerall = Name = "TSUK"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(QCF) && map(b_b) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 125

;---------------------------------------------------------------------------
; Big Empty LK
[State -1, QCF,a]
type = ChangeState
value = 1310
triggerall = statetype != A
triggerall = Name = "TSUK"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(QCF) && map(b_a) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Big Bang SP
[State -1, QCF,y]
type = ChangeState
value = 1301
triggerall = statetype != A
triggerall = Name = "TSUK"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(QCF) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 125

;---------------------------------------------------------------------------
; Big Bang LP
[State -1, QCF,x]
type = ChangeState
value = 1300
triggerall = statetype != A
triggerall = Name = "TSUK"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(QCF) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; SP I’ll Overwhelm You Until You Quit! 
[State -1, QCB,y]
type = ChangeState
value = 1205
triggerall = statetype != A
triggerall = Name != "TSUK"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(QCB) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; LP I’ll Overwhelm You Until You Quit! 
[State -1, QCB,x]
type = ChangeState
value = 1200
triggerall = statetype != A
triggerall = Name != "TSUK"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(QCB) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 125

;---------------------------------------------------------------------------
; I’ll Aim for Greater Heights!
[State -1, DP,y]
type = ChangeState
value = 1105
triggerall = statetype != A
triggerall = Name != "TSUK"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(DP) && map(b_y) && !Var(15)
trigger2 = (Var(17) = 410 || Var(17) = 1100) && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Going Up!
[State -1, DP,x]
type = ChangeState
value = 1100
triggerall = statetype != A
triggerall = Name != "TSUK"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(DP) && map(b_x) && !Var(15)
trigger2 = (Var(17) = 410 || Var(17) = 1600) && Var(15) && Random < 350 && EnemyNear,StateType != A

;---------------------------------------------------------------------------
; Not a Chance!
[State -1, QCF,a]
type = ChangeState
value = 1015
triggerall = Name = "TSUX"
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(QCF) && map(b_a) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 500 && EnemyNear,StateType != A
trigger3 = Var(17) = 1700 && Var(15) && Random < 125

;---------------------------------------------------------------------------
; Watch Your Step!
[State -1, QCF,b]
type = ChangeState
value = 1010
triggerall = Name = "TSUX"
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(QCF) && map(b_b) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 125

;---------------------------------------------------------------------------
; You Can’t Stop my Approach!
[State -1, QCF,y]
type = ChangeState
value = 1005
triggerall = statetype != A
triggerall = Name != "TSUK"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(QCF) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 125
trigger3 = Var(17) = 1300 && Var(15) && Random < 125

;---------------------------------------------------------------------------
; This'll Hurt!
[State -1, QCF,x]
type = ChangeState
value = 1000
triggerall = statetype != A
triggerall = Name != "TSUK"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(QCF) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 500 && EnemyNear,StateType != A
trigger3 = Var(17) = 1300 && Var(15) && Random < 250 && EnemyNear,StateType != A

;===========================================================================
;---------------------------------------------------------------------------
; CB f+LP
[State -1, st.f+LP]
type = ChangeState
value = 205 + (MoveHit=1&&!(map(p_Up)>0))
triggerall = statetype != A
triggerall = Name != "TSUK"
triggerall = StateNo != [205,206] && StateNo != 305 && StateNo != 415 && StateNo != 420
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(b_x) && (map(p_Fd)>0) && !(map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 205 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; CB df+SP
[State -1, cr.f+SP]
type = ChangeState
value = 415 + 5 * (Name!="TSUK")
triggerall = statetype != A
triggerall = StateNo != [205,206] && StateNo != 305 && StateNo != 415 && StateNo != 420
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(b_y) && (map(p_Fd)>0) && (map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 205 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; CB f+LK
[State -1, st.f+LK]
type = ChangeState
value = 305
triggerall = statetype != A
triggerall = Name = "TSUK"
triggerall = StateNo != [205,206] && StateNo != 305 && StateNo != 415 && StateNo != 420
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(b_a) && (map(p_Fd)>0) && !(map(p_Dn)>0) && !Var(15)
trigger2 = (Var(17) = 205 || Var(17) = 1700) && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Standing LP
[State -1, st.LP]
type = ChangeState
value = 200
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = 200 || StateNo = 300 || StateNo = 400 || StateNo = 500) && MoveContact && Map(LightChain)
trigger1 = (map(b_x) && StateNo != 400 && StateNo != 200 || map(b_x)) && !(map(p_Dn)>0) && !Var(15)
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
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = 200 || StateNo = 300 || StateNo = 400 || StateNo = 500) && MoveContact && Map(LightChain)
trigger1 = (map(b_x) && StateNo != 400 && StateNo != 200 || map(b_x)) && (map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 200 && Var(15) && Random < 500 && EnemyNear,StateType != A

;---------------------------------------------------------------------------
; Crouch SP
[State -1, cr.SP]
type = ChangeState
value = 410 + 20 * (Name="TSUK")
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = 200 || StateNo = 300 || StateNo = 400 || StateNo = 500) && MoveContact 
trigger1 = map(b_y) && (map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 410 && Var(15) && Random < 500

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
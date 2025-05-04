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

; moon doesnt shine
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
value = 102
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
[State -1, S.Jump]
Type = ChangeState
value = 55
triggerall = Ctrl || StateNo = 40 || StateNo = 100
triggerall = statetype != A
trigger1 = command = "DU" && !map(QCF) && !map(QCB) && !Var(15)
trigger2 = Var(17) = 55 && Var(15)

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
triggerall = (StateNo = [200,800) || StateNo = [900,1000) && StateNo != [970,971] || StateNo = [1100,1500) || StateNo = [1700,1800) || StateNo = 1900 || StateNo = [165,170)) && MoveHit || (StateNo = 960 || StateNo = [1000,1100) || StateNo = [1500,1700)) &&  (NumHelper(1010) || MoveType = I) && MoveHit || StateNo = 971 && Time >= 50
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
triggerall = StateNo != [800,900) && StateNo != [970,971] && !(StateNo = 1100 && Var(5)%2 && MoveGuarded)
triggerall = !MoveContact && !Var(51) || MoveGuarded
triggerall = StateNo != 960 && StateNo != [1000,1100) && StateNo != [1500,1700) && !Var(51) || (StateNo = 960 || StateNo = [1000,1100) || StateNo = [1500,1700)) && (NumHelper(1010) || MoveType = I) && MoveGuarded
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
triggerall = StateNo != 960 && StateNo != [1000,1100) && StateNo != [1500,1700) || (StateNo = 960 || StateNo = [1000,1100) || StateNo = [1500,1700)) && !MoveContact
triggerall = (ctrl || StateNo < 120) && !Var(51) || (StateNo = 960 || StateNo = [1000,1100) || StateNo = [1500,1700)) && (NumHelper(1010) || MoveType = I) && !MoveContact
trigger1 = map(b_a) && map(b_y) && map(b_x) && map(b_b) && !Var(15)
trigger2 = Var(17) = 3000 && Var(15)

;===========================================================================
;---------------------------------------------------------------------------
; Denjin Habjouken
[State -1, 2QCB,2p]
type = ChangeState
value = 2070
triggerall = statetype != A
triggerall = Name = "SHEX"
triggerall = Power >= 2000
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || StateNo = 167 || StateNo = 1400) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(QCBQC) && map(b_xy) && !Var(15)
trigger2 = (Var(17) = 1200 || Var(17) = 1300) && Var(15) && Random < 350

;---------------------------------------------------------------------------
; Stinky Hurricane Senpuukyaku
[State -1, 2QCB,k]
type = ChangeState
value = 2850 + 20 * (StateType=A)
triggerall = Name = "SHEX"
triggerall = Power >= 1000
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || StateNo = 167 || StateNo = 1400) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(QCBQC) && (map(b_a) || map(b_b)) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Shin Goku Messatsu
[State -1, SGS]
type = ChangeState
value = 2700
triggerall = Name = "SHEK"
triggerall = statetype != A
triggerall = Power >= 3000
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2 || StateNo = 205 && MoveType = A
trigger1 = map(SGS4) && !Var(15)
trigger2 = Var(17) = 800 && Var(15) && Random < 100
trigger2 = P2BodyDist X = [-8,const(size.ground.front)] && StateType != A && EnemyNear,StateType != A || P2BodyDist X <= 40 && !numtarget(860) && StateType = A && EnemyNear,StateType = A

;---------------------------------------------------------------------------
; Messatsu To All That Oppose Me Slash
[State -1, ddd+2p]
type = ChangeState
value = 2600
triggerall = Name = "SHEK"
triggerall = statetype != A
triggerall = Power >= 3000
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = (map(QCBQC) || command = "ddd") && map(b_xy) && !Var(15)
trigger2 = (Var(17) = 1100 || Var(17) = 1200 || Var(17) = 1300) && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Messatsu Reppa EX
[State -1, 2QCF,2k]
type = ChangeState
value = 2900
triggerall = statetype != A
triggerall = Name = "SHEK"
triggerall = Power >= 2000 - 1000 * (StateNo = 2800)
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || (StateNo = [200,800) || StateNo = 2800) && Time <= 2
trigger1 = map(QCFQC) && map(b_ab) && !Var(15)
trigger2 = (Var(17) = 1200 || Var(17) = 1300) && Var(15) && Random < 350

;---------------------------------------------------------------------------
; Messatsu Reppa
[State -1, 2QCF,k]
type = ChangeState
value = 2800
triggerall = statetype != A
triggerall = Name = "SHEK"
triggerall = Power >= 1000
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(QCFQC) && (map(b_a) || map(b_b)) && !Var(15)
trigger2 = (Var(17) = 1200 || Var(17) = 1300) && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Air Messatsu Habjouken
[State -1, j.2QCF,SP]
type = ChangeState
value = 2551
triggerall = Name = "SHEK"
triggerall = statetype = A
triggerall = Power >= 1000
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2 || StateNo = 950
trigger1 = map(QCFQC) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1000 && Var(15) && Random < 100

;---------------------------------------------------------------------------
; Air Messatsu Habjouken
[State -1, j.2QCF,LP]
type = ChangeState
value = 2550
triggerall = Name = "SHEK"
triggerall = statetype = A
triggerall = Power >= 1000
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2 || StateNo = 950
trigger1 = map(QCFQC) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1000 && Var(15) && Random < 100

;---------------------------------------------------------------------------
; I'm The Best!
[State -1, 2QCF,s]
type = ChangeState
value = 2400
triggerall = Name = "SHER"
triggerall = statetype != A
triggerall = Power >= 1000
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || StateNo = 167 || StateNo = 1400) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = (command = "start" || map(b_yb) || map(b_y) && map(b_b)) && (map(QCFQC) || map(QCBQC)) && !Var(15)

;---------------------------------------------------------------------------
; SHIN SHERMRYUKEN
[State -1, 2QCF,2k]
type = ChangeState
value = 2300
triggerall = statetype != A
triggerall = Name != "SHEK"
triggerall = Power >= 3000
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || StateNo = 167 || StateNo = 1400) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(QCFQC) && map(b_ab) && !Var(15)
trigger2 = (Var(17) = 1200 || Var(17) = 1300) && Var(15)

;---------------------------------------------------------------------------
; Shermkyugen Ougi EX
[State -1, 2QCB,2p]
type = ChangeState
value = 2200
triggerall = statetype != A
triggerall = Name = "SHER"
triggerall = Power >= 2000 - 1000 * (StateNo = 2100)
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || StateNo = 167 || StateNo = 1400) && MoveContact || (StateNo = [200,800) || StateNo = 2100) && Time <= 2
trigger1 = map(QCBQC) && map(b_xy) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Shermkyugen Ougi
[State -1, 2QCB,p]
type = ChangeState
value = 2100
triggerall = statetype != A
triggerall = Name = "SHER"
triggerall = Power >= 1000
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || StateNo = 167 || StateNo = 1400) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(QCBQC) && (map(b_x) || map(b_y)) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Stinky Habjouken
[State -1, 2QCF,p]
type = ChangeState
value = 2000 + (Name = "SHEK") * 500 + (Name = "SHEX") * 50
triggerall = statetype != A
triggerall = Power >= 1000
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || StateNo = 167 || StateNo = 1400) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(QCFx2) && (map(b_x) || map(b_y)) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;===========================================================================
;---------------------------------------------------------------------------
; Messatsu Flip
[State -1, Y+B]
type = ChangeState
value = 950
triggerall = Name = "SHEK"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Ultimate Chesto Punch
[State -1, Y+B]
type = ChangeState
value = 995
triggerall = Name = "SHEX"
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || StateNo = 167) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Evade, Then I'll Make a Joke!
[State -1, QCB,s]
type = ChangeState
value = 1401
triggerall = Name = "SHER"
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || StateNo = 167) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(QCB) && (command = "start" || map(b_yb)) && !Var(15)
trigger2 = (Var(17) = 1600 || Var(17) = 1700) && Var(15) && Random < 50

;---------------------------------------------------------------------------
; Sick Taunt!
[State -1, QCF,s]
type = ChangeState
value = 1400
triggerall = Name = "SHER"
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || StateNo = 167) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(QCF) && (command = "start" || map(b_yb)) && !Var(15)
trigger2 = (Var(17) = 1600 || Var(17) = 1700) && Var(15) && Random < 50

;---------------------------------------------------------------------------
; Just Keep Running!
[State -1, Y+B]
type = ChangeState
value = 900
triggerall = Name = "SHER"
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || StateNo = 167) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = (Var(17) = 1400 || Var(17) = 1700) && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Throw
[State -1, X+A]
type = ChangeState
value = ifelse(StateType=A,850,800)
;triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && Time <= 2 && PrevStateNo != [200,800) || StateNo = [600,800) && MoveHit
trigger1 = (map(b_x) && map(b_a) || map(b_xa)) && !Var(15)
trigger2 = Var(17) = 800 && Var(15)
trigger2 = P2BodyDist X = [-8,const(size.ground.front)] && StateType != A && EnemyNear,StateType != A || P2BodyDist X <= 40 && !numtarget(860) && StateType = A && EnemyNear,StateType = A

;===========================================================================
;---------------------------------------------------------------------------
; SK Jordan Shermtogeri
[State -1, HCF,b]
type = ChangeState
value = 1901
triggerall = Name = "SHEX"
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || StateNo = 167 || StateNo = 1400) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(HCF) && map(b_b) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; LK Jordan Shermtogeri
[State -1, HCF,a]
type = ChangeState
value = 1900
triggerall = Name = "SHEX"
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || StateNo = 167 || StateNo = 1400) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(HCF) && map(b_a) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; A-Sherm-Raw Warp B
[State -1, DP,2K]
type = ChangeState
value = 1801
triggerall = Name = "SHEK"
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(rDP) && map(b_ab) && !Var(15)
trigger2 = Var(17) = 105 && Var(15) && Random < 50

;---------------------------------------------------------------------------
; A-Sherm-Raw Warp F
[State -1, DP,2K]
type = ChangeState
value = 1800
triggerall = Name = "SHEK"
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(DP) && map(b_ab) && !Var(15)
trigger2 = Var(17) = 100 && Var(15) && Random < 50

;---------------------------------------------------------------------------
; SK Messatsu Hurricane Senpuukyakuu
[State -1, QCB,b]
type = ChangeState
value = 1701 + (StateType = A) * 50
triggerall = Name = "SHEK"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(QCB) && map(b_b) && !Var(15)
trigger3 = (Var(17) = 1200 || Var(17) = 1400) && Var(15) && Random < 500

;---------------------------------------------------------------------------
; LK Messatsu Hurricane Senpuukyakuu
[State -1, QCB,a]
type = ChangeState
value = 1700 + (StateType = A) * 50
triggerall = Name = "SHEK"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(QCB) && map(b_a) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; SP Messatsu Shermryuken
[State -1, DP,y]
type = ChangeState
value = 1101 + 2 * (StateType=A)
triggerall = Name != "SHER"
triggerall = statetype != A || Name = "SHEX"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(DP) && map(b_y) && !Var(15)
trigger2 = (Var(17) = 1100 || Var(17) = 1300) && Var(15) && Random < 500

;---------------------------------------------------------------------------
; LP Messatsu Shermryuken
[State -1, DP,x]
type = ChangeState
value = 1100 + 2 * (StateType=A)
triggerall = Name != "SHER"
triggerall = statetype != A || Name = "SHEX"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(DP) && map(b_x) && !Var(15)
trigger2 = (Var(17) = 1100 || Var(17) = 1300) && Var(15) && Random < 500

;---------------------------------------------------------------------------
; SP Double Messatsu Habjouken
[State -1, HCB,y]
type = ChangeState
value = 1601
triggerall = Name = "SHEK"
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
triggerall = !NumHelper(1010)
trigger1 = map(HCB) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1000 && Var(15) && Random < 100

;---------------------------------------------------------------------------
; LP Double Messatsu Habjouken
[State -1, HCB,x]
type = ChangeState
value = 1600
triggerall = Name = "SHEK"
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
triggerall = !NumHelper(1010)
trigger1 = map(HCB) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1000 && Var(15) && Random < 100

;---------------------------------------------------------------------------
; SP Messatsu Habjouken
[State -1, QCF,y]
type = ChangeState
value = 1501 + (StateType = A) * 50 + (Name = "SHEX" && StateType = A) * 20
triggerall = Name = "SHEK" || Name = "SHEX"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
triggerall = !NumHelper(1010)
trigger1 = map(QCF) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1000 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; LP Messatsu Habjouken
[State -1, QCF,x]
type = ChangeState
value = 1500 + (StateType = A) * 50 + (Name = "SHEX" && StateType = A) * 20
triggerall = Name = "SHEK" || Name = "SHEX"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
triggerall = !NumHelper(1010)
trigger1 = map(QCF) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1000 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; SK Power Punch
[State -1, ChDU,b]
type = ChangeState
value = 1301
triggerall = Name = "SHER"
triggerall = statetype != A
triggerall = ctrl || StateNo = 40 || StateNo = 55 || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || StateNo = 167 || StateNo = 1400) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(b_b) && !Var(15)
trigger1 = Var(44) >= 24 && ((map(p_Up)>0) || command = "up")
trigger2 = (Var(17) = 1600 || Var(17) = 1700) && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LK Power Punch
[State -1, ChDU,a]
type = ChangeState
value = 1300
triggerall = Name = "SHER"
triggerall = statetype != A
triggerall = ctrl || StateNo = 40 || StateNo = 55 || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || StateNo = 167 || StateNo = 1400) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(b_a) && !Var(15)
trigger1 = Var(44) >= 24 && ((map(p_Up)>0) || command = "up")
trigger2 = (Var(17) = 1600 || Var(17) = 1700) && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SP Shermyuken
[State -1, ChDU,y]
type = ChangeState
value = 1101
triggerall = Name = "SHER"
triggerall = statetype != A
triggerall = ctrl || StateNo = 40 || StateNo = 55 || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || StateNo = 167 || StateNo = 1400) && MoveContact || StateNo = [200,800) && Time <= 2 || StateNo = 1105 && PrevStateNo = 930 && MoveHit
trigger1 = map(b_y) && !Var(15)
trigger1 = Var(44) >= 24 && ((map(p_Up)>0) || command = "up")
trigger2 = (Var(17) = 1100 || Var(17) = 1300) && Var(15) && Random < 500

;---------------------------------------------------------------------------
; LP Shermyuken
[State -1, ChDU,x]
type = ChangeState
value = 1100
triggerall = Name = "SHER"
triggerall = statetype != A
triggerall = ctrl || StateNo = 40 || StateNo = 55 || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || StateNo = 167 || StateNo = 1400) && MoveContact || StateNo = [200,800) && Time <= 2 || StateNo = 1105 && PrevStateNo = 930 && MoveHit
trigger1 = map(b_x) && !Var(15)
trigger1 = Var(44) >= 24 && ((map(p_Up)>0) || command = "up")
trigger2 = (Var(17) = 1100 || Var(17) = 1300) && Var(15) && Random < 500

;---------------------------------------------------------------------------
; SK Hurricane Senpuukyakuu
[State -1, QCB,b]
type = ChangeState
value = 1201 + 2 * (StateType = A)
triggerall = Name != "SHEK"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || StateNo = 167 || StateNo = 1400) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = Var(17) = 1201 && Var(15)
trigger2 = map(QCB) && map(b_b) && !Var(15)
trigger3 = (Var(17) = 1200 || Var(17) = 1400) && Var(15) && Random < 500

;---------------------------------------------------------------------------
; LK Hurricane Senpuukyakuu
[State -1, QCB,a]
type = ChangeState
value = 1200 + 2 * (StateType = A)
triggerall = Name != "SHEK"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || StateNo = 167 || StateNo = 1400) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = Var(17) = 1200 && Var(15)
trigger2 = map(QCB) && map(b_a) && !Var(15)
trigger3 = (Var(17) = 1200 || Var(17) = 1400) && Var(15) && Random < 500

;---------------------------------------------------------------------------
; SP Habjouken
[State -1, ChBF,y]
type = ChangeState
value = 1001
triggerall = Name = "SHER"
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || StateNo = 167 || StateNo = 1400) && MoveContact || StateNo = [200,800) && Time <= 2
triggerall = !NumHelper(1010)
trigger1 = map(b_y) && !Var(15)
trigger1 = Var(40) >= 24 && P2Dist X >= 0 && Facing = 1 && (((map(p_Fd)>0) && P2Dist X >= 0) || ((map(p_Bk)>0) && P2Dist X < 0))
trigger2 = map(b_y) && !Var(15)
trigger2 = Var(42) >= 24 && P2Dist X >= 0 && Facing = -1 && (((map(p_Fd)>0) && P2Dist X >= 0) || ((map(p_Bk)>0) && P2Dist X < 0))
trigger3 = Var(17) = 1000 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; LP Habjouken
[State -1, ChBF,x]
type = ChangeState
value = 1000
triggerall = Name = "SHER"
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || StateNo = 167 || StateNo = 1400) && MoveContact || StateNo = [200,800) && Time <= 2
triggerall = !NumHelper(1010)
trigger1 = map(b_x) && !Var(15)
trigger1 = Var(40) >= 24 && P2Dist X >= 0 && Facing = 1 && (((map(p_Fd)>0) && P2Dist X >= 0) || ((map(p_Bk)>0) && P2Dist X < 0))
trigger2 = map(b_x) && !Var(15)
trigger2 = Var(42) >= 24 && P2Dist X >= 0 && Facing = -1 && (((map(p_Fd)>0) && P2Dist X >= 0) || ((map(p_Bk)>0) && P2Dist X < 0))
trigger3 = Var(17) = 1000 && Var(15) && Random < 500

;===========================================================================
;---------------------------------------------------------------------------
; CN f+SK
[State -1, f+SK]
type = ChangeState
value = ifelse(map(p_Bk)>0,316,315)
triggerall = Name != "SHEK"
triggerall = statetype != A
triggerall = StateNo != [205,206] && StateNo != 315 && StateNo != 505
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(b_b) && ((map(p_Bk)>0) || (map(p_Fd)>0)) && !(map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 205 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; CN f+LP
[State -1, st.f+LP]
type = ChangeState
value = 205 + (MoveHit=1&&!map(p_Up))
triggerall = statetype != A
triggerall = StateNo != [205,206] && StateNo != 315 && StateNo != 505
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(b_x) && (map(p_Fd)>0) && !(map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 205 && Var(15) && Random < 500
trigger3 = Var(17) = 1700 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; CN db+SK
[State -1, db+SK]
type = ChangeState
value = 505
;triggerall = Name = "SHER"
triggerall = statetype != A
triggerall = StateNo != [205,206] && StateNo != 315 && StateNo != 505
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(b_b) && (map(p_Bk)>0) && (map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 205 && Var(15) && Random < 500 && EnemyNear,StateType != A
trigger3 = Var(17) = 1700 && Var(15) && Random < 250

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
; ju.Taunt
[State -1, ju.Taunt]
type = ChangeState
value = 169
triggerall = Name = "SHER"
triggerall = statetype = A
triggerall = ctrl || stateno = 169 && time > 1
trigger1 = command = "start" && !Var(15)
trigger2 = Var(17) = 169 && Var(15)

;---------------------------------------------------------------------------
; Taunt
[State -1, Taunt]
type = ChangeState
value = ifelse(Name="SHEK",168,ifelse((map(p_Fd)>0),167,165 + random%2))
;triggerall = Name = "SHER"
triggerall = statetype != A
triggerall = ctrl || StateNo = [200,800) && MoveContact && Name != "SHEK"
trigger1 = command = "start" && !Var(15)
trigger2 = Var(17) = 165 && Var(15)
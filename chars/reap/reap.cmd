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

; dont misunderstand me, im not getting soft
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
[State 0, Chianable Reset]
type = MapSet
trigger1 = 1
map = "CmdChain"
value = ctrl
[State 0, Chianable Check]
type = MapSet
trigger1 = StateNo = [200,800) && StateNo != 510 && !(StateNo = 520 && AnimElemNo(1)>=7) && MoveContact
trigger2 = StateNo = [200,800) && Time <= 2
map = "CmdChain"
value = 1

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
value = 102 - 2 * (Name="REAK"&&Var(41)>=1000)
triggerall = statetype = S || statetype = C && Var(15) || StateType = C && Name = "REAK" && StateNo = [200,600)
triggerall = ctrl || MoveContact && Name = "REAK"
trigger1 = ctrl
trigger1 = (command="FF" || map(b_66)) && p2dist x >= -8 && !Var(15) || (command="BB" || map(b_44)) && p2dist x < -8 && !Var(15)
trigger2 = Name = "REAK"
trigger2 = MoveContact && (StateNo = [200,800) || StateNo = [1300,2000) && MoveType = I)
trigger2 = (command="FF" || map(b_66)) && p2dist x >= -8 && !Var(15) || (command="BB" || map(b_44)) && p2dist x < -8 && !Var(15)
trigger2 = Var(41) >= 1000 + 1000 * !!(MoveContact) + 1000 * !!(MoveHit)
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
; AirDash Fwd
[State -1, AirDash Fwd]
type = ChangeState
value = 110 + (Name="REAK"&&Var(41)>=1000)
triggerall = statetype = A
triggerall = !(StateNo = 50 && NumHelper(56))
triggerall = ctrl || MoveContact && Name = "REAK"
trigger1 = ctrl && stateno != [110,115] || StateNo = 931 && Time
trigger1 = Vel Y >= -1 || Time >= 10
trigger1 = Var(1) || StateNo = 931
trigger1 = (command="FF" || map(b_66)) && !Var(15)
trigger2 = Name = "REAK"
trigger2 = MoveContact && (StateNo = [600,800) || StateNo = [1300,2000) && MoveType = I)
trigger2 = (command="FF" || map(b_66)) && !Var(15)
trigger2 = Var(41) >= 1000 + 1000 * !!(MoveContact) + 1000 * !!(MoveHit)
trigger3 = Var(17) = 100 && Var(15)

;---------------------------------------------------------------------------
; AirDash Back
[State -1, AirDash Back]
type = ChangeState
value = 115
triggerall = ctrl && stateno != [110,115] || StateNo = 931 && Time
triggerall = Vel Y >= -1 || Time >= 10
triggerall = statetype = A
triggerall = Var(1) || StateNo = 931
triggerall = !(StateNo = 50 && NumHelper(56))
trigger1 = (command="BB" || map(b_44)) && !Var(15)
trigger2 = Var(17) = 105 && Var(15)

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
value = ifelse(StateType=A,45,40)
triggerall = Ctrl || StateNo = 100
triggerall = statetype != A || statetype = A && Var(1)
trigger1 = StateNo >= 200
trigger1 = ctrl && command = "up"
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
triggerall = (StateNo = [200,800) || StateNo = [1000,1110] || StateNo = [1300,1400)) && MoveHit || StateNo = 900 && AnimElem = 3, >= 0 && MoveHit || StateNo = 921 && AnimElem = 4, >= 1 && MoveHit || StateNo = 1130 && AnimElem = 18, >= 1 || StateNo = 1200 && (NumHelper(1210) || MoveType = I) && MoveHit || StateNo = 1400 && (NumHelper(1410) || MoveType = I) && MoveHit || StateNo = 1500 && (NumHelper(1510) || MoveType = I) && MoveHit || StateNo = 1600 && (NumHelper(1610) || MoveType = I) && MoveHit
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
triggerall = StateNo != [800,900)
triggerall = !MoveContact && !Var(51) || MoveGuarded
triggerall = StateNo != [920,921] && StateNo != [1200,1300) && StateNo != [1400,1700) && !Var(51) || StateNo = 900 && AnimElem = 3, >= 0 && MoveGuarded || StateNo = 921 && AnimElem = 4, >= 1 && MoveGuarded || StateNo = 1200 && (NumHelper(1210) || MoveType = I) && MoveGuarded || StateNo = 1400 && (NumHelper(1410) || MoveType = I) && MoveGuarded || StateNo = 1500 && (NumHelper(1510) || MoveType = I) && MoveGuarded || StateNo = 1600 && (NumHelper(1610) || MoveType = I) && MoveGuarded
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
triggerall = (ctrl || StateNo < 120) && !Var(51) || StateNo = 900 && AnimElem = 3, >= 0 && !MoveContact || StateNo = 921 && AnimElem = 4, >= 1 && !MoveContact || StateNo = 1200 && (NumHelper(1210) || MoveType = I) && !MoveContact || StateNo = 1400 && (NumHelper(1410) || MoveType = I) && !MoveContact || StateNo = 1500 && (NumHelper(1510) || MoveType = I) && !MoveContact || StateNo = 1600 && (NumHelper(1610) || MoveType = I) && !MoveContact
trigger1 = map(b_a) && map(b_y) && map(b_x) && map(b_b) && !Var(15)
trigger2 = Var(17) = 3000 && Var(15)

;===========================================================================
;---------------------------------------------------------------------------
; Galactic_Orbit
[State -1, 2QCB,2p]
type = ChangeState
value = 2400
triggerall = statetype != A
triggerall = Name = "REAK"
triggerall = Power >= 3000
triggerall = !NumHelper(2410)
triggerall = Map(CmdChain)
trigger1 = map(QCBQC) && map(b_xy) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Emergency_Nova
[State -1, 2QCF,k]
type = ChangeState
value = 2200
triggerall = statetype != A
triggerall = Power >= 1000
triggerall = Map(CmdChain)
trigger1 = map(QCFQC) && (map(b_a) || map(b_b)) && !Var(15)
trigger2 = Var(17) = 1300 && Var(15) && Random < 350

;---------------------------------------------------------------------------
; Saturns_Belt
[State -1, 2QCB,2p]
type = ChangeState
value = 2500 + 100 * (Name="REAX")
triggerall = statetype != A
triggerall = Name != "REAK"
triggerall = Power >= 3000
triggerall = Map(CmdChain)
trigger1 = map(QCBQC) && map(b_xy) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 350

;---------------------------------------------------------------------------
; Final_Twin_Alignment EX
[State -1, 2QCF,2p]
type = ChangeState
value = 2350
triggerall = Name = "REAX"
triggerall = StateType != A
triggerall = Power >= 2000 - 1000 * (StateNo = 2300)
triggerall = Map(CmdChain) || StateNo = 2350 && Time <= 2
trigger1 = map(QCFQC) && map(b_x) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1000 && Var(15) && Random < 100
trigger3 = Var(17) = 1200 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Final_Twin_Alignment
[State -1, 2QCF,p]
type = ChangeState
value = 2300 + 5 * (StateType=A)
triggerall = Name = "REAX"
triggerall = Power >= 1000
triggerall = Map(CmdChain)
trigger1 = map(QCFQC) && (map(b_x) || map(b_y)) && !Var(15)
trigger2 = Var(17) = 1000 && Var(15) && Random < 125
trigger3 = Var(17) = 1200 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Cosmic_Divider EX
[State -1, 2QCF,2p]
type = ChangeState
value = 2100 + 50 * (Name="REAK")
triggerall = statetype != A && Name != "REAX"
triggerall = Power >= 2000 - 1000 * (StateNo = 2000 || StateNo = 2050)
triggerall = Map(CmdChain) || (StateNo = 2000 || StateNo = 2050) && Time <= 2
trigger1 = map(QCFQC) && map(b_xy) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Cosmic_Divider
[State -1, 2QCF,p]
type = ChangeState
value = 2000 + 50 * (Name="REAK")
triggerall = statetype != A && Name != "REAX"
triggerall = Power >= 1000
triggerall = Map(CmdChain)
trigger1 = map(QCFQC) && (map(b_x) || map(b_y)) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;===========================================================================
;---------------------------------------------------------------------------
; Void_Drifter
[State -1, Y+B]
type = ChangeState
value = 930 + (StateType=A)
triggerall = Map(CmdChain) || StateNo = 40 || StateNo = [1300,2000) && MoveType = I && MoveContact
triggerall = Name = "REAK"
triggerall = StateNo != [800,1000) && PrevStateNo != 931
triggerall = Var(41) >= 1000 + 1000 * !!(MoveContact) + 1000 * !!(MoveHit)
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = Var(17) = 40 && Var(15) && Random < 100

;---------------------------------------------------------------------------
; Stardust_Firewall
[State -1, f.Y+B]
type = ChangeState
value = 921
triggerall = Map(CmdChain) || (StateNo = 1300 || StateNo = 1310) && MoveContact
triggerall = Name = "REAX"
triggerall = Map(ReapAltAirAction)
triggerall = NumHelper(920)
triggerall = StateNo != 920 && !(PrevStateNo=920&&StateType=A)
triggerall = !NumHelper(940)
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && map(p_Fd)>0 && !Var(15)
trigger2 = Var(17) = 1000 && Var(15) && Random < 100

;---------------------------------------------------------------------------
; Grav_Spinner
[State -1, b.Y+B]
type = ChangeState
value = 922
triggerall = Map(CmdChain) || (StateNo = 1300 || StateNo = 1310) && MoveContact
triggerall = Name = "REAX"
triggerall = Map(ReapAltAirAction)
triggerall = NumHelper(920) + NumHelper(921) + NumHelper(922) = 3
triggerall = StateNo != 920 && !(PrevStateNo=920&&StateType=A)
triggerall = StateNo != 1400
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = Var(17) = 900 && Var(15) && Random < 150

;---------------------------------------------------------------------------
; Booster_Deploy
[State -1, Y+B]
type = ChangeState
value = 920
triggerall = Map(CmdChain) || (StateNo = 1300 || StateNo = 1310) && MoveContact
triggerall = Name = "REAX"
triggerall = Map(ReapAltAirAction)
triggerall = NumHelper(920) + NumHelper(921) + NumHelper(922) < 3
triggerall = StateNo != 920 && !(PrevStateNo=920&&StateType=A)
triggerall = !NumHelper(940) && !NumHelper(945)
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = Var(17) = 900 && Var(15) && Random < 500
trigger3 = (Var(17) = 900 || Var(17) = 1000 || Var(17) = 1700) && Random < Map(ReaxBuffer) * 250

;---------------------------------------------------------------------------
; Solar_Deploy
[State -1, Y+B]
type = ChangeState
value = 900 + (!!NumHelper(905))
triggerall = Map(CmdChain)
triggerall = Name = "REAP"
triggerall = Map(ReapAltAirAction)
triggerall = !Map(ReapSateBusy)
triggerall = NumHelper(905) || Map(ReapTimer) = 1.0
triggerall = StateNo != 900 && !(PrevStateNo=900&&StateType=A)
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = Var(17) = 900 && Var(15) && Random < 500
trigger3 = (Var(17) = 900 || Var(17) = 1000 || Var(17) = 1700) && Var(18) < 2000 && !NumHelper(905)
trigger4 = (Var(17) = 900 || Var(17) = 1000 || Var(17) = 1700) && Var(40) <= 1 && NumHelper(905)

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
; SK Asteroid_Obliterator
[State -1, QCF,b]
type = ChangeState
value = 1601
triggerall = statetype != A || statetype = A && Map(ReapAltAirAction)
triggerall = Name = "REAK"
triggerall = !NumHelper(1610)
triggerall = Map(CmdChain)
trigger1 = map(QCF) && map(b_b) && !Var(15)
trigger2 = (Var(17) = 900 || Var(17) = 1700) && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LK Asteroid_Obliterator
[State -1, QCF,a]
type = ChangeState
value = 1600
triggerall = statetype != A || statetype = A && Map(ReapAltAirAction)
triggerall = Name = "REAK"
triggerall = !NumHelper(1610)
triggerall = Map(CmdChain)
trigger1 = map(QCF) && map(b_a) && !Var(15)
trigger2 = (Var(17) = 900 || Var(17) = 1700) && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SP Shooting_Star
[State -1, QCB,y]
type = ChangeState
value = 1501
triggerall = statetype != A || statetype = A && Map(ReapAltAirAction)
triggerall = Name = "REAX"
triggerall = !NumHelper(1510)
triggerall = Map(CmdChain)
triggerall = NumHelper(920)
trigger1 = map(QCB) && map(b_y) && !Var(15)
trigger2 = (Var(17) = 900 || Var(17) = 1000) && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LP Shooting_Star
[State -1, QCB,x]
type = ChangeState
value = 1500
triggerall = statetype != A || statetype = A && Map(ReapAltAirAction)
triggerall = Name = "REAX"
triggerall = !NumHelper(1510)
triggerall = Map(CmdChain)
triggerall = NumHelper(920)
trigger1 = map(QCB) && map(b_x) && !Var(15)
trigger2 = (Var(17) = 900 || Var(17) = 1000) && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SP Nebula_Storm
[State -1, QCB,y]
type = ChangeState
value = 1101
triggerall = StateType != A
triggerall = Var(18) >= 500 && Name = "REAP" || Name = "REAK"
triggerall = Map(CmdChain) || StateNo = 1600 && MoveType = I
trigger1 = map(QCB) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 100 && Name = "REAP"

;---------------------------------------------------------------------------
; LP Nebula_Storm
[State -1, QCB,x]
type = ChangeState
value = 1100
triggerall = StateType != A
triggerall = Var(18) >= 500 && Name = "REAP" || Name = "REAK"
triggerall = Map(CmdChain); || StateNo = 1600 && MoveType = I
trigger1 = map(QCB) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 350

;---------------------------------------------------------------------------
; SK Star_Crossed_Snipe
[State -1, QCF,b]
type = ChangeState
value = 1403
triggerall = statetype != A || statetype = A && Map(ReapAltAirAction)
triggerall = !(statetype = A && Vel Y < const(velocity.jump.y)*0.125) || MoveContact
triggerall = Name = "REAX"
triggerall = Map(CmdChain)
triggerall = NumHelper(920) && !NumHelper(1415)
trigger1 = map(QCF) && map(b_b) && !Var(15)
trigger2 = (Var(17) = 900 || Var(17) = 1000) && Var(15) && Random < 250
trigger2 = P2BodyDist X > 128

;---------------------------------------------------------------------------
; SP Star_Crossed_Snipe
[State -1, QCF,y]
type = ChangeState
value = 1402
triggerall = statetype != A || statetype = A && Map(ReapAltAirAction)
triggerall = !(statetype = A && Vel Y < const(velocity.jump.y)*0.25) || MoveContact
triggerall = Name = "REAX"
triggerall = Map(CmdChain)
triggerall = NumHelper(920) && !NumHelper(1415)
trigger1 = map(QCF) && map(b_y) && !Var(15)
trigger2 = (Var(17) = 900 || Var(17) = 1000) && Var(15) && Random < 250
trigger2 = P2BodyDist X = [96,128]

;---------------------------------------------------------------------------
; LK Star_Crossed_Snipe
[State -1, QCF,a]
type = ChangeState
value = 1401
triggerall = statetype != A || statetype = A && Map(ReapAltAirAction)
triggerall = !(statetype = A && Vel Y < const(velocity.jump.y)*0.25) || MoveContact
triggerall = Name = "REAX"
triggerall = Map(CmdChain)
triggerall = NumHelper(920) && !NumHelper(1415)
trigger1 = map(QCF) && map(b_a) && !Var(15)
trigger2 = (Var(17) = 900 || Var(17) = 1000) && Var(15) && Random < 250
trigger2 = P2BodyDist X = [64,96]

;---------------------------------------------------------------------------
; LP Star_Crossed_Snipe
[State -1, QCF,x]
type = ChangeState
value = 1400
triggerall = statetype != A || statetype = A && Map(ReapAltAirAction)
triggerall = !(statetype = A && Vel Y < const(velocity.jump.y)*0.25) || MoveContact
triggerall = Name = "REAX"
triggerall = Map(CmdChain)
triggerall = NumHelper(920) && !NumHelper(1415)
trigger1 = map(QCF) && map(b_x) && !Var(15)
trigger2 = (Var(17) = 900 || Var(17) = 1000) && Var(15) && Random < 250
trigger2 = P2BodyDist X < 64

;---------------------------------------------------------------------------
; SP Star_Crossed
[State -1, QCF,y]
type = ChangeState
value = 1001 + 10 * (StateType=A) + 700 * (Name="REAK")
triggerall = statetype != A || statetype = A && Map(ReapAltAirAction)
triggerall = !(statetype = A && Vel Y < const(velocity.jump.y)*0.25) || MoveContact
triggerall = Var(18) >= 500 && Name = "REAP" || Name = "REAK"
triggerall = Map(CmdChain)
trigger1 = map(QCF) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1000 && Var(15) && Random < 350 && Name = "REAP"
trigger3 = Var(17) = 1600 && Var(15) && Random < 500 && Name = "REAK"

;---------------------------------------------------------------------------
; LP Star_Crossed
[State -1, QCF,x]
type = ChangeState
value = 1000 + 10 * (StateType=A) + 700 * (Name="REAK")
triggerall = statetype != A || statetype = A && Map(ReapAltAirAction)
triggerall = !(statetype = A && Vel Y < const(velocity.jump.y)*0.125) || MoveContact
triggerall = Var(18) >= 500 && Name = "REAP" || Name = "REAK"
triggerall = Map(CmdChain)
trigger1 = map(QCF) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1000 && Var(15) && Random < 350 && Name = "REAP"
trigger3 = Var(17) = 1700 && Var(15) && Random < 500 && Name = "REAK"

;---------------------------------------------------------------------------
; SK Meteor_Strike
[State -1, QCB,b]
type = ChangeState
value = 1301 + 10 * (StateType=A)
triggerall = statetype != A || statetype = A && Map(ReapAltAirAction)
triggerall = !(statetype = A && Vel Y < const(velocity.jump.y)*0.125) || MoveContact
triggerall = Map(CmdChain)
trigger1 = map(QCB) && map(b_b) && !Var(15)
trigger2 = (Var(17) = 1600 || Var(17) = 1700) && Var(15) && Random < 500 && StateType = A
trigger3 = Var(17) = 1200 && Var(15) && Random < 500 && StateType != A

;---------------------------------------------------------------------------
; LK Meteor_Strike
[State -1, QCB,a]
type = ChangeState
value = 1300 + 10 * (StateType=A)
triggerall = statetype != A || statetype = A && Map(ReapAltAirAction)
triggerall = !(statetype = A && Vel Y < const(velocity.jump.y)*0.125) || MoveContact
triggerall = Map(CmdChain)
trigger1 = map(QCB) && map(b_a) && !Var(15)
trigger2 = (Var(17) = 1600 || Var(17) = 1700) && Var(15) && Random < 500 && StateType = A
trigger3 = Var(17) = 1200 && Var(15) && Random < 500 && StateType != A

;---------------------------------------------------------------------------
; Det Satellite_Colony
[State -1, DD,any]
type = ChangeState
value = 1205
triggerall = statetype != A || statetype = A && Map(ReapAltAirAction)
triggerall = Map(CmdChain)
triggerall = Name = "REAP"
triggerall = Map(ReapMineReady)
trigger1 = map(DD) && (map(b_x) || map(b_y) || map(b_a) || map(b_b)) && !Var(15)

;---------------------------------------------------------------------------
; SK Satellite_Colony
[State -1, DD,b]
type = ChangeState
value = 1203
triggerall = statetype != A || statetype = A && Map(ReapAltAirAction)
triggerall = Map(CmdChain)
triggerall = Name = "REAP"
triggerall = !NumHelper(1210)
triggerall = Var(18) >= 500
trigger1 = map(DD) && map(b_b) && !Var(15)
trigger2 = (Var(17) = 900 || Var(17) = 1000) && Var(15) && Random < 250
trigger2 = P2BodyDist X > 128

;---------------------------------------------------------------------------
; SP Satellite_Colony
[State -1, DD,y]
type = ChangeState
value = 1202
triggerall = statetype != A || statetype = A && Map(ReapAltAirAction)
triggerall = Map(CmdChain)
triggerall = Name = "REAP"
triggerall = !NumHelper(1210)
triggerall = Var(18) >= 500
trigger1 = map(DD) && map(b_y) && !Var(15)
trigger2 = (Var(17) = 900 || Var(17) = 1000) && Var(15) && Random < 250
trigger2 = P2BodyDist X = [96,128]

;---------------------------------------------------------------------------
; LK Satellite_Colony
[State -1, DD,a]
type = ChangeState
value = 1201
triggerall = statetype != A || statetype = A && Map(ReapAltAirAction)
triggerall = Map(CmdChain)
triggerall = Name = "REAP"
triggerall = !NumHelper(1210)
triggerall = Var(18) >= 500
trigger1 = map(DD) && map(b_a) && !Var(15)
trigger2 = (Var(17) = 900 || Var(17) = 1000) && Var(15) && Random < 250
trigger2 = P2BodyDist X = [64,96]

;---------------------------------------------------------------------------
; LP Satellite_Colony
[State -1, DD,x]
type = ChangeState
value = 1200
triggerall = statetype != A || statetype = A && Map(ReapAltAirAction)
triggerall = Map(CmdChain)
triggerall = Name = "REAP"
triggerall = !NumHelper(1210)
triggerall = Var(18) >= 500
trigger1 = map(DD) && map(b_x) && !Var(15)
trigger2 = (Var(17) = 900 || Var(17) = 1000) && Var(15) && Random < 250
trigger2 = P2BodyDist X < 64

;===========================================================================
;---------------------------------------------------------------------------
; CN f+SP
[State -1, st.f+SP]
type = ChangeState
value = 225
triggerall = statetype != A
triggerall = StateNo != 215 && StateNo != 225 && StateNo != 205 && StateNo != 615
triggerall = Map(CmdChain)
triggerall = Name != "REAK"
trigger1 = map(b_y) && (map(p_Fd)>0) && !(map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 205 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; CN f+LP
[State -1, st.f+LP]
type = ChangeState
value = 215 + (MoveHit=1&&!(map(p_Up)>0))
triggerall = statetype != A
triggerall = StateNo != 215 && StateNo != 225 && StateNo != 205 && StateNo != 615
triggerall = Map(CmdChain)
trigger1 = map(b_x) && (map(p_Fd)>0) && !(map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 205 && Var(15) && Random < 500 && P2BodyDist X < 48

;---------------------------------------------------------------------------
; CN b+SP
[State -1, st.b+SP]
type = ChangeState
value = 205
triggerall = statetype != A
triggerall = StateNo != 215 && StateNo != 225 && StateNo != 205 && StateNo != 615
triggerall = Map(CmdChain)
triggerall = Name = "REAK"
trigger1 = map(b_y) && (map(p_Bk)>0) && !(map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 1100 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; CN ju.d+SP
[State -1, ju.d+SP]
type = ChangeState
value = 615 - 10 * (Name="REAK")
triggerall = statetype = A
triggerall = StateNo != 215 && StateNo != 225 && StateNo != 205 && StateNo != 605 && StateNo != 615
triggerall = Map(CmdChain)
trigger1 = map(b_y) && (map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 205 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Standing LP
[State -1, st.LP]
type = ChangeState
value = 200
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = 300 || StateNo = 320 || StateNo = 400 || StateNo = 500) && MoveContact && Map(LightChain)
trigger1 = map(b_x) && !(map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 200 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Standing HP
[State -1, st.HP]
type = ChangeState
value = 210 + 10 * (Name="REAK")
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = 200 || StateNo = 300 || StateNo = 320 || StateNo = 400 || StateNo = 500) && MoveContact 
trigger1 = map(b_y) && !(map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 210 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Standing LK
[State -1, st.LK]
type = ChangeState
value = 300 + 20 * (Name="REAK")
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
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = 200 || StateNo = 300 || StateNo = 320 || StateNo = 400 || StateNo = 500) && MoveContact 
trigger1 = map(b_b) && !(map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 210 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Crouch LP
[State -1, cr.LP]
type = ChangeState
value = 400
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = 200 || StateNo = 300 || StateNo = 320 || StateNo = 500) && MoveContact && Map(LightChain)
trigger1 = map(b_x) && (map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 200 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Crouch SP
[State -1, cr.SP]
type = ChangeState
value = 410 + 10 * (Name="REAK")
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = 200 || StateNo = 300 || StateNo = 320 || StateNo = 400 || StateNo = 500) && MoveContact 
trigger1 = map(b_y) && (map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 210 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Crouch LK
[State -1, cr.LK]
type = ChangeState
value = 500
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = 200 || StateNo = 300 || StateNo = 320 || StateNo = 400) && MoveContact && Map(LightChain)
trigger1 = map(b_a) && (map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 200 && Var(15) && Random < 500 && EnemyNear,StateType = S

;---------------------------------------------------------------------------
; Crouch SK
[State -1, cr.SK]
type = ChangeState
value = 520 - 10 * (Name="REAK")
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = 200 || StateNo = 300 || StateNo = 320 || StateNo = 400 || StateNo = 500) && MoveContact 
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
value = 610 + 10 * (Name="REAK")
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
; Taunt
[State -1, Taunt]
type = ChangeState
value = 165
triggerall = statetype != A
triggerall = ctrl
trigger1 = command = "s" && !Var(15)
trigger2 = Var(17) = 165 && Var(15)
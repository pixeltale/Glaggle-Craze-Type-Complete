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

; capture the beliefs of another god's world
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
;Run Fwd
[State -1, Run Fwd]
type = ChangeState
value = 100 + 2 * (Name="AJIK")
triggerall = ctrl
triggerall = statetype = S || statetype = C && Var(15)
trigger1 = (command="FF" || map(b_66)) && p2dist x >= -8 && !Var(15)
trigger2 = (command="BB" || map(b_44)) && p2dist x < -8 && !Var(15)
trigger3 = (Var(17) = 100 || Var(17) = 800 && p2bodydist x > 16) && Var(15)

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
trigger1 = map(p_Up) && !ctrl && !Var(15)
trigger2 = Var(17) = 40 && Var(15)
trigger3 = (Var(47)=1||Var(47)=3) && ctrl

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
[State -1, A+B+X+Y]
type = ChangeState
value = 3002
triggerall = RoundState = 2
triggerall = var(18) >= 3000 && !Map(CCDisable)
triggerall = !MoveGuarded && !Ctrl && !MoveReversed
triggerall = (StateNo = [200,800) || StateNo = 902 || StateNo = [960,970) || StateNo = [1100,1400) || StateNo = [1500,1800]) && MoveHit || StateNo = 1000 && (NumHelper(1010) || MoveType = I) && MoveHit || StateNo = 1402 && Time > 79
trigger1 = map(b_a) && map(b_y) && map(b_x) && map(b_b) && !Var(15)
trigger2 = Var(17) = 3000 && Var(15)

;---------------------------------------------------------------------------
; Craze Assault
[State -1, A+B+X+Y]
type = ChangeState
value = 3001
triggerall = RoundState = 2
triggerall = var(18) >= 2000 && !Map(CCDisable)
triggerall = StateNo = [200,2000) && !Ctrl && (!Var(51) || MoveType = I) && !MoveReversed
triggerall = StateNo != [800,900) && StateNo != [901,902] && StateNo != 1402 && !((StateNo = 1100 || StateNo = 1800) && Var(5) && MoveGuarded)
triggerall = !MoveContact && !Var(51) || MoveGuarded
triggerall = StateNo != [1000,1100) && !Var(51) || StateNo = [1000,1100) && (NumHelper(1010) || MoveType = I) && MoveGuarded
trigger1 = map(b_a) && map(b_y) && map(b_x) && map(b_b) && !Var(15)
trigger2 = Var(17) = 3000 && Var(15)

;---------------------------------------------------------------------------
; Craze Focus
[State -1, A+B+X+Y]
type = ChangeState
value = 3000
triggerall = RoundState = 2
triggerall = var(18) >= 1000 && !Map(CCDisable)
triggerall = StateNo != [3000,4000)
;triggerall = StateNo != [1000,1050] || StateNo = [1000,1050] && !MoveContact
triggerall = (ctrl || StateNo < 120) && !Var(51) || StateNo = [1000,1100) && (NumHelper(1010) || MoveType = I) && !MoveContact
trigger1 = map(b_a) && map(b_y) && map(b_x) && map(b_b) && !Var(15)
trigger2 = Var(17) = 3000 && Var(15)

;===========================================================================
;---------------------------------------------------------------------------
; Pillar of Fire
[State -1, DBDF,p]
type = ChangeState
value = 2400 + 200 * (Name="AJIK")
triggerall = statetype != A
triggerall = Power >= 3000
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = 200 || StateNo = 210 || StateNo = 300 || StateNo = 310 || StateNo = 315 || StateNo = 400 || StateNo = 410 || StateNo = 500 || StateNo = 205 || StateNo = 305 || StateNo = 306) && MoveContact || (StateNo = [200,800) || StateNo = 1300 || StateNo = 1600) && Time <= 2
trigger1 = map(QCBQC) && map(b_xy) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Lion's Cascade EX
[State -1, 2QCF,2p]
type = ChangeState
value = 2550
triggerall = statetype != A
triggerall = Name = "AJIK"
triggerall = Power >= 2000 - 1000 * (StateNo = 2200)
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && MoveContact || (StateNo = [200,800) || StateNo = 2500) && Time <= 2
trigger1 = map(QCFQC) && map(b_xy) && !Var(15)
trigger2 = (Var(17) = 1200 || Var(17) = 1300) && Var(15) && Random < 250

;---------------------------------------------------------------------------
; EXodus
[State -1, 2QCF,2k]
type = ChangeState
value = 2250
triggerall = statetype != A
triggerall = Name != "AJIK"
triggerall = Power >= 2000 - 1000 * (StateNo = 2200)
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = 200 || StateNo = 210 || StateNo = 300 || StateNo = 310 || StateNo = 400 || StateNo = 410 || StateNo = 500 || StateNo = 205 || StateNo = 305 || StateNo = 306) && MoveContact || (StateNo = 2200) && Time <= 2 || StateNo = [200,800) && Time <= 2
trigger1 = map(QCFQC) && map(b_ab) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Exodus
[State -1, 2QCF,k]
type = ChangeState
value = 2200 + 500 * (Name="AJIK")
triggerall = statetype != A
triggerall = Power >= 1000
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(QCFQC) && (map(b_a) || map(b_b)) && !Var(15)
trigger2 = (Var(17) = 1200 && Name != "AJIK" || Var(17) = 1300 && Name = "AJIK") && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SK Heatstroke
[State -1, 2QCB,b]
type = ChangeState
value = 2121 - 20 * (StateType=A)
triggerall = Name != "AJIK"
triggerall = Power >= 1000
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800)) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(QCBQC) && map(b_b) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 100

;---------------------------------------------------------------------------
; LK Heatstroke
[State -1, 2QCB,a]
type = ChangeState
value = 2120 - 20 * (StateType=A)
triggerall = Name != "AJIK"
triggerall = Power >= 1000
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800)) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(QCBQC) && map(b_a) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 100

;---------------------------------------------------------------------------
; Solar Flare
[State -1, 2QCF,p]
type = ChangeState
value = 2000 + 500 * (Name="AJIK")
triggerall = statetype != A
triggerall = Power >= 1000
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(QCFQC) && (map(b_x) || map(b_y)) && !Var(15)
trigger2 = (Var(17) = 1300 && Name != "AJIK" || Var(17) = 2200 && Name = "AJIK") && Var(15) && Random < 250

;===========================================================================
;---------------------------------------------------------------------------
; Fiery Dance
[State -1, Y+B]
type = ChangeState
value = 960 + ifelse(StateType=A,3,(!!map(p_Fd)||Var(15)&&p2bodydist x > 24) + 2 * !!map(p_Bk))
triggerall = Name = "AJIK"
triggerall = !(statetype = A && Vel Y < const(velocity.jump.y)*0.5) || MoveContact
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (Time <= 2 || StateNo != 510 && MoveContact) || StateNo = [1000,1800) && MoveContact
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = (Var(17) = 1000 || Var(17) = 1200 || Var(17) = 1400 || Var(17) = 1700) && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Flare Install
[State -1, Y+B]
type = ChangeState
value = 955
triggerall = Name = "AJIX"
triggerall = Map(AjixStore) && !Map(AjixTimer)
triggerall = ctrl && StateNo != 950 || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && (MoveContact || Time <= 2)
trigger1 = map(p_Fd) && (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = Var(17) = 900 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Burn Meditation
[State -1, Y+B]
type = ChangeState
value = 950
triggerall = Name = "AJIX"
;triggerall = Var(18) < 3000 || Map(AjixStore)
triggerall = ctrl && StateNo != 950 || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && (MoveContact || Time <= 2)
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = Var(17) = 900 && Var(15) && Random < 500 && Var(18) < 3000

;---------------------------------------------------------------------------
; Future Sight
[State -1, Y+B]
type = ChangeState
value = 900
triggerall = Name = "AJIT"
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && Time <= 2 && PrevStateNo != [200,800)
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = Var(17) = 120 && Var(15) && Random < 125

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
; SP Dragon's Strike
[State -1, QCF,b]
type = ChangeState
value = 1801
triggerall = Name = "AJIK"
triggerall = StateType != A
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(QCF) && map(b_b) && !Var(15)
trigger2 = Var(17) = 1300 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; LP Dragon's Strike
[State -1, QCF,a]
type = ChangeState
value = 1800
triggerall = Name = "AJIK"
triggerall = StateType != A
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(QCF) && map(b_a) && !Var(15)
trigger2 = (Var(17) = 1100 || Var(17) = 1600) && Var(15) && Random < 500

;---------------------------------------------------------------------------
; SP Solar Burst
[State -1, QCB,y]
type = ChangeState
value = 1601
triggerall = Name = "AJIK"
triggerall = StateType != A
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(QCB) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; LP Solar Burst
[State -1, QCB,x]
type = ChangeState
value = 1600
triggerall = Name = "AJIK"
triggerall = StateType != A
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(QCB) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1200 && EnemyNear,StateType != A && Var(15) && Random < 500

;---------------------------------------------------------------------------
; SP Lion's Pounce
[State -1, QCF,y]
type = ChangeState
value = 1701
triggerall = Name = "AJIK"
triggerall = !(statetype = A && Vel Y < const(velocity.jump.y)*0.5)
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(QCF) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; LP Lion's Pounce
[State -1, QCF,x]
type = ChangeState
value = 1700
triggerall = Name = "AJIK"
triggerall = !(statetype = A && Vel Y < const(velocity.jump.y)*0.5)
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(QCF) && map(b_x) && !Var(15)
trigger2 = (Var(17) = 1400 || Var(17) = 1600 && StateType = A) && Var(15) && Random < 500

;---------------------------------------------------------------------------
; SK Cobra Lunge
[State -1, QCB,b]
type = ChangeState
value = 1503 - 2 * (StateType=A)
triggerall = Name = "AJIK"
triggerall = !(statetype = A && Vel Y < const(velocity.jump.y)*0.5)
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(QCB) && map(b_b) && !Var(15)
trigger2 = (Var(17) = 1400 || Var(17) = 1600 && StateType = A) && Var(15) && Random < 500

;---------------------------------------------------------------------------
; LK Cobra Lunge
[State -1, QCB,a]
type = ChangeState
value = 1502 - 2 * (StateType=A)
triggerall = Name = "AJIK"
triggerall = !(statetype = A && Vel Y < const(velocity.jump.y)*0.5)
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(QCB) && map(b_a) && !Var(15)
trigger2 = (Var(17) = 1400 || Var(17) = 1600 && StateType = A) && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Roc Twister EX
[State -1, QCB,2k]
type = ChangeState
value = 1250
triggerall = Name = "AJIX"
triggerall = Var(18) >= 1000
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = 200 || StateNo = 210 || StateNo = 300 || StateNo = 310 || StateNo = 400 || StateNo = 410 || StateNo = 500 || StateNo = 205 || StateNo = 305 || StateNo = 306 || StateNo = 600 || StateNo = 610 || StateNo = 700 || StateNo = 710) && MoveContact || (StateNo = [200,800) || StateNo = 1200) && Time <= 2 
trigger1 = map(QCB) && map(b_ab) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 125

;---------------------------------------------------------------------------
; Cobra Gatling EX
[State -1, FBF,2p]
type = ChangeState
value = 1450
triggerall = statetype != A
triggerall = Name = "AJIX"
triggerall = Var(18) >= 1000
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = 200 || StateNo = 210 || StateNo = 300 || StateNo = 310 || StateNo = 400 || StateNo = 410 || StateNo = 500 || StateNo = 205 || StateNo = 305 || StateNo = 306) && MoveContact || (StateNo = [200,800) || StateNo = 1400) && Time <= 2 
trigger1 = map(RDP) && map(b_xy) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 125

;---------------------------------------------------------------------------
; Dragon Blaze EX
[State -1, HCB,2p]
type = ChangeState
value = 1350
triggerall = statetype != A
triggerall = Name = "AJIX"
triggerall = Var(18) >= 1000
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = 200 || StateNo = 210 || StateNo = 300 || StateNo = 310 || StateNo = 400 || StateNo = 410 || StateNo = 500 || StateNo = 205 || StateNo = 305 || StateNo = 306) && MoveContact || (StateNo = [200,800) || StateNo = 1300) && Time <= 2 
trigger1 = (map(HCB) || COMMAND = "HCB") && map(b_xy) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 125

;---------------------------------------------------------------------------
; Tiger's Strike EX
[State -1, DP,2p]
type = ChangeState
value = 1150
triggerall = statetype != A
triggerall = Name = "AJIX"
triggerall = Var(18) >= 1000
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = 200 || StateNo = 210 || StateNo = 300 || StateNo = 310 || StateNo = 400 || StateNo = 410 || StateNo = 500 || StateNo = 205 || StateNo = 305 || StateNo = 306) && MoveContact || (StateNo = [200,800) || StateNo = 1100) && Time <= 2
trigger1 = map(DP) && map(b_xy) && !Var(15)
trigger2 = (Var(17) = 1100 || Var(17) = 1300) && Var(15) && Random < 125

;---------------------------------------------------------------------------
; Lion's Sunspot EX
[State -1, QCF,p]
type = ChangeState
value = 1050
triggerall = statetype != A
triggerall = Name = "AJIX"
triggerall = Var(18) >= 1000
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = 200 || StateNo = 210 || StateNo = 300 || StateNo = 310 || StateNo = 400 || StateNo = 410 || StateNo = 500 || StateNo = 205 || StateNo = 305 || StateNo = 306) && MoveContact || (StateNo = [200,800) || StateNo = 1000) && Time <= 2
triggerall = !NumHelper(1010)
trigger1 = map(QCF) && map(b_xy) && !Var(15)
trigger2 = Var(17) = 1000 && Var(15) && Random < 125

;---------------------------------------------------------------------------
; SP Dragon Blaze
[State -1, HCB,y]
type = ChangeState
value = 1301
triggerall = statetype != A
triggerall = Name != "AJIK"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = 200 || StateNo = 210 || StateNo = 300 || StateNo = 310 || StateNo = 400 || StateNo = 410 || StateNo = 500 || StateNo = 205 || StateNo = 305 || StateNo = 306) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = (map(HCB) || COMMAND = "HCB") && map(b_y) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; LP Dragon Blaze
[State -1, HCB,x]
type = ChangeState
value = 1300
triggerall = statetype != A
triggerall = Name != "AJIK"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = 200 || StateNo = 210 || StateNo = 300 || StateNo = 310 || StateNo = 400 || StateNo = 410 || StateNo = 500 || StateNo = 205 || StateNo = 305 || StateNo = 306) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = (map(HCB) || COMMAND = "HCB") && map(b_x) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; SP Cobra Gattling
[State -1, FBF,y]
type = ChangeState
value = 1401
triggerall = Name != "AJIK"
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = 200 || StateNo = 210 || StateNo = 300 || StateNo = 310 || StateNo = 400 || StateNo = 410 || StateNo = 500 || StateNo = 205 || StateNo = 305 || StateNo = 306) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(RDP) && map(b_y) && !Var(15)
trigger2 = (Var(17) = 1200 && Name = "AJIT" || Var(17) = 1600 && Name = "AJIX") && Var(15) && Random < 125

;---------------------------------------------------------------------------
; LP Cobra Gattling
[State -1, FBF,x]
type = ChangeState
value = 1400
triggerall = Name != "AJIK"
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = 200 || StateNo = 210 || StateNo = 300 || StateNo = 310 || StateNo = 400 || StateNo = 410 || StateNo = 500 || StateNo = 205 || StateNo = 305 || StateNo = 306) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(RDP) && map(b_x) && !Var(15)
trigger2 = (Var(17) = 1200 && Name = "AJIT" || Var(17) = 1600 && Name = "AJIX") && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SK Roc Twister
[State -1, QCB,b]
type = ChangeState
value = 1201 + 5 * (Name="AJIT")
triggerall = Name != "AJIK"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = 200 || StateNo = 210 || StateNo = 300 || StateNo = 310 || StateNo = 400 || StateNo = 410 || StateNo = 500 || StateNo = 205 || StateNo = 305 || StateNo = 306 || StateNo = 600 || StateNo = 610 || StateNo = 700 || StateNo = 710) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(QCB) && map(b_b) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; LK Roc Twister
[State -1, QCB,a]
type = ChangeState
value = 1200 + 5 * (Name="AJIT")
triggerall = Name != "AJIK"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = 200 || StateNo = 210 || StateNo = 300 || StateNo = 310 || StateNo = 400 || StateNo = 410 || StateNo = 500 || StateNo = 205 || StateNo = 305 || StateNo = 306 || StateNo = 600 || StateNo = 610 || StateNo = 700 || StateNo = 710) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(QCB) && map(b_a) && !Var(15)
trigger2 = (Var(17) = 1600 && Name = "AJIT" || Var(17) = 1200 && Name = "AJIX") && Var(15) && Random < 500

;---------------------------------------------------------------------------
; SP Tiger's Strike
[State -1, DP,y]
type = ChangeState
value = 1101
triggerall = statetype != A
triggerall = Name != "AJIK"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = 200 || StateNo = 210 || StateNo = 300 || StateNo = 310 || StateNo = 400 || StateNo = 410 || StateNo = 500 || StateNo = 205 || StateNo = 305 || StateNo = 306) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(DP) && map(b_y) && !Var(15)
trigger2 = (Var(17) = 1100 || Var(17) = 1300) && Var(15) && Random < 500

;---------------------------------------------------------------------------
; LP Tiger's Strike
[State -1, DP,x]
type = ChangeState
value = 1100
triggerall = statetype != A
triggerall = Name != "AJIK"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = 200 || StateNo = 210 || StateNo = 300 || StateNo = 310 || StateNo = 400 || StateNo = 410 || StateNo = 500 || StateNo = 205 || StateNo = 305 || StateNo = 306) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(DP) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1100 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; SP Lion's Sunspot
[State -1, QCF,y]
type = ChangeState
value = 1001
triggerall = statetype != A
triggerall = Name != "AJIK"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = 200 || StateNo = 210 || StateNo = 300 || StateNo = 310 || StateNo = 400 || StateNo = 410 || StateNo = 500 || StateNo = 205 || StateNo = 305 || StateNo = 306) && MoveContact || StateNo = [200,800) && Time <= 2
triggerall = !NumHelper(1010)
trigger1 = map(QCF) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1000 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; LP Lion's Sunspot
[State -1, QCF,x]
type = ChangeState
value = 1000
triggerall = statetype != A
triggerall = Name != "AJIK"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = 200 || StateNo = 210 || StateNo = 300 || StateNo = 310 || StateNo = 400 || StateNo = 410 || StateNo = 500 || StateNo = 205 || StateNo = 305 || StateNo = 306) && MoveContact || StateNo = [200,800) && Time <= 2
triggerall = !NumHelper(1010)
trigger1 = map(QCF) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1000 && Var(15) && Random < 500

;===========================================================================
;---------------------------------------------------------------------------
; CN f+LP
[State -1, st.f+LP]
type = ChangeState
value = 205 + 10 * (Name="AJIK")
triggerall = statetype != A
triggerall = StateNo != 205 && StateNo != 305 && StateNo != 306 && StateNo != 315
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = 200 || StateNo = 210 || StateNo = 300 || StateNo = 310 || StateNo = 400 || StateNo = 410 || StateNo = 500) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(b_x) && map(p_Fd) && !map(p_Dn) && !Var(15)
trigger2 = Var(17) = 205 && Var(15) && (Map(P2Proxy) <= 16 || Name = "AJIK")

;---------------------------------------------------------------------------
; CN f+LK
[State -1, st.f+LK]
type = ChangeState
value = 305 + (MoveHit=1&&(!map(p_Up)||Var(15))&&Name!="AJIK") + 10 * (Name="AJIK")
triggerall = statetype != A
triggerall = StateNo != 205 && StateNo != 305 && StateNo != 306 && StateNo != 315
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = 200 || StateNo = 210 || StateNo = 300 || StateNo = 310 || StateNo = 400 || StateNo = 410 || StateNo = 500) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(b_a) && map(p_Fd) && !map(p_Dn) && !Var(15)
trigger2 = (Var(17) = 205 || Var(17) = 1700) && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Standing LP
[State -1, st.LP]
type = ChangeState
value = 200
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = 300 || StateNo = 400 || StateNo = 500) && MoveContact && Map(LightChain)
trigger1 = map(b_x) && !map(p_Dn) && !Var(15)
trigger2 = Var(17) = 200 && Var(15) && random < 500

;---------------------------------------------------------------------------
; Standing HP
[State -1, st.HP]
type = ChangeState
value = 210
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = 200 || StateNo = 300 || StateNo = 400 || StateNo = 500) && MoveContact 
trigger1 = map(b_y) && !map(p_Dn) && !Var(15)
trigger2 = Var(17) = 210 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Standing LK
[State -1, st.LK]
type = ChangeState
value = 300
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = 200 || StateNo = 400 || StateNo = 500) && MoveContact && Map(LightChain)
trigger1 = map(b_a) && !map(p_Dn) && !Var(15)
trigger2 = Var(17) = 200 && Var(15) && random < 250

;---------------------------------------------------------------------------
; Standing HK
[State -1, st.HK]
type = ChangeState
value = 310
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = 200 || StateNo = 300 || StateNo = 400 || StateNo = 500) && MoveContact 
trigger1 = map(b_b) && !map(p_Dn) && !Var(15)
trigger2 = Var(17) = 210 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Crouch LP
[State -1, cr.LP]
type = ChangeState
value = 400
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = 200 || StateNo = 300 || StateNo = 500) && MoveContact && Map(LightChain)
trigger1 = map(b_x) && map(p_Dn) && !Var(15)
trigger2 = Var(17) = 200 && Var(15) && Random < 500 && EnemyNear,StateType != A

;---------------------------------------------------------------------------
; Crouch SP
[State -1, cr.SP]
type = ChangeState
value = 410
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = 200 || StateNo = 300 || StateNo = 400 || StateNo = 500) && MoveContact
trigger1 = map(b_y) && map(p_Dn) && !Var(15)
trigger2 = (Var(17) = 210 || Var(17) = 410) && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Crouch LK
[State -1, cr.LK]
type = ChangeState
value = 500
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = 200 || StateNo = 300 || StateNo = 400) && MoveContact && Map(LightChain)
trigger1 = map(b_a) && map(p_Dn) && !Var(15)
trigger2 = Var(17) = 200 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Crouch SK
[State -1, cr.SK]
type = ChangeState
value = 510
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = 200 || StateNo = 300 || StateNo = 400 || StateNo = 500) && MoveContact
trigger1 = map(b_b) && map(p_Dn) && !Var(15)
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
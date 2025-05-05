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

; never fear, army is here
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
; Walljump
[State -1, Walljump]
type = ChangeState
value = 60
triggerall = ctrl && Vel Y >= -3.5
triggerall = statetype = A && Var(1) && Var(5)
triggerall = BackEdgeDist < 24 || FrontEdgeDist < 24
triggerall = !(FrontEdgeDist < 24 && EnemyNear,BackEdgeDist < 4 && Pos Y > -enemynear,const(size.height))
trigger1 = (command = "up" || command = "upback" || command = "upfwd") && !Var(15)
trigger1 = BackEdgeDist < 24 && (map(p_Fd)>0) || FrontEdgeDist < 24 && (map(p_Bk)>0) 
trigger2 = Var(17) = 60 && Var(15)

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
triggerall = (StateNo = [200,800) || StateNo = 900 || StateNo = 910 || StateNo = 915 || StateNo = [1000,1300) || StateNo = [1800,2000)) && MoveHit || StateNo = 1310 && AnimElem = 10, >= 2 || StateNo = [1400,1405] && (NumHelper(1410) || MoveType = I) && MoveHit || StateNo = 1610 && AnimElem = 41, >= 2 
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
triggerall = StateNo != [800,900) && !(StateNo = 910 && MoveGuarded) && !(StateNo = 1200 && Var(5) && MoveGuarded) && StateNo != [1600,1610]
triggerall = !MoveContact && !Var(51) || MoveGuarded
triggerall = StateNo != 900 && StateNo != [1400,1405] && StateNo != 1310 && StateNo != 1710 || StateNo = 900 && (NumHelper(900) || MoveType = I) && MoveGuarded || StateNo = [1400,1405] && (NumHelper(1410) || MoveType = I) && MoveGuarded
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
triggerall = !(StateNo = 61 && Var(51))
triggerall = (ctrl || StateNo < 120) && !Var(51) || StateNo = 900 && (NumHelper(900) || MoveType = I) && !MoveContact || StateNo = [1400,1405] && (NumHelper(1410) || MoveType = I) && !MoveContact
trigger1 = map(b_a) && map(b_y) && map(b_x) && map(b_b) && !Var(15)
trigger2 = Var(17) = 3000 && Var(15)

;===========================================================================
;---------------------------------------------------------------------------
; Noontide
[State -1, 2QCB,2k]
type = ChangeState
value = 2300
triggerall = statetype != A
triggerall = Power >= 3000
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || (StateNo = 1100 || StateNo = 1600) && Time <= 2
trigger1 = map(QCBQC) && map(b_ab) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Grand Entrance
[State -1, 2QCF,2k]
type = ChangeState
value = 2500
triggerall = statetype != A
triggerall = Power >= 2000
triggerall = Name = "EMIK"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = 1100 && Time <= 2
trigger1 = map(QCFQC) && map(b_ab) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Shogatsu
[State -1, 2QCF,2k]
type = ChangeState
value = 2700
triggerall = statetype != A
triggerall = Power >= 2000
triggerall = Name = "EMIC"
triggerall = ctrl || StateNo = 40 || StateNo = 55|| (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || (StateNo = 1100 || StateNo = 1600) && Time <= 2
trigger1 = map(QCFQC) && map(b_ab) && !Var(15)
trigger2 = (Var(17) = 1200 || Var(17) = 1300) && Var(15) && Random < 350

;---------------------------------------------------------------------------
; Noontide
[State -1, 2QCB,p]
type = ChangeState
value = 2101 - (StateType=A)
triggerall = Power >= 1000
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || (StateNo = 1400) && Time <= 2
trigger1 = map(QCBQC) && (map(b_x) || map(b_y)) && !Var(15)
trigger2 = Var(17) = 1000 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Dusk EX
[State -1, 2QCF,2p]
type = ChangeState
value = 2200
triggerall = statetype != A
triggerall = Name = "EMIX"
triggerall = Power >= 2000 - 1000 * (StateNo = 2000)
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || (StateNo = [200,800) || StateNo = 2000) && Time <= 2
trigger1 = map(QCFQC) && map(b_xy) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Dusk
[State -1, 2QCF,p]
type = ChangeState
value = 2000 + 600 * (Name="EMIC") + 400 * (Name="EMIK")
triggerall = statetype != A
triggerall = Power >= 1000
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || (StateNo = 1400) && Time <= 2
trigger1 = map(QCFQC) && (map(b_x) || map(b_y)) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;===========================================================================
;---------------------------------------------------------------------------
; Remembrance
[State -1, Y+B]
type = ChangeState
value = 930
;triggerall = statetype != A
triggerall = !(StateType=A && (StateNo=930||PrevStateNo=930)) 
triggerall = Name = "EMIX"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = Var(17) = 900 && Var(15) && Random < 500 && !NumHelper(930)

;---------------------------------------------------------------------------
; Shadow Step
[State -1, ju.Y+B]
type = ChangeState
value = 920
triggerall = statetype = A
triggerall = Name = "EMIK"
triggerall = Life > 1
triggerall = Var(1) = 1 || StateNo = 61 && PrevStateNo = 60
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = Var(17) = 1400 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Ishiwatari Smash
[State -1, f+Y+B]
type = ChangeState
value = 915
triggerall = statetype != A
triggerall = Name = "EMIK"
triggerall = Life > 1
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && (map(p_Fd)>0) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Sound Test
[State -1, Y+B]
type = ChangeState
value = 910
triggerall = statetype != A
triggerall = Name = "EMIK"
triggerall = Life > 1
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = Var(17) = 1300 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Daybreak
[State -1, Y+B]
type = ChangeState
value = 900
triggerall = statetype != A
triggerall = Name = "EMIC"
triggerall = !NumHelper(900)
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = (Var(17) = 900 || Var(17) = 1000) && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Throw
[State -1, X+A]
type = ChangeState
value = ifelse(StateType=A,850,800)
;triggerall = statetype != A
triggerall = Ctrl || (StateNo = [100,101]) || StateNo = [200,800) && Time <= 2 && PrevStateNo != [200,800) || StateNo = [600,800) && MoveHit
trigger1 = (map(b_x) && map(b_a) || map(b_xa)) && !Var(15)
trigger2 = Var(17) = 800 && Var(15) && (Random < 500 || Name != "EMIC")
trigger2 = P2BodyDist X = [-8,const(size.ground.front)] && StateType != A && EnemyNear,StateType != A || P2BodyDist X <= 40 && !numtarget(860) && StateType = A && EnemyNear,StateType = A

;===========================================================================
;---------------------------------------------------------------------------
; SP Precipice
[State -1, QCF,y]
type = ChangeState
value = 1701
triggerall = StateType = A
triggerall = Name = "EMIK"
triggerall = ctrl && Vel Y > -3.5 || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact
trigger1 = map(QCF) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1400 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LP Precipice
[State -1, QCF,x]
type = ChangeState
value = 1700
triggerall = StateType = A
triggerall = Name = "EMIK"
triggerall = ctrl && Vel Y > -3.5 || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact
trigger1 = map(QCF) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1400 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; EX Clear Skies
[State -1, 360,2k]
type = ChangeState
value = 1605
triggerall = statetype != A
triggerall = Name = "EMIC" && Power >= 500
triggerall = ctrl || StateNo = 40 || StateNo = 55|| (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = 1600 && Time <= 2
trigger1 = (map(DP) || map(f360) || map(r360)) && (map(b_ab)) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 125

;---------------------------------------------------------------------------
; SK Clear Skies
[State -1, 360,b]
type = ChangeState
value = 1601
triggerall = statetype != A
triggerall = Name = "EMIC"
triggerall = ctrl || StateNo = 40 || StateNo = 55 || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact
trigger1 = (map(DP) || map(f360) || map(r360)) && map(b_b) && !Var(15)
trigger2 = Var(17) = 800 && Var(15) && Random < 500
trigger2 = P2BodyDist X = [-8,const(size.ground.front)] && StateType != A && EnemyNear,StateType != A || P2BodyDist X <= 40 && !numtarget(860) && StateType = A && EnemyNear,StateType = A

;---------------------------------------------------------------------------
; LK Clear Skies
[State -1, 360,a]
type = ChangeState
value = 1600
triggerall = statetype != A
triggerall = Name = "EMIC"
triggerall = ctrl || StateNo = 40 || StateNo = 55 || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact
trigger1 = (map(DP) || map(f360) || map(r360)) && map(b_a) && !Var(15)
trigger2 = Var(17) = 800 && Var(15) && Random < 500
trigger2 = P2BodyDist X = [-8,const(size.ground.front)] && StateType != A && EnemyNear,StateType != A || P2BodyDist X <= 40 && !numtarget(860) && StateType = A && EnemyNear,StateType = A

;---------------------------------------------------------------------------
; EX Cloudy Weather
[State -1, QCB,2p]
type = ChangeState
value = 1405
triggerall = StateType = A
triggerall = Name = "EMIC" && Power >= 500
triggerall = ctrl && Vel Y > -3.5 || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = 1400 && Time <= 2 || StateNo = 1200 && PrevStateNo = 1210 && AnimElemNo(0) >= 6
triggerall = !NumHelper(1410)
trigger1 = map(QCB) && map(b_xy) && !Var(15)
trigger2 = Var(17) = 1000 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SP Cloudy Weather
[State -1, QCB,y]
type = ChangeState
value = 1401
triggerall = StateType = A
triggerall = ctrl && Vel Y > -3.5 || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact
triggerall = !NumHelper(1410)
trigger1 = map(QCB) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1000 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LP Cloudy Weather
[State -1, QCB,x]
type = ChangeState
value = 1400
triggerall = StateType = A
triggerall = ctrl && Vel Y > -3.5 || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact
triggerall = !NumHelper(1410)
trigger1 = map(QCB) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1000 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SP Springtime
[State -1, QCB,y]
type = ChangeState
value = 1501
triggerall = statetype != A
triggerall = Name = "EMIK"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(QCB) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LP Springtime
[State -1, QCB,x]
type = ChangeState
value = 1500
triggerall = statetype != A
triggerall = Name = "EMIK"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(QCB) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Autumn EX
[State -1, ChDU,2K]
type = ChangeState
value = 1305
triggerall = statetype != A
triggerall = Name = "EMIC" && Power >= 500; || Name="EMIX" && NumHelper(930)
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || (StateNo = [200,800) || StateNo = 1300) && Time <= 2
trigger1 = map(QCB) && map(b_ab) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SK Autumn
[State -1, ChDU,b]
type = ChangeState
value = 1301
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(QCB) && map(b_b) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LK Autumn
[State -1, ChDU,a]
type = ChangeState
value = 1300
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(QCB) && map(b_a) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Spring EX
[State -1, ChDU,2P]
type = ChangeState
value = 1210
triggerall = statetype != A
triggerall = Name = "EMIC" && Power >= 500; || Name="EMIX" && NumHelper(930)
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || (StateNo = [200,800) || StateNo = 1200) && Time <= 2
trigger1 = map(DP) && map(b_xy) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 125

;---------------------------------------------------------------------------
; SP Spring
[State -1, ChDU,y]
type = ChangeState
value = 1201
triggerall = statetype != A
triggerall = Name != "EMIK"
triggerall = ctrl || StateNo = [39,40]  || StateNo = 55 || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(b_y) && !Var(15)
trigger1 = Var(44) >= 24 && ((map(p_Up)>0) || command = "up")
trigger1 = Name = "EMIX"
trigger2 = map(DP) && map(b_y) && !Var(15)
trigger2 = Name = "EMIC"
trigger3 = Var(17) = 1300 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LP Spring
[State -1, ChDU,x]
type = ChangeState
value = 1200
triggerall = statetype != A
triggerall = Name != "EMIK"
triggerall = ctrl || StateNo = [39,40]  || StateNo = 55 || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(b_x) && !Var(15)
trigger1 = Var(44) >= 24 && ((map(p_Up)>0) || command = "up")
trigger1 = Name = "EMIX"
trigger2 = map(DP) && map(b_x) && !Var(15)
trigger2 = Name = "EMIC"
trigger3 = Var(17) = 1100 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SK Accident
[State -1, ChBF,b]
type = ChangeState
value = 1811
triggerall = statetype != A
triggerall = Name = "EMIX"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(b_b) && !Var(15)
trigger1 = Var(40) >= 24 && P2Dist X >= 0 && Facing = 1 && (((map(p_Fd)>0) && P2Dist X >= 0) || ((map(p_Bk)>0) && P2Dist X < 0))
trigger2 = map(b_b) && !Var(15)
trigger2 = Var(42) >= 24 && P2Dist X >= 0 && Facing = -1 && (((map(p_Fd)>0) && P2Dist X >= 0) || ((map(p_Bk)>0) && P2Dist X < 0))
trigger3 = Var(17) = 1700 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LK Accident
[State -1, ChBF,a]
type = ChangeState
value = 1810
triggerall = statetype != A
triggerall = Name = "EMIX"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(b_a) && !Var(15)
trigger1 = Var(40) >= 24 && P2Dist X >= 0 && Facing = 1 && (((map(p_Fd)>0) && P2Dist X >= 0) || ((map(p_Bk)>0) && P2Dist X < 0))
trigger2 = map(b_a) && !Var(15)
trigger2 = Var(42) >= 24 && P2Dist X >= 0 && Facing = -1 && (((map(p_Fd)>0) && P2Dist X >= 0) || ((map(p_Bk)>0) && P2Dist X < 0))
trigger3 = Var(17) = 1700 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; 2K Winter EX
[State -1, ChBF,2K]
type = ChangeState
value = 1110
triggerall = statetype != A
triggerall = Name = "EMIC"
triggerall = Power >= 500
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || (StateNo = [200,800) || StateNo = 1100) && Time <= 2
trigger1 = map(QCF) && map(b_a) && map(b_b) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SK Winter
[State -1, QCF,b]
type = ChangeState
value = 1101
triggerall = statetype != A
triggerall = Name != "EMIX"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(QCF) && map(b_b) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LK Winter
[State -1, QCF,a]
type = ChangeState
value = 1100
triggerall = statetype != A
triggerall = Name != "EMIX"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(QCF) && map(b_a) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SP Heartbreak
[State -1, ChBF,y]
type = ChangeState
value = 1801
triggerall = statetype != A
triggerall = Name = "EMIX"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(b_y) && !Var(15)
trigger1 = Var(40) >= 24 && P2Dist X >= 0 && Facing = 1 && (((map(p_Fd)>0) && P2Dist X >= 0) || ((map(p_Bk)>0) && P2Dist X < 0))
trigger2 = map(b_y) && !Var(15)
trigger2 = Var(42) >= 24 && P2Dist X >= 0 && Facing = -1 && (((map(p_Fd)>0) && P2Dist X >= 0) || ((map(p_Bk)>0) && P2Dist X < 0))
trigger3 = Var(17) = 1600 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LP Heartbreak
[State -1, ChBF,x]
type = ChangeState
value = 1800
triggerall = statetype != A
triggerall = Name = "EMIX"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(b_x) && !Var(15)
trigger1 = Var(40) >= 24 && P2Dist X >= 0 && Facing = 1 && (((map(p_Fd)>0) && P2Dist X >= 0) || ((map(p_Bk)>0) && P2Dist X < 0))
trigger2 = map(b_x) && !Var(15)
trigger2 = Var(42) >= 24 && P2Dist X >= 0 && Facing = -1 && (((map(p_Fd)>0) && P2Dist X >= 0) || ((map(p_Bk)>0) && P2Dist X < 0))
trigger3 = Var(17) = 1600 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; 2P Summer EX
[State -1, QCF,2P]
type = ChangeState
value = 1010
triggerall = statetype != A
triggerall = Name = "EMIC"
triggerall = Power >= 500
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || (StateNo = [200,800) || StateNo = 1000) && Time <= 2
trigger1 = map(QCF) && map(b_x) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SP Summer
[State -1, QCF,y]
type = ChangeState
value = 1001
triggerall = statetype != A
triggerall = Name != "EMIX"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(QCF) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LP Summer
[State -1, QCF,x]
type = ChangeState
value = 1000
triggerall = statetype != A
triggerall = Name != "EMIX"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(QCF) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Side-L Teleport
[State -1, DD,b]
type = ChangeState
value = 941
;triggerall = statetype != A
triggerall = Name = "EMIX" && NumHelper(930)
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(DD) && map(b_b) && !Var(15)
trigger2 = Var(17) = 100 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Side-L Teleport
[State -1, DD,a]
type = ChangeState
value = 940
;triggerall = statetype != A
triggerall = Name = "EMIX" && NumHelper(930)
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(DD) && map(b_a) && !Var(15)
trigger2 = Var(17) = 100 && Var(15) && Random < 250

;===========================================================================
;---------------------------------------------------------------------------
; CN f+LP
[State -1, st.f+LP]
type = ChangeState
value = 225 + (MoveHit=1&&!(map(p_Up)>0))
triggerall = statetype != A
triggerall = Name = "EMIK"
triggerall = StateNo != 215 && StateNo != 225 && StateNo != 305 && StateNo != 415
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(b_x) && (map(p_Fd)>0) && !(map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; CN db+SP
[State -1, cr.b+SP]
type = ChangeState
value = 415
triggerall = statetype != A
triggerall = StateNo != 215 && StateNo != 225 && StateNo != 305 && StateNo != 415
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(b_y) && (map(p_Bk)>0) && (map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 205 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; CN f+SP
[State -1, st.f+SP]
type = ChangeState
value = 215
triggerall = statetype != A
triggerall = Name != "EMIX"
triggerall = StateNo != 215 && StateNo != 225 && StateNo != 305 && StateNo != 415
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(b_y) && (map(p_Fd)>0) && !(map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 205 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; CN f+LK
[State -1, st.f+LK]
type = ChangeState
value = 305 + (MoveHit=1&&!(map(p_Up)>0))
triggerall = statetype != A
triggerall = Name != "EMIK"
triggerall = StateNo != 215 && StateNo != 225 && StateNo != 305 && StateNo != 415
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(b_a) && (map(p_Fd)>0) && !(map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; CN ju.d+SK
[State -1, ju.d+SK]
type = ChangeState
value = 715
triggerall = statetype = A
triggerall = Name = "EMIK"
triggerall = StateNo != 705
triggerall = Var(1) || StateNo = 61 && PrevStateNo = 60
triggerall = ctrl && Vel Y > -3.5 || (StateNo = [100,101]) || (StateNo = 600 || StateNo = 610 || StateNo = 700 || StateNo = 710) && MoveContact
trigger1 = map(b_b) && (map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 1400 && Var(15) && Random < 125

;---------------------------------------------------------------------------
; CN ju.d+LK
[State -1, ju.d+LK]
type = ChangeState
value = 705 + 1 * (!(map(p_Fd)>0)&&!(map(p_Bk)>0)) + 2 * (!(map(p_Fd)>0)&&(map(p_Bk)>0))
triggerall = statetype = A
triggerall = StateNo != 705
triggerall = ctrl && Vel Y > -3.5 || (StateNo = [100,101]) || (StateNo = 600 || StateNo = 610 || StateNo = 700 || StateNo = 710) && MoveContact
trigger1 = map(b_a) && (map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 500

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
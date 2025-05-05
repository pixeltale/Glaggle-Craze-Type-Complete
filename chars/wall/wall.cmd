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

; theres a universe in a soul
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

[State 0, Guard]
Type = ChangeState
Value = 120
triggerall = StateType != A
triggerall = (Ctrl || (StateNo = 100 || StateNo = 101))
trigger1 = StateNo = 100 && inguarddist && enemynear,movetype = A
trigger1 = (map(p_Bk)>0) && !Var(15)
trigger2 = Var(17) = 120 && Var(15)

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
triggerall = (StateNo = [200,800) || StateNo = [1000,1400) || StateNo = [1500,1605]) && MoveHit || StateNo = 910 && Time > 20 || StateNo = 970 && Time > 114 || StateNo = 1410 && Time > 50 || StateNo = 1810 && Time > 53 || StateNo = [1710,1715] && AnimElem = 14, >= 1
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
triggerall = StateNo != [800,900) && StateNo != 930 && StateNo != [960,970] && StateNo != [1400,1410] && StateNo != [1700,1710] && StateNo != 1715
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
triggerall = (ctrl || StateNo < 120) && !Var(51) || StateNo = 930 && (Time > 20 || NumHelper(940))
trigger1 = map(b_a) && map(b_y) && map(b_x) && map(b_b) && !Var(15)
trigger2 = Var(17) = 3000 && Var(15)

;===========================================================================
;---------------------------------------------------------------------------
; Maximaler Ubersteuerungsfaktor
[State -1, 2QCF,2k]
type = ChangeState
value = 2500
triggerall = statetype != A
triggerall = Power >= 3000
triggerall = Name = "WALK"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(QCFQC) && map(b_ab) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Das Ende der Tage
[State -1, 360,2p]
type = ChangeState
value = 2300
triggerall = statetype != A
triggerall = Power >= 3000
triggerall = Name != "WALK"
triggerall = ctrl || StateNo = 40 || StateNo = 55 || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveHit || StateNo = [200,800) && Time <= 2
trigger1 = (map(HCB) || map(f360) || map(r360)) && map(b_ab) && !Var(15)
trigger2 = (Var(17) = 1300 || Var(17) = 800) && Var(15) && Random < 500
trigger2 = P2BodyDist X = [-8,const(size.ground.front)] && StateType != A && EnemyNear,StateType != A || P2BodyDist X <= 40 && !numtarget(860) && StateType = A && EnemyNear,StateType = A

;---------------------------------------------------------------------------
; Volldampf Voraus EX!
[State -1, 2QCF,2p]
type = ChangeState
value = 2200
triggerall = statetype != A
triggerall = Power >= 2000 - 1000 * (StateNo = 2000)
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || (StateNo = [200,800) || StateNo = 1100 || StateNo = 1800 || StateNo = 2000) && Time <= 2
trigger1 = map(QCFQC) && map(b_xy) && !Var(15)
trigger2 = (Var(17) = 1200 || Var(17) = 1300) && Var(15) && Random < 125

;---------------------------------------------------------------------------
; Open Casket Smasher
[State -1, HCB,2p]
type = ChangeState
value = 2400
triggerall = statetype != A
triggerall = Name != "WALL"
triggerall = Power >= 1000
triggerall = ctrl || StateNo = 40 || StateNo = 55 || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || (StateNo = [200,800) || StateNo = 1400) && Time <= 2
trigger1 = (map(HCB) || map(f360) || map(r360)) && map(b_xy) && !Var(15)
trigger2 = (Var(17) = 1300 || Var(17) = 800) && Var(15) && Random < 250
trigger2 = P2BodyDist X = [-8,const(size.ground.front)] && StateType != A && EnemyNear,StateType != A || P2BodyDist X <= 40 && !numtarget(860) && StateType = A && EnemyNear,StateType = A

;---------------------------------------------------------------------------
; Trauerzug
[State -1, 2QCF,k]
type = ChangeState
value = 2100
triggerall = statetype != A
triggerall = Name = "WALL"
triggerall = Power >= 1000
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(QCFQC) && (map(b_a) || map(b_b)) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 350

;---------------------------------------------------------------------------
; Volldampf Voraus!
[State -1, 2QCF,p]
type = ChangeState
value = 2000
triggerall = statetype != A
triggerall = Power >= 1000
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || (StateNo = [200,800) || StateNo = 1100 || StateNo = 1800) && Time <= 2
trigger1 = map(QCFx2) && (map(b_x) || map(b_y)) && !Var(15)
trigger2 = (Var(17) = 1200 || Var(17) = 1300) && Var(15) && Random < 250

;===========================================================================
;---------------------------------------------------------------------------
; Der Nebel
[State -1, Y+B]
type = ChangeState
value = 955
triggerall = statetype != A
triggerall = Name = "WALK"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = !(map(p_Fd)>0) && (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = Var(17) = 900 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Der Laufende Mann
[State -1, f.Y+B]
type = ChangeState
value = 950
triggerall = statetype != A
triggerall = Name = "WALK"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = (map(p_Fd)>0) && (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = Var(17) = 1400 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Mephisto Seben
[State -1, Y+B]
type = ChangeState
value = 900 + (Name="WALX")*60
triggerall = statetype != A
triggerall = Name != "WALK"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = Var(17) = 1300 && Var(15) && Random < 250 && Name = "WALL"
trigger3 = Var(17) = 800 && Var(15) && Name = "WALX"
trigger3 = P2BodyDist X = [-8,const(size.ground.front)] && StateType != A && EnemyNear,StateType != A || P2BodyDist X <= 40 && !numtarget(860) && StateType = A && EnemyNear,StateType = A

;---------------------------------------------------------------------------
; Throw
[State -1, X+A]
type = ChangeState
value = ifelse(StateType=A,850,800)
;triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && Time <= 2 && PrevStateNo != [200,800) || StateNo = [600,800) && MoveHit
trigger1 = (map(b_x) && map(b_a) || map(b_xa)) && !Var(15)
trigger2 = Var(17) = 800 && Var(15) && (Random < 500 || Name = "WALL")
trigger2 = P2BodyDist X = [-8,const(size.ground.front)] && StateType != A && EnemyNear,StateType != A || P2BodyDist X <= 40 && !numtarget(860) && StateType = A && EnemyNear,StateType = A

;===========================================================================
;---------------------------------------------------------------------------
; SP Der Nachtflieger
[State -1, QCB,b]
type = ChangeState
value = 1603
triggerall = statetype != A
triggerall = Name = "WALK"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(QCB) && map(b_b) && !Var(15)

;---------------------------------------------------------------------------
; LP Der Nachtflieger
[State -1, QCB,a]
type = ChangeState
value = 1602
triggerall = statetype != A
triggerall = Name = "WALK"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(QCB) && map(b_a) && !Var(15)

;---------------------------------------------------------------------------
; SP Der Nachtflieger
[State -1, QCF,b]
type = ChangeState
value = 1601
triggerall = statetype != A
triggerall = Name = "WALK"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(QCF) && map(b_b) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 350

;---------------------------------------------------------------------------
; LP Der Nachtflieger
[State -1, QCF,a]
type = ChangeState
value = 1600
triggerall = statetype != A
triggerall = Name = "WALK"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(QCF) && map(b_a) && !Var(15)
trigger2 = (Var(17) = 1600 || Var(17) = 1700) && Var(15) && Random < 350

;---------------------------------------------------------------------------
; SP Achilles Hell
[State -1, QCF,b]
type = ChangeState
value = 1501
triggerall = statetype != A
triggerall = Name = "WALX"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(QCF) && map(b_b) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LP Achilles Hell
[State -1, QCF,a]
type = ChangeState
value = 1500
triggerall = statetype != A
triggerall = Name = "WALX"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(QCF) && map(b_a) && !Var(15)
trigger2 = Var(17) = 1400 && Var(15)

;---------------------------------------------------------------------------
; SP Nachwehen
[State -1, 360,y]
type = ChangeState
value = 1701
triggerall = statetype != A
triggerall = Name = "WALK"
triggerall = ctrl || StateNo = 40 || StateNo = 55 || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 && StateNo != 420) && MoveContact || (StateNo = 1000 || StateNo = 1500) && Time <= 2
trigger1 = (map(HCB) || map(f360) || map(r360)) && map(b_y) && !Var(15)
trigger2 = Var(17) = 800 && Var(15)
trigger2 = P2BodyDist X = [-8,const(size.ground.front)] && StateType != A && EnemyNear,StateType != A || P2BodyDist X <= 40 && !numtarget(860) && StateType = A && EnemyNear,StateType = A

;---------------------------------------------------------------------------
; LP Nachwehen
[State -1, 360,x]
type = ChangeState
value = 1700
triggerall = statetype != A
triggerall = Name = "WALK"
triggerall = ctrl || StateNo = 40 || StateNo = 55 || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 && StateNo != 420) && MoveContact || (StateNo = 1000 || StateNo = 1500) && Time <= 2
trigger1 = (map(HCB) || map(f360) || map(r360)) && map(b_x) && !Var(15)
trigger2 = Var(17) = 800 && Var(15)
trigger2 = P2BodyDist X = [-8,const(size.ground.front)] && StateType != A && EnemyNear,StateType != A || P2BodyDist X <= 40 && !numtarget(860) && StateType = A && EnemyNear,StateType = A

;---------------------------------------------------------------------------
; SP Unterwelt Zerbrechen
[State -1, HCB,y]
type = ChangeState
value = 1401
triggerall = statetype != A
triggerall = Name != "WALK"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveHit || StateNo = [200,800) && Time <= 2
trigger1 = map(HCB) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1000 && Var(15) && Random < 100
trigger2 = EnemyNear,StateType = A && P2Dist X = [112,168]
trigger3 = Var(17) = 1100 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; LP Unterwelt Zerbrechen
[State -1, HCB,x]
type = ChangeState
value = 1400
triggerall = statetype != A
triggerall = Name != "WALK"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveHit || StateNo = [200,800) && Time <= 2
trigger1 = map(HCB) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1000 && Var(15) && Random < 100
trigger2 = EnemyNear,StateType != A && P2Dist X = [112,168]

;---------------------------------------------------------------------------
; SK Turmbrecher
[State -1, ChDU,b]
type = ChangeState
value = 1301
triggerall = statetype != A
triggerall = Name = "WALL"
triggerall = ctrl || StateNo = [39,40] || StateNo = 55 || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(b_b) && !Var(15)
trigger1 = Var(44) >= 24 && ((map(p_Up)>0) || command = "up")
trigger2 = Var(17) = 1700 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LK Turmbrecher
[State -1, ChDU,a]
type = ChangeState
value = 1300
triggerall = statetype != A
triggerall = Name = "WALL"
triggerall = ctrl || StateNo = [39,40] || StateNo = 55 || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(b_a) && !Var(15)
trigger1 = Var(44) >= 24 && ((map(p_Up)>0) || command = "up")
trigger2 = Var(17) = 1700 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SP Mondherrschaft
[State -1, DP,y]
type = ChangeState
value = 1101 + 700 * (Name="WALK")
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(DP) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 500 && Name != "WALK"
trigger3 = (Var(17) = 1100 || Var(17) = 1200 && EnemyNear,StateType = A) && Var(15) && Random < 500 && Name = "WALK"

;---------------------------------------------------------------------------
; LP Mondherrschaft
[State -1, DP,x]
type = ChangeState
value = 1100 + 700 * (Name="WALK")
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(DP) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 500 && Name != "WALK"
trigger3 = (Var(17) = 1100 || Var(17) = 1200 && EnemyNear,StateType = A) && Var(15) && Random < 500 && Name = "WALK"

;---------------------------------------------------------------------------
; SP Todesgerat
[State -1, HCF,y]
type = ChangeState
value = 1001
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(HCF) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; LP Todesgerat
[State -1, HCF,x]
type = ChangeState
value = 1000
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(HCF) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; SP Friedhofsbeben
[State -1, DD,y]
type = ChangeState
value = 1201
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(DD) && map(b_y) && !Var(15)
trigger2 = (Var(17) = 1000 || Var(17) = 1700) && Var(15) && Random < 250 && EnemyNear,StateType != A

;---------------------------------------------------------------------------
; LP Friedhofsbeben
[State -1, DD,x]
type = ChangeState
value = 1200
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(DD) && map(b_x) && !Var(15)
trigger2 = (Var(17) = 1000 || Var(17) = 1700) && Var(15) && Random < 500 && EnemyNear,StateType != A

;===========================================================================
;---------------------------------------------------------------------------
; CN f+SP
[State -1, st.f+SP]
type = ChangeState
value = 215
triggerall = statetype != A
triggerall = stateno != 215 && stateno != 305
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = 210 && Time <= 2
trigger1 = map(b_y) && (map(p_Fd)>0) && !(map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 205 && Var(15) && Random < 500 && EnemyNear,StateType != A
trigger3 = Var(17) = 205 && Var(15) && Random < 100 && EnemyNear,StateType = A

;---------------------------------------------------------------------------
; CN f+LK
[State -1, st.f+LK]
type = ChangeState
value = 305
triggerall = statetype != A
triggerall = Name != "WALX"
triggerall = stateno != 215 && stateno != 305
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = 300 && Time <= 2
trigger1 = map(b_a) && (map(p_Fd)>0) && !(map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 205 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; CN ju.d+SP
[State -1, ju.d+SP]
type = ChangeState
value = 615
triggerall = statetype = A
triggerall = StateNo != 615
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && MoveContact || StateNo = 610 && Time <= 2
triggerall = Vel Y > const(velocity.jump.y)*0.5 || MoveContact
trigger1 = map(b_y) && (map(p_Dn)>0) && !Var(15)
trigger2 = (Var(17) = 1300 || Var(17) = 1600) && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Standing LP
[State -1, st.LP]
type = ChangeState
value = 200
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101])
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
trigger3 = (Var(17) = 1000 || Var(17) = 1400) && Var(15) && Random < 250 && P2BodyDist X < 160

;---------------------------------------------------------------------------
; Standing LK
[State -1, st.LK]
type = ChangeState
value = 300
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101])
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
triggerall = ctrl || (StateNo = [100,101])
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
triggerall = ctrl || (StateNo = [100,101])
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
; Taunt
[State -1, Taunt]
type = ChangeState
value = 165
triggerall = statetype != A
triggerall = ctrl
trigger1 = command = "s" && !Var(15)
trigger2 = Var(17) = 165 && Var(15)
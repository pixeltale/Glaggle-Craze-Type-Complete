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
name = "holdfwd_unbuffer"
command = /F
time = 2
buffer.time = 0
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

; between heaven and angels
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
value = 102 + 8 * (Name="TERX")
triggerall = ctrl
triggerall = statetype = S || statetype = C && Var(15)
trigger1 = (command="FF" || map(b_66)) && !Var(15)
trigger2 = Var(17) = 100 && Var(15)

;Run Fwd
[State -1, Run Fwd]
type = ChangeState
value = 110
triggerall = name = "TERX"
trigger1 = command = "FF"
trigger1 = stateno = [200, 500] && movecontact = 1

;---------------------------------------------------------------------------
;Run Back
[State -1, Run Back]
type = ChangeState
value = 105 + 10 * name = "TERX"
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
triggerall = (StateNo = [200,800) || StateNo = [950,1000] || StateNo = [1010,1020] || StateNo = 1050 || StateNo = 1100 || StateNo = 1150 && Var(7) < 0 || StateNo = 1300) && MoveHit || StateNo = 910 && Time >= 40 || StateNo = 1030 && Time >= 40 || StateNo = 1060 && Time >= 50 || StateNo = 1150 && (NumHelper(1160) || MoveType = I) && MoveHit || StateNo = 1210 && Time >= 41
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
triggerall = StateNo != [800,900) && StateNo != 910 && StateNo != 1030 && StateNo != 1150 && StateNo != [1200,1210] || StateNo = 1150 && MoveGuarded
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
triggerall = (ctrl || StateNo < 120) && !Var(51) || StateNo = 1150 && Var(7) >= 0 && (NumHelper(1160) || MoveType = I) && !MoveContact
trigger1 = map(b_a) && map(b_y) && map(b_x) && map(b_b) && !Var(15)
trigger2 = Var(17) = 3000 && Var(15)

;===========================================================================
;---------------------------------------------------------------------------
; Long Forgotten
[State -1, 2QCB,2p]
type = ChangeState
value = 2600
triggerall = statetype != A
triggerall = Power >= 3000
triggerall = Name = "TERK"
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && MoveContact || StateNo = 1350 && Time <= 2
trigger1 = map(QCBQC) && map(b_xy) && !Var(15)
trigger2 = (Var(17) = 1200 || Var(17) = 1300) && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Strip Down
[State -1, 2QCB,2p]
type = ChangeState
value = 2300 + 50 * !!MoveContact
triggerall = statetype != A
triggerall = Power >= 3000
triggerall = Name != "TERK"
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && MoveContact || StateNo = 1300 && PrevStateNo < 1000 && Time <= 2
trigger1 = map(QCBQC) && map(b_xy) && !Var(15)
trigger2 = (Var(17) = 1200 || Var(17) = 1300) && Var(15) && Random < 350

;---------------------------------------------------------------------------
; Burn Out
[State -1, 2QCF,2k]
type = ChangeState
value = 2200 + (300 * Name="TERK")
triggerall = statetype != A
;triggerall = Name != "TERK"
triggerall = Power >= 2000
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && MoveContact
trigger1 = map(QCFQC) && map(b_ab) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 350
trigger3 = Var(17) = 1300 && EnemyNear,StateType != A && Var(15) && Random < 500 && Name = "TERK"

;---------------------------------------------------------------------------
; Carve Out
[State -1, 2QCB,k]
type = ChangeState
value = 2400
triggerall = statetype != A
triggerall = Name = "TERK"
triggerall = Power >= 1000
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && MoveContact
trigger1 = map(QCBQC) && (map(b_a) || map(b_b)) && !Var(15)
trigger2 = Var(17) = 2300 && Var(15) && Random < 350

;---------------------------------------------------------------------------
; Tear Out SK
[State -1, 2QCB,b]
type = ChangeState
value = 2101
triggerall = statetype != A
triggerall = Name != "TERK"
triggerall = Power >= 1000
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && MoveContact
trigger1 = map(QCBQC) && map(b_b) && !Var(15)
trigger2 = (Var(17) = 1300 && EnemyNear,StateType != A || Var(17) = 1700) && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Tear Out LK
[State -1, 2QCB,a]
type = ChangeState
value = 2100
triggerall = statetype != A
triggerall = Name != "TERK"
triggerall = Power >= 1000
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && MoveContact
trigger1 = map(QCBQC) && map(b_a) && !Var(15)
trigger2 = Var(17) = 800 && Var(15) && Random < 500
trigger2 = P2BodyDist X = [-8,const(size.ground.front)] && StateType != A && EnemyNear,StateType != A || P2BodyDist X <= 40 && !numtarget(860) && StateType = A && EnemyNear,StateType = A

;---------------------------------------------------------------------------
; Top Falls Down
[State -1, 2QCF,y]
type = ChangeState
value = 2000
triggerall = statetype != A
triggerall = Power >= 1000
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && MoveContact
trigger1 = map(QCFQC) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 350

;---------------------------------------------------------------------------
; Killing Communication
[State -1, 2QCF,x]
type = ChangeState
value = 2050
triggerall = statetype != A
triggerall = Power >= 1000
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && MoveContact || StateNo = 1000 && PrevStateNo < 1000 && Time <= 2
trigger1 = map(QCFQC) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1000 && Var(15) && Random < 100

;===========================================================================
;---------------------------------------------------------------------------
; Demon Off
[State -1, Y+B]
Type = ChangeState
Value = 961
triggerall = StateType != A
triggerall = Name = "TERK" && !!Map(TerkDemon)
triggerall = Ctrl && StateNo != 960 || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [1000,3000) && MoveType = I
trigger1 = Map(TerkDemon) = 1
trigger2 = (map(b_y) && map(b_b) || map(b_yb) || (command = "holdy" && command = "holdb" || command = "holdc") && AnimTime = 0 && (PrevStateNo = [200,900) || PrevStateNo = [1000,2000))) && !Var(15)
trigger3 = Map(TerkDemon) < 300 && Var(15) && (Var(17) = 900 || MoveHit)

;---------------------------------------------------------------------------
; Demon
[State -1, Y+B]
type = ChangeState
value = 960
triggerall = statetype != A
triggerall = Name = "TERK" && !Map(TerkDemon)
triggerall = ctrl && StateNo != 960 || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = Var(17) = 900 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Driven Under
[State -1, Y+B]
type = ChangeState
value = 950 + (StateType=A)
triggerall = Name = "TERX"
triggerall = StateType != A || Var(1)
triggerall = ctrl || StateNo = [39,40] || StateNo = 55 || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = (Var(17) = 100 || Var(17) = 1700) && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Auger
[State -1, Y+B]
type = ChangeState
value = 900
triggerall = statetype != A
triggerall = Name = "TERI"
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,510) && MoveContact
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = (Var(17) = 1200 || Var(17) = 1700) && Var(15) && Random < 350

;---------------------------------------------------------------------------
; Throw
[State -1, X+A]
type = ChangeState
value = ifelse(StateType=A,850,800)
;triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && Time <= 2 && PrevStateNo != [200,800) || StateNo = [600,800) && MoveHit
trigger1 = (map(b_x) && map(b_a) || map(b_xa)) && !Var(15)
trigger2 = Var(17) = 800 && Var(15) && (Random < 500 || Name = "TERK")
trigger2 = P2BodyDist X = [-8,const(size.ground.front)] && StateType != A && EnemyNear,StateType != A || P2BodyDist X <= 40 && !numtarget(860) && StateType = A && EnemyNear,StateType = A

;===========================================================================
;---------------------------------------------------------------------------
; Undercurrent SK
[State -1, QCF,b]
type = ChangeState
value = 1301
triggerall = statetype != A
triggerall = Name != "TERX"
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,510) && MoveContact
trigger1 = map(QCF) && map(b_b) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Undercurrent LK
[State -1, QCF,a]
type = ChangeState
value = 1300
triggerall = statetype != A
triggerall = Name != "TERX"
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,510) && MoveContact
trigger1 = map(QCF) && map(b_a) && !Var(15)
trigger2 = Var(17) = 100 && Var(15) && Random < 125
trigger3 = Var(17) = 1700 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Knock Down Walls SK
[State -1, QCB,b]
type = ChangeState
value = 1251
triggerall = statetype != A
triggerall = Name = "TERK"
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,510) && MoveContact
trigger1 = map(QCB) && map(b_b) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 125

;---------------------------------------------------------------------------
; Knock Down Walls LK
[State -1, QCB,a]
type = ChangeState
value = 1250
triggerall = statetype != A
triggerall = Name = "TERK"
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,510) && MoveContact
trigger1 = map(QCB) && map(b_a) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 350

;---------------------------------------------------------------------------
; Crowd Control SK
[State -1, QCB,b]
type = ChangeState
value = 1201
triggerall = statetype != A
triggerall = Name != "TERK"
triggerall = ctrl || StateNo = 40 || StateNo = 55 || (StateNo = [100,101]) || StateNo = [200,510) && MoveContact
trigger1 = (map(HCB) || COMMAND = "HCB" || map(f360) || map(r360)) && map(b_b) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 350

;---------------------------------------------------------------------------
; Crowd Control LK
[State -1, HCB,a]
type = ChangeState
value = 1200
triggerall = statetype != A
triggerall = Name != "TERK"
triggerall = ctrl || StateNo = 40 || StateNo = 55 || (StateNo = [100,101]) || StateNo = [200,510) && MoveContact
trigger1 = (map(HCB) || COMMAND = "HCB" || map(f360) || map(r360)) && map(b_a) && !Var(15)
trigger2 = Var(17) = 800 && Var(15) && Random < 500
trigger2 = P2BodyDist X = [-8,const(size.ground.front)] && StateType != A && EnemyNear,StateType != A || P2BodyDist X <= 40 && !numtarget(860) && StateType = A && EnemyNear,StateType = A

;---------------------------------------------------------------------------
; Oppress Claw SP
[State -1, QCB,y]
type = ChangeState
value = 1101 + 49 * (Name="TERK")
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,510) && MoveContact
trigger1 = map(QCB) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1300 && Var(15) && Random < 500 && Name != "TERK"
trigger3 = (Var(17) = 900 || Var(17) = 1000) && Var(15) && Random < 500 && Name = "TERK"

;---------------------------------------------------------------------------
; Oppress Claw LP
[State -1, QCB,x]
type = ChangeState
value = 1100; + 50 * (Name="TERK")
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,510) && MoveContact
trigger1 = map(QCB) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 350

;---------------------------------------------------------------------------
; Trapper
[State -1, QCF,y]
type = ChangeState
value = 1001
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,510) && MoveContact
trigger1 = map(QCF) && map(b_y) && !Var(15)
trigger2 = (Var(17) = 1100 || Var(17) = 1200) && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Huntress
[State -1, QCF,x]
type = ChangeState
value = 1000
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,510) && MoveContact
trigger1 = map(QCF) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 500

;===========================================================================
;---------------------------------------------------------------------------
; CB f+SP
[State -1, st.f+SP]
type = ChangeState
value = 215
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,510) && MoveContact
triggerall = StateNo != 215 && StateNo != 305
trigger1 = map(b_y) && (map(p_Fd)>0) && !(map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 205 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; CB f+SK
[State -1, st.f+SK]
type = ChangeState
value = 305
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,510) && MoveContact
triggerall = StateNo != 215 && StateNo != 305
trigger1 = map(b_b) && (map(p_Fd)>0) && !(map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 500

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
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = 200 || StateNo = 300 || StateNo = 400 || StateNo = 500) && MoveContact || StateNo = 13
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
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = 200 || StateNo = 300 || StateNo = 400 || StateNo = 500) && MoveContact || StateNo = 13
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
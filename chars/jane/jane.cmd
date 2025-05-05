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

; theres no good or bad in there
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
;Burnout
[State -1, Burnout]
type = ChangeState
value = 4000
triggerall = ctrl || StateNo <= 3000 && MoveType = I
triggerall = Name = "JANX"
triggerall = RoundState = 2
trigger1 = Var(43) >= 5 && Var(44) <= 1

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
triggerall = !(Name="JANX"&&Var(43)>=5)
triggerall = RoundState = 2
triggerall = var(18) >= 3000 && !Map(CCDisable)
triggerall = !MoveGuarded && !Ctrl && !MoveReversed
triggerall = (StateNo = [200,800) || StateNo = 920 || StateNo = [1100,1300]) && MoveHit || StateNo = 215 && (NumHelper(216) || MoveType = I) && MoveHit || (StateNo = 1000 || StateNo = 1005) && (NumHelper(1010) || MoveType = I) && MoveHit 
trigger1 = map(b_a) && map(b_y) && map(b_x) && map(b_b) && !Var(15)
trigger2 = Var(17) = 3000 && Var(15)

;---------------------------------------------------------------------------
; Craze Assault
[State -1, A+Y / X+B]
type = ChangeState
value = 3001
triggerall = !(Name="JANX"&&Var(43)>=5)
triggerall = RoundState = 2
triggerall = var(18) >= 2000 && !Map(CCDisable)
triggerall = StateNo = [200,2000) && !Ctrl && (!Var(51) || MoveType = I) && !MoveReversed
triggerall = StateNo != [800,900)
triggerall = !MoveContact && !Var(51) || MoveGuarded
triggerall = StateNo != [1000,1100) || (StateNo = 1000 || StateNo = 1005) && (NumHelper(1010) || MoveType = I) && MoveGuarded
trigger1 = map(b_a) && map(b_y) && map(b_x) && map(b_b) && !Var(15)
trigger2 = Var(17) = 3000 && Var(15)

;---------------------------------------------------------------------------
; Craze Focus
[State -1, A+Y / X+B]
type = ChangeState
value = 3000
triggerall = !(Name="JANX"&&Var(43)>=5)
triggerall = RoundState = 2
triggerall = var(18) >= 1000 && !Map(CCDisable)
triggerall = StateNo != [3000,4000)
triggerall = (ctrl || StateNo < 120) && !Var(51) || (StateNo = 1000 || StateNo = 1005) && (NumHelper(1010) || MoveType = I) && !MoveContact
trigger1 = map(b_a) && map(b_y) && map(b_x) && map(b_b) && !Var(15)
trigger2 = Var(17) = 3000 && Var(15)

;===========================================================================
;---------------------------------------------------------------------------
; Freaks' Finale
[State -1, 2QCB,2p]
type = ChangeState
value = 2300
triggerall = statetype != A
triggerall = Power >= 3000
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,510)) && MoveContact
trigger1 = map(QCBQC) && map(b_xy) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 500 

;---------------------------------------------------------------------------
; Mistress of Broilty
[State -1, 2QCB,2k]
type = ChangeState
value = 2400
triggerall = statetype != A
triggerall = Name = "JANX"
triggerall = Power >= 1000
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,510) || StateNo = [600,710]) && MoveContact
trigger1 = map(QCBQC) && (map(b_a) || map(b_b)) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; The Pumpkin Queen?
[State -1, 2QCB,2k]
type = ChangeState
value = 2200 + 300 * (Name!="JANE")
triggerall = statetype != A || Name != "JANE"
triggerall = Power >= 2000
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,510) || StateNo = [600,710]) && MoveContact || StateNo = 950 && Time <= 2 && PrevStateNo != 999
trigger1 = map(QCBQC) && map(b_ab) && !Var(15) && Name != "JANX"
trigger2 = map(DD) && map(b_ab) && !Var(15) && Name = "JANX"
trigger3 = Var(17) = 1300 && Var(15) && Random < 350 && Name = "JANE"
trigger4 = Var(17) = 900 && Var(15) && Random < 250 && Name = "JANX"
trigger5 = Var(17) = 1000 && Var(15) && Random < 350 && Name = "JANK"

;---------------------------------------------------------------------------
; SK Scary Loathe
[State -1, 2QCF,b]
type = ChangeState
value = 2101
triggerall = statetype != A
triggerall = Power >= 1000
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,510)) && MoveContact
trigger1 = map(QCFQC) && map(b_b) && !Var(15)
trigger2 = Var(17) = 1300 && Var(15) && Random < 350

;---------------------------------------------------------------------------
; LK Scary Loathe
[State -1, 2QCF,a]
type = ChangeState
value = 2100
triggerall = statetype != A
triggerall = Power >= 1000
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,510)) && MoveContact
trigger1 = map(QCFQC) && map(b_a) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 350

;---------------------------------------------------------------------------
; Burning Brouhaha
[State -1, 2QCF,p]
type = ChangeState
value = 2000
triggerall = statetype != A
triggerall = Power >= 1000
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,510)) && MoveContact
trigger1 = map(QCFQC) && (map(b_x) || map(b_y)) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 350

;===========================================================================
;---------------------------------------------------------------------------
; CTech Archimedes' Advance
[State -1, Y+B]
type = ChangeState
value = 930
triggerall = Name = "JANK"
triggerall = statetype != A
triggerall = NumHelper(940) = 0
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,510)) && MoveContact
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = Var(17) = 900 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; CTech Out to Fry
[State -1, Y+B]
type = ChangeState
value = 920
triggerall = Name = "JANX"
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,510)) && MoveContact
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = Var(17) = 900 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; CTech Booming Fright Det2
[State -1, d.Y+B]
type = ChangeState
value = 906
triggerall = Name = "JANE"
triggerall = cond(NumHelper(910),Helper(910),StateNo != 916,0)
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,510) || StateNo = [600,800)) && MoveContact
trigger1 = (map(p_Dn)>0) && (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = Var(17) = 900 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; CTech Booming Fright Det1
[State -1, Y+B]
type = ChangeState
value = 905
triggerall = Name = "JANE"
triggerall = cond(NumHelper(910),Helper(910),StateNo != 916,0)
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,510) || StateNo = [600,800)) && MoveContact
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = Var(17) = 900 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; CTech Booming Fright
[State -1, Y+B]
type = ChangeState
value = 900
triggerall = Name = "JANE"
triggerall = statetype != A
triggerall = NumHelper(910) = 0
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,510)) && MoveContact
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = Var(17) = 900 && Var(15) && Random < 250

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
; Frozen Strut
[State -1, KK]
type = ChangeState
value = 950
triggerall = Name = "JANK"
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,510)) && (MoveContact || Time <= 2)
trigger1 = (map(b_a) && map(b_b) || map(b_ab)) && !Var(15)
trigger2 = Var(17) = 1300 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SK Rigor Repulse
[State -1, QCB,b]
type = ChangeState
value = 1301
triggerall = Name != "JANK"
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,510)) && MoveContact
trigger1 = map(QCB) && map(b_b) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LK Rigor Repulse
[State -1, QCB,a]
type = ChangeState
value = 1300
triggerall = Name != "JANK"
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,510)) && MoveContact
trigger1 = map(QCB) && map(b_a) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 350

;---------------------------------------------------------------------------
; SP Flarespin
[State -1, QCB,y]
type = ChangeState
value = 1201
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,510)) && MoveContact
trigger1 = map(QCB) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 350

;---------------------------------------------------------------------------
; LP Flarespin
[State -1, QCB,x]
type = ChangeState
value = 1200
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,510)) && MoveContact
trigger1 = map(QCB) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; SP Backburner
[State -1, ju.QCB,y]
type = ChangeState
value = 1101 + 50 * (Name="JANK")
triggerall = statetype = A
triggerall = StateNo != [1100,1200)
triggerall = ctrl && Vel Y > -3.5 || (StateNo = [200,215) || StateNo = (215,800)) && MoveContact
trigger1 = map(QCB) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; LP Backburner
[State -1, ju.QCB,x]
type = ChangeState
value = 1100 + 50 * (Name="JANK")
triggerall = statetype = A
triggerall = StateNo != [1100,1200)
triggerall = ctrl && Vel Y > -3.5 || (StateNo = [200,215) || StateNo = (215,800)) && MoveContact
trigger1 = map(QCB) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; SP Pyro-aired
[State -1, QCF,y]
type = ChangeState
value = 1006
triggerall = statetype = A
triggerall = StateNo != 1005
triggerall = ctrl || (StateNo = [200,215) || StateNo = (215,800)) && MoveContact
triggerall = !NumHelper(1010)
trigger1 = map(QCF) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1000 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; LP Pyro-aired
[State -1, QCF,x]
type = ChangeState
value = 1005
triggerall = statetype = A
triggerall = StateNo != 1005
triggerall = ctrl || (StateNo = [200,215) || StateNo = (215,800)) && MoveContact
triggerall = !NumHelper(1010)
trigger1 = map(QCF) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1000 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; SP Pyro-uette
[State -1, QCF,y]
type = ChangeState
value = 1001
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,510)) && MoveContact
triggerall = !NumHelper(1010)
trigger1 = map(QCF) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1000 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; LP Pyro-uette
[State -1, QCF,x]
type = ChangeState
value = 1000
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,510)) && MoveContact
triggerall = !NumHelper(1010)
trigger1 = map(QCF) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1000 && Var(15) && Random < 500

;===========================================================================
;---------------------------------------------------------------------------
; CN f+LK
[State -1, st.f+LK]
type = ChangeState
value = 315
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = 200 || StateNo = 210 || StateNo = 300 || StateNo = 310 || StateNo = 400 || StateNo = 410 || StateNo = 500) && MoveContact
trigger1 = map(b_a) && !(map(p_Dn)>0) && (map(p_Fd)>0) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; CN b+LK
[State -1, st.b+LK]
type = ChangeState
value = 320
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = 200 || StateNo = 210 || StateNo = 300 || StateNo = 310 || StateNo = 400 || StateNo = 410 || StateNo = 500) && MoveContact
trigger1 = map(b_a) && !(map(p_Dn)>0) && (map(p_Bk)>0) && !Var(15)
trigger2 = Var(17) = 410 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; CN f+LP
[State -1, st.f+LP]
type = ChangeState
value = 215
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = 200 || StateNo = 210 || StateNo = 300 || StateNo = 310 || StateNo = 400 || StateNo = 410 || StateNo = 500) && MoveContact
trigger1 = map(b_x) && !(map(p_Dn)>0) && (map(p_Fd)>0) && !Var(15)
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
value = 165 + cond(NumHelper(910),Helper(910),StateNo = 916,0)
triggerall = statetype != A
triggerall = ctrl
trigger1 = command = "s" && !Var(15)
trigger2 = Var(17) = 165 && Var(15)
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

; tell me who wants to look back on their years and wonder where those years have gone
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
;Crawl Fwd
[State -1, Crawl Fwd]
type = ChangeState
value = 25
;triggerall = Name = "TYRK"
triggerall = ctrl && StateNo != 25
triggerall = statetype != A
trigger1 = (map(p_Fd)>0) && (map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 30 && Var(15)


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
triggerall = !MoveHit || StateNo = [200,800) && StateNo != [225,230)
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
triggerall = !(StateNo = 225 && MoveHit) && !(StateNo = 226 && AnimElem = 15, <= 1)
triggerall = (StateNo = [200,800) || StateNo = [900,930] || StateNo = [1000,1130) || StateNo = [1200,1500) || StateNo = 1550 || StateNo = [1700,1710]) && MoveHit || StateNo = 1131 && AnimElem = 15, >= 1 || StateNo = 1160 && AnimElem = 21, >= 1 || StateNo = 1500 && MoveHit && (NumHelper(1510) || MoveType = I) || StateNo = 1613 && AnimElem = 17, >= 3
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
triggerall = StateNo != [800,900) && StateNo != [1130,1131] && StateNo != [1150,1170] && StateNo != 1300 && StateNo != 1500 && StateNo != [1600,1700) || StateNo = 1300 && MoveGuarded && (NumHelper(1310) || MoveType = I) || StateNo = 1500 && MoveGuarded && (NumHelper(1510) || MoveType = I)
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
triggerall = (ctrl || StateNo < 120) && !Var(51) || StateNo = 1300 && !MoveContact && (NumHelper(1310) || MoveType = I) || StateNo = 1500 && !MoveContact && (NumHelper(1510) || MoveType = I)
trigger1 = map(b_a) && map(b_y) && map(b_x) && map(b_b) && !Var(15)
trigger2 = Var(17) = 3000 && Var(15)

;===========================================================================
;---------------------------------------------------------------------------
; THE WORLD CONSUMED
[State -1, 2QCF,2k]
type = ChangeState
value = 2200 + 600 * (Name="TYRK")
triggerall = statetype != A
triggerall = !(StateNo = 225 && MoveHit) && !(StateNo = 226 && AnimElem = 15, <= 1)
triggerall = Power >= 3000
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && MoveContact || (StateNo = [200,800) || StateNo = 1100 || StateNo = 1300) && Time <= 2 || StateNo = 930 && MoveContact && Map(TyrxDoom)
trigger1 = map(QCFQC) && map(b_ab) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; SLAM BAM IM FEELIN ALRIGHT
[State -1, 360,2k]
type = ChangeState
value = 2700
triggerall = statetype != A
triggerall = Name = "TYRK"
triggerall = !(StateNo = 225 && MoveHit) && !(StateNo = 226 && AnimElem = 15, <= 1)
triggerall = Power >= 2000
triggerall = ctrl || StateNo = 40 || StateNo = 55 || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveHit || (StateNo = [200,800)) && Time <= 2
trigger1 = (map(HCB) || map(f360) || map(r360)) && map(b_ab) && !Var(15)
trigger2 = Var(17) = 1300 && Var(15) && Random < 350
trigger3 = Var(17) = 800 && Var(15) && Random < 350
trigger3 = P2BodyDist X = [-8,const(size.ground.front)] && StateType != A && EnemyNear,StateType != A || P2BodyDist X <= 40 && !numtarget(860) && StateType = A && EnemyNear,StateType = A


;---------------------------------------------------------------------------
; VULCAN BEAM
[State -1, 2QCF,2p]
type = ChangeState
value = 2150
triggerall = statetype != A
triggerall = Name != "TYRK"
triggerall = Power >= 2000 - 1000 * (StateNo = 2100)
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && MoveContact || (StateNo = [200,800) || StateNo = 2100) && Time <= 2 || StateNo = 930 && MoveContact && Map(TyrxDoom)
trigger1 = map(QCFQC) && map(b_xy) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 350

;---------------------------------------------------------------------------
; DEBT OF WAR
[State -1, 360,2p]
type = ChangeState
value = 2300
triggerall = statetype != A
triggerall = Name != "TYRA"
triggerall = !(StateNo = 225 && MoveHit) && !(StateNo = 226 && AnimElem = 15, <= 1)
triggerall = Power >= 1000
triggerall = ctrl || StateNo = 40 || StateNo = 55 || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveHit || (StateNo = [200,800) || StateNo = 1000 || StateNo = 1170) && Time <= 2 || StateNo = 930 && Map(TyrxDoom)
trigger1 = (map(HCB) || map(f360) || map(r360)) && map(b_xy) && !Var(15)
trigger2 = Var(17) = 800 && Var(15) && Random < 500
trigger2 = P2BodyDist X = [-8,const(size.ground.front)] && StateType != A && EnemyNear,StateType != A || P2BodyDist X <= 40 && !numtarget(860) && StateType = A && EnemyNear,StateType = A

;---------------------------------------------------------------------------
; VULCAN FLAME
[State -1, 2QCF,p]
type = ChangeState
value = 2100 + 400 * (Name="TYRK")
triggerall = statetype != A
triggerall = !(StateNo = 225 && MoveHit) && !(StateNo = 226 && AnimElem = 15, <= 1)
triggerall = Power >= 1000
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2 || StateNo = 930 && MoveContact && Map(TyrxDoom)
trigger1 = map(QCFQC) && (map(b_x) || map(b_y)) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SP DELTA CAULDRON
[State -1, 2QCB,sp]
type = ChangeState
value = 2401
triggerall = statetype != A
triggerall = Name = "TYRX"
triggerall = Power >= 1000
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2 || StateNo = 930 && MoveContact && Map(TyrxDoom)
trigger1 = map(QCBQC) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1100 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LP DELTA CAULDRON
[State -1, 2QCB,lp]
type = ChangeState
value = 2400
triggerall = statetype != A
triggerall = Name = "TYRX"
triggerall = Power >= 1000
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2 || StateNo = 930 && MoveContact && Map(TyrxDoom)
trigger1 = map(QCBQC) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1100 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; GRAIL TEMPEST
[State -1, 2QCB,p]
type = ChangeState
value = 2000
triggerall = statetype != A
triggerall = Name = "TYRA"
triggerall = Power >= 1000
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(QCBQC) && (map(b_x) || map(b_y)) && !Var(15)
trigger2 = (Var(17) = 1200 || Var(17) = 1300) && Var(15) && Random < 350

;===========================================================================
;---------------------------------------------------------------------------
; WAR CRY
[State -1, Y+B]
type = ChangeState
value = 920
triggerall = statetype != A
triggerall = !(StateNo = 225 && MoveHit) && !(StateNo = 226 && AnimElem = 15, <= 1)
triggerall = Name = "TYRK"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = (Var(17) = 900 || Var(17) = 1200) && Var(15) && Random < 250

;---------------------------------------------------------------------------
; GRAIL WAVE
[State -1, Y+B]
type = ChangeState
value = 930
triggerall = statetype != A
triggerall = Name = "TYRX"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = (Var(17) = 1300 || Var(17) = 1700) && Var(15) && Random < 500

;---------------------------------------------------------------------------
; DEVIL'S SCUTUM
[State -1, Y+B]
type = ChangeState
value = 900
triggerall = statetype != A
triggerall = Name = "TYRA"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = (Var(17) = 1200 || Var(17) = 1700) && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Throw
[State -1, X+A]
type = ChangeState
value = ifelse(StateType=A,850,800)
;triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && Time <= 2 && PrevStateNo != [200,800) || StateNo = [600,800) && MoveHit
trigger1 = (map(b_x) && map(b_a) || map(b_xa)) && !Var(15)
trigger2 = Var(17) = 800 && Var(15) && (Random < 500 || Name = "TYRA")
trigger2 = P2BodyDist X = [-8,const(size.ground.front)] && StateType != A && EnemyNear,StateType != A || P2BodyDist X <= 40 && !numtarget(860) && StateType = A && EnemyNear,StateType = A

;===========================================================================
;---------------------------------------------------------------------------
; SK PRIMAL BURN b
[State -1, QCB,b]
type = ChangeState
value = 1303
triggerall = statetype != A
triggerall = Name = "TYRX" && !NumHelper(1310)
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2 || StateNo = 930 && MoveContact && Map(TyrxDoom)
trigger1 = map(QCB) && map(b_b) && !Var(15)
trigger2 = (Var(17) = 900 || Var(17) = 1000) && Var(15) && Random < 125

;---------------------------------------------------------------------------
; LK PRIMAL BURN b
[State -1, QCB,a]
type = ChangeState
value = 1302
triggerall = statetype != A
triggerall = Name = "TYRX" && !NumHelper(1310)
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2 || StateNo = 930 && MoveContact && Map(TyrxDoom)
trigger1 = map(QCB) && map(b_a) && !Var(15)
trigger2 = (Var(17) = 900 || Var(17) = 1000) && Var(15) && Random < 125

;---------------------------------------------------------------------------
; SK PRIMAL BURN f
[State -1, QCF,b]
type = ChangeState
value = 1301
triggerall = statetype != A
triggerall = Name = "TYRX" && !NumHelper(1310)
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2 || StateNo = 930 && MoveContact && Map(TyrxDoom)
trigger1 = map(QCF) && map(b_b) && !Var(15)
trigger2 = (Var(17) = 900 || Var(17) = 1000) && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LK PRIMAL BURN f
[State -1, QCF,a]
type = ChangeState
value = 1300
triggerall = statetype != A
triggerall = Name = "TYRX" && !NumHelper(1310)
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2 || StateNo = 930 && MoveContact && Map(TyrxDoom)
trigger1 = map(QCF) && map(b_a) && !Var(15)
trigger2 = (Var(17) = 900 || Var(17) = 1000) && Var(15) && Random < 250

;---------------------------------------------------------------------------
; 2K ALL-MIGHTY PRESENCE
[State -1, QCF,ab]
type = ChangeState
value = 1251
triggerall = statetype = A && Var(1)
triggerall = (Vel Y >= -1.5 || Time >= 10) && ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [1202,1203] && Time <= 2
triggerall = Name = "TYRA" && Map(TyraEXStack) = 3
trigger1 = map(QCF) && map(b_ab) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 125

;---------------------------------------------------------------------------
; 2K ALL-MIGHTY PRESENCE
[State -1, QCB,ab]
type = ChangeState
value = 1250 + 4 * (statetype!=A)
triggerall = statetype = A && Var(1) || statetype != A
triggerall = (Vel Y >= -1.5 || Time >= 10) && ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || (StateNo = [1200,1201] || StateNo = [1204,1205]) && Time <= 2
triggerall = Name = "TYRA" && Map(TyraEXStack) = 3
trigger1 = map(QCB) && map(b_ab) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 125

;---------------------------------------------------------------------------
; SK ALL-MIGHTY PRESENCE
[State -1, QCF,b]
type = ChangeState
value = 1203
triggerall = statetype = A && Var(1)
triggerall = (Vel Y >= -1.5 || Time >= 10) && ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact; || StateNo = [200,800) && Time <= 2
triggerall = Name = "TYRA"
trigger1 = map(QCF) && map(b_b) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 125

;---------------------------------------------------------------------------
; LK ALL-MIGHTY PRESENCE
[State -1, QCF,a]
type = ChangeState
value = 1202
triggerall = statetype = A && Var(1)
triggerall = (Vel Y >= -1.5 || Time >= 10) && ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact; || StateNo = [200,800) && Time <= 2
triggerall = Name = "TYRA"
trigger1 = map(QCF) && map(b_a) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 125

;---------------------------------------------------------------------------
; b.SK ALL-MIGHTY PRESENCE
[State -1, QCB,b]
type = ChangeState
value = 1201 + 4 * (statetype!=A)
triggerall = statetype = A && Var(1) || statetype != A
triggerall = (Vel Y >= -1.5 || Time >= 10) && ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact; || StateNo = [200,800) && Time <= 2
triggerall = Name = "TYRA"
trigger1 = map(QCB) && map(b_b) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 125

;---------------------------------------------------------------------------
; b.LK ALL-MIGHTY PRESENCE
[State -1, QCB,a]
type = ChangeState
value = 1200 + 4 * (statetype!=A)
triggerall = statetype = A && Var(1) || statetype != A
triggerall = (Vel Y >= -1.5 || Time >= 10) && ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact; || StateNo = [200,800) && Time <= 2
triggerall = Name = "TYRA"
trigger1 = map(QCB) && map(b_a) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 125

;---------------------------------------------------------------------------
; SP EMPEROR'S CROWN
[State -1, ChDU,b]
type = ChangeState
value = 1701
triggerall = Name = "TYRK"
triggerall = !(StateNo = 225 && MoveHit) && !(StateNo = 226 && AnimElem = 15, <= 1)
triggerall = statetype != A
triggerall = ctrl || StateNo = 40 || StateNo = 55 || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(b_b) && !Var(15)
trigger1 = Var(44) >= 24 && ((map(p_Up)>0) || command = "up")
trigger2 = Var(17) = 1300 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; LP EMPEROR'S CROWN
[State -1, ChDU,a]
type = ChangeState
value = 1700
triggerall = Name = "TYRK"
triggerall = !(StateNo = 225 && MoveHit) && !(StateNo = 226 && AnimElem = 15, <= 1)
triggerall = statetype != A
triggerall = ctrl || StateNo = 40 || StateNo = 55 || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(b_a) && !Var(15)
trigger1 = Var(44) >= 24 && ((map(p_Up)>0) || command = "up")
trigger2 = Var(17) = 1100 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; SP EMPEROR'S HEARSE
[State -1, ChDU,y]
type = ChangeState
value = 1601
triggerall = Name = "TYRK"
triggerall = !(StateNo = 225 && MoveHit) && !(StateNo = 226 && AnimElem = 15, <= 1)
triggerall = statetype != A
triggerall = ctrl || StateNo = 40 || StateNo = 55 || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(b_y) && !Var(15)
trigger1 = Var(44) >= 24 && ((map(p_Up)>0) || command = "up")
trigger2 = Var(17) = 800 && Var(15) && Random < 500
trigger2 = P2BodyDist X = [-8,const(size.ground.front)] && StateType != A && EnemyNear,StateType != A || P2BodyDist X <= 40 && !numtarget(860) && StateType = A && EnemyNear,StateType = A

;---------------------------------------------------------------------------
; LP EMPEROR'S HEARSE
[State -1, ChDU,x]
type = ChangeState
value = 1600
triggerall = Name = "TYRK"
triggerall = !(StateNo = 225 && MoveHit) && !(StateNo = 226 && AnimElem = 15, <= 1)
triggerall = statetype != A
triggerall = ctrl || StateNo = 40 || StateNo = 55 || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(b_x) && !Var(15)
trigger1 = Var(44) >= 24 && ((map(p_Up)>0) || command = "up")
trigger2 = Var(17) = 800 && Var(15) && Random < 500
trigger2 = P2BodyDist X = [-8,const(size.ground.front)] && StateType != A && EnemyNear,StateType != A || P2BodyDist X <= 40 && !numtarget(860) && StateType = A && EnemyNear,StateType = A

;---------------------------------------------------------------------------
; SP EMPEROR'S CURSE
[State -1, 360,y]
type = ChangeState
value = 1171
triggerall = statetype != A
triggerall = Name = "TYRX"
triggerall = ctrl || StateNo = 40 || StateNo = 55 || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 && StateNo != 420) && MoveContact || (StateNo = 1000 || StateNo = 1175 && PrevStateNo != [900,2000)) && Time <= 2 || StateNo = 930 && MoveContact && Map(TyrxDoom)
trigger1 = (map(HCB) || map(f360) || map(r360)) && map(b_y) && !Var(15)
trigger2 = Var(17) = 800 && Var(15) && Random < 500
trigger2 = P2BodyDist X = [-8,const(size.ground.front)] && StateType != A && EnemyNear,StateType != A || P2BodyDist X <= 40 && !numtarget(860) && StateType = A && EnemyNear,StateType = A

;---------------------------------------------------------------------------
; LP EMPEROR'S CURSE
[State -1, 360,x]
type = ChangeState
value = 1170
triggerall = statetype != A
triggerall = Name = "TYRX"
triggerall = ctrl || StateNo = 40 || StateNo = 55 || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 && StateNo != 420) && MoveContact || (StateNo = 1000 || StateNo = 1175 && PrevStateNo != [900,2000)) && Time <= 2 || StateNo = 930 && MoveContact && Map(TyrxDoom)
trigger1 = (map(HCB) || map(f360) || map(r360)) && map(b_x) && !Var(15)
trigger2 = Var(17) = 800 && Var(15) && Random < 500
trigger2 = P2BodyDist X = [-8,const(size.ground.front)] && StateType != A && EnemyNear,StateType != A || P2BodyDist X <= 40 && !numtarget(860) && StateType = A && EnemyNear,StateType = A

;---------------------------------------------------------------------------
; EMPEROR'S DECREE
[State -1, DD,2p]
type = ChangeState
value = 1175
triggerall = statetype != A
triggerall = Name = "TYRX"
triggerall = NumHelper(1180)
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) || (StateNo = 1000) && Map(TyrxDoom)) && StateNo != 510 && MoveContact || StateNo = 1131 && Time >= 68 && Map(TyrxDoom) || StateNo = 1300 && MoveType = I && Map(TyrxDoom) || StateNo = 930 && MoveContact && Map(TyrxDoom)
trigger1 = map(QCB) && (map(b_x) || map(b_y)) && !Var(15)
trigger2 = Var(17) = 1000 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; 2K EMPEROR’S MARCH
[State -1, QCF,ab]
type = ChangeState
value = 1150
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || (StateNo = [200,800) || StateNo = 1100) && Time <= 2
triggerall = Name = "TYRA" && Map(TyraEXStack) = 3
trigger1 = map(QCF) && map(b_ab) && !Var(15)
trigger2 = (Var(17) = 900 || Var(17) = 1700) && Var(15) && Random < 500

;---------------------------------------------------------------------------
; SK EMPEROR’S MARCH
[State -1, QCF,b]
type = ChangeState
value = 1101
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
triggerall = Name = "TYRA"
trigger1 = map(QCF) && map(b_b) && !Var(15)
trigger2 = (Var(17) = 900 || Var(17) = 1700) && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LK EMPEROR’S MARCH
[State -1, QCF,a]
type = ChangeState
value = 1100
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
triggerall = Name = "TYRA"
trigger1 = map(QCF) && map(b_a) && !Var(15)
trigger2 = (Var(17) = 900 || Var(17) = 1700) && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SP EMPEROR'S FLAME SHOT
[State -1, ChBF,y]
type = ChangeState
value = 1501
triggerall = Name = "TYRK"
triggerall = !(StateNo = 225 && MoveHit) && !(StateNo = 226 && AnimElem = 15, <= 1)
triggerall = !NumHelper(1510)
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(b_y) && !Var(15)
trigger1 = Var(40) >= 24 && P2Dist X >= 0 && Facing = 1 && (((map(p_Fd)>0) && P2Dist X >= 0) || ((map(p_Bk)>0) && P2Dist X < 0))
trigger2 = map(b_y) && !Var(15)
trigger2 = Var(42) >= 24 && P2Dist X >= 0 && Facing = -1 && (((map(p_Fd)>0) && P2Dist X >= 0) || ((map(p_Bk)>0) && P2Dist X < 0))
trigger3 = Var(17) = 1000 && Var(15) && Random < 350

;---------------------------------------------------------------------------
; LP EMPEROR'S FLAME SHOT
[State -1, ChBF,x]
type = ChangeState
value = 1500
triggerall = Name = "TYRK"
triggerall = !(StateNo = 225 && MoveHit) && !(StateNo = 226 && AnimElem = 15, <= 1)
triggerall = !NumHelper(1510)
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(b_x) && !Var(15)
trigger1 = Var(40) >= 24 && P2Dist X >= 0 && Facing = 1 && (((map(p_Fd)>0) && P2Dist X >= 0) || ((map(p_Bk)>0) && P2Dist X < 0))
trigger2 = map(b_x) && !Var(15)
trigger2 = Var(42) >= 24 && P2Dist X >= 0 && Facing = -1 && (((map(p_Fd)>0) && P2Dist X >= 0) || ((map(p_Bk)>0) && P2Dist X < 0))
trigger3 = Var(17) = 1000 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; SK EMPEROR'S GAUNTLET
[State -1, ChBF,b]
type = ChangeState
value = 1401
triggerall = Name = "TYRK"
triggerall = !(StateNo = 225 && MoveHit) && !(StateNo = 226 && AnimElem = 15, <= 1)
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(b_b) && !Var(15)
trigger1 = Var(40) >= 24 && P2Dist X >= 0 && Facing = 1 && (((map(p_Fd)>0) && P2Dist X >= 0) || ((map(p_Bk)>0) && P2Dist X < 0))
trigger2 = map(b_b) && !Var(15)
trigger2 = Var(42) >= 24 && P2Dist X >= 0 && Facing = -1 && (((map(p_Fd)>0) && P2Dist X >= 0) || ((map(p_Bk)>0) && P2Dist X < 0))
trigger3 = Var(17) = 1200 && Var(15) && Random < 350

;---------------------------------------------------------------------------
; LK EMPEROR'S GAUNTLET
[State -1, ChBF,a]
type = ChangeState
value = 1400
triggerall = Name = "TYRK"
triggerall = !(StateNo = 225 && MoveHit) && !(StateNo = 226 && AnimElem = 15, <= 1)
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(b_a) && !Var(15)
trigger1 = Var(40) >= 24 && P2Dist X >= 0 && Facing = 1 && (((map(p_Fd)>0) && P2Dist X >= 0) || ((map(p_Bk)>0) && P2Dist X < 0))
trigger2 = map(b_a) && !Var(15)
trigger2 = Var(42) >= 24 && P2Dist X >= 0 && Facing = -1 && (((map(p_Fd)>0) && P2Dist X >= 0) || ((map(p_Bk)>0) && P2Dist X < 0))
trigger3 = Var(17) = 1200 && Var(15) && Random < 350

;---------------------------------------------------------------------------
; 2P LION SLAYER
[State -1, QCF,xy]
type = ChangeState
value = 1050
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || (StateNo = [200,800) || StateNo = 1000) && Time <= 2
triggerall = Name = "TYRA" && Map(TyraEXStack) = 3
trigger1 = map(QCF) && map(b_xy) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SP LION SLAYER
[State -1, QCF,y]
type = ChangeState
value = 1001
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2 || StateNo = 930 && MoveContact && Map(TyrxDoom)
trigger1 = Name != "TYRK"
trigger1 = map(QCF) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; LP LION SLAYER
[State -1, QCF,x]
type = ChangeState
value = 1000
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2 || StateNo = 930 && MoveContact && Map(TyrxDoom)
trigger1 = Name != "TYRK"
trigger1 = map(QCF) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 500

;===========================================================================
;---------------------------------------------------------------------------
; CN b+SK
[State -1, b+SK]
type = ChangeState
value = 505
triggerall = statetype != A
triggerall = Name = "TYRK"
triggerall = StateNo != 505 && StateNo != [225,226]
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = 510 && Time <= 2
trigger1 = map(b_b) && (map(p_Bk)>0) && (map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; CN db+SP
[State -1, db+SP]
type = ChangeState
value = 225
triggerall = statetype != A
triggerall = Name = "TYRK"
triggerall = StateNo != 505 && StateNo != [225,226]
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = 510 && Time <= 2
trigger1 = map(b_y) && (map(p_Bk)>0) && (map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 205 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; CN f+LK
[State -1, st.f+LK]
type = ChangeState
value = 305 + (MoveHit=1&&!(map(p_Up)>0))
triggerall = statetype != A
triggerall = Name != "TYRK"
triggerall = StateNo != 205 && StateNo != 305
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = 310 && Time <= 2
trigger1 = map(b_b) && (map(p_Fd)>0) && !(map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; CN f+LP
[State -1, st.f+LP]
type = ChangeState
value = 205
triggerall = statetype != A
triggerall = Name != "TYRK"
triggerall = StateNo != 205 && StateNo != 305
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = 210 && Time <= 2
trigger1 = map(b_y) && (map(p_Fd)>0) && !(map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 205 && Var(15) && Random < 500

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
value = 210 + 10 * (Name="TYRK")
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
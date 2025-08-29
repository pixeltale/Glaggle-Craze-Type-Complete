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

; can you feel the love coming from above
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
trigger1 = StateNo = [200,800) && StateNo != 510 && MoveContact; && !(Anim=211||Anim=311||Anim=411||Anim=511||Anim=611||Anim=711)
trigger2 = StateNo = [200,800) && Time <= 2
;trigger3 = StateNo = [200,800) && StateNo != 510 && MoveContact && Name="NECK"
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
value = 102 - 2 * (Name="NECK")
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
triggerall = (StateNo = [200,800) || StateNo = [900,913] && StateNo != 912 || StateNo = [1000,1100] || StateNo = [1400,1600) || StateNo = 1850) && MoveHit || StateNo = 1060 && Time >= 25 || StateNo = 1210 && Time >= 118 || StateNo = 1310 && Time >= 14
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
triggerall = StateNo != [800,900) && StateNo != [1200,1210] && StateNo != [1300,1310] && !(StateNo = [1600,1800] && !MoveContact)
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
triggerall = (ctrl || StateNo < 120) && !Var(51) || StateNo = 1600 && !MoveContact && NumHelper(1610) || StateNo = 1700 && !MoveContact && NumHelper(1710) || StateNo = 1800 && !MoveContact && NumHelper(1810)
trigger1 = map(b_a) && map(b_y) && map(b_x) && map(b_b) && !Var(15)
trigger2 = Var(17) = 3000 && Var(15)

;===========================================================================
;---------------------------------------------------------------------------
; Seraphim’s War Cry
[State -1, 2QCB,2k]
type = ChangeState
value = 2800
triggerall = statetype != A
triggerall = Name = "NECK"
triggerall = Power >= 3000
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || (StateNo = 1700 || StateNo = 1900) && Time <= 2
trigger1 = map(QCBQC) && map(b_ab) && !Var(15)
trigger2 = (Var(17) = 1300 || Var(17) = 1200) && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Seraphim’s Ecstasy
[State -1, 2QCF,2p]
type = ChangeState
value = 2300
triggerall = statetype != A
triggerall = Name != "NECK"
triggerall = Power >= 3000
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveHit || (StateNo = 1400) && Time <= 2
trigger1 = map(QCFQC) && map(b_xy) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Seraphim’s Chorus
[State -1, 2QCB,2p]
type = ChangeState
value = 2550
triggerall = statetype != A
triggerall = Name = "NECX"
triggerall = Power >= 2000
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveHit || (StateNo = 1400) && Time <= 2
trigger1 = map(QCBQC) && map(b_xy) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Seraphim’s Feast
[State -1, 2QCF,2k]
type = ChangeState
value = 2700
triggerall = statetype != A
triggerall = Name = "NECK"
triggerall = Power >= 2000
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || (StateNo = 1850) && Time <= 2
trigger1 = map(QCFQC) && map(b_ab) && !Var(15)
trigger2 = Var(17) = 1000 && Var(15) && Random < 125

;---------------------------------------------------------------------------
; Seraphim’s Godspeed EX
[State -1, 360,2k]
type = ChangeState
value = 2200
triggerall = statetype != A
triggerall = Name = "NECC"
triggerall = Power >= 2000
triggerall = ctrl || StateNo = 40 || StateNo = 55 || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveHit || (StateNo = 1100) && Time <= 2
trigger1 = (map(HCB) || COMMAND = "HCB" || map(f360) || map(r360)) && map(b_ab) && !Var(15)
trigger2 = Var(17) = 800 && Var(15) && Random < 500
trigger2 = P2BodyDist X = [-8,const(size.ground.front)] && StateType != A && EnemyNear,StateType != A || P2BodyDist X <= 40 && !numtarget(860) && StateType = A && EnemyNear,StateType = A

;---------------------------------------------------------------------------
; SP Seraphim's Blight
[State -1, 2QCB,y]
type = ChangeState
value = 2601 + 2 * (StateType=A||StateNo=305&&Anim=305)
triggerall = Name = "NECK"
triggerall = Power >= 1000
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveHit; || (StateNo = 1400) && Time <= 2
trigger1 = map(QCBQC) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1000 && Var(15) && Random < 125

;---------------------------------------------------------------------------
; LP Seraphim's Blight
[State -1, 2QCB,x]
type = ChangeState
value = 2600 + 2 * (StateType=A||StateNo=305&&Anim=305)
triggerall = Name = "NECK"
triggerall = Power >= 1000
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveHit; || (StateNo = 1400) && Time <= 2
trigger1 = map(QCBQC) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1000 && Var(15) && Random < 125

;---------------------------------------------------------------------------
; Seraphim's Song
[State -1, 2QCF,p]
type = ChangeState
value = 2500
triggerall = statetype != A
triggerall = Name = "NECK"
triggerall = Power >= 1000
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveHit; || (StateNo = 1400) && Time <= 2
trigger1 = map(QCFQC) && (map(b_x) || map(b_y)) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Seraphim's Ecstasy
[State -1, 2QCB,p]
type = ChangeState
value = 2400
triggerall = statetype != A
triggerall = Name = "NECX" && !Map(NecxChoir)
triggerall = Power >= 1000
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveHit || (StateNo = 1500) && Time <= 2
trigger1 = map(QCBQC) && (map(b_a) || map(b_b)) && !Var(15)
trigger2 = Var(17) = 900 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Seraphim’s Godspeed
[State -1, 360,2p]
type = ChangeState
value = 2100
triggerall = statetype != A
triggerall = Name != "NECK"
triggerall = Power >= 1000
triggerall = ctrl || StateNo = 40 || StateNo = 55 || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveHit || (StateNo = 1200) && Time <= 2
trigger1 = (map(HCB) || COMMAND = "HCB" || map(f360) || map(r360)) && map(b_xy) && !Var(15)
trigger2 = Var(17) = 800 && Var(15) && Random < 500
trigger2 = P2BodyDist X = [-8,const(size.ground.front)] && StateType != A && EnemyNear,StateType != A || P2BodyDist X <= 40 && !numtarget(860) && StateType = A && EnemyNear,StateType = A

;---------------------------------------------------------------------------
; Cherubim's Sword
[State -1, 2QCF,k]
type = ChangeState
value = 2000
triggerall = statetype != A
triggerall = Name != "NECK"
triggerall = Power >= 1000
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveHit || (StateNo = 1400) && Time <= 2
trigger1 = map(QCFQC) && (map(b_a) || map(b_b)) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 500

;===========================================================================
;---------------------------------------------------------------------------
; Agios O Theos
[State -1, Y+B]
type = ChangeState
value = 920
triggerall = statetype != A
triggerall = Name = "NECK"
triggerall = Map(CmdChain)
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = Var(17) = 900 && Var(15) && Random < 1000 - 50 * Map(NeckDoll)

;---------------------------------------------------------------------------
; Angel's Sprint
[State -1, Y+B]
type = ChangeState
value = 910
triggerall = statetype != A
triggerall = Name = "NECX"
triggerall = Map(CmdChain)
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = (Var(17) = 1600 || Var(17) = 1700) && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Last Will and Testament
[State -1, Y+B]
type = ChangeState
value = 900
triggerall = statetype != A
triggerall = Name = "NECC"
triggerall = Map(CmdChain)
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = (Var(17) = 1600 || Var(17) = 1700) && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Throw
[State -1, X+A]
type = ChangeState
value = ifelse(StateType=A,850,800)
;triggerall = statetype != A
triggerall = Ctrl || (StateNo = [100,101]) || StateNo = [200,800) && Time <= 2 && PrevStateNo != [200,800) || StateNo = [600,800) && MoveHit
trigger1 = (map(b_x) && map(b_a) || map(b_xa)) && !Var(15)
trigger2 = Var(17) = 800 && Var(15) && (Random < 500 || Name = "NECK")
trigger2 = P2BodyDist X = [-8,const(size.ground.front)] && StateType != A && EnemyNear,StateType != A || P2BodyDist X <= 40 && !numtarget(860) && StateType = A && EnemyNear,StateType = A

;===========================================================================
;---------------------------------------------------------------------------
; db.Power's Approach
[State -1, 1KK]
type = ChangeState
value = 1903
triggerall = Map(CmdChain)
triggerall = statetype != A || statetype = A && Var(1) && StateNo != 305
triggerall = Name = "NECK" && Map(NeckDoll) && !NumHelper(1710)
trigger1 = map(b_ab) && (map(p_Bk)>0) && (map(p_Dn)>0) && !Var(15)

;---------------------------------------------------------------------------
; d.Power's Approach
[State -1, 2KK]
type = ChangeState
value = 1901
triggerall = Map(CmdChain)
triggerall = statetype != A || statetype = A && Var(1) && StateNo != 305
triggerall = Name = "NECK" && Map(NeckDoll) && !NumHelper(1710)
trigger1 = map(b_ab) && (map(p_Dn)>0) && !Var(15)

;---------------------------------------------------------------------------
; b.Power's Approach
[State -1, 4KK]
type = ChangeState
value = 1902
triggerall = Map(CmdChain)
triggerall = statetype != A || statetype = A && Var(1) && StateNo != 305
triggerall = Name = "NECK" && Map(NeckDoll) && !NumHelper(1710)
trigger1 = map(b_ab) && (map(p_Bk)>0) && !Var(15)

;---------------------------------------------------------------------------
; n.Power's Approach
[State -1, 5KK]
type = ChangeState
value = 1900
triggerall = Map(CmdChain)
triggerall = statetype != A || statetype = A && Var(1) && StateNo != 305
triggerall = Name = "NECK" && Map(NeckDoll) && !NumHelper(1710)
trigger1 = map(b_ab) && !Var(15)

;---------------------------------------------------------------------------
; SK Jonah 1:17
[State -1, QCB,b]
type = ChangeState
value = 1703
triggerall = Map(CmdChain)
triggerall = statetype != A
triggerall = Name = "NECK" && Map(NeckDoll) && !NumHelper(1710)
trigger1 = map(QCB) && map(b_b) && !Var(15)
trigger2 = Var(17) = 1000 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SP Lost Faith
[State -1, QCB,y]
type = ChangeState
value = 1702
triggerall = Map(CmdChain)
triggerall = statetype != A
triggerall = Name = "NECK" && Map(NeckDoll) && !NumHelper(1710)
trigger1 = map(QCB) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1000 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LK Saw Judgement
[State -1, QCB,a]
type = ChangeState
value = 1701
triggerall = Map(CmdChain)
triggerall = statetype != A
triggerall = Name = "NECK" && Map(NeckDoll) && !NumHelper(1710)
trigger1 = map(QCB) && map(b_a) && !Var(15)
trigger2 = Var(17) = 1000 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LP Icthys Bones
[State -1, QCB,x]
type = ChangeState
value = 1700
triggerall = Map(CmdChain)
triggerall = statetype != A
triggerall = Name = "NECK" && Map(NeckDoll) && !NumHelper(1710)
trigger1 = map(QCB) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1000 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SP Cherubim's Polearm
[State -1, HCF,b]
type = ChangeState
value = 1851
triggerall = Map(CmdChain)
triggerall = statetype != A
triggerall = Name = "NECK" && Map(NeckDoll)
trigger1 = (map(HCF) || COMMAND = "HCF") && map(b_b) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LP Cherubim's Polearm
[State -1, HCF,a]
type = ChangeState
value = 1850
triggerall = Map(CmdChain)
triggerall = statetype != A
triggerall = Name = "NECK" && Map(NeckDoll)
trigger1 = (map(HCF) || COMMAND = "HCF") && map(b_a) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SP Samuel 17:49
[State -1, QCF,y]
type = ChangeState
value = 1801
triggerall = Map(CmdChain)
triggerall = statetype != A
triggerall = Name = "NECK" && Map(NeckDoll) && !NumHelper(1810)
trigger1 = map(QCF) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1000 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LP Samuel 17:49
[State -1, QCF,x]
type = ChangeState
value = 1800
triggerall = Map(CmdChain)
triggerall = statetype != A
triggerall = Name = "NECK" && Map(NeckDoll) && !NumHelper(1810)
trigger1 = map(QCF) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1000 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SK Cherubim's Cord
[State -1, HCF,b]
type = ChangeState
value = 1301
triggerall = statetype != A
triggerall = Name = "NECC"
triggerall = Map(CmdChain)
trigger1 = (map(HCF) || COMMAND = "HCF") && map(b_b) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LK Cherubim's Cord
[State -1, HCF,a]
type = ChangeState
value = 1300
triggerall = statetype != A
triggerall = Name = "NECC"
triggerall = Map(CmdChain)
trigger1 = (map(HCF) || COMMAND = "HCF") && map(b_a) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Seraphim's Roar SP
[State -1, 360,y]
type = ChangeState
value = 1201
triggerall = statetype != A
triggerall = Name != "NECK"
triggerall = Map(CmdChain) || StateNo = 40 || StateNo = 55 || StateNo = 1000 && Time <= 2
trigger1 = (map(HCB) || COMMAND = "HCB" || map(f360) || map(r360)) && map(b_y) && !Var(15)
trigger2 = Var(17) = 800 && Var(15) && Random < 500
trigger2 = P2BodyDist X = [-8,const(size.ground.front)] && StateType != A && EnemyNear,StateType != A || P2BodyDist X <= 40 && !numtarget(860) && StateType = A && EnemyNear,StateType = A

;---------------------------------------------------------------------------
; Seraphim's Roar LP
[State -1, 360,x]
type = ChangeState
value = 1200
triggerall = statetype != A
triggerall = Name != "NECK"
triggerall = Map(CmdChain) || StateNo = 40 || StateNo = 55 || StateNo = 1000 && Time <= 2
trigger1 = (map(HCB) || COMMAND = "HCB" || map(f360) || map(r360)) && map(b_x) && !Var(15)
trigger2 = Var(17) = 800 && Var(15) && Random < 500
trigger2 = P2BodyDist X = [-8,const(size.ground.front)] && StateType != A && EnemyNear,StateType != A || P2BodyDist X <= 40 && !numtarget(860) && StateType = A && EnemyNear,StateType = A

;---------------------------------------------------------------------------
; SP Ophanim
[State -1, ChBF,y]
type = ChangeState
value = 1601
triggerall = Map(CmdChain)
triggerall = StateType != A
triggerall = !NumHelper(1610)
triggerall = Name = "NECX"
trigger1 = map(rDP) && map(b_y) && !Var(15)
trigger2 = (Var(17) = 900 || Var(17) = 1000) && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LP Ophanim
[State -1, ChBF,x]
type = ChangeState
value = 1600
triggerall = Map(CmdChain)
triggerall = StateType != A
triggerall = !NumHelper(1610)
triggerall = Name = "NECX"
trigger1 = map(rDP) && map(b_x) && !Var(15)
trigger2 = (Var(17) = 900 || Var(17) = 1000) && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SK Virtue's Rage
[State -1, QCB,b]
type = ChangeState
value = 1501 + 50 * (StateType=A)
triggerall = Map(CmdChain)
triggerall = Name = "NECX"
trigger1 = map(QCB) && map(b_b) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LP Virtue's Rage
[State -1, QCB,a]
type = ChangeState
value = 1500 + 50 * (StateType=A)
triggerall = Map(CmdChain)
triggerall = Name = "NECX"
trigger1 = map(QCB) && map(b_a) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SP Dominion’s Leash
[State -1, QCF,y]
type = ChangeState
value = 1001 + 50 * (StateType=A)
triggerall = statetype != A || statetype = A && Var(1)
triggerall = Name != "NECK"
triggerall = Map(CmdChain)
trigger1 = map(QCF) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LP Dominion’s Leash
[State -1, QCF,x]
type = ChangeState
value = 1000 + 50 * (StateType=A)
triggerall = statetype != A || statetype = A && Var(1)
triggerall = Name != "NECK"
triggerall = Map(CmdChain)
trigger1 = map(QCF) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SK PrincipalitiesDemand
[State -1, DP,b]
type = ChangeState
value = 1401
triggerall = statetype != A
triggerall = Map(CmdChain)
triggerall = Name != "NECK"
trigger1 = map(DP) && map(b_b) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LK PrincipalitiesDemand
[State -1, DP,a]
type = ChangeState
value = 1400
triggerall = statetype != A
triggerall = Map(CmdChain)
triggerall = Name != "NECK"
trigger1 = map(DP) && map(b_a) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SK Power's Advance
[State -1, QCB,b]
type = ChangeState
value = 1101
triggerall = statetype != A
triggerall = Map(CmdChain)
triggerall = Name = "NECC"
trigger1 = map(QCB) && map(b_b) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LK Power's Advance
[State -1, QCB,a]
type = ChangeState
value = 1100
triggerall = statetype != A
triggerall = Map(CmdChain)
triggerall = Name = "NECC"
trigger1 = map(QCB) && map(b_a) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;===========================================================================
;---------------------------------------------------------------------------
; CN f+LK
[State -1, st.f+LK]
type = ChangeState
value = 305 + (MoveHit=1&&!(map(p_Up)>0))
triggerall = statetype != A
triggerall = Name = "NECK"
triggerall = !(StateNo%10 = 5 && StateNo = [200,800)) && StateNo != 220
triggerall = Map(CmdChain)
trigger1 = map(b_a) && (map(p_Fd)>0) && !(map(p_Dn)>0) && !Var(15)
trigger2 = (Var(17) = 205 || Var(17) = 1700) && Var(15) && Random < 250

;---------------------------------------------------------------------------
; CN f+LP
[State -1, st.f+LP]
type = ChangeState
value = 205 + (MoveHit=1&&!map(p_Up))
triggerall = statetype != A
triggerall = Name != "NECK"
triggerall = !(StateNo%10 = 5 && StateNo = [200,800)) && StateNo != 220
triggerall = Map(CmdChain)
trigger1 = map(b_x) && (map(p_Fd)>0) && !(map(p_Dn)>0) && !Var(15)
trigger2 = (Var(17) = 205 || Var(17) = 1700) && Var(15) && Random < 250

;---------------------------------------------------------------------------
; CN b+SP
[State -1, b+SP]
type = ChangeState
value = 220
triggerall = statetype != A
triggerall = Name != "NECK"
triggerall = !(StateNo%10 = 5 && StateNo = [200,800)) && StateNo != 220
triggerall = Map(CmdChain)
trigger1 = map(b_y) && (map(p_Bk)>0) && !Var(15)
trigger2 = Var(17) = 410 && Var(15) && Random < 125

;---------------------------------------------------------------------------
; CN ju.d+SK
[State -1, ju.d+SK]
type = ChangeState
value = 715
triggerall = statetype = A
triggerall = Name = "NECC" || Name="NECX" && Map(NecxChoir)>0.1 || Name = "NECK" && Map(NeckDoll)
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = 600 || StateNo = 610 || StateNo = 700) && MoveContact || StateNo = 710 && Time <= 2
trigger1 = map(b_b) && (map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 125

;---------------------------------------------------------------------------
; CN ju.d+SP
[State -1, ju.d+SP]
type = ChangeState
value = 615
triggerall = statetype = A
triggerall = Name = "NECC" || Name="NECX" && Map(NecxChoir)>0.1 || Name = "NECK" && Map(NeckDoll)
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = 600 || StateNo = 700 || StateNo = 710) && MoveContact || StateNo = 610 && Time <= 2
trigger1 = map(b_y) && (map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; CN df+SK
[State -1, df+SK]
type = ChangeState
value = 515
triggerall = statetype != A
triggerall = Name = "NECC" || Name="NECX" && Map(NecxChoir)>0.1 || Name = "NECK" && Map(NeckDoll)
triggerall = Ctrl || !(StateNo%10 = 5 && StateNo = [200,800)) && StateNo != 220
triggerall = Map(CmdChain)
trigger1 = map(b_b) && (map(p_Fd)>0) && (map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 125

;---------------------------------------------------------------------------
; CN df+SP
[State -1, df+SP]
type = ChangeState
value = 415
triggerall = statetype != A
triggerall = Name = "NECC" || Name="NECX" && Map(NecxChoir)>0.1 || Name = "NECK" && Map(NeckDoll)
triggerall = Ctrl || !(StateNo%10 = 5 && StateNo = [200,800)) && StateNo != 220 && StateNo != 410
triggerall = Map(CmdChain)
trigger1 = map(b_y) && (map(p_Fd)>0) && (map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 205 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; CN f+SK
[State -1, f+SK]
type = ChangeState
value = 315 + 10 * (Name="NECK")
triggerall = statetype != A
triggerall = Name = "NECC" || Name="NECX" && Map(NecxChoir)>0.1 || Name = "NECK" && Map(NeckDoll)
triggerall = Ctrl || !(StateNo%10 = 5 && StateNo = [200,800)) && StateNo != 220 && (StateNo != 310 || Name = "NECK")
triggerall = Map(CmdChain)
trigger1 = map(b_b) && (map(p_Fd)>0) && !(map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 125

;---------------------------------------------------------------------------
; CN f+SP
[State -1, f+SP]
type = ChangeState
value = 215
triggerall = statetype != A
triggerall = Name = "NECC" || Name="NECX" && Map(NecxChoir)>0.1 || Name = "NECK" && Map(NeckDoll)
triggerall = Ctrl || !(StateNo%10 = 5 && StateNo = [200,800)) && StateNo != 220 && StateNo != 210
triggerall = Map(CmdChain)
trigger1 = map(b_y) && (map(p_Fd)>0) && !(map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 250

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
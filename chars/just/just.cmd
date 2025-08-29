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

; from the minute im away from you
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
; Burnout
[State -1, Burnout]
Type = ChangeState
Value = 4500
triggerall = StateType != A
triggerall = Name = "JUSK" && Map(JuskHeat) > 6
triggerall = Ctrl || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [1000,3000) && MoveType = I
trigger1 = Map(JuskHeat) > 12

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
triggerall = !(Name="JUSK" && Map(JuskHeat)>=13)
triggerall = (StateNo = [200,800) || StateNo = 900 || StateNo = 912 || StateNo = [965,970) || StateNo = 975 || StateNo = [980,985) || StateNo = [1000,1100] || StateNo = [1400,1600]) && MoveHit || StateNo = [910,915) && (NumHelper(920) || MoveType = I) && MoveHit || StateNo = 971 && AnimElem = 14, >= 1 || StateNo = 986 && AnimElem = 13, >= 1 || StateNo = 1110 && AnimElem = 5, >= 1 || StateNo = 1210 && Time >= 68 || StateNo = 1215 && AnimElem = 12, >= 1 || StateNo = 1250 && Time >= 44 || StateNo = 1310 && Time >= 46
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
triggerall = !(Name="JUSK" && Map(JuskHeat)>=13)
triggerall = StateNo != [800,900) && StateNo != [910,911] && StateNo != [960,965) && StateNo != [970,971] && StateNo != 980 && StateNo != [985,990] && StateNo != 1110 && StateNo != [1200,1215] && StateNo != 1250 && StateNo != [1300,1310] || StateNo = [910,911] && (NumHelper(920) || MoveType = I) && MoveGuarded || StateNo = [960,965) && MoveGuarded || StateNo = [980,985) && MoveGuarded || StateNo = 990 && MoveGuarded
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
triggerall = !(Name="JUSK" && Map(JuskHeat)>=13)
triggerall = (ctrl || StateNo < 120) && !Var(51) || StateNo = [910,911] && (NumHelper(920) || MoveType = I) && !MoveContact || StateNo = [960,965) && !MoveContact || StateNo = [980,985) && !MoveContact || StateNo = 990 && !MoveContact
trigger1 = map(b_a) && map(b_y) && map(b_x) && map(b_b) && !Var(15)
trigger2 = Var(17) = 3000 && Var(15)

;===========================================================================
;---------------------------------------------------------------------------
; 1000 Feet Under
[State -1, 2QCF,2k]
type = ChangeState
value = 2800
triggerall = statetype != A
triggerall = Power >= 3000
triggerall = Name = "JUSK"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = 980 && Time <= 8 && !Var(5) 
trigger1 = map(QCFQC) && map(b_ab) && !Var(15)
trigger2 = Var(17) = 1200 && EnemyNear,StateType != A && Random < 500

;---------------------------------------------------------------------------
; Defining Testament EX
[State -1, 360,2k]
type = ChangeState
value = 2700
triggerall = statetype != A
triggerall = Name = "JUSK"
triggerall = Power >= 2000
triggerall = ctrl || StateNo = 40 || StateNo = 55 || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && (MoveHit || Time < 4) || StateNo = 980 && Time <= 8 && !Var(5) 
trigger1 = (map(HCB) || COMMAND = "HCB" || map(f360) || map(r360)) && map(b_ab) && !Var(15)
trigger2 = Var(17) = 800 && Var(15) && Random < 250
trigger2 = P2BodyDist X = [-8,const(size.ground.front)] && StateType != A && EnemyNear,StateType != A || P2BodyDist X <= 40 && !numtarget(860) && StateType = A && EnemyNear,StateType = A

;---------------------------------------------------------------------------
; And Justice For All
[State -1, 360,2k]
type = ChangeState
value = 2300
triggerall = statetype != A
triggerall = Power >= 3000
triggerall = Name != "JUSK"
triggerall = ctrl || StateNo = 40 || StateNo = 55 || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && (MoveContact || Time < 4) || (StateNo = 1300) && Time <= 2
trigger1 = (map(HCB) || COMMAND = "HCB" || map(f360) || map(r360)) && map(b_ab) && !Var(15)
trigger2 = Var(17) = 800 && Var(15) && Random < 250
trigger2 = P2BodyDist X = [-8,const(size.ground.front)] && StateType != A && EnemyNear,StateType != A || P2BodyDist X <= 40 && !numtarget(860) && StateType = A && EnemyNear,StateType = A
trigger3 = Var(17) = 1200 && EnemyNear,StateType != A && Random < 500

;---------------------------------------------------------------------------
; Kokyuu Nage
[State -1, 2QCB,2P]
type = ChangeState
value = 2200 + 10 * (MoveHit&&Var(51))
triggerall = statetype != A
triggerall = Power >= 2000
triggerall = Name = "JUST"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && (MoveContact || Time < 4)
trigger1 = map(QCBQC) && map(b_xy) && !Var(15)
trigger2 = Var(17) = 1300 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Defining Verdict
[State -1, 360,2p]
type = ChangeState
value = 2100
triggerall = statetype != A || StateNo = 305
triggerall = Power >= 1000
triggerall = ctrl || StateNo = 40 || StateNo = 55 || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && (MoveHit || Time < 4) || (StateNo = 1200) && Time <= 4 || StateNo = 980 && Time <= 8 && !Var(5) 
trigger1 = (map(HCB) || COMMAND = "HCB" || map(f360) || map(r360)) && map(b_xy) && !Var(15)
trigger2 = Var(17) = 800 && Var(15) && Random < 250
trigger2 = P2BodyDist X = [-8,const(size.ground.front)] && StateType != A && EnemyNear,StateType != A || P2BodyDist X <= 40 && !numtarget(860) && StateType = A && EnemyNear,StateType = A

;---------------------------------------------------------------------------
; Moment of Truth EX
[State -1, 2QCF,2p]
type = ChangeState
value = 2500
triggerall = statetype != A || StateNo = 305
triggerall = Power >= 2000 - 1000 * (StateNo = 2400)
triggerall = Name = "JUSX"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || (StateNo = 2400) && Time <= 2
trigger1 = map(QCFQC) && map(b_xy) && !Var(15)
trigger2 = (Var(17) = 1200 || Var(17) = 1300) && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SP Lights Out
[State -1, 2QCF,y]
type = ChangeState
value = 2601
triggerall = statetype != A
triggerall = Name = "JUSK"
triggerall = Power >= 1000
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || (StateNo = 1200) && Time <= 4 || StateNo = 980 && Time <= 8 && !Var(5)  || (StateNo = 1550) && !Var(5) && Time <= 2
trigger1 = map(QCFQC) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250 && Map(JuskHeat) < 5

;---------------------------------------------------------------------------
; LP Lights Out
[State -1, 2QCF,x]
type = ChangeState
value = 2600
triggerall = statetype != A
triggerall = Name = "JUSK"
triggerall = Power >= 1000
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || (StateNo = 1200) && Time <= 4 || StateNo = 980 && Time <= 8 && !Var(5) || (StateNo = 1550) && !Var(5) && Time <= 2
trigger1 = map(QCFQC) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250 && Map(JuskHeat) >= 5

;---------------------------------------------------------------------------
; Morning Sun
[State -1, 2QCF,p]
type = ChangeState
value = 2000 + (Name="JUSX")*400
triggerall = statetype != A || StateNo = 305
triggerall = Name != "JUSK"
triggerall = Power >= 1000
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact
trigger1 = map(QCFQC) && (map(b_x) || map(b_y)) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;===========================================================================
;---------------------------------------------------------------------------
; SK Jump Stance
[State -1, DP,b]
type = ChangeState
value = 991
triggerall = statetype != A
triggerall = Name = "JUSK"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = 980 && Time <= 4 && !Var(5) || (StateNo = [965,968] || StateNo = [981,984] || StateNo = 1550) && MoveContact && Map(JuskHeat) < 13
trigger1 = map(DP) && map(b_b) && !Var(15)
trigger2 = (Var(17) = 1200 || Var(17) = 1700) && Var(15) && Random < 50

;---------------------------------------------------------------------------
; LK Jump Stance
[State -1, DP,a]
type = ChangeState
value = 990
triggerall = statetype != A
triggerall = Name = "JUSK"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = 980 && Time <= 4 && !Var(5) || (StateNo = [965,968] || StateNo = [981,984] || StateNo = 1550) && MoveContact && Map(JuskHeat) < 13
trigger1 = map(DP) && map(b_a) && !Var(15)
trigger2 = (Var(17) = 1200 || Var(17) = 1700) && Var(15) && Random < 50

;---------------------------------------------------------------------------
; Run Stance
[State -1, HCF]
type = ChangeState
value = 980
triggerall = statetype != A
triggerall = Name = "JUSK"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || (StateNo = [965,968] || StateNo = 1550) && MoveContact && Map(JuskHeat) < 13
trigger1 = (map(HCF) || COMMAND = "HCF") && !Var(15)
trigger2 = (Var(17) = 1200 || Var(17) = 1700) && Var(15) && Random < 125

;---------------------------------------------------------------------------
; Roll Over
[State -1, db.Y+B]
type = ChangeState
value = 964
triggerall = statetype != A
triggerall = Name = "JUSK"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || (StateNo = [981,984] || StateNo = 1550) && MoveContact && Map(JuskHeat) < 13
trigger1 = (map(p_Dn)>0) && (map(p_Bk)>0) && (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = (Var(17) = 1200 || Var(17) = 1700) && Var(15) && Random < 50

;---------------------------------------------------------------------------
; Roll Over
[State -1, df.Y+B]
type = ChangeState
value = 963
triggerall = statetype != A
triggerall = Name = "JUSK"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || (StateNo = [981,984] || StateNo = 1550) && MoveContact && Map(JuskHeat) < 13
trigger1 = (map(p_Dn)>0) && (map(p_Fd)>0) && (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = (Var(17) = 1200 || Var(17) = 1700) && Var(15) && Random < 125

;---------------------------------------------------------------------------
; Heel Turn
[State -1, b.Y+B]
type = ChangeState
value = 962
triggerall = statetype != A
triggerall = Name = "JUSK"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || (StateNo = [981,984] || StateNo = 1550) && MoveContact && Map(JuskHeat) < 13
trigger1 = (map(p_Bk)>0) && (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = (Var(17) = 1200 || Var(17) = 1700) && Var(15) && Random < 50

;---------------------------------------------------------------------------
; Heel Turn
[State -1, f.Y+B]
type = ChangeState
value = 961
triggerall = statetype != A
triggerall = Name = "JUSK"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || (StateNo = [981,984] || StateNo = 1550) && MoveContact && Map(JuskHeat) < 13
trigger1 = (map(p_Fd)>0) && (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = (Var(17) = 1200 || Var(17) = 1700) && Var(15) && Random < 125

;---------------------------------------------------------------------------
; Stand-Off
[State -1, Y+B]
type = ChangeState
value = 960
triggerall = statetype != A
triggerall = Name = "JUSK"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || (StateNo = [981,984] || StateNo = 1550) && MoveContact && Map(JuskHeat) < 13
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = (Var(17) = 1200 || Var(17) = 1700) && Var(15) && Random < 125

;---------------------------------------------------------------------------
; Throne Driver
[State -1, f.Y+B]
type = ChangeState
value = 912
triggerall = statetype != A || StateNo = 305
triggerall = Name = "JUSX"
triggerall = !NumHelper(920) && Var(40) >= 500
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact
trigger1 = (map(p_Fd)>0) && (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Overthrow the Throne
[State -1, b.Y+B]
type = ChangeState
value = 911
triggerall = statetype != A || StateNo = 305
triggerall = Name = "JUSX"
triggerall = !NumHelper(920) && Var(40) >= 500
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact
trigger1 = (map(p_Bk)>0) && (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 125

;---------------------------------------------------------------------------
; Throne of Justice
[State -1, Y+B]
type = ChangeState
value = 910
triggerall = statetype != A || StateNo = 305
triggerall = Name = "JUSX"
triggerall = !NumHelper(920) && Var(40) >= 500
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = Var(17) = 900 && Var(15) && Random < 125

;---------------------------------------------------------------------------
; Dropkick!
[State -1, Y+B]
type = ChangeState
value = 900
triggerall = statetype != A
triggerall = Name = "JUST"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 125

;---------------------------------------------------------------------------
; Throw
[State -1, X+A]
type = ChangeState
value = ifelse(StateType=A,850,800)
;triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && Time <= 2 && PrevStateNo != [200,800) || StateNo = [200,600) && StateNo != 510 && MoveHit && Name = "JUST" || StateNo = [600,800) && MoveHit
trigger1 = (map(b_x) && map(b_a) || map(b_xa)) && !Var(15)
trigger2 = Var(17) = 800 && Var(15) && Random < 250
trigger2 = P2BodyDist X = [-8,const(size.ground.front)] && StateType != A && EnemyNear,StateType != A || P2BodyDist X <= 40 && !numtarget(860) && StateType = A && EnemyNear,StateType = A
trigger3 = Name = "JUST" && Var(17) = 1200 && Random < 500

;===========================================================================
;---------------------------------------------------------------------------
; SK Sunset Slam
[State -1, 360,b]
type = ChangeState
value = 1301
triggerall = statetype != A || StateNo = 305
triggerall = Name != "JUSK"
triggerall = ctrl || StateNo = 40 || StateNo = 55 || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || (StateNo = 1100) && Time <= 2
trigger1 = (map(HCB) || COMMAND = "HCB" || map(f360) || map(r360)) && map(b_b) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LK Sunset Slam
[State -1, 360,a]
type = ChangeState
value = 1300
triggerall = statetype != A || StateNo = 305
triggerall = Name != "JUSK"
triggerall = ctrl || StateNo = 40 || StateNo = 55 || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || (StateNo = 1100) && Time <= 2
trigger1 = (map(HCB) || COMMAND = "HCB" || map(f360) || map(r360)) && map(b_a) && !Var(15)
trigger2 = Var(17) = 1400 && Var(15) && Random < 100

;---------------------------------------------------------------------------
; Justice Hammer
[State -1, 360,y]
type = ChangeState
value = 1201
triggerall = statetype != A || StateNo = 305
triggerall = ctrl || StateNo = 40 || StateNo = 55 || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || (StateNo = 1000 || StateNo = 1500) && Time <= 2
trigger1 = (map(HCB) || COMMAND = "HCB" || map(f360) || map(r360)) && map(b_y) && !Var(15)
trigger2 = Var(17) = 800 && Var(15) && Random < 350
trigger2 = P2BodyDist X = [-8,const(size.ground.front)] && StateType != A && EnemyNear,StateType != A || P2BodyDist X <= 40 && !numtarget(860) && StateType = A && EnemyNear,StateType = A

;---------------------------------------------------------------------------
; Justice Hammer
[State -1, 360,x]
type = ChangeState
value = 1200
triggerall = statetype != A || StateNo = 305
triggerall = ctrl || StateNo = 40 || StateNo = 55 || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || (StateNo = 1000 || StateNo = 1500) && Time <= 2
trigger1 = (map(HCB) || COMMAND = "HCB" || map(f360) || map(r360)) && map(b_x) && !Var(15)
trigger2 = Var(17) = 800 && Var(15) && Random < 350
trigger2 = P2BodyDist X = [-8,const(size.ground.front)] && StateType != A && EnemyNear,StateType != A || P2BodyDist X <= 40 && !numtarget(860) && StateType = A && EnemyNear,StateType = A

;---------------------------------------------------------------------------
; SK Meteor Clutch
[State -1, QCF,b]
type = ChangeState
value = 1101
triggerall = statetype != A || StateNo = 305
triggerall = Name != "JUSK"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact
trigger1 = map(QCF) && map(b_b) && !Var(15)
trigger2 = Var(17) = 1100 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LK Meteor Clutch
[State -1, QCF,a]
type = ChangeState
value = 1100
triggerall = statetype != A || StateNo = 305
triggerall = Name != "JUSK"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact
trigger1 = map(QCF) && map(b_a) && !Var(15)
trigger2 = Var(17) = 1100 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SP Red Friday Drop
[State -1, QCB,y]
type = ChangeState
value = 1601
triggerall = statetype = A
triggerall = Vel Y >= -1 || Time > 10 && Ctrl || !Ctrl
triggerall = Name = "JUSK"
triggerall = ctrl || StateNo = [600,800) && MoveContact
trigger1 = map(QCB) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LP Red Friday Drop
[State -1, QCB,x]
type = ChangeState
value = 1600
triggerall = statetype = A
triggerall = Vel Y >= -1 || Time > 10 && Ctrl || !Ctrl
triggerall = Name = "JUSK"
triggerall = ctrl || StateNo = [600,800) && MoveContact
trigger1 = map(QCB) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SK Flamingo Splash
[State -1, QCF,b]
type = ChangeState
value = 1403
triggerall = statetype = A
triggerall = Vel Y >= -1 || Time > 10 && Ctrl || !Ctrl
triggerall = Name = "JUSX"
triggerall = ctrl || (StateNo = 600 || StateNo = 610 || StateNo = 700 || StateNo = 710) && MoveContact
trigger1 = map(QCF) && map(b_b) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LK Flamingo Splash
[State -1, QCF,a]
type = ChangeState
value = 1402
triggerall = statetype = A
triggerall = Vel Y >= -1 || Time > 10 && Ctrl || !Ctrl
triggerall = Name = "JUSX"
triggerall = ctrl || (StateNo = 600 || StateNo = 610 || StateNo = 700 || StateNo = 710) && MoveContact
trigger1 = map(QCF) && map(b_a) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 125

;---------------------------------------------------------------------------
; SP Flamingo Splash
[State -1, QCF,y]
type = ChangeState
value = 1401
triggerall = statetype = A
triggerall = Vel Y >= -1 || Time > 10 && Ctrl || !Ctrl
triggerall = Name = "JUSX"
triggerall = ctrl || (StateNo = 600 || StateNo = 610 || StateNo = 700 || StateNo = 710) && MoveContact
trigger1 = map(QCF) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 50

;---------------------------------------------------------------------------
; LP Flamingo Splash
[State -1, QCF,x]
type = ChangeState
value = 1400
triggerall = statetype = A
triggerall = Vel Y >= -1 || Time > 10 && Ctrl || !Ctrl
triggerall = Name = "JUSX"
triggerall = ctrl || (StateNo = 600 || StateNo = 610 || StateNo = 700 || StateNo = 710) && MoveContact
trigger1 = map(QCF) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 25

;---------------------------------------------------------------------------
; SP Tyranny Slash
[State -1, DP,y]
type = ChangeState
value = 1551
triggerall = statetype != A || StateNo = 305
triggerall = Name = "JUSK"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = 980 && Time <= 4 && !Var(5) || (StateNo = [965,968] || StateNo = [981,984]) && MoveContact && Map(JuskHeat) < 13
trigger1 = map(DP) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LP Tyranny Slash
[State -1, DP,x]
type = ChangeState
value = 1550
triggerall = statetype != A || StateNo = 305
triggerall = Name = "JUSK"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = 980 && Time <= 4 && !Var(5) || (StateNo = [965,968] || StateNo = [981,984]) && MoveContact && Map(JuskHeat) < 13
trigger1 = map(DP) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SP Star Lariat
[State -1, QCF,y]
type = ChangeState
value = 1001 + 500*(Name="JUSX")
triggerall = statetype != A || StateNo = 305
triggerall = Name != "JUSK"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact
trigger1 = map(QCF) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LP Star Lariat
[State -1, QCF,x]
type = ChangeState
value = 1000 + 500*(Name="JUSX")
triggerall = statetype != A || StateNo = 305
triggerall = Name != "JUSK"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact
trigger1 = map(QCF) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 125

;===========================================================================
;---------------------------------------------------------------------------
; CN f+LP S-L
[State -1, st.f+LP]
type = ChangeState
value = 220 + 5 * (Name="JUSK")
triggerall = statetype != A
triggerall = Name != "JUST"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = 200 || StateNo = 210 || StateNo = 300 || StateNo = 310 || StateNo = 400 || StateNo = 410 || StateNo = 500) && MoveContact
trigger1 = map(b_x) && (map(p_Fd)>0) && !(map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 205 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; CN f+LP
[State -1, st.f+LP]
type = ChangeState
value = 205 + (MoveHit=1&&!(map(p_Up)>0))
triggerall = statetype != A
triggerall = Name = "JUST"
triggerall = ctrl || StateNo != 205 && StateNo != 305 && StateNo != 420
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = 200 || StateNo = 210 || StateNo = 300 || StateNo = 310 || StateNo = 400 || StateNo = 410 || StateNo = 500) && MoveContact
trigger1 = map(b_x) && (map(p_Fd)>0) && !(map(p_Dn)>0) && !Var(15)
trigger2 = (Var(17) = 205 || Var(17) = 1700) && Var(15) && Random < 250

;---------------------------------------------------------------------------
; CN f+LK
[State -1, st.f+LK]
type = ChangeState
value = 305
triggerall = statetype != A
triggerall = Name = "JUSX"
triggerall = ctrl || StateNo != 205 && StateNo != 305 && StateNo != 420
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = 200 || StateNo = 210 || StateNo = 300 || StateNo = 310 || StateNo = 400 || StateNo = 410 || StateNo = 500) && MoveContact
trigger1 = map(b_a) && (map(p_Fd)>0) && !(map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; CN df+SK
[State -1, df+SK]
type = ChangeState
value = 420
triggerall = statetype != A
triggerall = Name != "JUSK"
triggerall = ctrl || StateNo != 205 && StateNo != 305 && StateNo != 420
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = 200 || StateNo = 210 || StateNo = 300 || StateNo = 310 || StateNo = 400 || StateNo = 410 || StateNo = 500) && MoveContact
trigger1 = map(b_b) && (map(p_Fd)>0) && (map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; CN ju.d+SP
[State -1, ju.d+SP]
type = ChangeState
value = 615
triggerall = statetype = A
triggerall = Name != "JUSX"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = 600 || StateNo = 610 || StateNo = 700 || StateNo = 710) && MoveContact
trigger1 = map(b_y) && (map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 205 && Var(15) && Random < 500
trigger3 = Var(17) = 200 && P2BodyDist X <= 0

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
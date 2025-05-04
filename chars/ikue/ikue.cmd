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

; watch me im weightless though im on the ground
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
value = 100 + 2 * (Name="IKUK")
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
; AirDash Fwd
[State -1, AirDash Fwd]
type = ChangeState
value = 110
triggerall = ctrl
triggerall = Vel Y >= -1 || Time >= 10
triggerall = !(StateNo = [110,115] && Time < 12)
triggerall = statetype = A && Var(1)
triggerall = !(StateNo = 50 && NumHelper(56))
trigger1 = (command="FF" || map(b_66)) && !Var(15)
trigger2 = Var(17) = 110 && Var(15)

;---------------------------------------------------------------------------
; AirDash Back
[State -1, AirDash Back]
type = ChangeState
value = 115
triggerall = ctrl
triggerall = Vel Y >= -1 || Time >= 10
triggerall = !(StateNo = [110,115] && Time < 12)
triggerall = statetype = A && Var(1)
triggerall = !(StateNo = 50 && NumHelper(56))
trigger1 = (command="BB" || map(b_44)) && !Var(15)
trigger2 = Var(17) = 110 && Var(15)

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
triggerall = !(StateNo = [110,115] && Time < 8)
triggerall = statetype != A || statetype = A && Var(1)
trigger1 = StateNo = 100
trigger1 = (map(p_Up)>0) && !ctrl && !Var(15)
trigger2 = Var(17) = 40 && Var(15)
trigger3 = StateNo > 100
trigger3 = ctrl && (command = "up" || command = "upback" || command = "upfwd")

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
triggerall = !Var(40)
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
triggerall = (StateNo = [200,800) || StateNo = 900 || StateNo = 910 || StateNo = [1100,1250) || StateNo = [1400,1600]) && MoveHit || (StateNo = 1000 || StateNo = 1050 || StateNo = 1070) && (NumHelper(1010) || MoveType = I) && MoveHit || StateNo = 1260 && Time >= 31 || StateNo = [1300,1400) && (NumHelper(1310) || MoveType = I) && MoveHit 
triggerall = !Var(40)
trigger1 = map(b_a) && map(b_y) && map(b_x) && map(b_b) && !Var(15)
trigger2 = Var(17) = 3000 && Var(15)

;---------------------------------------------------------------------------
; Craze Assault
[State -1, A+Y / X+B]
type = ChangeState
value = 3001
triggerall = RoundState = 2
triggerall = var(18) >= 2000 && !Map(CCDisable)
triggerall = StateNo = [200,2000) && !Ctrl && (!Var(51) || MoveType = I) && !MoveReversed && !((StateNo = 1100 && Var(5) || StateNo = 1150 || StateNo = 1400 && Var(5)) && MoveGuarded)
triggerall = StateNo != [800,900) && StateNo != [1000,1100) && StateNo != [1250,1270] && StateNo != [1300,1400) || StateNo = [1000,1100) && (NumHelper(1010) || MoveType = I) && MoveGuarded || StateNo = [1300,1400) && (NumHelper(1310) || MoveType = I) && MoveGuarded
triggerall = !MoveContact && !Var(51) || MoveGuarded
triggerall = !Var(40)
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
triggerall = (ctrl || StateNo < 120) && !Var(51) || StateNo = [1000,1100) && (NumHelper(1010) || MoveType = I) && !MoveContact || StateNo = [1300,1400) && (NumHelper(1310) || MoveType = I) && !MoveContact
triggerall = !Var(40)
trigger1 = map(b_a) && map(b_y) && map(b_x) && map(b_b) && !Var(15)
trigger2 = Var(17) = 3000 && Var(15)

;===========================================================================
;---------------------------------------------------------------------------
; Blade Armageddon
[State -1, 2QCF,2k]
type = ChangeState
value = 2300 + 600 * (Name="IKUK")
triggerall = statetype != A
triggerall = Power >= 3000 - 1000 * (StateNo = 2400)
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (MoveContact && StateNo != 510 || Time <= 2) || (StateNo = 2400) && Time <= 2
trigger1 = map(QCFQC) && map(b_ab) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Decimating Blade
[State -1, 2QCB,2p]
type = ChangeState
value = 2200
triggerall = statetype != A
triggerall = Name != "IKUK"
triggerall = Power >= 2000 - 1000 * (StateNo = 2000)
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (MoveContact && StateNo != 510 || Time <= 2) || (StateNo = 2100) && Time <= 2
trigger1 = map(QCBQC) && map(b_xy) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 350

;---------------------------------------------------------------------------
; Denjin Overdrive
[State -1, 2QCB,k]
type = ChangeState
value = 2500 + 50 * !!Map(IkukOD)
triggerall = statetype != A
triggerall = Power >= 1000
triggerall = Var(40) && Map(IkukOD) < 2
triggerall = Name = "IKUK"
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (MoveContact && StateNo != 510 || Time <= 2) || StateNo = 2500 && Time >= 42
trigger1 = map(QCBQC) && (map(b_a) || map(b_b)) && !Var(15)
trigger2 = (Var(17) = 900 || Var(17) = 1700) && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Soaring Blade
[State -1, 2QCF,k]
type = ChangeState
value = 2400
triggerall = statetype != A
triggerall = Power >= 1000
triggerall = Name != "IKUK"
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (MoveContact && StateNo != 510 || Time <= 2)
trigger1 = map(QCFQC) && (map(b_a) || map(b_b)) && !Var(15)
trigger2 = Var(17) = 1300 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Killing Blade
[State -1, 2QCB,p]
type = ChangeState
value = 2100 + 500 * (Name="IKUK")
triggerall = statetype != A
triggerall = Power >= 1000
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (MoveContact && StateNo != 510 || Time <= 2)
trigger1 = map(QCBQC) && (map(b_x) || map(b_y)) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250
trigger3 = Var(17) = 1300 && Var(15) && Random < 250 && Name = "IKUK"

;---------------------------------------------------------------------------
; Infinite Blade EX
[State -1, 2QCF,2p]
type = ChangeState
value = 2750
triggerall = statetype != A
triggerall = Name = "IKUK"
triggerall = Power >= 2000 - 1000 * (StateNo = 2700)
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (MoveContact && StateNo != 510 || Time <= 2) || (StateNo = 2700) && Time <= 2
trigger1 = map(QCFQC) && map(b_xy) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 350

;---------------------------------------------------------------------------
; Infinite Blade
[State -1, 2QCF,p]
type = ChangeState
value = 2000 + 700 * (Name="IKUK")
triggerall = statetype != A
triggerall = Power >= 1000
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (MoveContact && StateNo != 510 || Time <= 2) 
trigger1 = map(QCFx2) && (map(b_x) || map(b_y)) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;===========================================================================
;---------------------------------------------------------------------------
; Blade Tempest
[State -1, QCB,ct]
type = ChangeState
value = 1240
triggerall = statetype != A
triggerall = Name = "IKUX"
triggerall = Var(41)&4
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (MoveContact && StateNo != 510 || Time <= 2)
trigger1 = map(QCB) && (map(b_yb)) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Denjin Bolt
[State -1, DP,ct]
type = ChangeState
value = 1140
triggerall = statetype != A
triggerall = Name = "IKUX"
triggerall = Var(41)&2
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (MoveContact && StateNo != 510 || Time <= 2)
trigger1 = map(DP) && (map(b_yb)) && !Var(15)
trigger2 = Var(17) = 1000 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Blade Bulletstorm
[State -1, QCF,ct]
type = ChangeState
value = 1070
triggerall = statetype != A
triggerall = Name = "IKUX"
triggerall = Var(41)&1
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (MoveContact && StateNo != 510 || Time <= 2)
trigger1 = map(QCF) && (map(b_yb)) && !Var(15)
trigger2 = Var(17) = 1000 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Cutting Edge Kick
[State -1, QCB,ct]
type = ChangeState
value = 1250
triggerall = statetype != A
triggerall = Name = "IKUE"
triggerall = Power >= 500
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (MoveContact && StateNo != 510 || Time <= 2) 
trigger1 = map(QCB) && (map(b_yb)) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Rage of the Dragon
[State -1, DP,ct]
type = ChangeState
value = 1150
triggerall = statetype != A
triggerall = Name = "IKUE"
triggerall = Power >= 500
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (MoveContact && StateNo != 510 || Time <= 2)
trigger1 = map(DP) && (map(b_yb)) && !Var(15)
trigger2 = Var(17) = 1300 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Blade Inferno
[State -1, QCF,ct]
type = ChangeState
value = 1050
triggerall = statetype != A
triggerall = Name = "IKUE"
triggerall = Power >= 500
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (MoveContact && StateNo != 510 || Time <= 2)
trigger1 = map(QCF) && (map(b_yb)) && !Var(15)
trigger2 = Var(17) = 1400 && Var(15) && Random < 200

;---------------------------------------------------------------------------
; Invigorate
[State -1, Y+B]
type = ChangeState
value = 960
triggerall = statetype != A
triggerall = Name = "IKUK"
triggerall = Var(18) >= 3000 && Var(40) <= 0
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (MoveContact && StateNo != 510 || Time <= 2) || StateNo = 950 && AnimElemNo(0) >= 8
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = Var(17) = 900 && Var(15) && Random < 750

;---------------------------------------------------------------------------
; Invigoration
[State -1, Y+B]
type = ChangeState
value = 950
triggerall = statetype != A
triggerall = Name = "IKUK"
triggerall = Var(18) < 3000 || Var(40) < 1000
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (MoveContact && StateNo != 510 || Time <= 2)
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = Var(17) = 900 && Var(15) && Random < 350

;---------------------------------------------------------------------------
; Crescent Slash
[State -1, Y+B]
type = ChangeState
value = 910 + (map(p_Fd)>0) + 2 * (map(p_Bk)>0)
triggerall = Name = "IKUX"
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (MoveContact && StateNo != 510 || Time <= 2)
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 350

;---------------------------------------------------------------------------
; Overcrush
[State -1, Y+B]
type = ChangeState
value = 900
triggerall = statetype != A
triggerall = Name = "IKUE"
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (MoveContact && StateNo != 510 || Time <= 2)
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 350

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
; 2K Denspin
[State -1, 2~8,ab]
type = ChangeState
value = 1650
triggerall = Name = "IKUK" && Var(40) >= 1000
triggerall = statetype != A
triggerall = ctrl || StateNo = 40 || StateNo = 55 || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || (StateNo = [200,800) || StateNo = 1600) && Time <= 2
trigger1 = map(b_ab) && !Var(15)
trigger1 = Var(48) >= 24 && ((map(p_Up)>0) || command = "up")
trigger3 = (Var(17) = 1400 || Var(17) = 1700) && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SK Denspin
[State -1, 2~8,b]
type = ChangeState
value = 1601
triggerall = Name = "IKUK"
triggerall = statetype != A
triggerall = ctrl || StateNo = 40 || StateNo = 55 || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(b_b) && !Var(15)
trigger1 = Var(48) >= 24 && ((map(p_Up)>0) || command = "up")
trigger3 = (Var(17) = 1400 || Var(17) = 1700) && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LK Denspin
[State -1, 2~8,a]
type = ChangeState
value = 1600
triggerall = Name = "IKUK"
triggerall = statetype != A
triggerall = ctrl || StateNo = 40 || StateNo = 55 || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(b_a) && !Var(15)
trigger1 = Var(48) >= 24 && ((map(p_Up)>0) || command = "up")
trigger2 = Var(17) = 1600 && Var(15) && Random < 350

;---------------------------------------------------------------------------
; 2K Denpunch
[State -1, 4~6,ab]
type = ChangeState
value = 1550
triggerall = Name = "IKUK" && Var(40) >= 1000
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || (StateNo = [200,800) || StateNo = 1500) && Time <= 2
trigger1 = map(b_ab) && !Var(15)
trigger1 = Var(44) >= 24 && P2Dist X >= 0 && Facing = 1 && (((map(p_Fd)>0) && P2Dist X >= 0) || ((map(p_Bk)>0) && P2Dist X < 0))
trigger2 = map(b_ab) && !Var(15)
trigger2 = Var(46) >= 24 && P2Dist X >= 0 && Facing = -1 && (((map(p_Fd)>0) && P2Dist X >= 0) || ((map(p_Bk)>0) && P2Dist X < 0))
trigger3 = Var(17) = 1600 && Var(15) && Random < 350

;---------------------------------------------------------------------------
; SK Denpunch
[State -1, 4~6,b]
type = ChangeState
value = 1501
triggerall = Name = "IKUK"
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(b_b) && !Var(15)
trigger1 = Var(44) >= 24 && P2Dist X >= 0 && Facing = 1 && (((map(p_Fd)>0) && P2Dist X >= 0) || ((map(p_Bk)>0) && P2Dist X < 0))
trigger2 = map(b_b) && !Var(15)
trigger2 = Var(46) >= 24 && P2Dist X >= 0 && Facing = -1 && (((map(p_Fd)>0) && P2Dist X >= 0) || ((map(p_Bk)>0) && P2Dist X < 0))
trigger3 = Var(17) = 1600 && Var(15) && Random < 350

;---------------------------------------------------------------------------
; LK Denpunch
[State -1, 4~6,a]
type = ChangeState
value = 1500
triggerall = Name = "IKUK"
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(b_a) && !Var(15)
trigger1 = Var(44) >= 24 && P2Dist X >= 0 && Facing = 1 && (((map(p_Fd)>0) && P2Dist X >= 0) || ((map(p_Bk)>0) && P2Dist X < 0))
trigger2 = map(b_a) && !Var(15)
trigger2 = Var(46) >= 24 && P2Dist X >= 0 && Facing = -1 && (((map(p_Fd)>0) && P2Dist X >= 0) || ((map(p_Bk)>0) && P2Dist X < 0))
trigger3 = Var(17) = 1400 && Var(15) && Random < 350

;---------------------------------------------------------------------------
; 2P Denshoru
[State -1, 2~8,xy]
type = ChangeState
value = 1450
triggerall = Name = "IKUK" && Var(40) >= 1000
triggerall = statetype != A
triggerall = ctrl || StateNo = 40 || StateNo = 55 || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || (StateNo = [200,800) || StateNo = 1400) && Time <= 2
trigger1 = map(b_xy) && !Var(15)
trigger1 = Var(48) >= 24 && ((map(p_Up)>0) || command = "up")
trigger2 = Var(17) = 1600 && Var(15) && Random < 350

;---------------------------------------------------------------------------
; SP Denshoru
[State -1, 2~8,y]
type = ChangeState
value = 1401
triggerall = Name = "IKUK"
triggerall = statetype != A
triggerall = ctrl || StateNo = 40 || StateNo = 55 || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(b_y) && !Var(15)
trigger1 = Var(48) >= 24 && ((map(p_Up)>0) || command = "up")
trigger2 = Var(17) = 1300 && Var(15) && Random < 350

;---------------------------------------------------------------------------
; LP Denshoru
[State -1, 2~8,x]
type = ChangeState
value = 1400
triggerall = Name = "IKUK"
triggerall = statetype != A
triggerall = ctrl || StateNo = 40 || StateNo = 55 || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(b_x) && !Var(15)
trigger1 = Var(48) >= 24 && ((map(p_Up)>0) || command = "up")
trigger2 = Var(17) = 1100 && Var(15) && Random < 350

;---------------------------------------------------------------------------
; 2P Denjouken
[State -1, 4~6,xy]
type = ChangeState
value = 1350
triggerall = Name = "IKUK" && Var(40) >= 1000
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || (StateNo = [200,800) || StateNo = 1300) && Time <= 2
triggerall = !NumHelper(1310) && !NumHelper(1350)
trigger1 = map(b_xy) && !Var(15)
trigger1 = Var(44) >= 24 && P2Dist X >= 0 && Facing = 1 && (((map(p_Fd)>0) && P2Dist X >= 0) || ((map(p_Bk)>0) && P2Dist X < 0))
trigger2 = map(b_xy) && !Var(15)
trigger2 = Var(46) >= 24 && P2Dist X >= 0 && Facing = -1 && (((map(p_Fd)>0) && P2Dist X >= 0) || ((map(p_Bk)>0) && P2Dist X < 0))
trigger3 = Var(17) = 1000 && Var(15) && Random < 350

;---------------------------------------------------------------------------
; SP Denjouken
[State -1, 4~6,y]
type = ChangeState
value = 1301
triggerall = Name = "IKUK"
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
triggerall = !NumHelper(1310)
trigger1 = map(b_y) && !Var(15)
trigger1 = Var(44) >= 24 && P2Dist X >= 0 && Facing = 1 && (((map(p_Fd)>0) && P2Dist X >= 0) || ((map(p_Bk)>0) && P2Dist X < 0))
trigger2 = map(b_y) && !Var(15)
trigger2 = Var(46) >= 24 && P2Dist X >= 0 && Facing = -1 && (((map(p_Fd)>0) && P2Dist X >= 0) || ((map(p_Bk)>0) && P2Dist X < 0))
trigger3 = Var(17) = 1000 && Var(15) && Random < 350

;---------------------------------------------------------------------------
; LP Denjouken
[State -1, 4~6,x]
type = ChangeState
value = 1300
triggerall = Name = "IKUK"
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
triggerall = !NumHelper(1310)
trigger1 = map(b_x) && !Var(15)
trigger1 = Var(44) >= 24 && P2Dist X >= 0 && Facing = 1 && (((map(p_Fd)>0) && P2Dist X >= 0) || ((map(p_Bk)>0) && P2Dist X < 0))
trigger2 = map(b_x) && !Var(15)
trigger2 = Var(46) >= 24 && P2Dist X >= 0 && Facing = -1 && (((map(p_Fd)>0) && P2Dist X >= 0) || ((map(p_Bk)>0) && P2Dist X < 0))
trigger3 = Var(17) = 1000 && Var(15) && Random < 350

;---------------------------------------------------------------------------
; SK Splitting Kick
[State -1, QCB,b]
type = ChangeState
value = 1201
triggerall = statetype != A
triggerall = Name != "IKUK"
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (MoveContact && StateNo != 510 || Time <= 2)
trigger1 = map(QCB) && map(b_b) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 350

;---------------------------------------------------------------------------
; LK Splitting Kick
[State -1, QCB,a]
type = ChangeState
value = 1200
triggerall = statetype != A
triggerall = Name != "IKUK"
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (MoveContact && StateNo != 510 || Time <= 2)
trigger1 = map(QCB) && map(b_a) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 350

;---------------------------------------------------------------------------
; SP Rising Dragon
[State -1, DP,y]
type = ChangeState
value = 1101
triggerall = statetype != A
triggerall = Name != "IKUK"
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (MoveContact && StateNo != 510 || Time <= 2)
trigger1 = map(DP) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1300 && Var(15) && Random < 350

;---------------------------------------------------------------------------
; LP Rising Dragon
[State -1, DP,x]
type = ChangeState
value = 1100
triggerall = statetype != A
triggerall = Name != "IKUK"
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (MoveContact && StateNo != 510 || Time <= 2)
trigger1 = map(DP) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1100 && Var(15) && Random < 350

;---------------------------------------------------------------------------
; SP Blade Bullet
[State -1, QCF,y]
type = ChangeState
value = 1001
triggerall = statetype != A
triggerall = Name != "IKUK"
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (MoveContact && StateNo != 510 || Time <= 2)
triggerall = !NumHelper(1010)
trigger1 = map(QCF) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1000 && Var(15) && Random < 350

;---------------------------------------------------------------------------
; LP Blade Bullet
[State -1, QCF,x]
type = ChangeState
value = 1000
triggerall = statetype != A
triggerall = Name != "IKUK"
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (MoveContact && StateNo != 510 || Time <= 2)
triggerall = !NumHelper(1010)
trigger1 = map(QCF) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1000 && Var(15) && Random < 350

;===========================================================================
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
trigger2 = Var(17) = 1600 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; CN db+SK
[State -1, cr.b+SK]
type = ChangeState
value = 515
triggerall = statetype != A
triggerall = Name = "IKUK"
triggerall = StateNo != 205 && StateNo != 215 && StateNo != 225 && StateNo != 515 && StateNo != 615
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (MoveContact && StateNo != 510 || Time <= 2)
trigger1 = map(b_b) && (map(p_Bk)>0) && (map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; CN f+LP
[State -1, st.f+LP]
type = ChangeState
value = 225
triggerall = statetype != A
triggerall = StateNo != 205 && StateNo != 215 && StateNo != 225 && StateNo != 515 && StateNo != 615
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (MoveContact && StateNo != 510 || Time <= 2)
trigger1 = map(b_x) && (map(p_Fd)>0) && !(map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; CN b+SP
[State -1, st.b+SP]
type = ChangeState
value = 205
triggerall = statetype != A
triggerall = StateNo != 205 && StateNo != 215 && StateNo != 225 && StateNo != 515 && StateNo != 615
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (MoveContact && StateNo != 510 || Time <= 2)
trigger1 = map(b_y) && (map(p_Bk)>0) && !(map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 205 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; CN f+SP
[State -1, st.f+SP]
type = ChangeState
value = 215
triggerall = statetype != A
triggerall = Name != "IKUK"
triggerall = StateNo != 205 && StateNo != 215 && StateNo != 225 && StateNo != 515 && StateNo != 615
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (MoveContact && StateNo != 510 || Time <= 2)
trigger1 = map(b_y) && (map(p_Fd)>0) && !(map(p_Dn)>0) && !Var(15)
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
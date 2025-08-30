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

; cause nobodys listening
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
trigger1 = (command="FF" || map(b_66)) && p2dist x < -8 && !Var(15)
trigger2 = (command="BB" || map(b_44)) && p2dist x >= -8 && !Var(15)
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
triggerall = Name = "BOUK" && (Var(44)=1||Var(44)=5)
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
triggerall = Name = "BOUK" && (Var(44)=1||Var(44)=5)
triggerall = !(StateNo = 50 && NumHelper(56))
trigger1 = (command="BB" || map(b_44)) && !Var(15)
trigger2 = Var(17) = 115 && Var(15)


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
triggerall = (StateNo = [200,800) || StateNo = 920 || StateNo = [1100,1500) || StateNo = 1600 || StateNo = 1700 || StateNo = 1900) && MoveHit || StateNo = 1000 && (NumHelper(1010) || MoveType = I) && MoveHit || StateNo = 1630 && (NumHelper(1630) || MoveType = I) && MoveHit || StateNo = 1650 && Time > 53 || StateNo = 1800 && (NumHelper(945) || MoveType = I) && MoveHit || StateNo = 1850 && (NumHelper(1850) || MoveType = I) && MoveHit
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
triggerall = StateNo != [800,900) && StateNo != [1640,1650]
triggerall = !MoveContact && !Var(51) || MoveGuarded
triggerall = StateNo != [900,920) && StateNo != (920,1100) && StateNo != 1110 && StateNo != 1630 && StateNo != [1800,1850] && !Var(51) || StateNo = 900 && NumHelper(910) || StateNo = 1000 && (NumHelper(1010) || MoveType = I) && MoveGuarded || StateNo = 1110 && Time >= 12 || StateNo = 1630 && (NumHelper(1630) || MoveType = I) && MoveGuarded || StateNo = 1800 && (NumHelper(945) || MoveType = I) && MoveGuarded || StateNo = 1850 && (NumHelper(1850) || MoveType = I) && MoveGuarded
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
triggerall = (ctrl || StateNo < 120) && !Var(51) || StateNo = 1000 && (NumHelper(1010) || MoveType = I) && !MoveContact || StateNo = 1630 && (NumHelper(1630) || MoveType = I) && !MoveContact || StateNo = 1800 && (NumHelper(945) || MoveType = I) && !MoveContact || StateNo = 1850 && (NumHelper(1850) || MoveType = I) && !MoveContact
trigger1 = map(b_a) && map(b_y) && map(b_x) && map(b_b) && !Var(15)
trigger2 = Var(17) = 3000 && Var(15)

;===========================================================================
;---------------------------------------------------------------------------
; Field Corruption
[State -1, 2QCF,2k]
type = ChangeState
value = 2400 + 500 * (Name="BOUX")
triggerall = statetype != A
triggerall = Power >= 3000
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && MoveContact
trigger1 = map(QCFQC) && map(b_ab) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Down The Parapets
[State -1, dd+2p]
type = ChangeState
value = 2500
triggerall = Name = "BOUN"
triggerall = statetype != A
triggerall = Power >= 2000
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && MoveContact && !MoveGuarded
trigger1 = map(DD) && map(b_xy) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Spirit Crush
[State -1, 2QCB,2k]
type = ChangeState
value = 2700
triggerall = statetype != A
triggerall = Name = "BOUK"
triggerall = Power >= 2000 - 1000 * (StateNo = 2600)
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && MoveContact || (StateNo = 2600 || StateNo = 2601) && Time <= 2
trigger1 = map(QCBQC) && map(b_ab) && !Var(15)
trigger2 = (Var(17) = 1200 || Var(17) = 1300) && Var(15) && Random < 350

;---------------------------------------------------------------------------
; Soulless Journey EX
[State -1, 2QCF,2p]
type = ChangeState
value = 2300
triggerall = Name = "BOUX"
triggerall = statetype != A
triggerall = Power >= 2000 - 1000 * (StateNo = 2000)
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && MoveContact || (StateNo = 2000) && Time <= 2
trigger1 = map(QCFQC) && map(b_xy) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Spirit Rider SK
[State -1, 2QCB,a]
type = ChangeState
value = 2601 + 5 * (StateType = A)
triggerall = Name = "BOUK"
triggerall = Power >= 1000
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && MoveContact
trigger1 = map(QCBQC) && map(b_b) && !Var(15)
trigger2 = Var(17) = 1300 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Spirit Rider LK
[State -1, 2QCB,a]
type = ChangeState
value = 2600 + 5 * (StateType = A)
triggerall = Name = "BOUK"
triggerall = Power >= 1000
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && MoveContact
trigger1 = map(QCBQC) && map(b_a) && !Var(15)
trigger2 = Var(17) = 1300 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Karmatic Weight
[State -1, 2QCB,p]
type = ChangeState
value = 2550
triggerall = Name = "BOUK"
triggerall = statetype != A
triggerall = Power >= 1000
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && MoveContact
trigger1 = map(QCBQC) && (map(b_x) || map(b_y)) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 50

;---------------------------------------------------------------------------
; 10,000 Blades
[State -1, 2QCF,k]
type = ChangeState
value = 2450
triggerall = Name = "BOUX"
triggerall = statetype != A
triggerall = Power >= 1000
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && MoveContact
trigger1 = map(QCFQC) && (map(b_a) || map(b_b)) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Fallen Heroes
[State -1, 2QCB,k]
type = ChangeState
value = 2100 + 700 * (Name="BOUX")
triggerall = Name != "BOUK"
triggerall = statetype != A
triggerall = Power >= 1000
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && MoveContact
trigger1 = map(QCBQC) && (map(b_a) || map(b_b)) && !Var(15)
trigger2 = Var(17) = 1300 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Soulless Journey
[State -1, 2QCF,p]
type = ChangeState
value = 2000
triggerall = statetype != A
triggerall = Power >= 1000
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && MoveContact
trigger1 = map(QCFQC) && (map(b_x) || map(b_y)) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;===========================================================================
;---------------------------------------------------------------------------
; CTech: Anhur Stance
[State -1, f.Y+B]
type = ChangeState
value = 933
triggerall = Name = "BOUK"
triggerall = Var(44) != 4 && Map(BoukStanceCDTime) = 0
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || StateNo = [1300,1500] || StateNo = 1700) && MoveContact || StateNo = 1650 && Time > 53
trigger1 = !(map(p_Bk)>0) && (!(map(p_Dn)>0) || Var(44) = 3) && (map(p_Fd)>0) && (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; CTech: Ptah Stance
[State -1, d.Y+B]
type = ChangeState
value = 932
triggerall = Name = "BOUK"
triggerall = Var(44) != 3 && Map(BoukStanceCDTime) = 0
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || StateNo = [1300,1500] || StateNo = 1700) && MoveContact || StateNo = 1650 && Time > 53
trigger1 = (map(p_Dn)>0) && (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 125

;---------------------------------------------------------------------------
; CTech: Osiris Stance
[State -1, b.Y+B]
type = ChangeState
value = 931
triggerall = Name = "BOUK"
triggerall = Var(44) != 2 && Map(BoukStanceCDTime) = 0
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || StateNo = [1300,1500] || StateNo = 1700) && MoveContact || StateNo = 1650 && Time > 53
trigger1 = (map(p_Bk)>0) && (!(map(p_Dn)>0) || Var(44) = 3) && !(map(p_Fd)>0) && (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = Var(17) = 900 && Var(15) && Random < 350 && Life < 250

;---------------------------------------------------------------------------
; CTech: Nu Stance
[State -1, Y+B]
type = ChangeState
value = 930
triggerall = Name = "BOUK"
triggerall = Var(44) != 1 && Map(BoukStanceCDTime) = 0
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || StateNo = [1300,1500] || StateNo = 1700) && MoveContact || StateNo = 1650 && Time > 53
trigger1 = ((!(map(p_Bk)>0) && (!(map(p_Dn)>0) || Var(44) = 3) && !(map(p_Fd)>0)) || (map(p_Up)>0)) && (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = Var(17) = 900 && Var(15) && Random < 350 && P2BodyDist X > 128

;---------------------------------------------------------------------------
; CTech: Area Field
[State -1, Y+B]
type = ChangeState
value = 920
triggerall = Name = "BOUX"
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && MoveContact
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = Var(17) = 120 && Var(15) && Random < 350

;---------------------------------------------------------------------------
; CTech: Portal Set
[State -1, Y+B]
type = ChangeState
value = 905 + (-3*(map(p_Dn)>0)-1*(map(p_Bk)>0)+1*(map(p_Fd)>0))
triggerall = Name = "BOUN"
triggerall = !NumHelper(2210)
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && MoveContact || StateNo = 1300 && MoveContact
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = Var(17) = 900 && Var(15) && Random < 500 && !NumHelper(910)
trigger3 = Var(15) && StateNo = 1300 && !Var(5) && Random < 500 && !NumHelper(910)

;---------------------------------------------------------------------------
; Throw
[State -1, X+A]
type = ChangeState
value = ifelse(StateType=A,850,800)
;triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && Time <= 2 && PrevStateNo != [200,800) || StateNo = [600,800) && MoveHit
trigger1 = (map(b_x) && map(b_a) || map(b_xa)) && !Var(15)
trigger2 = Var(17) = 800 && Var(15) && (Random < 500 || Name != "BOUK")
trigger2 = P2BodyDist X = [-8,const(size.ground.front)] && StateType != A && EnemyNear,StateType != A || P2BodyDist X <= 40 && !numtarget(860) && StateType = A && EnemyNear,StateType = A

;===========================================================================
;---------------------------------------------------------------------------
; Neith's Hunt 9
[State -1, UF,ab]
type = ChangeState
value = 1507
triggerall = Name != "BOUN"
triggerall = statetype = A && Var(1)
triggerall = Ctrl || (StateNo = [600,800)) && MoveContact || (StateNo = 700 || StateNo = 710) && Time <= 2
trigger1 = (map(p_Up)>0) && (map(p_Fd)>0) && (map(b_a) && map(b_b) || map(b_ab)) && !Var(15)

;---------------------------------------------------------------------------
; Neith's Hunt 7
[State -1, UB,ab]
type = ChangeState
value = 1505
triggerall = Name != "BOUN"
triggerall = statetype = A && Var(1)
triggerall = Ctrl || (StateNo = [600,800)) && MoveContact || (StateNo = 700 || StateNo = 710) && Time <= 2
trigger1 = (map(p_Up)>0) && (map(p_Bk)>0) && (map(b_a) && map(b_b) || map(b_ab)) && !Var(15)

;---------------------------------------------------------------------------
; Neith's Hunt 3
[State -1, DF,ab]
type = ChangeState
value = 1502
triggerall = Name != "BOUN"
triggerall = statetype = A && Var(1)
triggerall = (Vel Y >= -1 || Time >= 10) && Ctrl || (StateNo = [600,800)) && MoveContact || (StateNo = 700 || StateNo = 710) && Vel Y >= -1 && Time <= 2
trigger1 = (map(p_Dn)>0) && (map(p_Fd)>0) && (map(b_a) && map(b_b) || map(b_ab)) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Neith's Hunt 1
[State -1, DB,ab]
type = ChangeState
value = 1500
triggerall = Name != "BOUN"
triggerall = statetype = A && Var(1)
triggerall = (Vel Y >= -1 || Time >= 10) && Ctrl || (StateNo = [600,800)) && MoveContact || (StateNo = 700 || StateNo = 710) && Vel Y >= -1 && Time <= 2
trigger1 = (map(p_Dn)>0) && (map(p_Bk)>0) && (map(b_a) && map(b_b) || map(b_ab)) && !Var(15)

;---------------------------------------------------------------------------
; Neith's Hunt 8
[State -1, U,ab]
type = ChangeState
value = 1506
triggerall = Name != "BOUN"
triggerall = statetype = A && Var(1)
triggerall = Ctrl || (StateNo = [600,800)) && MoveContact || (StateNo = 700 || StateNo = 710) && Time <= 2
trigger1 = (map(p_Up)>0) && (map(b_a) && map(b_b) || map(b_ab)) && !Var(15)

;---------------------------------------------------------------------------
; Neith's Hunt 6
[State -1, F,ab]
type = ChangeState
value = 1504
triggerall = Name != "BOUN"
triggerall = statetype = A && Var(1)
triggerall = Ctrl || (StateNo = [600,800)) && MoveContact || (StateNo = 700 || StateNo = 710) && Time <= 2
trigger1 = (map(p_Fd)>0) && !(map(p_Dn)>0) && (map(b_a) && map(b_b) || map(b_ab)) && !Var(15)

;---------------------------------------------------------------------------
; Neith's Hunt 4
[State -1, B,ab]
type = ChangeState
value = 1503
triggerall = Name != "BOUN"
triggerall = statetype = A && Var(1)
triggerall = Ctrl || (StateNo = [600,800)) && MoveContact || (StateNo = 700 || StateNo = 710) && Time <= 2
trigger1 = (map(p_Bk)>0) && !(map(p_Dn)>0) && (map(b_a) && map(b_b) || map(b_ab)) && !Var(15)

;---------------------------------------------------------------------------
; Neith's Hunt 2
[State -1, D,ab]
type = ChangeState
value = 1501
triggerall = Name != "BOUN"
triggerall = statetype = A && Var(1)
triggerall = (Vel Y >= -1 || Time >= 10) && Ctrl || (StateNo = [600,800)) && MoveContact || (StateNo = 700 || StateNo = 710) && Vel Y >= -1 && Time <= 2
trigger1 = (map(p_Dn)>0) && (map(b_a) && map(b_b) || map(b_ab)) && !Var(15)

;---------------------------------------------------------------------------
; SK Aura of Osiris
[State -1, DP,b]
type = ChangeState
value = 1401
triggerall = Name = "BOUK"
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && MoveContact || StateNo = 1700 && MoveContact && (Var(44)=2||Var(44)=5)
trigger1 = map(DP) && map(b_b) && !Var(15)
trigger2 = Var(17) = 1300 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; LK Aura of Osiris
[State -1, DP,a]
type = ChangeState
value = 1400
triggerall = Name = "BOUK"
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && MoveContact || StateNo = 1700 && MoveContact && (Var(44)=2||Var(44)=5)
trigger1 = map(DP) && map(b_a) && !Var(15)
trigger2 = Var(17) = 1100 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SK Vertical Swing
[State -1, DP,b]
type = ChangeState
value = 1301
triggerall = statetype != A
triggerall = Name = "BOUN"
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && MoveContact
trigger1 = map(DP) && map(b_b) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; LK Vertical Swing
[State -1, DP,a]
type = ChangeState
value = 1300
triggerall = statetype != A
triggerall = Name = "BOUN"
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && MoveContact
trigger1 = map(DP) && map(b_a) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SP Bastet Pounce
[State -1, QCF,y]
type = ChangeState
value = 1701 + 200 * (Name="BOUX")
triggerall = Name != "BOUN"
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && MoveContact
trigger1 = map(QCF) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; LP Bastet Pounce
[State -1, QCF,x]
type = ChangeState
value = 1700 + 200 * (Name="BOUX")
triggerall = Name != "BOUN"
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && MoveContact
trigger1 = map(QCF) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SP Anhur March
[State -1, 360,y]
type = ChangeState
value = 1641
triggerall = Name = "BOUK"
triggerall = statetype != A
triggerall = ctrl || StateNo = 40 || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && MoveContact || StateNo = 1700 && MoveContact && (Var(44)=[4,5])
trigger1 = ((map(HCB) || COMMAND = "HCB") || map(f360) || map(r360)) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LP Anhur March
[State -1, 360,x]
type = ChangeState
value = 1640
triggerall = Name = "BOUK"
triggerall = statetype != A
triggerall = ctrl || StateNo = 40 || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && MoveContact || StateNo = 1700 && MoveContact && (Var(44)=[4,5])
trigger1 = ((map(HCB) || COMMAND = "HCB") || map(f360) || map(r360)) && map(b_x) && !Var(15)
trigger2 = Var(17) = 800 && Var(15) && Random < 500
trigger2 = P2BodyDist X = [-8,const(size.ground.front)] && StateType != A && EnemyNear,StateType != A || P2BodyDist X <= 40 && !numtarget(860) && StateType = A && EnemyNear,StateType = A

;---------------------------------------------------------------------------
; SK Ptah Gift
[State -1, QCB,b]
type = ChangeState
value = 1631
triggerall = Name = "BOUK"
triggerall = !NumHelper(1630)
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && MoveContact || StateNo = 1700 && MoveContact && (Var(44)=3||Var(44)=5)
trigger1 = map(QCB) && map(b_b) && !Var(15)
trigger2 = (Var(17) = 900 || Var(17) = 1000) && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LK Ptah Gift
[State -1, QCB,a]
type = ChangeState
value = 1630
triggerall = Name = "BOUK"
triggerall = !NumHelper(1630)
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && MoveContact || StateNo = 1700 && MoveContact && (Var(44)=3||Var(44)=5)
trigger1 = map(QCB) && map(b_a) && !Var(15)
trigger2 = (Var(17) = 900 || Var(17) = 1000) && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SK Drift of Nu
[State -1, DD,b]
type = ChangeState
value = 1613
triggerall = Name = "BOUK"
triggerall = Var(1)
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && MoveContact || StateNo = 1700 && MoveContact && (Var(44)=1||Var(44)=5)
trigger1 = map(DD) && map(b_b) && !Var(15)
trigger2 = (Var(17) = 100 || Var(17) = 1700) && Var(15) && Random < 125

;---------------------------------------------------------------------------
; SP Drift of Nu
[State -1, DD,y]
type = ChangeState
value = 1612
triggerall = Name = "BOUK"
triggerall = Var(1)
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && MoveContact || StateNo = 1700 && MoveContact && (Var(44)=1||Var(44)=5)
trigger1 = map(DD) && map(b_y) && !Var(15)
trigger2 = (Var(17) = 100 || Var(17) = 1700) && Var(15) && Random < 125

;---------------------------------------------------------------------------
; LK Drift of Nu
[State -1, DD,a]
type = ChangeState
value = 1611
triggerall = Name = "BOUK"
triggerall = Var(1)
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && MoveContact || StateNo = 1700 && MoveContact && (Var(44)=1||Var(44)=5)
trigger1 = map(DD) && map(b_a) && !Var(15)
trigger2 = (Var(17) = 100 || Var(17) = 1700) && Var(15) && Random < 125

;---------------------------------------------------------------------------
; LP Drift of Nu
[State -1, DD,x]
type = ChangeState
value = 1610
triggerall = Name = "BOUK"
triggerall = Var(1)
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && MoveContact || StateNo = 1700 && MoveContact && (Var(44)=1||Var(44)=5)
trigger1 = map(DD) && map(b_x) && !Var(15)
trigger2 = (Var(17) = 100 || Var(17) = 1700) && Var(15) && Random < 125

;---------------------------------------------------------------------------
; SK Portal
[State -1, QCB,y]
type = ChangeState
value = 1851
triggerall = Name = "BOUX"
triggerall = Map(BouxArm) >= 1 && !NumHelper(1850) && NumHelper(940) >= floor(Map(BouxArm))
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && MoveContact || StateNo = 1900 && MoveContact
trigger1 = map(QCB) && map(b_y) && !Var(15)
trigger2 = Var(17) = 900 && Var(15) && Random < 125

;---------------------------------------------------------------------------
; LK Portal
[State -1, QCB,x]
type = ChangeState
value = 1850
triggerall = Name = "BOUX"
triggerall = Map(BouxArm) >= 1 && !NumHelper(1850) && NumHelper(940) >= floor(Map(BouxArm))
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && MoveContact || StateNo = 1900 && MoveContact
trigger1 = map(QCB) && map(b_x) && !Var(15)
trigger2 = Var(17) = 900 && Var(15) && Random < 125

;---------------------------------------------------------------------------
; SK Swords
[State -1, QCB,a]
type = ChangeState
value = 1805
triggerall = Name = "BOUX"
triggerall = statetype != A
triggerall = Map(BouxArm) >= 1 && !NumHelper(945) && NumHelper(940) >= floor(Map(BouxArm))
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && MoveContact || StateNo = 1900 && MoveContact
trigger1 = map(QCB) && map(b_b) && !Var(15)
trigger2 = Var(17) = 1000 && Var(15) && Random < 125

;---------------------------------------------------------------------------
; LK Swords
[State -1, QCB,b]
type = ChangeState
value = 1804
triggerall = Name = "BOUX"
triggerall = statetype != A
triggerall = Map(BouxArm) >= 1 && !NumHelper(945) && NumHelper(940) >= floor(Map(BouxArm))
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && MoveContact || StateNo = 1900 && MoveContact
trigger1 = map(QCB) && map(b_a) && !Var(15)
trigger2 = Var(17) = 1000 && Var(15) && Random < 125

;---------------------------------------------------------------------------
; SP Swords
[State -1, QCF,b]
type = ChangeState
value = 1801
triggerall = Name = "BOUX"
triggerall = Map(BouxArm) >= 1 && !NumHelper(945) && NumHelper(940) >= floor(Map(BouxArm))
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && MoveContact || StateNo = 1900 && MoveContact
trigger1 = map(QCF) && map(b_b) && !Var(15)
trigger2 = Var(17) = 1000 && Var(15) && Random < 125

;---------------------------------------------------------------------------
; LP Swords
[State -1, QCF,a]
type = ChangeState
value = 1800
triggerall = Name = "BOUX"
triggerall = Map(BouxArm) >= 1 && !NumHelper(945) && NumHelper(940) >= floor(Map(BouxArm))
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && MoveContact || StateNo = 1900 && MoveContact
trigger1 = map(QCF) && map(b_a) && !Var(15)
trigger2 = Var(17) = 1000 && Var(15) && Random < 125

;---------------------------------------------------------------------------
; SP Portal Implode
[State -1, QCB,y]
type = ChangeState
value = 1201 + (StateType=A)*5
triggerall = NumHelper(910)
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && MoveContact || StateNo = 1300 && MoveContact
trigger1 = map(QCB) && map(b_y) && !Var(15)
trigger2 = Var(17) = 900 && Var(15) && Random < 125

;---------------------------------------------------------------------------
; LP Portal Implode
[State -1, QCB,x]
type = ChangeState
value = 1200 + (StateType=A)*5
triggerall = NumHelper(910)
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && MoveContact || StateNo = 1300 && MoveContact
trigger1 = map(QCB) && map(b_x) && !Var(15)
trigger2 = (Var(17) = 1000 || Var(17) = 1200) && Var(15) && Random < 500

;---------------------------------------------------------------------------
; SK Revenge of Horus
[State -1, QCB,b]
type = ChangeState
value = 1101 + 2 * (StateType=A)
triggerall = statetype != A || statetype = A && Var(1)
triggerall = NumHelper(910)
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && MoveContact || StateNo = 1300 && MoveContact
trigger1 = map(QCB) && map(b_b) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 125

;---------------------------------------------------------------------------
; LK Journey of Ra
[State -1, QCB,a]
type = ChangeState
value = 1100 + 2 * (StateType=A)
triggerall = statetype != A || statetype = A && Var(1)
triggerall = NumHelper(910)
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && MoveContact || StateNo = 1300 && MoveContact
trigger1 = map(QCB) && map(b_a) && !Var(15)
trigger2 = Var(17) = 100 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SK Portal Distort
[State -1, DD,b]
type = ChangeState
value = 1003
triggerall = Name = "BOUN"
triggerall = statetype != A
triggerall = !NumHelper(1010)
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && MoveContact
trigger1 = map(DD) && map(b_b) && !Var(15)
trigger2 = (Var(17) = 900 || Var(17) = 1000) && Var(15) && Random < 250
trigger2 = P2BodyDist X > 128

;---------------------------------------------------------------------------
; SP Portal Distort
[State -1, DD,y]
type = ChangeState
value = 1002
triggerall = Name = "BOUN"
triggerall = statetype != A
triggerall = !NumHelper(1010)
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && MoveContact
trigger1 = map(DD) && map(b_y) && !Var(15)
trigger2 = (Var(17) = 900 || Var(17) = 1000) && Var(15) && Random < 250
trigger2 = P2BodyDist X = [96,128]

;---------------------------------------------------------------------------
; LK Portal Distort
[State -1, DD,a]
type = ChangeState
value = 1001
triggerall = Name = "BOUN"
triggerall = statetype != A
triggerall = !NumHelper(1010)
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && MoveContact
trigger1 = map(DD) && map(b_a) && !Var(15)
trigger2 = (Var(17) = 900 || Var(17) = 1000) && Var(15) && Random < 250
trigger2 = P2BodyDist X = [64,96]

;---------------------------------------------------------------------------
; LP Portal Distort
[State -1, DD,x]
type = ChangeState
value = 1000
triggerall = Name = "BOUN"
triggerall = statetype != A
triggerall = !NumHelper(1010)
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && MoveContact
trigger1 = map(DD) && map(b_x) && !Var(15)
trigger2 = (Var(17) = 900 || Var(17) = 1000) && Var(15) && Random < 250
trigger2 = P2BodyDist X < 64

;===========================================================================
;---------------------------------------------------------------------------
; CN f+SK
[State -1, cr.f+SK]
type = ChangeState
value = 515
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = 200 || StateNo = 210 || StateNo = 300 || StateNo = 310 || StateNo = 400 || StateNo = 410 || StateNo = 500) && MoveContact
trigger1 = map(b_b) && (map(p_Fd)>0) && (map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 205 && Var(15) && Random < 250 && EnemyNear,StateType != A

;---------------------------------------------------------------------------
; CN b+SP
[State -1, b+SP]
type = ChangeState
value = 216
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = 200 || StateNo = 210 || StateNo = 300 || StateNo = 310 || StateNo = 400 || StateNo = 410 || StateNo = 500) && MoveContact
trigger1 = map(b_y) && (map(p_Bk)>0) && !(map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 205 && Var(15) && Random < 125

;---------------------------------------------------------------------------
; CN f+SP
[State -1, f+SP]
type = ChangeState
value = 215
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = 200 || StateNo = 210 || StateNo = 300 || StateNo = 310 || StateNo = 400 || StateNo = 410 || StateNo = 500) && MoveContact
trigger1 = map(b_y) && (map(p_Fd)>0) && !(map(p_Dn)>0) && !Var(15)
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
value = 165
triggerall = statetype != A
triggerall = ctrl
trigger1 = command = "s" && !Var(15)
trigger2 = Var(17) = 165 && Var(15)
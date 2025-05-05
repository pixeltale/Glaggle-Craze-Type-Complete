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

; the failure of the week
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
value = 102 - 2 * !!Map(BaxtFullPal)
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
triggerall = Name = "BAXK"
triggerall = Vel Y >= -1 || Time >= 10
triggerall = !(StateNo = [110,115] && Time < 12)
triggerall = statetype = A && Var(1)
triggerall = !(StateNo = 50 && NumHelper(56))
trigger1 = (map(FF) || command = "FF") && !Var(15)
trigger2 = Var(17) = 110 && Var(15)

;---------------------------------------------------------------------------
; AirDash Back
[State -1, AirDash Back]
type = ChangeState
value = 115
triggerall = ctrl
triggerall = Name = "BAXK"
triggerall = Vel Y >= -1 || Time >= 10
triggerall = !(StateNo = [110,115] && Time < 12)
triggerall = statetype = A && Var(1)
triggerall = !(StateNo = 50 && NumHelper(56))
trigger1 = (map(BB) || command = "BB") && !Var(15)
trigger2 = Var(17) = 110 && Var(15)


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
triggerall = (StateNo = [200,800) || StateNo = 910 && MoveType = I || StateNo = [920,1400) || StateNo = 1510 && AnimElem = 10, >= 1 || StateNo = 1550 && AnimElem = 23, >= 1 || StateNo = [1700,1800)) && MoveHit || StateNo = 1400 && MoveType = I && Var(7) = 2
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
triggerall = StateNo != [800,900) && StateNo != 910 && !(StateNo = 1100 && Var(5) && MoveGuarded) && StateNo != [1400,1600) || StateNo = 910 && MoveType = I && MoveGuarded || StateNo = 1400 && MoveType = I && Var(7) < 2 || StateNo = 1500 && !MoveHit
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
triggerall = (ctrl || StateNo < 120) && !Var(51) || StateNo = 910 && MoveType = I && !MoveContact
trigger1 = map(b_a) && map(b_y) && map(b_x) && map(b_b) && !Var(15)
trigger2 = Var(17) = 3000 && Var(15)

;===========================================================================
;---------------------------------------------------------------------------
; Polarized Flight
[State -1, 2QCF,2k]
type = ChangeState
value = 2400 + 300 * (Name="BAXK")
triggerall = statetype != A
triggerall = Power >= 3000
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || Anim = 510 && AnimElemNo(0) < 9) && (MoveContact || Time <= 2) || StateNo = 900 && Time >= 8 || StateNo = 1400 && Time <= 2
trigger1 = map(QCFQC) && map(b_ab) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; CMYK Cruncher EX
[State -1, 2QCF,2p]
type = ChangeState
value = 2650
triggerall = Name = "BAXK"
triggerall = Power >= 2000 - 1000 * (StateNo = 2600)
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || Anim = 510 && AnimElemNo(0) < 9) && (MoveContact || Time <= 2) || (StateNo = 1400 || StateNo = 2600) && Time <= 2
trigger1 = map(QCFQC) && map(b_xy) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Garish Hues EX
[State -1, 2QCF,2p]
type = ChangeState
value = 2200
triggerall = statetype != A
triggerall = Name != "BAXK"
triggerall = Power >= 2000 - 1000 * (StateNo = 2200)
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || Anim = 510 && AnimElemNo(0) < 9) && (MoveContact || Time <= 2) || (StateNo = 2000) && Time <= 2
trigger1 = map(QCFQC) && map(b_xy) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; CMYK Cruncher
[State -1, 2QCF,p]
type = ChangeState
value = 2600
triggerall = Name = "BAXK"
triggerall = Power >= 1000
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || Anim = 510 && AnimElemNo(0) < 9) && (MoveContact || Time <= 2) || StateNo = 1400 && Time <= 2
trigger1 = map(QCFQC) && (map(b_x) || map(b_y)) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SP Contrast Pillar
[State -1, 2QCF,y]
type = ChangeState
value = 2501
triggerall = statetype != A
triggerall = Name = "BAXK"
triggerall = Power >= 1000
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || Anim = 510 && AnimElemNo(0) < 9) && (MoveContact || Time <= 2) || StateNo = 1400 && Time <= 2
trigger1 = map(QCBQC) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1300 && Var(15) && Random < 350

;---------------------------------------------------------------------------
; LP Contrast Pillar
[State -1, 2QCF,x]
type = ChangeState
value = 2500
triggerall = statetype != A
triggerall = Name = "BAXK"
triggerall = Power >= 1000
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || Anim = 510 && AnimElemNo(0) < 9) && (MoveContact || Time <= 2) || StateNo = 1400 && Time <= 2
trigger1 = map(QCBQC) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1300 && Var(15) && Random < 350

;---------------------------------------------------------------------------
; Full Palette
[State -1, 2QCB,k]
type = ChangeState
value = 2300
triggerall = statetype != A
triggerall = Name = "BAXT"
triggerall = Power >= 1000 && !Map(BaxtFullPal)
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || Anim = 510 && AnimElemNo(0) < 9) && (MoveContact || Time <= 2) || StateNo = 900 && Time >= 8 || StateNo = 1400 && Time <= 2
trigger1 = map(QCBQC) && (map(b_a) || map(b_b)) && !Var(15)
trigger2 = Var(17) = 900 && Var(15) && Random < 125

;---------------------------------------------------------------------------
; Contrast Bomber SP
[State -1, 2QCB,y]
type = ChangeState
value = 2101 + 20 * (StateType!=A)
;triggerall = statetype = A
triggerall = Name != "BAXK"
triggerall = Power >= 1000
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || Anim = 510 && AnimElemNo(0) < 9) && (MoveContact || Time <= 2) || StateNo = 900 && Time >= 8
trigger1 = map(QCBQC) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1300 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Contrast Bomber LP
[State -1, 2QCB,x]
type = ChangeState
value = 2100 + 20 * (StateType!=A)
;triggerall = statetype = A
triggerall = Name != "BAXK"
triggerall = Power >= 1000
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || Anim = 510 && AnimElemNo(0) < 9) && (MoveContact || Time <= 2) || StateNo = 900 && Time >= 8
trigger1 = map(QCBQC) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1300 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Garish Hues
[State -1, 2QCF,p]
type = ChangeState
value = 2000
triggerall = statetype != A
triggerall = Name != "BAXK"
triggerall = Power >= 1000
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || Anim = 510 && AnimElemNo(0) < 9) && (MoveContact || Time <= 2) || StateNo = 900 && Time >= 8 || StateNo = 1400 && Time <= 2
trigger1 = map(QCFQC) && (map(b_x) || map(b_y)) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;===========================================================================
;---------------------------------------------------------------------------
; b.Saturated Rush
[State -1, b.Y+B]
type = ChangeState
value = 922
triggerall = Name = "BAXK"
triggerall = StateType != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || Anim = 510 && AnimElemNo(0) < 9) && (MoveContact || Time <= 2)
trigger1 = (map(p_Bk)>0) && (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = Var(17) = 900 && Var(15) && Random < 125

;---------------------------------------------------------------------------
; f.Saturated Rush
[State -1, f.Y+B]
type = ChangeState
value = 921
triggerall = Name = "BAXK"
triggerall = StateType != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || Anim = 510 && AnimElemNo(0) < 9) && (MoveContact || Time <= 2)
trigger1 = (map(p_Fd)>0) && (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = Var(17) = 1400 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Lime Drop
[State -1, ju.Y+B]
type = ChangeState
value = 905
triggerall = statetype = A
triggerall = Name != "BAXX"
triggerall = (Vel Y >= -1.5 || Time >= 10) && ctrl || StateNo = [600,800) && MoveContact ;|| Time <= 2)
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && (map(p_Dn)>0) && !Var(15)

;---------------------------------------------------------------------------
; Crimson Sunder
[State -1, Y+B]
type = ChangeState
value = 920
triggerall = Name = "BAXK" && StateNo != 920 && PrevStateNo != 920
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || Anim = 510 && AnimElemNo(0) < 9) && (MoveContact || Time <= 2)
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = Var(17) = 900 && Var(15) && Map(BaxtSpin) < 5

;---------------------------------------------------------------------------
; Violet Shot
[State -1, Y+B]
type = ChangeState
value = 2355 + (-3*((map(p_Dn)>0))+3*((map(p_Up)>0))-1*((map(p_Bk)>0))+1*((map(p_Fd)>0)))
triggerall = Name = "BAXT"
triggerall = Map(BaxtFullPal) > 0.02
triggerall = StateNo = [1000,1500) && MoveContact || StateNo = 1510 && AnimElem = 10, >= 1
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Blank Canvas Son
[State -1, Y+B]
type = ChangeState
value = 910
triggerall = statetype != A
triggerall = Name = "BAXX"
triggerall = !NumHelper(910) || Map(BaxxSon) >= 5.0
triggerall = ctrl || (StateNo = [100,101]) ||  (StateNo = [200,800) && StateNo != 510 || Anim = 510 && AnimElemNo(0) < 9) && (MoveContact || Time <= 2)
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = Var(17) = 900 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Burn Roller
[State -1, Y+B]
type = ChangeState
value = 900+(StateType=A)
triggerall = Name = "BAXT" && Var(1)
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || Anim = 510 && AnimElemNo(0) < 9) && (MoveContact || Time <= 2)
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = Var(17) = 900 && Var(15) && Random < 500

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
; SP Cobalt Bomber
[State -1, ju.QCB,y]
type = ChangeState
value = 1751
triggerall = Name = "BAXK"
triggerall = StateType = A
triggerall = Vel Y > const(velocity.jump.y)*0.5 || MoveContact
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || Anim = 510 && AnimElemNo(0) < 9) && (MoveContact || Time <= 2)
trigger1 = map(QCB) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LP Cobalt Bomber
[State -1, ju.QCB,x]
type = ChangeState
value = 1750
triggerall = Name = "BAXK"
triggerall = StateType = A
triggerall = Vel Y > const(velocity.jump.y)*0.5 || MoveContact
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || Anim = 510 && AnimElemNo(0) < 9) && (MoveContact || Time <= 2)
trigger1 = map(QCB) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SP Amber Tear
[State -1, ju.QCF,y]
type = ChangeState
value = 1701
triggerall = Name = "BAXK"
triggerall = StateType = A && Var(1)
triggerall = Vel Y > const(velocity.jump.y)*0.5 || MoveContact
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || Anim = 510 && AnimElemNo(0) < 9) && (MoveContact || Time <= 2)
trigger1 = map(QCF) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LP Amber Tear
[State -1, ju.QCF,x]
type = ChangeState
value = 1700
triggerall = Name = "BAXK"
triggerall = StateType = A && Var(1)
triggerall = Vel Y > const(velocity.jump.y)*0.5 || MoveContact
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || Anim = 510 && AnimElemNo(0) < 9) && (MoveContact || Time <= 2)
trigger1 = map(QCF) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SP Multi-Chromatic Engine
[State -1, QCB,y]
type = ChangeState
value = 1501
triggerall = StateType != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || Anim = 510 && AnimElemNo(0) < 9) && (MoveContact || Time <= 2) || StateNo = 900 && Time >= 8
trigger1 = map(QCB) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LP Multi-Chromatic Engine
[State -1, QCB,x]
type = ChangeState
value = 1500
triggerall = StateType != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || Anim = 510 && AnimElemNo(0) < 9) && (MoveContact || Time <= 2) || StateNo = 900 && Time >= 8
trigger1 = map(QCB) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SK Indigo Scream
[State -1, QCB,b]
type = ChangeState
value = 1301 + (StateType = A) * 50
triggerall = StateType != A || StateType = A && Vel Y > const(velocity.jump.y)*0.5 || MoveContact
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || Anim = 510 && AnimElemNo(0) < 9) && (MoveContact || Time <= 2) || StateNo = 900 && Time >= 8
trigger1 = map(QCB) && map(b_b) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LK Indigo Scream
[State -1, QCB,a]
type = ChangeState
value = 1300 + (StateType = A) * 50
triggerall = StateType != A || StateType = A && Vel Y > const(velocity.jump.y)*0.5 || MoveContact
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || Anim = 510 && AnimElemNo(0) < 9) && (MoveContact || Time <= 2) || StateNo = 900 && Time >= 8
trigger1 = map(QCB) && map(b_a) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Air SK White Catapult
[State -1, ju.QCF,b]
type = ChangeState
value = 1251
triggerall = Name != "BAXK"
triggerall = StateType = A
triggerall = !(Vel Y < const(velocity.jump.y)*0.5) || MoveContact
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || Anim = 510 && AnimElemNo(0) < 9) && (MoveContact || Time <= 2) || StateNo = 900 && Time >= 8
trigger1 = map(QCF) && map(b_b) && !Var(15)
trigger2 = (Var(17) = 1400 || Var(17) = 1200) && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Air LK White Catapult
[State -1, ju.QCF,a]
type = ChangeState
value = 1250
triggerall = Name != "BAXK"
triggerall = StateType = A
triggerall = !(Vel Y < const(velocity.jump.y)*0.5) || MoveContact
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || Anim = 510 && AnimElemNo(0) < 9) && (MoveContact || Time <= 2) || StateNo = 900 && Time >= 8
trigger1 = map(QCF) && map(b_a) && !Var(15)
trigger2 = (Var(17) = 1400 || Var(17) = 1200) && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SK White Catapult
[State -1, QCF,b]
type = ChangeState
value = 1201 + 450 * (Name="BAXK")
triggerall = StateType != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || Anim = 510 && AnimElemNo(0) < 9) && (MoveContact || Time <= 2) || StateNo = 900 && Time >= 8
trigger1 = map(QCF) && map(b_b) && !Var(15)
trigger2 = Var(17) = 1400 && Var(15) && Random < 50 * Map(BaxtSpin)

;---------------------------------------------------------------------------
; LK White Catapult
[State -1, QCF,a]
type = ChangeState
value = 1200 + 450 * (Name="BAXK")
triggerall = StateType != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || Anim = 510 && AnimElemNo(0) < 9) && (MoveContact || Time <= 2) || StateNo = 900 && Time >= 8
trigger1 = map(QCF) && map(b_a) && !Var(15)
trigger2 = Var(17) = 1400 && Var(15) && Random < 50 * Map(BaxtSpin)

;---------------------------------------------------------------------------
; SP Blue Wave
[State -1, ChDU,y]
type = ChangeState
value = 1101
triggerall = Name = "BAXT"
triggerall = statetype != A || Var(48) && Pos Y >= -2 && StateNo = [1000,2000)
triggerall = ctrl || StateNo = [39,40]  || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || Anim = 510 && AnimElemNo(0) < 9) && (MoveContact || Time <= 2) || StateNo = 900 && Time >= 8
trigger1 = map(b_y) && !Var(15)
trigger1 = Var(44) >= 24 && ((map(p_Up)>0) || command = "up")
trigger2 = Var(17) = 1300 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; LP Blue Wave
[State -1, ChDU,x]
type = ChangeState
value = 1100
triggerall = Name = "BAXT"
triggerall = statetype != A || Var(48) && Pos Y >= -2 && StateNo = [1000,2000)
triggerall = ctrl || StateNo = [39,40]  || StateNo = 55 || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || Anim = 510 && AnimElemNo(0) < 9) && (MoveContact || Time <= 2) || StateNo = 900 && Time >= 8
trigger1 = map(b_x) && !Var(15)
trigger1 = Var(44) >= 24 && ((map(p_Up)>0) || command = "up")
trigger2 = Var(17) = 1100 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Air SP Grey Cannon
[State -1, ju.QCF,y]
type = ChangeState
value = 1051
triggerall = Name != "BAXK"
triggerall = StateType = A
triggerall = !(Vel Y < const(velocity.jump.y)*0.5) || MoveContact
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || Anim = 510 && AnimElemNo(0) < 9) && (MoveContact || Time <= 2) || StateNo = 900 && Time >= 8
trigger1 = map(QCF) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Air LP Grey Cannon
[State -1, ju.QCF,x]
type = ChangeState
value = 1050
triggerall = Name != "BAXK"
triggerall = StateType = A
triggerall = !(Vel Y < const(velocity.jump.y)*0.5) || MoveContact
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || Anim = 510 && AnimElemNo(0) < 9) && (MoveContact || Time <= 2) || StateNo = 900 && Time >= 8
trigger1 = map(QCF) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SP Grey Cannon
[State -1, QCF,y]
type = ChangeState
value = 1001 + 600 * (Name="BAXK")
triggerall = StateType != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || Anim = 510 && AnimElemNo(0) < 9) && (MoveContact || Time <= 2) || StateNo = 900 && Time >= 8
trigger1 = map(QCF) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LP Grey Cannon
[State -1, QCF,x]
type = ChangeState
value = 1000 + 600 * (Name="BAXK")
triggerall = StateType != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || Anim = 510 && AnimElemNo(0) < 9) && (MoveContact || Time <= 2) || StateNo = 900 && Time >= 8
trigger1 = map(QCF) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SK Sepia Tone Seismo
[State -1, DD,b]
type = ChangeState
value = 1401
triggerall = statetype != A
triggerall = Name = "BAXX"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || Anim = 510 && AnimElemNo(0) < 9) && (MoveContact || Time <= 2) || StateNo = 900 && Time >= 8
trigger1 = map(DD) && map(b_b) && !Var(15)
trigger2 = Var(17) = 1000 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LK Sepia Tone Seismo
[State -1, DD,a]
type = ChangeState
value = 1400
triggerall = statetype != A
triggerall = Name = "BAXX"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || Anim = 510 && AnimElemNo(0) < 9) && (MoveContact || Time <= 2) || StateNo = 900 && Time >= 8
trigger1 = map(DD) && map(b_a) && !Var(15)
trigger2 = Var(17) = 1000 && Var(15) && Random < 250

;===========================================================================
;---------------------------------------------------------------------------
; CN b+SP
[State -1, b+SP]
type = ChangeState
value = 216
triggerall = statetype != A
triggerall = StateNo != 215 && StateNo != 515 && StateNo != 520
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || Anim = 510 && AnimElemNo(0) < 9) && MoveContact
trigger1 = map(b_y) && (map(p_Bk)>0) && !(map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 205 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; CN f+SP
[State -1, f+SP]
type = ChangeState
value = 215
triggerall = statetype != A
triggerall = StateNo != 215 && StateNo != 515 && StateNo != 520
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || Anim = 510 && AnimElemNo(0) < 9) && MoveContact
trigger1 = map(b_y) && (map(p_Fd)>0) && !(map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 205 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; CN 1SK
[State -1, cr.b+SK]
type = ChangeState
value = 515 + (MoveHit=1&&Name!="BAXK") + 5 * (Name="BAXK")
triggerall = statetype != A
triggerall = StateNo != 215 && StateNo != 515 && StateNo != 520
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || Anim = 510 && AnimElemNo(0) < 9) && MoveContact
trigger1 = map(b_b) && (map(p_Bk)>0) && (map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 250

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
trigger2 = Var(17) = 200 && Var(15) && Random < 500 && EnemyNear,StateType = S

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
trigger2 = Var(17) = 200 && Var(15) && Random < 500

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
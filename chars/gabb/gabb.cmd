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

; as we start a new tomorrow dawns
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
triggerall = (StateNo = [200,800) || StateNo = 950 || StateNo = [1000,1010] || StateNo = [1210,1220] || StateNo = 1420 || StateNo = [1500,1700]) && MoveHit || StateNo = 905 && NumHelper(910) && MoveHit || StateNo = 925 && (NumHelper(930) || MoveType = I) && MoveHit || StateNo = 1110 && AnimElem = 24, >= 1 || StateNo = 941 && AnimElem = 9, >= 1 || StateNo = 1800 && (NumHelper(1810) || MoveType = I) && MoveHit || StateNo = 1900 && (NumHelper(1910) || MoveType = I) && MoveHit
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
triggerall = StateNo != [800,900) && StateNo != 925 && StateNo != 941 && StateNo != [1100,1110] && !(StateNo = 1500 && Var(5) && MoveGuarded) && StateNo != [1800,1900] || StateNo = 905 && NumHelper(910) && MoveGuarded || StateNo = 925 && (NumHelper(930) || MoveType = I) && MoveGuarded || StateNo = 1800 && (NumHelper(1810) || MoveType = I) && MoveGuarded || StateNo = 1900 && (NumHelper(1910) || MoveType = I) && MoveGuarded
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
triggerall = (ctrl || StateNo < 120) && !Var(51) || StateNo = 905 && NumHelper(910) && !MoveContact || StateNo = 925 && (NumHelper(930) || MoveType = I) && !MoveContact || StateNo = 1800 && (NumHelper(1810) || MoveType = I) && !MoveContact || StateNo = 1900 && (NumHelper(1910) || MoveType = I) && !MoveContact
trigger1 = map(b_a) && map(b_y) && map(b_x) && map(b_b) && !Var(15)
trigger2 = Var(17) = 3000 && Var(15)

;===========================================================================
;---------------------------------------------------------------------------
; La Kometo de Gabby EX
[State -1, 2QCF,2p]
type = ChangeState
value = 2700
triggerall = statetype != A
triggerall = Name = "GABK"
triggerall = Power >= 2000 - 1000 * (StateNo = [2600,2650])
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2) || (StateNo = 2600 || StateNo = 2650) && Time <= 2
trigger1 = map(QCFQC) && map(b_xy) && !Var(15)
trigger2 = Var(17) = 1300 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Mono Body
[State -1, 2QCB,b]
type = ChangeState
value = 2550
triggerall = Name = "GABK"
triggerall = statetype != A
triggerall = Power >= 1000
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2) || StateNo = 2520 && Time <= 2
trigger1 = map(QCBQC) && map(b_b) && !Var(15)
trigger2 = Var(17) = 900 && Var(15) && Random < 100

;---------------------------------------------------------------------------
; Reverse Body
[State -1, 2QCB,a]
type = ChangeState
value = 2520
triggerall = Name = "GABK"
triggerall = statetype != A
triggerall = Power >= 1000
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = map(QCBQC) && map(b_a) && !Var(15)
trigger2 = Var(17) = 900 && Var(15) && Random < 100

;---------------------------------------------------------------------------
; Miksi Jokero
[State -1, 2QCB,k]
type = ChangeState
value = 2400
triggerall = Name = "GABX"
triggerall = statetype != A
triggerall = Power >= 1000
triggerall = !(Map(GabxCard1)=4 && Map(GabxCard2)=4 && Map(GabxCard3)=4)
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = map(QCBQC) && (map(b_a) || map(b_b)) && !Var(15)
trigger2 = Var(17) = 900 && Var(15) && Random < 200

;---------------------------------------------------------------------------
; Lucidaj Songoj
[State -1, 2QCB,2p]
type = ChangeState
value = 2300
triggerall = statetype != A
triggerall = Power >= 3000
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2) || (StateNo = 1100 || StateNo = 1400) && Time <= 2
trigger1 = map(QCBQC) && map(b_xy) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Aiken Tamburo EX
[State -1, 2QCF,2k]
type = ChangeState
value = 2200
triggerall = statetype != A
triggerall = Name != "GABK"
triggerall = Power >= 2000 - 1000 * (StateNo = 2200)
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2) || StateNo = 2000 && Time <= 2
trigger1 = map(QCFQC) && map(b_ab) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 350

;---------------------------------------------------------------------------
; SP Humu
[State -1, 2QCF,y]
type = ChangeState
value = 2651 + (StateType=A)
triggerall = Power >= 1000
triggerall = Name = "GABK" && Map(GabkFacing) = -1
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2) || StateNo = (1000,1010) && Time <= 2 && !Var(40)
trigger1 = map(QCFQC) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LP Humu
[State -1, 2QCF,x]
type = ChangeState
value = 2650
triggerall = Power >= 1000
triggerall = Name = "GABK" && Map(GabkFacing) = -1
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2) || StateNo = (1000,1010) && Time <= 2 && !Var(40)
trigger1 = map(QCFQC) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SP La Kometo de Gabby
[State -1, 2QCF,y]
type = ChangeState
value = 2601
triggerall = Power >= 1000
triggerall = Name = "GABK" && Map(GabkFacing) = 1
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2) || StateNo = (1000,1010) && Time <= 2 && !Var(40)
trigger1 = map(QCFQC) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LP La Kometo de Gabby
[State -1, 2QCF,x]
type = ChangeState
value = 2600
triggerall = Power >= 1000
triggerall = Name = "GABK" && Map(GabkFacing) = 1
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2) || StateNo = (1000,1010) && Time <= 2 && !Var(40)
trigger1 = map(QCFQC) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SP Supernovao
[State -1, 2QCF,y]
type = ChangeState
value = 2101 + (StateType=A)
triggerall = Power >= 1000
triggerall = Name != "GABK" && !Map(GabxCardUsed)
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2) || StateNo = (1000,1010) && Time <= 2 && !Var(40)
trigger1 = map(QCFQC) && map(b_y) && !Var(15)

;---------------------------------------------------------------------------
; LP Supernovao
[State -1, 2QCF,x]
type = ChangeState
value = 2100
triggerall = Power >= 1000
triggerall = Name != "GABK" && !Map(GabxCardUsed)
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2) || StateNo = (1000,1010) && Time <= 2 && !Var(40)
trigger1 = map(QCFQC) && map(b_x) && !Var(15)

;---------------------------------------------------------------------------
; Mirror Body
[State -1, 2QCF,k]
type = ChangeState
value = 2500
triggerall = statetype != A
triggerall = Name = "GABK"
triggerall = Power >= 1000
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = map(QCFQC) && (map(b_a) || map(b_b)) && !Var(15)
trigger2 = (Var(17) = 1200 || Var(17) = 1300) && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Aiken Tamburo
[State -1, 2QCF,k]
type = ChangeState
value = 2000
triggerall = statetype != A
triggerall = Name != "GABK"
triggerall = Power >= 1000
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = map(QCFQC) && (map(b_a) || map(b_b)) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;===========================================================================
;---------------------------------------------------------------------------
; Subite
[State -1, Y+B]
type = ChangeState
value = 950
triggerall = statetype != A
triggerall = Name = "GABK" && Map(GabkFacing) = -1
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (Time <= 2 || MoveContact && StateNo != 510)
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = Var(17) = 1100 && Var(15) && Random < 200

;---------------------------------------------------------------------------
; Militisto
[State -1, Y+B]
type = ChangeState
value = 940
triggerall = statetype != A
triggerall = Name = "GABK" && Map(GabkFacing) = 1
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (Time <= 2 || MoveContact && StateNo != 510)
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 200

;---------------------------------------------------------------------------
; b.Card Proj
[State -1, b.Y+B]
type = ChangeState
value = 923 + 4 * !!Map(GabxCard3)
triggerall = statetype != A
triggerall = Name = "GABX"
triggerall = !Map(GabxCard3) || !NumHelper(930)
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (Time <= 2 || MoveContact && StateNo != 510)
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && (map(p_Bk)>0) && !Var(15)
trigger2 = Var(17) = 1000 && Var(15) && Random < 250 && !!Map(GabxCard3)

;---------------------------------------------------------------------------
; f.Card Proj
[State -1, f.Y+B]
type = ChangeState
value = 921 + 4 * !!Map(GabxCard1)
triggerall = statetype != A
triggerall = Name = "GABX"
triggerall = !Map(GabxCard1) || !NumHelper(930)
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (Time <= 2 || MoveContact && StateNo != 510)
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && (map(p_Fd)>0) && !Var(15)
trigger2 = Var(17) = 1000 && Var(15) && Random < 250 && !!Map(GabxCard1)

;---------------------------------------------------------------------------
; d.Card Proj
[State -1, d.Y+B]
type = ChangeState
value = 922 + 4 * !!Map(GabxCard2)
triggerall = statetype != A
triggerall = Name = "GABX"
triggerall = !Map(GabxCard2) || !NumHelper(930)
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (Time <= 2 || MoveContact && StateNo != 510)
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && (map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 1000 && Var(15) && Random < 250 && !!Map(GabxCard2)

;---------------------------------------------------------------------------
; AfterImage
[State -1, Y+B]
type = ChangeState
value = 924
triggerall = statetype != A
triggerall = Name = "GABX"
triggerall = (Map(GabxJack)=1) + (Map(GabxQueen)=1) + (Map(GabxKing)=1) + Map(GabxJoker) = 3
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (Time <= 2 || MoveContact && StateNo != 510)
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = Var(17) = 900 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Miksi
[State -1, Y+B]
type = ChangeState
value = 920
triggerall = statetype != A
triggerall = Name = "GABX"
triggerall = Map(GabxCard1) = 0 || Map(GabxCard2) = 0 || Map(GabxCard3) = 0
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (Time <= 2 || MoveContact && StateNo != 510)
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = Var(17) = 900 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Fasadon
[State -1, Y+B]
type = ChangeState
value = 905 + (-3*((map(p_Dn)>0))+3*((map(p_Up)>0))-1*((map(p_Bk)>0))+1*((map(p_Fd)>0)))
triggerall = statetype != A
triggerall = Name = "GABB"
triggerall = !NumHelper(910)
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (Time <= 2 || MoveContact && StateNo != 510)
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
; SP Naskiga Meso
[State -1, QCF,y]
type = ChangeState
value = 1901
triggerall = StateType != A
triggerall = Name = "GABK" && Map(GabkFacing) = -1
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (Time <= 2 || MoveContact && StateNo != 510) 
trigger1 = map(QCF) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LP Naskiga Meso
[State -1, QCF,x]
type = ChangeState
value = 1900
triggerall = StateType != A
triggerall = Name = "GABK" && Map(GabkFacing) = -1
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (Time <= 2 || MoveContact && StateNo != 510)
trigger1 = map(QCF) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SK Ball
[State -1, QCB,b]
type = ChangeState
value = 1801
triggerall = StateType != A
triggerall = Name = "GABK" && Map(GabkFacing) = -1
triggerall = !NumHelper(1810)
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (Time <= 2 || MoveContact && StateNo != 510) 
trigger1 = map(QCB) && map(b_b) && !Var(15)
trigger2 = Var(17) = 1000 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LK Ball
[State -1, QCB,a]
type = ChangeState
value = 1800
triggerall = StateType != A
triggerall = Name = "GABK" && Map(GabkFacing) = -1
triggerall = !NumHelper(1810)
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (Time <= 2 || MoveContact && StateNo != 510)
trigger1 = map(QCB) && map(b_a) && !Var(15)
trigger2 = Var(17) = 1000 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SP Desegnis
[State -1, QCB,y]
type = ChangeState
value = 1701
triggerall = StateType != A
triggerall = Name = "GABK" && Map(GabkFacing) = -1
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (Time <= 2 || MoveContact && StateNo != 510) 
trigger1 = map(QCB) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LP Desegnis
[State -1, QCB,x]
type = ChangeState
value = 1700
triggerall = StateType != A
triggerall = Name = "GABK" && Map(GabkFacing) = -1
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (Time <= 2 || MoveContact && StateNo != 510)
trigger1 = map(QCB) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SK Flippy Kicko
[State -1, ChDU,b]
type = ChangeState
value = 1501
triggerall = Name = "GABK" && Map(GabkFacing) = -1
triggerall = statetype != A
triggerall = ctrl || StateNo = 40 || StateNo = 55 || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || StateNo = 167 || StateNo = 1400) && MoveContact || StateNo = [200,800) && Time <= 2 || StateNo = 1105 && PrevStateNo = 930 && MoveHit
trigger1 = map(b_b) && !Var(15)
trigger1 = Var(44) >= 24 && ((map(p_Up)>0) || command = "up")
trigger2 = Var(17) = 1300 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LK Flippy Kicko
[State -1, ChDU,a]
type = ChangeState
value = 1500
triggerall = Name = "GABK" && Map(GabkFacing) = -1
triggerall = statetype != A
triggerall = ctrl || StateNo = 40 || StateNo = 55 || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || StateNo = 167 || StateNo = 1400) && MoveContact || StateNo = [200,800) && Time <= 2 || StateNo = 1105 && PrevStateNo = 930 && MoveHit
trigger1 = map(b_a) && !Var(15)
trigger1 = Var(44) >= 24 && ((map(p_Up)>0) || command = "up")
trigger2 = Var(17) = 1100 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SK Cimbalo Kraso
[State -1, ChDU,b]
type = ChangeState
value = 1551
triggerall = Name = "GABK" && Map(GabkFacing) = 1
triggerall = statetype != A
triggerall = ctrl || StateNo = 40 || StateNo = 55 || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || StateNo = 167 || StateNo = 1400) && MoveContact || StateNo = [200,800) && Time <= 2 || StateNo = 1105 && PrevStateNo = 930 && MoveHit
trigger1 = map(b_b) && !Var(15)
trigger1 = Var(44) >= 24 && ((map(p_Up)>0) || command = "up")
trigger2 = (Var(17) = 1400 || Var(17) = 1700) && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LK Cimbalo Kraso
[State -1, ChDU,a]
type = ChangeState
value = 1550
triggerall = Name = "GABK" && Map(GabkFacing) = 1
triggerall = statetype != A
triggerall = ctrl || StateNo = 40 || StateNo = 55 || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510 || StateNo = 167 || StateNo = 1400) && MoveContact || StateNo = [200,800) && Time <= 2 || StateNo = 1105 && PrevStateNo = 930 && MoveHit
trigger1 = map(b_a) && !Var(15)
trigger1 = Var(44) >= 24 && ((map(p_Up)>0) || command = "up")
trigger2 = (Var(17) = 1400 || Var(17) = 1700) && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SK Korktirilo
[State -1, QCF,b]
type = ChangeState
value = 1601
triggerall = StateType != A || Pos Y >= -4
triggerall = Name = "GABX"
triggerall = StateNo < 1000 || Ctrl || MoveContact && (Map(GabxKing)+Map(GabxJoker))>=1+(!!MoveHit)
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (Time <= 2 || MoveContact && StateNo != 510) || StateNo = [1000,2000) && StateNo != 1600 && MoveContact
trigger1 = map(QCF) && map(b_b) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LK Korktirilo
[State -1, QCF,a]
type = ChangeState
value = 1600
triggerall = StateType != A || Pos Y >= -4
triggerall = Name = "GABX"
triggerall = StateNo < 1000 || Ctrl || MoveContact && (Map(GabxKing)+Map(GabxJoker))>=1+(!!MoveHit)
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (Time <= 2 || MoveContact && StateNo != 510) || StateNo = [1000,2000) && StateNo != 1600 && MoveContact
trigger1 = map(QCF) && map(b_a) && !Var(15)
trigger2 = Var(17) = 1100 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; SK Cimbalo Kraso
[State -1, ju.QCF,b]
type = ChangeState
value = 1251
triggerall = !(Vel Y < const(velocity.jump.y)*0.5) || MoveContact
triggerall = StateType = A
triggerall = Name = "GABX"
triggerall = StateNo < 1000 || Ctrl || MoveContact && (Map(GabxKing)+Map(GabxJoker))>=1+(!!MoveHit)
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (Time <= 2 || MoveContact && StateNo != 510) || StateNo = [1000,2000) && StateNo != [1220,1250] && MoveContact
trigger1 = map(QCF) && map(b_b) && !Var(15)
trigger2 = (Var(17) = 1600 || Var(17) = 1700) && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LK Cimbalo Kraso
[State -1, ju.QCF,a]
type = ChangeState
value = 1250
triggerall = !(Vel Y < const(velocity.jump.y)*0.5) || MoveContact
triggerall = StateType = A
triggerall = Name = "GABX"
triggerall = StateNo < 1000 || Ctrl || MoveContact && (Map(GabxKing)+Map(GabxJoker))>=1+(!!MoveHit)
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (Time <= 2 || MoveContact && StateNo != 510) || StateNo = [1000,2000) && StateNo != [1220,1250] && MoveContact
trigger1 = map(QCF) && map(b_a) && !Var(15)
trigger2 = (Var(17) = 1600 || Var(17) = 1700) && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SK Mortigu Ungegon
[State -1, QCB,b]
type = ChangeState
value = 1403
triggerall = StateType != A
triggerall = Name = "GABX" || Name = "GABK" && Map(GabkFacing) = 1
triggerall = StateNo < 1000 || Ctrl || MoveContact && (Map(GabxJack)+Map(GabxJoker))>=1+(!!MoveHit)
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (Time <= 2 || MoveContact && StateNo != 510) || StateNo = [1000,2000) && StateNo != 1400 && StateNo != 1420 && MoveContact
trigger1 = map(QCB) && map(b_b) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 125

;---------------------------------------------------------------------------
; LK Mortigu Ungegon
[State -1, QCB,a]
type = ChangeState
value = 1402
triggerall = StateType != A || Pos Y >= 0 && StateNo = 1010
triggerall = Name = "GABX" || Name = "GABK" && Map(GabkFacing) = 1
triggerall = StateNo < 1000 || Ctrl || MoveContact && (Map(GabxJack)+Map(GabxJoker))>=1+(!!MoveHit)
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (Time <= 2 || MoveContact && StateNo != 510) || StateNo = [1000,2000) && StateNo != 1400 && StateNo != 1420 && MoveContact
trigger1 = map(QCB) && map(b_a) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 125

;---------------------------------------------------------------------------
; SP Mielabelo
[State -1, QCB,y]
type = ChangeState
value = 1401
triggerall = StateType != A || Pos Y >= 0 && StateNo = 1010
triggerall = Name = "GABX" || Name = "GABK" && Map(GabkFacing) = 1
triggerall = StateNo < 1000 || Ctrl || MoveContact && (Map(GabxJack)+Map(GabxJoker))>=1+(!!MoveHit)
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (Time <= 2 || MoveContact && StateNo != 510) || StateNo = [1000,2000) && StateNo != 1400 && StateNo != 1210 && MoveContact
trigger1 = map(QCB) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LP Mielabelo
[State -1, QCB,x]
type = ChangeState
value = 1400
triggerall = StateType != A || Pos Y >= 0 && StateNo = 1010
triggerall = Name = "GABX" || Name = "GABK" && Map(GabkFacing) = 1
triggerall = StateNo < 1000 || Ctrl || MoveContact && (Map(GabxJack)+Map(GabxJoker))>=1+(!!MoveHit)
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (Time <= 2 || MoveContact && StateNo != 510) || StateNo = [1000,2000) && StateNo != 1400 && StateNo != 1210 && MoveContact
trigger1 = map(QCB) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SK Mortigu Ungegon
[State -1, ju.QCB,b]
type = ChangeState
value = 1303
triggerall = StateType = A
triggerall = Name = "GABX" || Name = "GABK" && Map(GabkFacing) = 1
triggerall = StateNo < 1000 || Ctrl || MoveContact && (Map(GabxJack)+Map(GabxJoker))>=1+(!!MoveHit)
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (Time <= 2 || MoveContact && StateNo != 510) || StateNo = [1000,2000) && StateNo != 1300 && StateNo != 1420 && MoveContact
trigger1 = map(QCB) && map(b_b) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 125

;---------------------------------------------------------------------------
; LK Mortigu Ungegon
[State -1, ju.QCB,a]
type = ChangeState
value = 1302
triggerall = StateType = A
triggerall = Name = "GABX" || Name = "GABK" && Map(GabkFacing) = 1
triggerall = StateNo < 1000 || Ctrl || MoveContact && (Map(GabxJack)+Map(GabxJoker))>=1+(!!MoveHit)
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (Time <= 2 || MoveContact && StateNo != 510) || StateNo = [1000,2000) && StateNo != 1300 && StateNo != 1420 && MoveContact
trigger1 = map(QCB) && map(b_a) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 125

;---------------------------------------------------------------------------
; SP Mielabelo
[State -1, ju.QCB,y]
type = ChangeState
value = 1301
triggerall = !(Vel Y < const(velocity.jump.y)*0.5) || MoveContact
triggerall = StateType = A
triggerall = Var(1) || !MoveContact && Time > 2 || Name = "GABX" && StateNo >= 1000 && Map(GabxJack)
triggerall = Name != "GABX" || StateNo < 1000 || Ctrl || MoveContact && (Map(GabxJack)+Map(GabxJoker))>=1+(!!MoveHit)
triggerall = Name != "GABK" || Map(GabkFacing) = 1
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (Time <= 2 || MoveContact && StateNo != 510) || StateNo = [1000,2000) && StateNo != 1300 && StateNo != 1210 && MoveContact && Name = "GABX"
trigger1 = map(QCB) && map(b_y) && !Var(15)
trigger2 = (var(17) = 1600 || Var(17) = 1700) && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LP Mielabelo
[State -1, ju.QCB,x]
type = ChangeState
value = 1300
triggerall = !(Vel Y < const(velocity.jump.y)*0.5) || MoveContact
triggerall = StateType = A
triggerall = Var(1) || !MoveContact && Time > 2 || Name = "GABX" && StateNo >= 1000 && Map(GabxJack)
triggerall = Name != "GABX" || StateNo < 1000 || Ctrl || MoveContact && (Map(GabxJack)+Map(GabxJoker))>=1+(!!MoveHit)
triggerall = Name != "GABK" || Map(GabkFacing) = 1
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (Time <= 2 || MoveContact && StateNo != 510) || StateNo = [1000,2000) && StateNo != 1300 && StateNo != 1210 && MoveContact && Name = "GABX"
trigger1 = map(QCB) && map(b_x) && !Var(15)
trigger2 = (var(17) = 1600 || Var(17) = 1700) && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SK Pordisto
[State -1, QCB,b]
type = ChangeState
value = 1201
triggerall = StateType != A || Var(1)
triggerall = Name = "GABB"
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (Time <= 2 || MoveContact && StateNo != 510)
trigger1 = map(QCB) && map(b_b) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LK Pordisto
[State -1, QCB,a]
type = ChangeState
value = 1200
triggerall = StateType != A || Var(1)
triggerall = Name = "GABB"
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (Time <= 2 || MoveContact && StateNo != 510)
trigger1 = map(QCB) && map(b_a) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SP Tamburrulado
[State -1, HCB,y]
type = ChangeState
value = 1101
triggerall = StateType != A
triggerall = Name = "GABB"
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (Time <= 2 || MoveContact && StateNo != 510)
trigger1 = (map(HCB) || map(f360) || map(r360)) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 125

;---------------------------------------------------------------------------
; LP Tamburrulado
[State -1, HCB,x]
type = ChangeState
value = 1100 + 2 * (MoveHit=1&&EnemyNear,StateType!=A&&P2BodyDist X=[-1,12])
triggerall = StateType != A
triggerall = Name = "GABB"
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (Time <= 2 || MoveContact && StateNo != 510)
trigger1 = (map(HCB) || map(f360) || map(r360)) && map(b_x) && !Var(15)
trigger2 = (Var(17) = 1200 || Var(17) = 1700) && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SP Falstelo
[State -1, QCF,y]
type = ChangeState
value = 1009 - 6 * (Pos Y < -4)
triggerall = !(statetype = A && Vel Y < const(velocity.jump.y)*0.5) || MoveContact
triggerall = Name != "GABX" || StateNo < 1000 || Ctrl || MoveContact && (Map(GabxQueen)+Map(GabxJoker))>=(1+(!!MoveHit))
triggerall = Name != "GABK" || Map(GabkFacing) = 1
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (Time <= 2 || MoveContact && StateNo != 510) || Name = "GABX" && StateNo = [1000,2000) && StateNo != 1010 && MoveContact
trigger1 = map(QCF) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 125

;---------------------------------------------------------------------------
; LP Falstelo
[State -1, QCF,x]
type = ChangeState
value = 1006
triggerall = !(statetype = A && Vel Y < const(velocity.jump.y)*0.5) || MoveContact
triggerall = Name != "GABX" || StateNo < 1000 || Ctrl || MoveContact && (Map(GabxQueen)+Map(GabxJoker))>=(1+(!!MoveHit))
triggerall = Name != "GABK" || Map(GabkFacing) = 1
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (Time <= 2 || MoveContact && StateNo != 510) || Name = "GABX" && StateNo = [1000,2000) && StateNo != 1010 && MoveContact
trigger1 = map(QCF) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 250

;===========================================================================
;---------------------------------------------------------------------------
; CB f+SK
[State -1, st.f+SK]
type = ChangeState
value = 315
triggerall = statetype != A
triggerall = StateNo != 205 && StateNo != 305 && StateNo != 315
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(b_b) && (map(p_Fd)>0) && !(map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 200

;---------------------------------------------------------------------------
; CB f+SP
[State -1, st.f+SP]
type = ChangeState
value = 205
triggerall = statetype != A
triggerall = StateNo != 205 && StateNo != 305 && StateNo != 315
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(b_y) && (map(p_Fd)>0) && !(map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 205 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; CB f+LK
[State -1, st.f+LK]
type = ChangeState
value = 305 + (MoveHit=1&&!(map(p_Up)>0))
triggerall = statetype != A
triggerall = StateNo != 205 && StateNo != 305 && StateNo != 315
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || StateNo = [200,800) && Time <= 2
trigger1 = map(b_a) && (map(p_Fd)>0) && !(map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 500

;===========================================================================
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
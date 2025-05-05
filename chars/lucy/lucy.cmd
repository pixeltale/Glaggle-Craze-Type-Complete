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

; theyve been there for a year or more
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
; AirDash Fwd
[State -1, AirDash Fwd]
type = ChangeState
value = 110
triggerall = ctrl
triggerall = Vel Y >= -1 || Time >= 10
triggerall = !(StateNo = [110,115] && Time < 12)
triggerall = statetype = A && Var(1)
triggerall = Name = "LUCK"; && (Map(LuckGems)&4)
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
triggerall = Name = "LUCK"; && (Map(LuckGems)&4)
triggerall = !(StateNo = 50 && NumHelper(56))
trigger1 = (command="BB" || map(b_44)) && !Var(15)
trigger2 = Var(17) = 115 && Var(15)

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
triggerall = (StateNo = [200,800) || StateNo = 900 || StateNo = [1000,1200) || StateNo = [1800,1900) || StateNo = 1300 && cond(NumHelper(4000),Helper(4000),StateNo = 4130,0) || StateNo = 1400 && cond(NumHelper(4000),Helper(4000),StateNo = 4140,0) || StateNo = 1500) && MoveHit || StateNo = 1210 && AnimElem = 5, >= 1 || StateNo = 1230 && AnimElem = 3, >= 1 || StateNo = 1600 && (NumHelper(1610) || MoveType = I) && MoveHit || StateNo = 1704 && MoveType = I && MoveHit || StateNo = 1900 && MoveType = I && MoveHit
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
triggerall = StateNo != [800,900)
triggerall = !MoveContact && !Var(51) || MoveGuarded
triggerall = StateNo != 900 && StateNo != (1200,1400] && StateNo != 1600 && StateNo != 1704 && !Var(51) || StateNo = 900 && Time >= 12  && MoveGuarded || StateNo = 1300 && cond(NumHelper(4000),Helper(4000),StateNo = 4130,0) && MoveGuarded || StateNo = 1400 && cond(NumHelper(4000),Helper(4000),StateNo = 4140,0) && MoveGuarded || StateNo = 1600 && (NumHelper(1610) || MoveType = I) && MoveGuarded || StateNo = 1704 && MoveType = I && MoveGuarded
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
triggerall = (ctrl || StateNo < 120) && !Var(51) || StateNo = 900 && Time >= 12 && !MoveContact || StateNo = 1300 && cond(NumHelper(4000),Helper(4000),StateNo = 4130||Helper(4000),StateNo = 4160,0) && !MoveContact || StateNo = 1400 && cond(NumHelper(4000),Helper(4000),StateNo = 4140,0) && !MoveContact || StateNo = 1600 && (NumHelper(1610) || MoveType = I) && !MoveContact || StateNo = 1704 && MoveType = I && !MoveContact
trigger1 = map(b_a) && map(b_y) && map(b_x) && map(b_b) && !Var(15)
trigger2 = Var(17) = 3000 && Var(15)

;===========================================================================
;---------------------------------------------------------------------------
; This is My Last Resort, So Say Your Prayers
[State -1, 2QCF,2k]
type = ChangeState
value = 2400
triggerall = statetype != A
triggerall = Power >= 3000
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = map(QCFQC) && (map(b_ab)) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; I Won't Make You Suffer...!
[State -1, 2QCB,2p]
type = ChangeState
value = 2700
triggerall = statetype != A
triggerall = Power >= 2000
triggerall = Name = "LUCK"
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2) || StateNo = 1700 && Time <= 2
trigger1 = map(QCBQC) && (map(b_xy)) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 350

;---------------------------------------------------------------------------
; You’re Really Getting On My Nerves
[State -1, 2QCB,2p]
type = ChangeState
value = 2300
triggerall = statetype != A
triggerall = Power >= 2000
triggerall = Name != "LUCK"
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = map(QCBQC) && (map(b_xy)) && !Var(15)
trigger2 = (Var(17) = 1200 || Var(17) = 1300) && Var(15) && Random < 350

;---------------------------------------------------------------------------
; SP Now I'm Mad...!
[State -1, 2QCF,y]
type = ChangeState
value = 2601
triggerall = statetype != A
triggerall = Power >= 1000
triggerall = Name = "LUCK"
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = map(QCFQC) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 200

;---------------------------------------------------------------------------
; LP Now I'm Mad...!
[State -1, 2QCF,x]
type = ChangeState
value = 2600
triggerall = statetype != A
triggerall = Power >= 1000
triggerall = Name = "LUCK"
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = map(QCFQC) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 200

;---------------------------------------------------------------------------
; Sorry, Just One Bite!
[State -1, 360,2p]
type = ChangeState
value = 2500
triggerall = statetype != A
triggerall = Name = "LUCK"
triggerall = Power >= 1000
triggerall = ctrl || StateNo = 40 || (StateNo = [100,101]) || (StateNo = [200,800) && StateNo != 510) && MoveContact || (StateNo = [200,800) || StateNo = 1050 || StateNo = 1700 || StateNo = 1705) && Time <= 2
trigger1 = (map(HCB) || map(f360) || map(r360)) && map(b_xy) && !Var(15)
trigger2 = Var(17) = 800 && Var(15) && Random < 500
trigger2 = P2BodyDist X = [-8,const(size.ground.front)] && StateType != A && EnemyNear,StateType != A || P2BodyDist X <= 40 && !numtarget(860) && StateType = A && EnemyNear,StateType = A

;---------------------------------------------------------------------------
; Yeah, No Thanks
[State -1, 2QCB,k]
type = ChangeState
value = 2200
triggerall = statetype != A
triggerall = Power >= 1000
triggerall = Name = "LUCY" && !Map(AsmosBusy) || Name = "LUCX" && Map(LucyAsmosOn)
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (MoveContact || Time <= 2)
trigger1 = map(QCBQC) && (map(b_a) || map(b_b)) && !Var(15)
trigger2 = Var(17) = 1300 && Var(15) && Random < 250 && Map(LucyAsmosOn)

;---------------------------------------------------------------------------
; Too Bad You Didn’t Bring Headphones
[State -1, 2QCF,p]
type = ChangeState
value = 2100
triggerall = statetype != A
triggerall = Power >= 1000
triggerall = Name != "LUCK" && !Map(LucyAsmosOn) && !Map(AsmosBusy)
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = map(QCFQC) && (map(b_x) || map(b_y)) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; I Call This One, The Sword of the Witch
[State -1, 2QCF,p]
type = ChangeState
value = 2000
triggerall = statetype != A
triggerall = Power >= 1000
triggerall = Name != "LUCK" && Map(LucyAsmosOn)
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = map(QCFQC) && (map(b_x) || map(b_y)) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;===========================================================================
;---------------------------------------------------------------------------
; I Envy Nothing... Nothing...
[State -1, Y+B]
type = ChangeState
value = 990
triggerall = Name = "LUCK"
triggerall = !NumHelper(990)
triggerall = Var(1)
triggerall = Vel Y >= -2 || Time >= 10
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2) || StateNo = 1700
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = (Var(17) = 900 || Var(17) = 1700) && Var(15) && Random < 125

;---------------------------------------------------------------------------
; B Seems Like All Vampires Know This Trick
[State -1, b.Y+B]
type = ChangeState
value = 1602
triggerall = statetype != A
triggerall = Name = "LUCX" && !NumHelper(1610)
triggerall = ctrl || StateNo = [100,101] || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = map(b_y) && map(b_b) && (map(p_Bk)>0) && !Var(15)
trigger2 = (Var(17) = 900 || Var(17) = 1000) && Var(15) && Random < 125

;---------------------------------------------------------------------------
; F Seems Like All Vampires Know This Trick
[State -1, f.Y+B]
type = ChangeState
value = 1601
triggerall = statetype != A
triggerall = Name = "LUCX" && !NumHelper(1610)
triggerall = ctrl || StateNo = [100,101] || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = map(b_y) && map(b_b) && (map(p_Fd)>0) && !Var(15)
trigger2 = (Var(17) = 900 || Var(17) = 1000) && Var(15) && Random < 125

;---------------------------------------------------------------------------
; N Seems Like All Vampires Know This Trick
[State -1, Y+B]
type = ChangeState
value = 1600
triggerall = statetype != A
triggerall = Name = "LUCX" && !NumHelper(1610)
triggerall = ctrl || StateNo = [100,101] || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = map(b_y) && map(b_b) && !Var(15)
trigger2 = (Var(17) = 900 || Var(17) = 1000) && Var(15) && Random < 125

;---------------------------------------------------------------------------
; b.Hell Control
[State -1, Y+B]
type = ChangeState
value = 902
triggerall = Name = "LUCY" && Map(LucyAsmosOn) && !Map(AsmosBusy)
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (Time <= 2 || MoveContact) && !(StateNo = 510 && MoveGuarded)
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && (map(p_Bk)>0) && !Var(15)
trigger2 = Var(17) = 900 && Var(15) && Random < 125

;---------------------------------------------------------------------------
; f.Hell Control
[State -1, Y+B]
type = ChangeState
value = 901
triggerall = Name = "LUCY" && Map(LucyAsmosOn) && !Map(AsmosBusy)
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (Time <= 2 || MoveContact) && !(StateNo = 510 && MoveGuarded)
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && (map(p_Fd)>0) && !Var(15)
trigger2 = Var(17) = 900 && Var(15) && Random < 125

;---------------------------------------------------------------------------
; Hell Control
[State -1, Y+B]
type = ChangeState
value = 900
triggerall = Name = "LUCY" && (!Map(AsmosBusy) || !Map(LucyAsmosOn))
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (Time <= 2 || MoveContact) && !(StateNo = 510 && MoveGuarded) || StateNo = [1300,1400] && MoveType = I
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = Var(17) = 900 && Var(15) && Random < 125

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
; SK Now I Truly Understand...
[State -1, QCB,b]
type = ChangeState
value = 1703 + 5 * !!(Map(LuckGems)&8)
triggerall = statetype != A
triggerall = Name = "LUCK" && cond(NumHelper(4903),Helper(4903),Ctrl,0)
triggerall = ctrl || StateNo = [100,101] || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = map(QCB) && map(b_b) && !Var(15)
trigger2 = Var(17) = 900 && Var(15) && Random < 250 && !(Map(LuckGems)&8)
trigger3 = Var(17) = 1700 && Var(15) && Random < 250 && !!(Map(LuckGems)&8)

;---------------------------------------------------------------------------
; SP Now I Truly Understand...
[State -1, QCB,y]
type = ChangeState
value = 1702 + 5 * !!(Map(LuckGems)&4)
triggerall = statetype != A
triggerall = Name = "LUCK" && cond(NumHelper(4902),Helper(4902),Ctrl,0)
triggerall = ctrl || StateNo = [100,101] || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = map(QCB) && map(b_y) && !Var(15)
trigger2 = Var(17) = 900 && Var(15) && Random < 250 && !(Map(LuckGems)&4)
trigger3 = Var(17) = 1600 && Var(15) && Random < 250 && !!(Map(LuckGems)&4)

;---------------------------------------------------------------------------
; LK Now I Truly Understand...
[State -1, QCB,a]
type = ChangeState
value = 1701 + 5 * !!(Map(LuckGems)&2)
triggerall = statetype != A
triggerall = Name = "LUCK" && cond(NumHelper(4901),Helper(4901),Ctrl,0)
triggerall = ctrl || StateNo = [100,101] || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = map(QCB) && map(b_a) && !Var(15)
trigger2 = Var(17) = 900 && Var(15) && Random < 250 && !(Map(LuckGems)&2)
trigger3 = Var(17) = 1000 && Var(15) && Random < 250 && !!(Map(LuckGems)&2)

;---------------------------------------------------------------------------
; LP Now I Truly Understand...
[State -1, QCB,x]
type = ChangeState
value = 1700 + 5 * !!(Map(LuckGems)&1)
triggerall = statetype != A
triggerall = Name = "LUCK" && cond(NumHelper(4900),Helper(4900),Ctrl,0)
triggerall = ctrl || StateNo = [100,101] || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = map(QCB) && map(b_x) && !Var(15)
trigger2 = Var(17) = 900 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SK I Envy Nothing... Nothing
[State -1, QCF,b]
type = ChangeState
value = 1901
triggerall = statetype != A
triggerall = Name = "LUCK" && cond(NumHelper(4901),Helper(4901),Ctrl,0)
triggerall = ctrl || StateNo = [100,101] || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = map(QCF) && map(b_b) && !Var(15)
trigger2 = Var(17) = 1000 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LK I Envy Nothing... Nothing
[State -1, QCF,a]
type = ChangeState
value = 1900
triggerall = statetype != A
triggerall = Name = "LUCK" && cond(NumHelper(4901),Helper(4901),Ctrl,0)
triggerall = ctrl || StateNo = [100,101] || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = map(QCF) && map(b_a) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SK I Know Your Every Move
[State -1, QCF,b]
type = ChangeState
value = 911
triggerall = Name = "LUCX" && Map(LucxCopy) && !Map(AsmosBusy)
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = map(QCF) && map(b_b) && !Var(15)
trigger2 = Var(17) = 1000 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LK I Know Your Every Move
[State -1, QCF,a]
type = ChangeState
value = 910
triggerall = Name = "LUCX" && Map(LucxCopy) && !Map(AsmosBusy)
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = map(QCF) && map(b_a) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SP Wallace Forgot This, I Didn't
[State -1, QCB,y]
type = ChangeState
value = 1501
triggerall = statetype != A
triggerall = Name != "LUCK" && Map(LucyAsmosOn) && !Map(AsmosBusy)
triggerall = ctrl || StateNo = [100,101] || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = map(QCB) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LP Wallace Forgot This, I Didn't
[State -1, QCB,x]
type = ChangeState
value = 1500
triggerall = statetype != A
triggerall = Name != "LUCK" && Map(LucyAsmosOn) && !Map(AsmosBusy)
triggerall = ctrl || StateNo = [100,101] || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = map(QCB) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SP I Should’ve Been a Meteorologist
[State -1, DP,y]
type = ChangeState
value = 1401
triggerall = statetype != A
triggerall = Name = "LUCY" && !Map(AsmosBusy)
triggerall = ctrl || StateNo = [100,101] || (StateNo = [200,800) || StateNo = 900) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = map(DP) && map(b_y) && !Var(15)
trigger1 = !Map(LucyAsmosOn) || map(b_b)
trigger2 = Var(17) = 1000 && Var(15) && Random < 125

;---------------------------------------------------------------------------
; LP I Should’ve Been a Meteorologist
[State -1, DP,x]
type = ChangeState
value = 1400
triggerall = statetype != A
triggerall = Name = "LUCY" && !Map(LucyAsmosOn) && !Map(AsmosBusy)
triggerall = ctrl || StateNo = [100,101] || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = map(DP) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1000 && Var(15) && Random < 125

;---------------------------------------------------------------------------
; SP You Should Keep Your Focus
[State -1, QCB,y]
type = ChangeState
value = 1303
triggerall = statetype != A
triggerall = Name = "LUCY" && !Map(AsmosBusy)
triggerall = ctrl || StateNo = [100,101] || (StateNo = [200,800) || StateNo = 900) && (StateNo != 510 && MoveContact || Time <= 2)
triggerall = ctrl || PrevStateNo != [1200,1300)
trigger1 = map(QCB) && map(b_y) && !Var(15)
trigger1 = !Map(LucyAsmosOn) || map(b_b)
trigger2 = Var(17) = 1000 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LP You Should Keep Your Focus
[State -1, QCB,x]
type = ChangeState
value = 1302
triggerall = statetype != A
triggerall = Name = "LUCY" && !Map(LucyAsmosOn) && !Map(AsmosBusy)
triggerall = ctrl || StateNo = [100,101] || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = map(QCB) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1000 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SP What Goes Up Must Come Down
[State -1, QCF,y]
type = ChangeState
value = 1301
triggerall = statetype != A
triggerall = Name = "LUCY" && !Map(AsmosBusy)
triggerall = ctrl || StateNo = [100,101] || (StateNo = [200,800) || StateNo = 900) && (StateNo != 510 && MoveContact || Time <= 2)
triggerall = ctrl || PrevStateNo != [1200,1300)
trigger1 = map(QCF) && map(b_y) && !Var(15)
trigger1 = !Map(LucyAsmosOn) || map(b_b)
trigger2 = Var(17) = 1000 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LP What Goes Up Must Come Down
[State -1, QCF,x]
type = ChangeState
value = 1300
triggerall = statetype != A
triggerall = Name = "LUCY" && !Map(LucyAsmosOn) && !Map(AsmosBusy)
triggerall = ctrl || StateNo = [100,101] || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = map(QCF) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1000 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SK My Table Manners are Good, Honest
[State -1, QCB,b]
type = ChangeState
value = 1201
triggerall = statetype != A
triggerall = Name != "LUCK"
triggerall = ctrl || StateNo = 40 || StateNo = [100,101] || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = map(QCB) && map(b_b) && !Var(15)
trigger2 = (Var(17) = 1200 || Var(17) = 1600) && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LK My Table Manners are Good, Honest
[State -1, QCB,a]
type = ChangeState
value = 1200
triggerall = statetype != A
triggerall = Name != "LUCK"
triggerall = ctrl || StateNo = 40 || StateNo = [100,101] || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = map(QCB) && map(b_a) && !Var(15)
trigger2 = (Var(17) = 1200 || Var(17) = 1600) && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SP Here I Spin Again On My Own
[State -1, DP,y]
type = ChangeState
value = 1101
triggerall = statetype != A
triggerall = Name != "LUCK" && Map(LucyAsmosOn) && !Map(AsmosBusy)
triggerall = ctrl || StateNo = [100,101] || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = map(DP) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LP Here I Spin Again On My Own
[State -1, DP,x]
type = ChangeState
value = 1100
triggerall = statetype != A
triggerall = Name != "LUCK" && Map(LucyAsmosOn) && !Map(AsmosBusy)
triggerall = ctrl || StateNo = [100,101] || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = map(DP) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SP Cut You To Ribbons, Shreds, etc.
[State -1, QCF,y]
type = ChangeState
value = 1001 + 50 * (Name="LUCK")
triggerall = statetype != A
triggerall = Name != "LUCK" && Map(LucyAsmosOn) && !Map(AsmosBusy) || Name = "LUCK" && cond(NumHelper(4902),Helper(4902),Ctrl,0)
triggerall = ctrl || StateNo = [100,101] || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = map(QCF) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250
trigger3 = Var(17) = 1600 && Var(15) && Random < 250 && Name = "LUCK"

;---------------------------------------------------------------------------
; LP Cut You To Ribbons, Shreds, etc.
[State -1, QCF,x]
type = ChangeState
value = 1000 + 50 * (Name="LUCK")
triggerall = statetype != A
triggerall = Name != "LUCK" && Map(LucyAsmosOn) && !Map(AsmosBusy) || Name = "LUCK" && cond(NumHelper(4902),Helper(4902),Ctrl,0)
triggerall = ctrl || StateNo = [100,101] || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = map(QCF) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1400 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SK Sloth, The Emptiness Of The Mind
[State -1, DD,b]
type = ChangeState
value = 1801
triggerall = statetype != A
triggerall = Name = "LUCK" && cond(NumHelper(4903),Helper(4903),Ctrl,0)
triggerall = ctrl || StateNo = [100,101] || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = map(DD) && map(b_b) && !Var(15)
trigger2 = Var(17) = 1300 && Var(15) && Random < 500 && Map(LuckGems)&8

;---------------------------------------------------------------------------
; LK Sloth, The Emptiness Of The Mind
[State -1, DD,a]
type = ChangeState
value = 1800
triggerall = statetype != A
triggerall = Name = "LUCK" && cond(NumHelper(4903),Helper(4903),Ctrl,0)
triggerall = ctrl || StateNo = [100,101] || StateNo = [200,800) && (StateNo != 510 && MoveContact || Time <= 2)
trigger1 = map(DD) && map(b_a) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 250

;===========================================================================
;---------------------------------------------------------------------------
; CN ju.d+SK
[State -1, ju.d+SK]
type = ChangeState
value = 725
triggerall = statetype = A
triggerall = Map(LucyAsmosOn) && !Map(AsmosBusy)
triggerall = StateNo != 725
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [600,710] && MoveContact
triggerall = Vel Y > const(velocity.jump.y)*0.5 || MoveContact
trigger1 = map(b_b) && (map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; CN f+LP
[State -1, st.f+LP]
type = ChangeState
value = 205
triggerall = statetype != A
triggerall = Name = "LUCK" && cond(NumHelper(4900),Helper(4900),Ctrl,0)
triggerall = StateNo != 205 && StateNo != 315 && StateNo != 325 && StateNo != 726
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && (Time <= 2 || MoveContact)
trigger1 = map(b_x) && (map(p_Fd)>0) && !(map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 205 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; CN f+SK
[State -1, st.f+SK]
type = ChangeState
value = 315 + 10 * (Name="LUCK")
triggerall = statetype != A
triggerall = StateNo != 205 && StateNo != 225 && StateNo != 315 && StateNo != 325 && StateNo != 726
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && (Time <= 2 || MoveContact)
trigger1 = map(b_b) && (map(p_Fd)>0) && !(map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 205 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; CN f+SP
[State -1, st.f+SP]
type = ChangeState
value = 225
triggerall = statetype != A
triggerall = Name != "LUCK"
triggerall = Map(LucyAsmosOn) && !Map(AsmosBusy)
triggerall = StateNo != 205 && StateNo != 225 && StateNo != 315 && StateNo != 325 && StateNo != 726
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && StateNo != 510 && (Time <= 2 || MoveContact)
trigger1 = map(b_y) && (map(p_Fd)>0) && !(map(p_Dn)>0) && !Var(15)
trigger2 = (Var(17) = 205 || Var(17) = 1700) && Var(15) && Random < 500

;===========================================================================
;---------------------------------------------------------------------------
; Standing LP
[State -1, st.LP]
type = ChangeState
value = 200 + (Name!="LUCK"&&(map(p_Bk)>0)&&!MoveContact)
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
value = 300 + (Name!="LUCK"&&(map(p_Bk)>0)&&!MoveContact)
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
value = 400 + (Name!="LUCK"&&(map(p_Bk)>0)&&!MoveContact)
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
value = 500 + (Name!="LUCK"&&(map(p_Bk)>0)&&!MoveContact)
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
triggerall = ctrl ;|| StateNo = 700 && PrevStateNo != 600 && MoveContact
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
triggerall = ctrl ;|| StateNo = 600 && PrevStateNo != 700 && MoveContact
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
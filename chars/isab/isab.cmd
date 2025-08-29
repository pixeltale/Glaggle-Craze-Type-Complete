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

; when youre down, feeling low
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
value = 100 + 2 * (Name!="ISAK")
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
value = ifelse(StateType=A,45,40)
triggerall = Ctrl || StateNo = 100
triggerall = statetype != A || statetype = A && Var(1)
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
triggerall = Var(40) = 0
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
triggerall = Var(40) = 0
triggerall = var(18) >= 3000 && !Map(CCDisable)
triggerall = !MoveGuarded && !Ctrl && !MoveReversed
triggerall = (StateNo = [200,800) || StateNo = 910 || StateNo = 945 || StateNo = 955 || StateNo = 1100 || StateNo = 1200 || StateNo = 1300 || StateNo = [1600,1800)) && MoveHit || StateNo = 941 && (AnimElemNo(0) > 28 || Var(8) = 1 && AnimElemNo(0) = 28) || StateNo = 960 && (NumHelper(960) || MoveType = I) && MoveHit || StateNo = 1000 && (NumHelper(1010) || MoveType = I) && MoveHit || StateNo = 1410 && AnimElemNo(0) > 15
trigger1 = map(b_a) && map(b_y) && map(b_x) && map(b_b) && !Var(15)
trigger2 = Var(17) = 3000 && Var(15)

;---------------------------------------------------------------------------
; Craze Assault
[State -1, A+Y / X+B]
type = ChangeState
value = 3001
triggerall = RoundState = 2
triggerall = Var(40) = 0
triggerall = var(18) >= 2000 && !Map(CCDisable)
triggerall = StateNo = [200,2000) && !Ctrl && (!Var(51) || MoveType = I) && !MoveReversed
triggerall = StateNo != [800,900) && StateNo != 930 && StateNo != 936 && StateNo != [940,941] && StateNo != 960 && StateNo != [1000,1100) && StateNo != [1500,1501] && !(StateNo = 1700 && Var(5) && MoveGuarded) || StateNo = 960 && (NumHelper(960) || MoveType = I) && MoveGuarded || StateNo = 1000 && (NumHelper(1010) || MoveType = I) && MoveGuarded
triggerall = !MoveContact && !Var(51) || MoveGuarded
trigger1 = map(b_a) && map(b_y) && map(b_x) && map(b_b) && !Var(15)
trigger2 = Var(17) = 3000 && Var(15)

;---------------------------------------------------------------------------
; Craze Focus
[State -1, A+Y / X+B]
type = ChangeState
value = 3000
triggerall = RoundState = 2
triggerall = Var(40) = 0
triggerall = var(18) >= 1000 && !Map(CCDisable)
triggerall = StateNo != [3000,4000)
triggerall = StateNo != 1000 || StateNo = 1000 && !MoveContact
triggerall = (ctrl || StateNo < 120) && !Var(51) || StateNo = 960 && (NumHelper(960) || MoveType = I) || StateNo = 1000 && (NumHelper(1010) || MoveType = I)
trigger1 = map(b_a) && map(b_y) && map(b_x) && map(b_b) && !Var(15)
trigger2 = Var(17) = 3000 && Var(15)

;===========================================================================
;---------------------------------------------------------------------------
; Telluric Meadow
[State -1, 2QCB,2k]
type = ChangeState
value = 2300
triggerall = statetype != A
triggerall = Power >= 3000
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800)) && MoveContact || (StateNo = [200,800) || StateNo = 1600) && Time <= 2
trigger1 = map(QCBQC) && map(b_ab) && !Var(15)
trigger2 = (Var(17) = 1200 || Var(17) = 1300) && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Flow of Nightshade
[State -1, 2QCF,2k]
type = ChangeState
value = 2200
triggerall = statetype != A
triggerall = Name != "ISAK"
triggerall = Power >= 2000
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800)) && MoveContact || (StateNo = [200,800) || StateNo = 1200) && Time <= 2
trigger1 = map(QCFQC) && map(b_ab) && !Var(15)
trigger2 = (Var(17) = 1200 || Var(17) = 1300) && Var(15) && Random < 350

;---------------------------------------------------------------------------
; Dragonfly Flight S-K
[State -1, 2QCB,p]
type = ChangeState
value = 2150
triggerall = Name != "ISAB"
triggerall = statetype != A
triggerall = Power >= 1000
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800)) && MoveContact || (StateNo = [200,800) || StateNo = 1400) && Time <= 2
trigger1 = map(QCBQC) && (map(b_x) || map(b_y)) && !Var(15)
trigger2 = (Var(17) = 1200 || Var(17) = 1300) && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Dragonfly Flight
[State -1, QCB,2p]
type = ChangeState
value = 2150
triggerall = Name = "ISAX"
triggerall = statetype != A
triggerall = Power >= 1000
triggerall = Var(7) && !MoveContact
triggerall = StateNo = 210 || StateNo = 310 || StateNo = 410 || StateNo = 510 || StateNo = 900 || StateNo = 905
trigger1 = map(QCB) && map(b_xy) && !Var(15)
trigger2 = map(QCBQC) && (map(b_x) || map(b_y)) && !Var(15)
trigger3 = (Var(17) = 1200 || Var(17) = 1300) && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Dragonfly Span
[State -1, 2QCB,p]
type = ChangeState
value = 2100
triggerall = Name = "ISAB"
triggerall = statetype != A
triggerall = Power >= 1000
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800)) && MoveContact || (StateNo = [200,800)) && Time <= 2
trigger1 = map(QCBQC) && (map(b_x) || map(b_y)) && !Var(15)
trigger2 = Var(17) = 1300 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; Garden of Warriors
[State -1, 2QCF,p]
type = ChangeState
value = 2000 + 400 * (Name="ISAK")
triggerall = statetype != A
triggerall = Power >= 1000 && !NumHelper(2410)
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800)) && MoveContact || (StateNo = [200,800) || StateNo = 1000) && Time <= 2
trigger1 = map(QCFQC) && (map(b_x) || map(b_y)) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;===========================================================================
;---------------------------------------------------------------------------
; f.Short Hop
[State -1, f.Y+B]
type = ChangeState
value = 932 + 2 * ((map(p_Dn)>0))
triggerall = statetype != A
triggerall = Name = "ISAK"
triggerall = ctrl || (StateNo = [100,101]); || (StateNo = 200 || StateNo = 210 || StateNo = 300 || StateNo = 310 || StateNo = 400 || StateNo = 410 || StateNo = 500 || StateNo = 205 || StateNo = 215) && MoveContact
trigger1 = (map(p_Fd)>0) && (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = Var(17) = 1400 && Var(15) && Random < 125

;---------------------------------------------------------------------------
; b.Short Hop
[State -1, b.Y+B]
type = ChangeState
value = 931 + 2 * ((map(p_Dn)>0))
triggerall = statetype != A
triggerall = Name = "ISAK"
triggerall = ctrl || (StateNo = [100,101]); || (StateNo = 200 || StateNo = 210 || StateNo = 300 || StateNo = 310 || StateNo = 400 || StateNo = 410 || StateNo = 500 || StateNo = 205 || StateNo = 215) && MoveContact
trigger1 = (map(p_Bk)>0) && (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = Var(17) = 1300 && Var(15) && Random < 100

;---------------------------------------------------------------------------
; Side Dodge
[State -1, b.Y+B]
type = ChangeState
value = 935
triggerall = statetype != A
triggerall = Name = "ISAK"
triggerall = ctrl || (StateNo = [100,101]); || (StateNo = 200 || StateNo = 210 || StateNo = 300 || StateNo = 310 || StateNo = 400 || StateNo = 410 || StateNo = 500 || StateNo = 205 || StateNo = 215) && MoveContact
trigger1 = (map(p_Dn)>0) && (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = Var(17) = 1300 && Var(15) && Random < 100

;---------------------------------------------------------------------------
; Concentration
[State -1, Y+B]
type = ChangeState
value = 930
triggerall = statetype != A
triggerall = Name = "ISAK"
triggerall = !Var(40)
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800)) && MoveContact || Var(18)>=3000 && MoveType = H && Alive && (StateNo = [5000,5020) || StateNo = [5320,5380)) && EnemyNear,StateNo != [2000,3000)
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = MoveType = H && Var(15) && Random < 350 && Life < 100

;---------------------------------------------------------------------------
; Empress March
[State -1, f.Y+B]
type = ChangeState
value = 905
triggerall = statetype != A
triggerall = Name = "ISAX"
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && MoveContact || StateNo = 1200 && MoveContact
trigger1 = (map(p_Fd)>0) && (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 350

;---------------------------------------------------------------------------
; Empress Parry
[State -1, Y+B]
type = ChangeState
value = 900
triggerall = statetype != A
triggerall = Name != "ISAK"
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && MoveContact && Name = "ISAX" || StateNo = 1200 && MoveContact && Name = "ISAX"
trigger1 = (map(b_y) && map(b_b) || map(b_yb)) && !Var(15)
trigger2 = Var(17) = 1300 && Var(15) && Random < 350

;---------------------------------------------------------------------------
; Throw
[State -1, X+A]
type = ChangeState
value = ifelse(StateType=A,850,800)
;triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && Time <= 2 && PrevStateNo != [200,800) || StateNo = [600,800) && MoveHit
trigger1 = (map(b_x) && map(b_a) || map(b_xa)) && !Var(15)
trigger2 = Var(17) = 800 && Var(15) && (Random < 500 || Name != "ISAK")
trigger2 = P2BodyDist X = [-8,const(size.ground.front)] && StateType != A && EnemyNear,StateType != A || P2BodyDist X <= 40 && !numtarget(860) && StateType = A && EnemyNear,StateType = A

;===========================================================================
;---------------------------------------------------------------------------
; Petals Gather
[State -1, GPC f+LP+LK]
type = ChangeState
value = 940
triggerall = Name = "ISAX"
triggerall = statetype != A
triggerall = Var(7) && !MoveContact
triggerall = StateNo = 210 || StateNo = 310 || StateNo = 410 || StateNo = 510 || StateNo = 900 || StateNo = 905
trigger1 = ((map(p_Fd)>0) || StateNo=[900,1000)) && map(b_xa) && !Var(15)
trigger2 = Var(17) = 800 && Var(15)
trigger2 = P2BodyDist X = [-8,const(size.ground.front)] && StateType != A && EnemyNear,StateType != A || P2BodyDist X <= 40 && !numtarget(860) && StateType = A && EnemyNear,StateType = A

;---------------------------------------------------------------------------
; Sun's Brilliance
[State -1, GPC f+SK]
type = ChangeState
value = 955
triggerall = Name = "ISAX"
triggerall = statetype != A
triggerall = Var(7) && !MoveContact
triggerall = StateNo = 210 || StateNo = 310 || StateNo = 410 || StateNo = 510 || StateNo = 900 || StateNo = 905
trigger1 = ((map(p_Fd)>0) || StateNo=[900,1000)) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Crushing Wave
[State -1, GPC f+SP]
type = ChangeState
value = 945
triggerall = Name = "ISAX"
triggerall = statetype != A
triggerall = Var(7) && !MoveContact
triggerall = StateNo = 210 || StateNo = 310 || StateNo = 410 || StateNo = 510 || StateNo = 900 || StateNo = 905
trigger1 = ((map(p_Fd)>0) || StateNo=[900,1000)) && map(b_a) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; Wind Stroll
[State -1, GPC f+LK]
type = ChangeState
value = 950
triggerall = Name = "ISAX"
triggerall = statetype != A
triggerall = Var(7) && !MoveContact
triggerall = StateNo = 210 || StateNo = 310 || StateNo = 410 || StateNo = 510 || StateNo = 900 || StateNo = 905
trigger1 = ((map(p_Fd)>0) || StateNo=[900,1000)) && map(b_b) && !Var(15)
trigger2 = Var(17) = 100 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; The Crythanthnemumthmem
[State -1, GPC f+LP]
type = ChangeState
value = 960
triggerall = Name = "ISAX" && !NumHelper(960)
triggerall = statetype != A
triggerall = Var(7) && !MoveContact
triggerall = StateNo = 210 || StateNo = 310 || StateNo = 410 || StateNo = 510 || StateNo = 900 || StateNo = 905
trigger1 = ((map(p_Fd)>0) || StateNo=[900,1000)) && map(b_x) && !Var(15)
trigger2 = Var(17) = 900 && Var(15) && Random < 500

;---------------------------------------------------------------------------
; SP Crushing Wave S-K
[State -1, QCB,b]
type = ChangeState
value = 1601
triggerall = statetype != A
triggerall = Name = "ISAK"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800)) && MoveContact || StateNo = 933 && (Anim = 933 || Time >= 22)
trigger1 = map(QCB) && map(b_b) && !Var(15)
trigger2 = Var(17) = 1300 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LP Crushing Wave S-K
[State -1, QCB,a]
type = ChangeState
value = 1600
triggerall = statetype != A
triggerall = Name = "ISAK"
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800)) && MoveContact || StateNo = 933 && (Anim = 933 || Time >= 22)
trigger1 = map(QCB) && map(b_a) && !Var(15)
trigger2 = Var(17) = 1300 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SP Petal Gather
[State -1, 360,y]
type = ChangeState
value = 1501
triggerall = StateType != A && Name = "ISAK"
triggerall = ctrl || StateNo = 40 || StateNo = 55  || (StateNo = [200,800)) && (MoveContact || Time <= 2) || (StateNo = 1000) && Time <= 2 || StateNo = 933 && (Anim = 933 || Time >= 22)
trigger1 = (map(HCB) || COMMAND = "HCB" || map(f360) || map(r360)) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 350

;---------------------------------------------------------------------------
; LP Petal Gather
[State -1, 360,x]
type = ChangeState
value = 1500
triggerall = StateType != A && Name = "ISAK"
triggerall = ctrl || StateNo = 40 || StateNo = 55 || (StateNo = [200,800)) && (MoveContact || Time <= 2) || (StateNo = 1000) && Time <= 2 || StateNo = 933 && (Anim = 933 || Time >= 22)
trigger1 = (map(HCB) || COMMAND = "HCB" || map(f360) || map(r360)) && map(b_x) && !Var(15)
trigger2 = Var(17) = 800 && Var(15) && Random < 500
trigger2 = P2BodyDist X = [-8,const(size.ground.front)] && StateType != A && EnemyNear,StateType != A || P2BodyDist X <= 40 && !numtarget(860) && StateType = A && EnemyNear,StateType = A

;---------------------------------------------------------------------------
; SP Petal Scatter
[State -1, QCB,y]
type = ChangeState
value = 1401
triggerall = StateType != A && Name = "ISAB"
triggerall = ctrl || (StateNo = [200,800)) && (MoveContact || Time <= 2)
trigger1 = map(QCB) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LP Petal Scatter
[State -1, QCB,x]
type = ChangeState
value = 1400
triggerall = StateType != A && Name = "ISAB"
triggerall = ctrl || (StateNo = [200,800)) && (MoveContact || Time <= 2)
trigger1 = map(QCB) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SP Swallow Counter
[State -1, ju.HCB,y]
type = ChangeState
value = 1301
triggerall = StateType = A
triggerall = (Vel Y >= -1 || Time >= 10) && Ctrl || (StateNo = [200,800)) && MoveContact
trigger1 = map(QCB) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LP Swallow Counter
[State -1, ju.HCB,x]
type = ChangeState
value = 1300
triggerall = StateType = A
triggerall = (Vel Y >= -1 || Time >= 10) && Ctrl || (StateNo = [200,800)) && MoveContact
trigger1 = map(QCB) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SK PrincessPardon
[State -1, QCF,b]
type = ChangeState
value = 1201 + 600 * (Name="ISAK")
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800)) && MoveContact || StateNo = 933 && (Anim = 933 || Time >= 22)
trigger1 = map(QCF) && map(b_b) && !Var(15)
trigger2 = Var(17) = 1600 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LK PrincessPardon
[State -1, QCF,a]
type = ChangeState
value = 1200 + 600 * (Name="ISAK")
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800)) && MoveContact || StateNo = 933 && (Anim = 933 || Time >= 22)
trigger1 = map(QCF) && map(b_a) && !Var(15)
trigger2 = Var(17) = 1200 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SP Glow of Moon
[State -1, DP,y]
type = ChangeState
value = 1101 + 600 * (Name="ISAK")
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800)) && MoveContact || StateNo = 933 && (Anim = 933 || Time >= 22)
trigger1 = map(DP) && map(b_y) && !Var(15)
trigger2 = (Var(17) = 1300 || Var(17) = 1600) && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LP Glow of Moon
[State -1, DP,x]
type = ChangeState
value = 1100 + 600 * (Name="ISAK")
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800)) && MoveContact || StateNo = 933 && (Anim = 933 || Time >= 22)
trigger1 = map(DP) && map(b_x) && !Var(15)
trigger2 = (Var(17) = 1100 || Var(17) = 1600) && Var(15) && Random < 250

;---------------------------------------------------------------------------
; SP Trimming Meadow
[State -1, QCF,y]
type = ChangeState
value = 1001
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800)) && MoveContact || StateNo = 933 && (Anim = 933 || Time >= 22)
triggerall = !NumHelper(1010)
trigger1 = map(QCF) && map(b_y) && !Var(15)
trigger2 = Var(17) = 1000 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; LP Trimming Meadow
[State -1, QCF,x]
type = ChangeState
value = 1000
triggerall = statetype != A
triggerall = ctrl || (StateNo = [100,101]) || (StateNo = [200,800)) && MoveContact || StateNo = 933 && (Anim = 933 || Time >= 22)
triggerall = !NumHelper(1010)
trigger1 = map(QCF) && map(b_x) && !Var(15)
trigger2 = Var(17) = 1000 && Var(15) && Random < 250

;===========================================================================
;---------------------------------------------------------------------------
; CN ju.d+LK
[State -1, ju.f+LK]
type = ChangeState
value = 705
triggerall = statetype = A
triggerall = stateno != 705
triggerall = ctrl || StateNo = [200,800) && MoveContact
trigger1 = map(b_a) && (map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 205 && Var(15) && Random < 250

;---------------------------------------------------------------------------
; CN f+SP
[State -1, st.f+SP]
type = ChangeState
value = 215 + (MoveHit=1&&!(map(p_Up)>0))
triggerall = statetype != A
triggerall = stateno != 215 && stateno != 305 && stateno != 505
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && MoveContact || StateNo = 300 && Time <= 2
trigger1 = map(b_y) && (map(p_Fd)>0) && !(map(p_Dn)>0) && !Var(15)
trigger2 = Var(17) = 1700 && Var(15) && Random < 350

;---------------------------------------------------------------------------
; CN df+SK
[State -1, cr.f+SK]
type = ChangeState
value = 505
triggerall = statetype != A
triggerall = stateno != 215 && stateno != 305 && stateno != 505
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && MoveContact || StateNo = 300 && Time <= 2
trigger1 = map(b_b) && (map(p_Fd)>0) && (map(p_Dn)>0) && !Var(15)
trigger2 = (Var(17) = 205 || Var(17) = 510 || Var(17) = 1700) && Var(15) && Random < 500

;---------------------------------------------------------------------------
; CN f+LK
[State -1, st.f+LK]
type = ChangeState
value = 305
triggerall = statetype != A
triggerall = stateno != 215 && stateno != 305 && stateno != 505
triggerall = ctrl || (StateNo = [100,101]) || StateNo = [200,800) && MoveContact || StateNo = 300 && Time <= 2
trigger1 = map(b_a) && (map(p_Fd)>0) && !(map(p_Dn)>0) && !Var(15)
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
trigger2 = Var(17) = 410 && Var(15) && Random < 500

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
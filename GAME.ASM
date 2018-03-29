    .model  tiny
    ; .stack  0100h

    .data
logging         db  ?
seed            dw  13

character       db  ?

matrixColorCode db  0fh,0ah,0ah,02h,02h,00h,00h,00h
matrixLength    db  7

WINDOW_TOP      db  0
WINDOW_LEFT     db  30
WINDOW_RIGHT    db  50
WINDOW_BOTTOM   db  20

printFlowMatrix_X   db  ?
printFlowMatrix_Y   db  ?


START_MATRIX_Y  db  100

matrixY         db  80 dup(?)

i               db  0h

xPos            db  0h
m       DB     0
delay   DW     ?
; delay
easydelay       DW     04h
mediumdelay     DW     02h
harddelay       DW     01h

life    db      9
;--------------------Sound Data-----------------------------
OverSong DW	2711,16		;�ѧ���������ͩҡ��
	DW	3043,16
	DW	3416,16
	DW	3619,16
	DW	4560,16
	DW	4831,16
	DW	5423,16
	DW	6087,16

	DW     00h, 00h

ModeSound DW	3834,32
	DW	1,8
	DW	5119,16
	DW	4560,4

	DW     00h, 00h


startSound DW     3834, 64                   ; start sound
	DW	1,8
        DW	5746, 64
	DW	1,8
	DW	4304, 16
	DW	1,8	
	DW	3834, 16
	DW	1,8
	DW	3619 , 16
	DW	1,8
	DW     	3834, 64                   ; start sound
	DW	1,8
        DW	5746, 64
	DW	1,8
	DW	4304, 16
	DW	1,8
	DW	3834, 16
	DW	1,8
	DW	3619 , 16
	DW	1,8
	DW  	3834, 64                  ; start sound
	DW	1,8
        DW	5746, 64
	DW	1,8
	DW	4304, 16
	DW	1,8
	DW	3834, 16
	DW	1,8
	DW	3619 , 16
	DW	1,8
	DW  	3834, 64                  ; start sound
	DW	1,8
        DW	5746, 64
	DW	1,8
	DW	4304, 16
	DW	1,8
	DW	3834, 16
	DW	1,8
	DW	3619 , 16
	DW	1,8

        DW     00h, 00h



;---------------------Screen--------------------
 
blankScreen db	'                                                                                '
            db	'                                                                                '
            db	'                                                                                '
            db	'                                                                                '
            db	'                                                                                '
            db	'                                                                                '
            db	'                                                                                '
            db	'                                                                                '
            db	'                                                                                '
            db	'                                                                                '
            db	'                                                                                '
            db	'                                                                                '
            db	'                                                                                '
            db	'                                                                                '
            db	'                                                                                '
            db	'                                                                                '
            db	'                                                                                '
            db	'                                                                                '
            db	'                                                                                '
            db	'                                                                                '
            db	'                                                                                '
            db	'                                                                                '
            db	'                                                                                '
            db	'                                                                                '
            db	'                                                                                $'

             
easyWindow  db  '                             |                     |                            '
            db  '                             |                     |                            '
            db  '                             |                     |                            '
            db  '                             |                     |                            '
            db  '                             |                     |                            '
            db  '                             |                     |                            '
            db  '                             |                     |                            '
            db  '                             |                     |                            '
            db  '                             |                     |                            '
            db  '                             |                     |                            '
            db  '                             |                     |                            '
            db  '                             |                     |                            '
            db  '                             |                     |                            '
            db  '                             |                     |                            '
            db  '                             |                     |                            '
            db  '                             |                     |                            '
            db  '                             |                     |                            '
            db  '                             |                     |                            '
            db  '                             |                     |                            '
            db  '                             |                     |                            '
            db  '                             |                     |                            '
            db  '                             |                     |                            '
            db  '                             |                     |                            '
            db  '                             |                     |                            '
            db  '                             |                     |                            $'

hardWindow  db  '                   |                                         |                  '
            db  '                   |                                         |                  '
            db  '                   |                                         |                  '
            db  '                   |                                         |                  '
            db  '                   |                                         |                  '
            db  '                   |                                         |                  '
            db  '                   |                                         |                  '
            db  '                   |                                         |                  '
            db  '                   |                                         |                  '
            db  '                   |                                         |                  '
            db  '                   |                                         |                  '
            db  '                   |                                         |                  '
            db  '                   |                                         |                  '
            db  '                   |                                         |                  '
            db  '                   |                                         |                  '
            db  '                   |                                         |                  '
            db  '                   |                                         |                  '
            db  '                   |                                         |                  '
            db  '                   |                                         |                  '
            db  '                   |                                         |                  '
            db  '                   |                                         |                  '
            db  '                   |                                         |                  '
            db  '                   |                                         |                  '
            db  '                   |                                         |                  $'
 hellWindow db  '         |                                                             |        '
            db  '         |                                                             |        '
            db  '         |                                                             |        '
            db  '         |                                                             |        '
            db  '         |                                                             |        '
            db  '         |                                                             |        '
            db  '         |                                                             |        '
            db  '         |                                                             |        '
            db  '         |                                                             |        '
            db  '         |                                                             |        '
            db  '         |                                                             |        '
            db  '         |                                                             |        '
            db  '         |                                                             |        '
            db  '         |                                                             |        '
            db  '         |                                                             |        '
            db  '         |                                                             |        '
            db  '         |                                                             |        '
            db  '         |                                                             |        '
            db  '         |                                                             |        '
            db  '         |                                                             |        '
            db  '         |                                                             |        '
            db  '         |                                                             |        '
            db  '         |                                                             |        '
            db  '         |                                                             |        $'





lifeStatus  db  '                                                                          Life$'
overS	DB     '                                                                               ', 0
	DB     '                                                                               ', 0
	DB     '                                                                               ', 0
	DB     '           __ __   ___   __ __      ___    ____    ___  ___                    ', 0
	DB     '          |  |  | /   \ |  |  |    |   \  |    |  /  _]|   \                   ', 0
	DB     '          |  |  ||     ||  |  |    |    \  |  |  /  [_ |    \                  ', 0
	DB     '          |  ~  ||  O  ||  |  |    |  D  | |  | |    _]|  D  |                 ', 0
	DB     '          |___, ||     ||  :  |    |     | |  | |   [_ |     |                 ', 0
	DB     '          |     ||     ||     |    |     | |  | |     ||     |                 ', 0
	DB     '          |____/  \___/  \__,_|    |_____||____||_____||_____|                 ', 0
	DB     '                                                                               ', 0
	DB     '                                                                               ', 0
	DB     '                                                                               ', 0
	DB     '                                                                               $', 0
                                                    
tittxt  DB     '                                                                               ', 0
	DB     '                                                                               ', 0
	DB     '          ____    _    _               _____              _____                ', 0
	DB     '         / __ \  | |  | |     /\      / ____|     /\     |  __ \               ', 0
	DB     '        | |  | | | |  | |    /  \    | (___      /  \    | |__) |              ', 0
	DB     '        | |  | | | |  | |   / /\ \    \___ \    / /\ \   |  _  /               ', 0
	DB     '        | |__| | | |__| |  / ____ \   ____) |  / ____ \  | | \ \               ', 0
	DB     '         \___\_\  \____/  /_/    \_\ |_____/  /_/    \_\ |_|  \_\              ', 0
	DB     '                                                                               ', 0
	DB     '                                                                               ', 0
	DB     '                                                                               $', 0



                                                       
modetxt DB     '                                                                               ', 0
        DB     '                                                                               ', 0
        DB     '                                                                               ', 0
	    DB     '            ____    ____   ________   ____  _____   _____  _____               ', 0
        DB     '           |_   \  /   _| |_   __  | |_   \|_   _| |_   _||_   _|              ', 0
        DB     '             |   \/   |     | |_ \_|   |   \ | |     | |    | |                ', 0 
        DB     '             | |\  /| |     |  _| _    | |\ \| |     | !    ! |                ', 0 
        DB     '            _| |_\/_| |_   _| |__/ |  _| |_\   |_     \ \__/ /                 ', 0
        DB     '           |_____||_____| |________| |_____|\____|     \.__./                  ', 0
        DB     '                                                                               ', 0
        DB     '                                                                               ', 0
	    DB     '                                                                               ', 0        
	    DB     '                                     EASY                                      ', 0
        DB     '                                     HARD                                      ', 0
        DB     '                                     HELL                                      ', 0
        DB     '                                                                               ', 0
        DB     '                                                                               ', 0
        DB     '                                                                               ', 0
        DB     '                                                                               ', 0
	    DB     '                                                                               $', 0

anyk    DB     '                          press any key to continue                            $', 0

;------ variable for ship ----------------------------
key		            db	0		;key status
ship_x	            db	40		;ship x axis
ship_y	            db	22		;ship y axis
flag	            db	0

;------ variable for bullet --------------------------
numBullet           db 180
bulletX             db 180 dup(?) ;bullet in x   
bulletY             db 180 dup(?) ;bullet in y
currentBullet       db 0

i_updateBullet      db 0
temp                db 0


;--------------------ETC Variable ---------------------
count_delay_matrix  db 0
DELAY_MATRIX        db 10

    .code 
    org     0100h

main:
    call    displayScreen
    

check:
	mov	ah,		01h		;check keyboard status
	int	16h
	jz 	check
	

	mov	ah,		00		;if pressed check what pressed
	int	16h
	cmp	al,		1Bh		;if esc
	je	exitgame
	cmp	al,		0Dh		;if it is ENTER go to menu
	je	modeselect

	jmp	check

OverScreen:
	mov     ah, 		00h         
       	mov     al,		03h		 ; 80x25 mode
       	int     10h

			; Printing
        mov 	ah, 		09h
       	mov 	dx, 		offset overS	;printoverS
       	int 	21h
	
	Call 	OverSound		;Oversong

exitgame:
        MOV    ah, 00h                  ; clear screen
        MOV    al, 03h
        INT    10h

        ; RET
        .exit                           ; exit game
		
modeselect:
	mov     	ah, 		00h         
       	mov     	al,		03h		 ; 80x25 mode
       	int     	10h

        mov 	ah, 		09h
       	mov 	dx, 		offset modetxt
       	int 	21h
	

        MOV    ah, 02h                  ; move cursor to
        MOV    dl, 35                   ;      column 35
        MOV    dh, 12                   ;      row 12
        MOV    bh, 0
        INT    10h

        MOV    ah, 0Ah                  ; clear all '>'
        MOV    al, 0
        MOV    bh, 0
        MOV    cx, 1
        INT    10h

        MOV    ah, 02h                  ; move cursor to
        MOV    dh, 13                   ;      row 13
        INT    10h

        MOV    ah, 0Ah                  ; clear
        INT    10h

        MOV    ah, 02h                  ; move cursor to
        MOV    dh, 14                   ;      row 14
        INT    10h

        MOV    ah, 0Ah                  ; clear
        INT    10h

        MOV    ah, 02h                  ; move cursor to
        MOV    dh, 12                   ;      row 12
        ADD    dh, m
        INT    10h

        MOV    ah, 0Ah                  ; print '>' to selected menu
        MOV    al, '>'
        INT    10h

inflp:
        MOV    ah, 01h                  ; wait for key pressed
        INT    16h
        JZ     inflp
	
	Call 	Soundmode			;call sound

        MOV    ah, 00h                  ; get key from buffer
        INT    16h

checkup:
        CMP    ah, 72                   ; arrow up
        JNE    checkdown

        CMP    m, 0
        JE     inflp
        DEC    m                        ; decrease menu
        JMP    modeselect

checkdown:
        CMP    ah, 80                   ; arrow down
        JNE    checkesc

        CMP    m, 2
        JE     inflp
        INC    m                        ; increase menu
        JMP    modeselect

checkesc:
        CMP    al, 27                   ; esc
        JNE    checkenter

        JMP    exitgame                 ; exit game

checkenter:
        CMP    al, 13                   ; carriage return
        JNE    inflp                    ; if no key pressed then infinite loop

        cmp     m,0
        je      if_easy
        
        cmp     m,1
        je      if_hard

        cmp     m,2
        je      if_hell
if_easy:
    mov     WINDOW_LEFT,30
    mov     WINDOW_RIGHT,50

    mov     bx,offset easyWindow
    
    jmp     initMatrix
if_hard:
    mov     WINDOW_LEFT,20
    mov     WINDOW_RIGHT,60

    mov     bx,offset hardWindow
    jmp     initMatrix
if_hell:
    mov     WINDOW_LEFT,10
    mov     WINDOW_RIGHT,70

    mov     bx,offset hellWIndow
    jmp     initMatrix

initMatrix:                             ;initilize matrix line
    call    clearScreen

    mov     dh,0
    mov     ch,0ah
    call    printStringAt

    call    displayShip
    
    mov     bl,WINDOW_LEFT              ;looping around window size
    mov     i,bl
loop_initMatrix:                        ;initilize by random number to matrixY
    mov     bx,0
    mov     bl,WINDOW_RIGHT

    cmp     i,bl
    jge     End_Loop_initMatrix

    mov     dl,START_MATRIX_Y           ;random number from START_MATRIX_Y to 0
    neg     dl                          
    mov     dh,0
    call    random_number
    neg     dl


    mov     si,offset matrixY           ;store in matrixY
    add     si,word ptr [i]
    mov     [si],dl

    add     i,1
    jmp     loop_initMatrix

End_Loop_initMatrix:


Game_loop:                      
    add     count_delay_matrix,1    ;count_delay_matrix++
;----------------------------------------------------
    call    InIf_One                ;if (count_delay_matrix == DELAY_MATRIX)
    call    Inif_two 

    call    sleep                       ;delaying


    jmp     Game_loop
    ret

;--------- if count_delay_matrix == DELAY_MATRIX -------
InIf_One:   ;PASS

    mov     bx,0                        ;bx is temp
    mov     bl,DELAY_MATRIX             ;bx=DELAY_MATRIX
    cmp     count_delay_matrix,bl       ;count_delay_matrix == DELAY_MATRIX
    je      IfONE

    ret

IfONE:   ;Pass


    call    updateMatrix                ;update matrix function
    call    checkBulletCollisMatrix
    call    updateBullet
    call    checkBulletCollisMatrix
    
    mov     count_delay_matrix,0        ;count_delay_matrix=0

    ret

    
;------------------- if kbhit() -----------------------
Inif_two:   ;PASS

    mov     ax,0
    mov	    ah,	01
	int	    16h			;check keyboard status
	jnz	    onControl   ;if  pressed go to onControl
    
    ret

    
;------------------ Control -------------------------
onControl:
    call    clearShip
    ; get Input from keybroad
    mov     ax,0
	mov	    ah,	00		;if pressed go to check
	int	    16h

	cmp	    al,	61h		;cmp a
	je	    CheckLeft

	cmp	    al,	64h		;cmp d
	je	    CheckRight

    cmp     al, 77h     ;cmp w
    je      ToShootBullet

    ;displayShip
    call    displayShip

    ret
;-------------- check LEFT ----------------------------
CheckLeft:
    push    ax
    mov     ax,0
    mov     al,ship_x

    cmp     al,WINDOW_LEFT
    jg      goleft

    call    displayShip
    pop     ax
    ret
;-------------- check Right ----------------------------
CheckRight:
    push    ax
    mov     ax,0
    mov     al,ship_x

    cmp     al,WINDOW_RIGHT
    jl      goright

    call    displayShip
    pop     ax
    ret

    

;------------------------------------------------------
clearShip:
    push	ax
	push	bx
	push	cx
    push    dx

    mov     dh,ship_y
    mov     dl,ship_x
    call    printAt
    
    pop     dx
    pop     cx
    pop     bx
    pop     ax

    push    ax
    push    bx
    push    cx
    push    dx

    mov     al,01h
    mov     bl,00h
    call    printColor

    pop     dx
	pop	    cx
	pop	    bx
	pop	    ax
ret
;-------- ToShootBullet Because out of Range ---------
ToShootBullet:
    call   shootBullet
ret
;----------------- GoLeft -----------------------------
goleft:
	sub	    ship_x,1
    call    displayShip
    pop     ax
ret

;------------------- GoRight -------------------------
goright:
    add 	ship_x,1
    call    displayShip

    pop     ax
ret

checkBulletCollisMatrix:
    push    dx       
    push    cx
    push    bx
    push    ax
    mov     cx,0
    mov     cl,WINDOW_RIGHT
    sub     cl,WINDOW_LEFT
loop_all_matrix:
    add     cl,WINDOW_LEFT
    mov     bx,cx                   ;bx iterate number of matrix

    mov     cx,0
    mov     cl,numBullet            ;cx iterate number of bullet
    add     cx,1
loop_all_bullet:
    sub     bx,1
    sub     cx,1

    mov     si,offset bulletX
    add     si,cx
    mov     ax,[si]
    sub     ax,1
    cmp     ax,bx
    je      If_Same_X_pos
Exit_If_checkBullet:

    add     cx,1
    add     bx,1



    loop    loop_all_bullet

    mov     cx,bx
    sub     cl,WINDOW_LEFT
    loop    loop_all_matrix

    pop     ax
    pop     bx
    pop     cx
    pop     dx
    ret


If_Same_X_pos:
  
    mov     si,offset matrixY
    add     si,bx
    mov     ax,[si]
    mov     dx,0
    mov     dl,WINDOW_TOP
    cmp     ax,dx
    jg      If_Not_Top_Window
    jmp     Exit_If_checkBullet

If_Not_Top_Window:
    mov     si,offset bulletY
    add     si,cx

    mov     ax,[si]
    sub     ax,2
    
    
    mov     si,offset matrixY
    add     si,bx
    add     si,1
    mov     dx,[si]

    cmp     al,dl                       ;ax = bulletY; dx = matrixY
    je      If_Coliis
    
    jmp     Exit_If_checkBullet

If_Coliis:

    push    dx


    pop     dx
    mov     si,offset matrixY
    add     si,bx
    mov     ax,-30
    mov     [si],ax

    mov     dx,0
    mov     dh,bl
    add     dh,1
    ; mov     dx,bx
    call    clearFlowMatrix

    jmp     Exit_If_checkBullet
;--------------------------- Display Screen ----------------------
displayScreen: ;Pass
    push    ax

    mov	    ah,	00
	mov	    al,	03h			;display 80*25
	int 	10h

    mov     bx,offset tittxt
    mov     ch,0fh
    mov     dh,0
    call    printStringAt


    call    SoundStart

    mov     bx,offset anyk
    mov     ch,0fh
    mov     dh,15
    call    printStringAt


    pop     ax
ret
;------------------------- displayShip ----------------------------
displayShip:
    push	ax
	push	bx
	push	cx
    push    dx

    mov     dh,ship_y
    mov     dl,ship_x
    call    printAt
    
    pop     dx
    pop     cx
    pop     bx
    pop     ax

    push    ax
    push    bx
    push    cx
    push    dx

    mov     al,01h
    mov     bl,0Fh
    call    printColor
    
    pop     dx
	pop	    cx
	pop	    bx
	pop	    ax
ret
;---------------------------------------------------------------
shootBullet:        ;PASS
    push    ax
    push    bx
    push    cx
    push    dx
    push    si

;----------------currentBullet = (currentBullet + 1) % numBullet;---------
    add     currentBullet,1             ;(currentBullet + 1)
    mov     dx,0                        ;clear dx
    mov     ax,0
    mov     al,currentBullet            ;dividend
    mov     cx,0                        
    mov     cl,numBullet                ;divisor
    div     cx              
    mov     currentBullet,dl            ;ax=/ || dx=%

    ;ax bx cx dx si can use
;----------------bulletX[currentBullet] = shipX --------------------------
    mov     si,offset bulletX           
    mov     bx,0                        ;clear bx for shipX
    mov     bl,ship_x
    mov     dx,0                        ;clear dx for currentBullet
    mov     dl,currentBullet
    add     si,dx
    mov     [si],bl                     ;bulletX[currentBullet] = shipX
    ;ax bx cx dx si can use

;----------------bulletY[currentBullet] = WINDOW_BOTTOM;------------------
    mov     si,offset bulletY           
    mov     bx,0                        ;clear bx for WINDOW_BOTTOM
    mov     bl,WINDOW_BOTTOM
    mov     dx,0                        ;clear dx for currentBullet
    mov     dl,currentBullet
    add     si,dx
    mov     [si],bl                     ;bulletX[currentBullet] = WINDOW_BOTTOM
    ;ax bx cx dx si can use

;-------------------------------------------------------------------------
    call    displayShip
    jmp     Exit
ret
;---------------- for cx= numBullet cx>0 ---------------
updateBullet:
    push    ax
    push    bx
    push    cx
    push    dx
    push    si
    
    mov     dx,0
    mov     dl,numBullet        
    mov     cx,0
    mov     cx,dx              ; cx is i in LOOP for

    ;CX CANT USE [ax,bx,dx,si can use] 
;-------------------- In Loop For----- ---------------
updateBullet_Loop:;pass
    push    cx                  ; store cx(i)    

    mov     si,offset bulletY   ; bulletY[]
    mov     ax,0                ; clear ax for temp
    mov     al,i_updateBullet   ; temp=i_updateBullet
    add     si,ax               ; bulletY[i]
    mov     ax,0                ; clear ax for tempAX
    mov     al,[si]             ; tempAX = bulletY[i]

    cmp     al,WINDOW_TOP
    jle     printBulletss

    mov     temp,0
    mov     temp,al             ; temp = tempAX
    sub     temp,1              ;
    
    mov     ax,0
    mov     al,temp
    mov     [si],al             ;bulletY[i]--
printBulletss:
    call    printBullet

    add     i_updateBullet,1            ;i++
    pop     cx
    loop    updateBullet_Loop
    ;End loop
    mov     i_updateBullet,0            ;i=0
    jmp     Exit
ret
    ;ax,bx,cx,dx,si can use
;--------------------------------------------------------


printBullet:
    push    ax
    push    bx
    push    cx
    push    dx
    push    si

;------------ IF bulletY[i] > WINDOW_TOP - 1 -------------
    mov     si,offset bulletY           ;bulletY[]
    mov     cx,0                        ;clear CX
    mov     cl,i_updateBullet
    add     si,cx                       ;bulletY[i]
    
    mov     cx,0                        ;clear CX
    mov     cl,WINDOW_TOP
    mov     temp,0               
    mov     temp,cl                     ;temp=WINDOW_TOP
    sub     temp,1                      ;temp=WINDOW_TOP - 1

    mov     cx,0                        
    mov     cl,[si]                     ;cl=bulletY[i]
    cmp     cl,temp                     ;cmp bulletY[i],WINDOW_TOP
    jg      IF_printBullet

;------------ELSEIF bulletY[i] == WINDOW_TOP - 1 ---------
    je      ELSEIF_printBullet

;---------------------------------------------------------
    jmp     Exitprint
ret
    ;ax bx cx dx can use

IF_printBullet:
    push    ax
    push    bx
    push    cx
    push    dx
;----------------------- Start If -------------------------
    mov     dx,0        
    mov     dl,i_updateBullet       ;dx=i_updateBullet

;--------- bulletX[i_updateBullet] -------------------
    mov     si,offset bulletX       ;bulleX[]      
    add     si,dx                   ;bullet[i_updateBullet]
    
    mov     ax,0                    ;ax for temp     
    mov     al,[si]                 ;al=bulletX[i_updateBullet]
;--------- bulletY[i_updateBullet] ------------------

    mov     si,offset bulletY       ;bulletY[]
    add     si,dx                   ;bulletY[i_updateBullet]

    mov     bx,0                    ;bx for temp1
    mov     bl,[si]                 ;bl=bulletY[i_updateBullet]
    sub     bl,1    

;------------- PRINT YELLOW---------------------------------
    mov     dh,bl       ;y
    mov     dl,al       ;x
    
    push    ax
    push    bx
    mov     ax,0

    call    printAt

    pop     bx
    pop     ax 

    push    ax
    push    bx
    push    cx 

    mov     al,0f9h      ;ascii
    mov     bl,0eh       ;color
    call    printColor

    pop     cx
    pop     ax
    pop     ax

;----------------------- Print BLACK -------------------------
    mov     dx,0        
    mov     dl,i_updateBullet       ;dx=i_updateBullet

;--------- bulletX[i_updateBullet] -------------------
    mov     si,offset bulletX       ;bulleX[]      
    add     si,dx                   ;bullet[i_updateBullet]
    
    mov     ax,0                    ;ax for temp     
    mov     al,[si]                 ;al=bulletX[i_updateBullet]
;--------- bulletY[i_updateBullet] + 1 ------------------

    mov     si,offset bulletY       ;bulletY[]
    add     si,dx                   ;bulletY[i_updateBullet]

    mov     bx,0                    ;bx for temp1
    mov     bl,[si]                 ;bl=bulletY[i_updateBullet]    
    ;add     bl,1                    ;bl = bulletY[i_updateBullet]+1

;------------- PRINT ---------------------------------
    mov     dh,bl       ;y
    mov     dl,al       ;x
    
    push    ax
    push    bx
    mov     ax,0

    call    printAt

    pop     bx
    pop     ax 

    push    ax
    push    bx
    push    cx 

    mov     al,0f9h      ;ascii
    mov     bl,00h       ;color
    call    printColor

    pop     cx
    pop     ax
    pop     ax    


;---------------------------- End if ---------------------
    pop     dx
    pop     cx
    pop     bx
    pop     ax

    jmp     Exitprint

ret

ELSEIF_printBullet:
    push    ax
    push    bx
    push    cx
    push    dx

;----------------------- Print BLACK -------------------------
    mov     dx,0        
    mov     dl,i_updateBullet       ;dx=i_updateBullet

;--------- bulletX[i_updateBullet] -------------------
    mov     si,offset bulletX       ;bulleX[]      
    add     si,dx                   ;bullet[i_updateBullet]
    
    mov     ax,0                    ;ax for temp     
    mov     al,[si]                 ;al=bulletX[i_updateBullet]
;--------- bulletY[i_updateBullet] + 1 ------------------

    mov     si,offset bulletY       ;bulletY[]
    add     si,dx                   ;bulletY[i_updateBullet]

    mov     bx,0                    ;bx for temp1
    mov     bl,[si]                 ;bl=bulletY[i_updateBullet]    
    ;add     bl,1                    ;bl = bulletY[i_updateBullet]+1

;------------- PRINT ---------------------------------
    mov     dh,bl       ;y
    mov     dl,al       ;x
    
    push    ax
    push    bx
    mov     ax,0

    call    printAt

    pop     bx
    pop     ax 

    push    ax
    push    bx
    push    cx 

    mov     al,0f9h      ;ascii
    mov     bl,00h       ;color
    call    printColor

    pop     cx
    pop     ax
    pop     ax    

;---------------------------- End if ---------------------
    pop     dx
    pop     cx
    pop     bx
    pop     ax

    jmp     Exitprint
ret


Exitprint:
    pop     si
    pop     dx
    pop     cx
    pop     bx
    pop     ax
ret

printAt:
    mov     ah,02h      ;set cursor
    mov     bh,0
    ;mov     dh,y       ;y
    ;mov     dl,x       ;x
    int     10h
ret 

printColor:
    mov     ah,09h      ;print
    ;mov     al,ascii   ;ascii
    mov     bh,0
    ;mov     bl,color    ;color
    mov     cx,1
    int     10h
ret

updateMatrix:                           ;make matrix go down 
    push    cx                          ;and check matrix is ended
    push    si

    mov     cx,0
    mov     cl,WINDOW_LEFT
    mov     i,cl
loop_updateMatrix:
    mov     cl,WINDOW_RIGHT
    cmp     i,cl
    jge     End_loop_updateMatrix
;LOOP BODY:
    mov     si,offset matrixY
    add     si,word ptr [i]
    add     [si],1

    mov     cl,[si]             
    mov     printFlowMatrix_Y,cl        ;set y axis
    mov     ch,i
    mov     printFlowMatrix_X,ch        ;set x axis
    
    call    printFlowMatrix             ;print matrix
    
    call    checkMatrixEnded
;END_LOOP_BODY

    mov     si,offset i
    add     [si],1
    jmp     loop_updateMatrix
End_loop_updateMatrix:
    pop     si
    pop     cx
    ret
    
checkMatrixEnded:                       ;check Matrix line is bottom of window
    push    dx
    mov     dh,printFlowMatrix_X        ;if matrix on bottom -> take damagge
    mov     dl,printFlowMatrix_Y        ;and start matrix again
                                        ;and clear matrix

    cmp     dl,WINDOW_BOTTOM
    je      If_MatrixEnded
Exit_If_MatrixEnded:


    pop     dx
    ret
    
If_MatrixEnded:
    push    cx
;start new matrix
    mov     cx,0
    mov     cl,dh
    mov     si,offset matrixY
    add     si,cx

    mov     cx,0
    mov     cl,START_MATRIX_Y
    mov     [si],cl                                 
;start new matrix END

    ; mov     xPos,dh
    call    clearFlowMatrix
    
    call    gotDamaged

    pop     cx
    jmp     Exit_If_MatrixEnded
refreshLife:
    push    bx
    push    dx
    push    cx

    mov     bx,offset lifeStatus
    mov     dh,23
    mov     ch,14
    call    printStringAt

    mov     dh,0
    mov     dl,79
    mov     bh,0fh
    mov     bl,life
    add     bl,'0'
    call    printCharAt

    pop     cx
    pop     dx
    pop     bx
    ret
gotDamaged:
    sub     life,1
    call    refreshLife

    cmp     life,0
    je      died
    ret

died:
    call    clearScreen
    
    mov     bx,offset overS
    mov     dh,0
    mov     ch,0fh
    call    printStringAt
    .exit

    

printFlowMatrix:
    push    cx
    push    bx
    push    si
    push    dx
    mov     bx,0
    mov     bl,i
    push    bx

    mov     i,0h
    
loop_printFlowMatrix:
    mov     cx,0
    mov     cl,matrixLength
    cmp     i,cl
    jge     End_Loop_PrintFlowMatrix
    
    mov     cl,printFlowMatrix_Y
    sub     cl,i

    cmp     cl,WINDOW_TOP
    jge     printFlowMatrix_IF_GREATERTHAN_WINDOWTOP
End_printFlowMatrix_IF_GREATERTHAN_WINDOWTOP:

    add     i,1
    jmp     loop_printFlowMatrix


printFlowMatrix_IF_GREATERTHAN_WINDOWTOP:
    cmp     cl,WINDOW_BOTTOM
    jl      printFlowMatrix_IF_LESSTHAN_WINDOWBOTTOM
    jmp     End_printFlowMatrix_IF_GREATERTHAN_WINDOWTOP

printFlowMatrix_IF_LESSTHAN_WINDOWBOTTOM:


    mov     si,OFFSET matrixColorCode
    mov     dx,0
    mov     dl,i
    add     si,dx
    mov     bl,[si]


    mov     dh,cl
    mov     dl,printFlowMatrix_X
    call    printRandomCharAt

    jmp     End_printFlowMatrix_IF_GREATERTHAN_WINDOWTOP


End_Loop_PrintFlowMatrix:
    pop     bx
    mov     i,bl
    pop     dx
    pop     si
    pop     bx
    pop     cx
    ret
clearFlowMatrix:
    push    bx
    push    cx
    push    dx

    mov     cx,0
    mov     cl,WINDOW_BOTTOM


    mov     dl,dh                       ;input X-axis is dh
    
loop_clearFlowMatrix:                   ;dh is Y-axis; dl is X-axis
    mov     dh,cl
    
    mov     bh,00h
    mov     bl,' '
    call    printCharAt

    loop    loop_clearFlowMatrix

    pop     dx
    pop     cx
    pop     bx
    ret
random_number:              ;random number from dh to dl
    
    push    ax              ;backup value ax
    push    cx              ;backup value cx
    

    push    dx

    mov     ax,seed
    mov     cx,17
    mul     cx
    add     ax,31
    mov     seed,ax
    mov     dx,ax
    
    
    mov     ax,dx           ;store system time to ax
    pop     dx              ;pop [from,to] -> dx

    mov     cx,0h
    sub     dl,dh           ;to - from
    mov     cl,dl           ;store answer to cl
    push    dx              ;push [from,to]
    mov     dx,0h           ;clear dx for dividend
    div     cx              ;divide

    pop     cx              ;pop [from,to] -> cx

    mov     cl,ch
    mov     ch,0h
    
    add     dx,cx           ;ret random number to dx

    

    pop     cx              ;give value back
    pop     ax

    ret
printRandomCharAt:                          ;print random character at position (dh = row,dl = column)
                                            ;with color ( bl = color code)

    push    ax
    push    cx
    push    dx
                                    
    mov     ax,0B800h                       ;select video ram address
    mov     es,ax                           

    mov     ax,0                            ;calculate address from row and column
    mov     al,dh                           ;by (row*80 + column)*2
    mov     cx,80
    push    dx
    mul     cx
    pop     dx
    mov     dh,0
    add     ax,dx
    mov     dx,02h
    mul     dx
    mov     di,ax                           ;store address offset to di
    
    mov     dh,33
    mov     dl,126
    call    random_number                   ;random character decimal number

    mov     ah,bl                           ;store color data
    mov     al,dl                           ;store character
    stosw                                   ;write video ram

    pop     dx
    pop     cx
    pop     ax

    ret

printCharAt:                            ;print character at position (dh = row,dl = column)
                                            ;color ( bh = color code)
                                            ;chacracter (bl = ascii)

    push    ax
    push    cx
    push    dx
                                    
    mov     ax,0B800h                       ;select video ram address
    mov     es,ax                           

    mov     ax,0                            ;calculate address from row and column
    mov     al,dh                           ;by (row*80 + column)*2
    mov     cx,80
    push    dx
    mul     cx
    pop     dx
    mov     dh,0
    add     ax,dx
    mov     dx,02h
    mul     dx
    mov     di,ax                           ;store address offset to di
    
    mov     ax,bx                           ;store color data                                        ;store character
    stosw                                   ;write video ram

    pop     dx
    pop     cx
    pop     ax

    ret
printStringAt:                              ;print String at position (dh = row)
                                            ;bx = String address
                                            ;ch = color
    
    push    ax
    push    cx
    push    dx
    mov     ax,0
    mov     al,dh
    mov     dx,0
    mul     dx
    mov     di,ax

loop_printStringAt:                         ;print character until find '$'
    

    mov     ax,0B800h                       ;select video ram address
    mov     es,ax                           
    mov     ax,[bx]                          ;store color data  
    cmp     al,'$'                          ;if character is '$' -> stop print
    je      Exit_loop_printStringAt 
    mov     ah,ch                                      ;store character
    stosw                                   ;write video ram
    add     bx,1

    jmp     loop_printStringAt
Exit_loop_printStringAt:

    pop     dx                              
    pop     cx
    pop     ax

    ret
sleep:
    push    cx
    mov     cx,05f0fh
loop_sleep:
    nop                                     ;do nothing
    nop     

         

    loop    loop_sleep                      ;loop until cx is zero
    pop     cx
    ret
;---------------Sound-----------------------
OverSound:
		mov	di,	offset OverSong
		call	playSound

SoundStart:
		mov	di,	offset Startsound
		call	playSound

Soundmode:	mov	di,	offset ModeSound
		call	playSound

PlaySound:
    mov  dx,61h                  ; turn speaker on
    in   al,dx                   ;
    or   al,03h                  ;
    out  dx,al                   ;
    mov  dx,43h                  ; get the timer ready
    mov  al,0B6h                 ;
    out  dx,al                   ;

LoopIt: 
	mov	 ax,[di]				 ; load freq from address DI to AX.
    or   ax,ax                   ; if freq. = 0 then done
    jz   LDone             		 ;
    mov  dx,42h                  ; port to out
    out  dx,al                   ; out low order
    xchg ah,al                   ;
    out  dx,al                   ; out high order                       
	add	 di,2					 ; point duration
	mov	 ax,[di]				 ; load duration from DI to AX.
    mov  cx,ax                   ; put it in cx (16 = 1 second)
	
		mov  ax,0040h				 ; pause it 
		mov  es,ax
		; wait for it to change the first time
		mov  al,es:[006Ch]
	@a: cmp  al,es:[006Ch]
		je   @a		
		; wait for it to change again
	loop_it:mov  al,es:[006Ch]
	@b: cmp  al,es:[006Ch]
        je   @b
        sub  cx,55
        jns  loop_it
	
	add	 di,2						; point next freq
	jmp  LoopIt
LDone: mov  dx,61h                  ; turn speaker off
       in   al,dx                   ;
       and  al,0FCh                 ;
       out  dx,al    
	ret
;-------------------------------------------------------------
clearScreen:
    push    dx
    push    bx
    push    cx

    mov     bx,offset   blankScreen
    mov     dh,0
    mov     ch,0h
    call    printStringAt
    pop     cx
    pop     bx
    pop     dx
    ret
Exit:
    pop     si
    pop     dx
    pop     cx
    pop     bx
    pop     ax
ret


end main
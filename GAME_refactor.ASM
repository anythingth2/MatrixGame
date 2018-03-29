    .model  tiny
    ; .stack  0100h

    .data

SEED            dw  13
char       db  ?

colorMatric db  0fh,0ah,0ah,02h,02h,00h,00h,00h
lenghtM    db  7

Top      db  0
Left     db  30
Right    db  50
Bottom   db  20

printMX   db  ?
printMY   db  ?


StartMY  db  100

MY         db  80 dup(?)

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
playerX	            db	40		;ship x axis
playerY	            db	22		;ship y axis

;------ variable for bullet --------------------------
Nbullet           db 180
bX             db 180 dup(?) ;bullet in x   
bY             db 180 dup(?) ;bullet in y
currentBullet       db 0

iB      db 0
temp                db 0


;--------------------ETC Variable ---------------------
counter_delay  db 0
delaym        db 10

    .code 
    org     0100h

main:
    call    showGame
    

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
    mov     Left,30
    mov     Right,50

    mov     Nbullet,offset easyWindow

    jmp     create
if_hard:
    mov     Left,20
    mov     Right,60

    mov     Nbullet,offset hardWindow
    jmp     create
if_hell:
    mov     Left,10
    mov     Right,70

    mov     Nbullet,offset hellWIndow
    jmp     create

create:                             ;initilize matrix line
    call    clearScreen

    mov     dh,0
    mov     ch,0ah
    call    printStringAt

    call    showPlayer
    
    mov     bl,Left              ;looping around window size
    mov     i,bl
loopCreate:                        ;initilize by random number to MY
    mov     Nbullet,0
    mov     bl,Right

    cmp     i,bl
    jge     end_loopCreate

    mov     dl,StartMY           ;random number from StartMY to 0
    neg     dl                          
    mov     dh,0
    call    random_number
    neg     dl


    mov     si,offset MY           ;store in MY
    add     si,word ptr [i]
    mov     [si],dl

    add     i,1
    jmp     loopCreate

end_loopCreate:


Infinity:                      
    add     counter_delay,1    ;counter_delay++
;----------------------------------------------------
    call    If1st                ;if (counter_delay == delaym)
    call    If2nd 

    call    sleep                       ;delaying


    jmp     Infinity
    ret

;--------- if counter_delay == delaym -------
If1st:   ;PASS

    mov     Nbullet,0                        ;Nbullet is temp
    mov     bl,delaym             ;Nbullet=delaym
    cmp     counter_delay,bl       ;counter_delay == delaym
    je      IfONE

    ret

IfONE:   ;Pass


    call    pushMatrix                ;update matrix function
    call    isDestory
    call    pushBullet
    call    isDestory
    
    mov     counter_delay,0        ;counter_delay=0

    ret

    
;------------------- if kbhit() -----------------------
If2nd:   ;PASS

    mov     ax,0
    mov	    ah,	01
	int	    16h			;check keyboard status
	jnz	    getInput   ;if  pressed go to getInput
    
    ret

    
;------------------ Control -------------------------
getInput:
    call    clearLastPlayer
    ; get Input from keybroad
    mov     ax,0
	mov	    ah,	00		;if pressed go to check
	int	    16h

	cmp	    al,	61h		;cmp a
	je	    CheckLeft

	cmp	    al,	64h		;cmp d
	je	    CheckRight

    cmp     al, 77h     ;cmp w
    je      shotd

    ;showPlayer
    call    showPlayer

    ret
;-------------- check LEFT ----------------------------
CheckLeft:
    push    ax
    mov     ax,0
    mov     al,playerX

    cmp     al,Left
    jg      goleft

    call    showPlayer
    pop     ax
    ret
;-------------- check Right ----------------------------
CheckRight:
    push    ax
    mov     ax,0
    mov     al,playerX

    cmp     al,Right
    jl      goright

    call    showPlayer
    pop     ax
    ret

    

;------------------------------------------------------
clearLastPlayer:
    push	ax
	push	Nbullet
	push	cx
    push    dx

    mov     dh,playerY
    mov     dl,playerX
    call    printAt
    
    pop     dx
    pop     cx
    pop     Nbullet
    pop     ax

    push    ax
    push    Nbullet
    push    cx
    push    dx

    mov     al,01h
    mov     bl,00h
    call    printColor

    pop     dx
	pop	    cx
	pop	    Nbullet
	pop	    ax
ret
;-------- shotd Because out of Range ---------
shotd:
    call   shootBullet
ret
;----------------- GoLeft -----------------------------
goleft:
	sub	    playerX,1
    call    showPlayer
    pop     ax
ret

;------------------- GoRight -------------------------
goright:
    add 	playerX,1
    call    showPlayer

    pop     ax
ret

isDestory:
    push    dx       
    push    cx
    push    Nbullet
    push    ax
    mov     cx,0
    mov     cl,Right
    sub     cl,Left
loopMatrix:
    add     cl,Left
    mov     Nbullet,cx                   ;Nbullet iterate number of matrix

    mov     cx,0
    mov     cl,Nbullet            ;cx iterate number of bullet
    add     cx,1
loopBullet:
    sub     Nbullet,1
    sub     cx,1

    mov     si,offset bX
    add     si,cx
    mov     ax,[si]
    sub     ax,1
    cmp     ax,Nbullet
    je      sameX
exit_checkBullet:

    add     cx,1
    add     Nbullet,1



    loop    loopBullet

    mov     cx,Nbullet
    sub     cl,Left
    loop    loopMatrix

    pop     ax
    pop     Nbullet
    pop     cx
    pop     dx
    ret

sameX:
  
    mov     si,offset MY
    add     si,Nbullet
    mov     ax,[si]
    mov     dx,0
    mov     dl,Top
    cmp     ax,dx
    jg      if_notTop
    jmp     exit_checkBullet

if_notTop:
    mov     si,offset bY
    add     si,cx

    mov     ax,[si]
    sub     ax,2
    
    
    mov     si,offset MY
    add     si,Nbullet
    add     si,1
    mov     dx,[si]

    cmp     al,dl                       ;ax = bY; dx = MY
    je      if_touch
    
    jmp     exit_checkBullet

if_touch:

    push    dx


    pop     dx
    mov     si,offset MY
    add     si,Nbullet
    mov     ax,-30
    mov     [si],ax

    mov     dx,0
    mov     dh,bl
    add     dh,1
    ; mov     dx,Nbullet
    call    clearFlowMatrix

    jmp     exit_checkBullet
;--------------------------- Display Screen ----------------------
showGame: ;Pass
    push    ax

    mov	    ah,	00
	mov	    al,	03h			;display 80*25
	int 	10h

    mov     Nbullet,offset tittxt
    mov     ch,0fh
    mov     dh,0
    call    printStringAt


    call    SoundStart

    mov     Nbullet,offset anyk
    mov     ch,0fh
    mov     dh,15
    call    printStringAt


    pop     ax
ret
;------------------------- showPlayer ----------------------------
showPlayer:
    push	ax
	push	Nbullet
	push	cx
    push    dx

    mov     dh,playerY
    mov     dl,playerX
    call    printAt
    
    pop     dx
    pop     cx
    pop     Nbullet
    pop     ax

    push    ax
    push    Nbullet
    push    cx
    push    dx

    mov     al,01h
    mov     bl,0Fh
    call    printColor
    
    pop     dx
	pop	    cx
	pop	    Nbullet
	pop	    ax
ret
;---------------------------------------------------------------
shootBullet:        ;PASS
    push    ax
    push    Nbullet
    push    cx
    push    dx
    push    si

;----------------currentBullet = (currentBullet + 1) % Nbullet;---------
    add     currentBullet,1             ;(currentBullet + 1)
    mov     dx,0                        ;clear dx
    mov     ax,0
    mov     al,currentBullet            ;dividend
    mov     cx,0                        
    mov     cl,Nbullet                ;divisor
    div     cx              
    mov     currentBullet,dl            ;ax=/ || dx=%

    ;ax Nbullet cx dx si can use
;----------------bX[currentBullet] = playerX --------------------------
    mov     si,offset bX           
    mov     Nbullet,0                        ;clear Nbullet for playerX
    mov     bl,playerX
    mov     dx,0                        ;clear dx for currentBullet
    mov     dl,currentBullet
    add     si,dx
    mov     [si],bl                     ;bX[currentBullet] = playerX
    ;ax Nbullet cx dx si can use

;----------------bY[currentBullet] = Bottom;------------------
    mov     si,offset bY           
    mov     Nbullet,0                        ;clear Nbullet for Bottom
    mov     bl,Bottom
    mov     dx,0                        ;clear dx for currentBullet
    mov     dl,currentBullet
    add     si,dx
    mov     [si],bl                     ;bX[currentBullet] = Bottom
    ;ax Nbullet cx dx si can use

;-------------------------------------------------------------------------
    call    showPlayer
    jmp     Exit
ret
;---------------- for cx= Nbullet cx>0 ---------------
pushBullet:
    push    ax
    push    Nbullet
    push    cx
    push    dx
    push    si
    
    mov     dx,0
    mov     dl,Nbullet        
    mov     cx,0
    mov     cx,dx              ; cx is i in LOOP for

    ;CX CANT USE [ax,Nbullet,dx,si can use] 
;-------------------- In Loop For----- ---------------
loop_push_bulet:;pass
    push    cx                  ; store cx(i)    

    mov     si,offset bY   ; bY[]
    mov     ax,0                ; clear ax for temp
    mov     al,iB   ; temp=iB
    add     si,ax               ; bY[i]
    mov     ax,0                ; clear ax for tempAX
    mov     al,[si]             ; tempAX = bY[i]

    cmp     al,Top
    jle     printBulletss

    mov     temp,0
    mov     temp,al             ; temp = tempAX
    sub     temp,1              ;
    
    mov     ax,0
    mov     al,temp
    mov     [si],al             ;bY[i]--
printBulletss:
    call    printBullet

    add     iB,1            ;i++
    pop     cx
    loop    loop_push_bulet
    ;End loop
    mov     iB,0            ;i=0
    jmp     Exit
ret
    ;ax,Nbullet,cx,dx,si can use
;--------------------------------------------------------


printBullet:
    push    ax
    push    Nbullet
    push    cx
    push    dx
    push    si

;------------ IF bY[i] > Top - 1 -------------
    mov     si,offset bY           ;bY[]
    mov     cx,0                        ;clear CX
    mov     cl,iB
    add     si,cx                       ;bY[i]
    
    mov     cx,0                        ;clear CX
    mov     cl,Top
    mov     temp,0               
    mov     temp,cl                     ;temp=Top
    sub     temp,1                      ;temp=Top - 1

    mov     cx,0                        
    mov     cl,[si]                     ;cl=bY[i]
    cmp     cl,temp                     ;cmp bY[i],Top
    jg      IF_printBullet

;------------ELSEIF bY[i] == Top - 1 ---------
    je      ELSEIF_printBullet

;---------------------------------------------------------
    jmp     Exitprint
ret
    ;ax Nbullet cx dx can use

IF_printBullet:
    push    ax
    push    Nbullet
    push    cx
    push    dx
;----------------------- Start If -------------------------
    mov     dx,0        
    mov     dl,iB       ;dx=iB

;--------- bX[iB] -------------------
    mov     si,offset bX       ;bulleX[]      
    add     si,dx                   ;bullet[iB]
    
    mov     ax,0                    ;ax for temp     
    mov     al,[si]                 ;al=bX[iB]
;--------- bY[iB] ------------------

    mov     si,offset bY       ;bY[]
    add     si,dx                   ;bY[iB]

    mov     Nbullet,0                    ;Nbullet for temp1
    mov     bl,[si]                 ;bl=bY[iB]
    sub     bl,1    

;------------- PRINT YELLOW---------------------------------
    mov     dh,bl       ;y
    mov     dl,al       ;x
    
    push    ax
    push    Nbullet
    mov     ax,0

    call    printAt

    pop     Nbullet
    pop     ax 

    push    ax
    push    Nbullet
    push    cx 

    mov     al,0f9h      ;ascii
    mov     bl,0eh       ;color
    call    printColor

    pop     cx
    pop     ax
    pop     ax

;----------------------- Print BLACK -------------------------
    mov     dx,0        
    mov     dl,iB       ;dx=iB

;--------- bX[iB] -------------------
    mov     si,offset bX       ;bulleX[]      
    add     si,dx                   ;bullet[iB]
    
    mov     ax,0                    ;ax for temp     
    mov     al,[si]                 ;al=bX[iB]
;--------- bY[iB] + 1 ------------------

    mov     si,offset bY       ;bY[]
    add     si,dx                   ;bY[iB]

    mov     Nbullet,0                    ;Nbullet for temp1
    mov     bl,[si]                 ;bl=bY[iB]    
    ;add     bl,1                    ;bl = bY[iB]+1

;------------- PRINT ---------------------------------
    mov     dh,bl       ;y
    mov     dl,al       ;x
    
    push    ax
    push    Nbullet
    mov     ax,0

    call    printAt

    pop     Nbullet
    pop     ax 

    push    ax
    push    Nbullet
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
    pop     Nbullet
    pop     ax

    jmp     Exitprint

ret

ELSEIF_printBullet:
    push    ax
    push    Nbullet
    push    cx
    push    dx

;----------------------- Print BLACK -------------------------
    mov     dx,0        
    mov     dl,iB       ;dx=iB

;--------- bX[iB] -------------------
    mov     si,offset bX       ;bulleX[]      
    add     si,dx                   ;bullet[iB]
    
    mov     ax,0                    ;ax for temp     
    mov     al,[si]                 ;al=bX[iB]
;--------- bY[iB] + 1 ------------------

    mov     si,offset bY       ;bY[]
    add     si,dx                   ;bY[iB]

    mov     Nbullet,0                    ;Nbullet for temp1
    mov     bl,[si]                 ;bl=bY[iB]    
    ;add     bl,1                    ;bl = bY[iB]+1

;------------- PRINT ---------------------------------
    mov     dh,bl       ;y
    mov     dl,al       ;x
    
    push    ax
    push    Nbullet
    mov     ax,0

    call    printAt

    pop     Nbullet
    pop     ax 

    push    ax
    push    Nbullet
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
    pop     Nbullet
    pop     ax

    jmp     Exitprint
ret


Exitprint:
    pop     si
    pop     dx
    pop     cx
    pop     Nbullet
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

pushMatrix:                           ;make matrix go down 
    push    cx                          ;and check matrix is ended
    push    si

    mov     cx,0
    mov     cl,Left
    mov     i,cl
loop_push_Matrix:
    mov     cl,Right
    cmp     i,cl
    jge     end_loop_pushMatrix
;LOOP BODY:
    mov     si,offset MY
    add     si,word ptr [i]
    add     [si],1

    mov     cl,[si]             
    mov     printMY,cl        ;set y axis
    mov     ch,i
    mov     printMX,ch        ;set x axis
    
    call    showMatrixLine             ;print matrix
    
    call    matrixAtBottom
;END_LOOP_BODY

    mov     si,offset i
    add     [si],1
    jmp     loop_push_Matrix
end_loop_pushMatrix:
    pop     si
    pop     cx
    ret
    
matrixAtBottom:                       ;check Matrix line is bottom of window
    push    dx
    mov     dh,printMX        ;if matrix on bottom -> take damagge
    mov     dl,printMY        ;and start matrix again
                                        ;and clear matrix

    cmp     dl,Bottom
    je      if_matrixAtBottom
Exit_matrixAtBottom:


    pop     dx
    ret
    
if_matrixAtBottom:
    push    cx
;start new matrix
    mov     cx,0
    mov     cl,dh
    mov     si,offset MY
    add     si,cx

    mov     cx,0
    mov     cl,StartMY
    mov     [si],cl                                 
;start new matrix END

    ; mov     xPos,dh
    call    clearFlowMatrix
    
    call    hurt

    pop     cx
    jmp     Exit_matrixAtBottom
showLife:
    push    Nbullet
    push    dx
    push    cx

    mov     Nbullet,offset lifeStatus
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
    pop     Nbullet
    ret
hurt:
    sub     life,1
    call    showLife

    cmp     life,0
    je      game_endeded
    ret

game_endeded:
    call    clearScreen
    
    mov     Nbullet,offset overS
    mov     dh,0
    mov     ch,0fh
    call    printStringAt
    .exit

    

showMatrixLine:
    push    cx
    push    Nbullet
    push    si
    push    dx
    mov     Nbullet,0
    mov     bl,i
    push    Nbullet

    mov     i,0h

loop_showMatrixLine:
    mov     cx,0
    mov     cl,lenghtM
    cmp     i,cl
    jge     End_Loop_PrintFlowMatrix
    
    mov     cl,printMY
    sub     cl,i

    cmp     cl,Top
    jge     printFlowMatrix_IF_GREATERTHAN_WINDOWTOP
End_printFlowMatrix_IF_GREATERTHAN_WINDOWTOP:

    add     i,1
    jmp     loop_showMatrixLine


printFlowMatrix_IF_GREATERTHAN_WINDOWTOP:
    cmp     cl,Bottom
    jl      printFlowMatrix_IF_LESSTHAN_WINDOWBOTTOM
    jmp     End_printFlowMatrix_IF_GREATERTHAN_WINDOWTOP

printFlowMatrix_IF_LESSTHAN_WINDOWBOTTOM:

    mov     si,OFFSET colorMatric
    mov     dx,0
    mov     dl,i
    add     si,dx
    mov     bl,[si]


    mov     dh,cl
    mov     dl,printMX
    call    printRandomCharAt

    jmp     End_printFlowMatrix_IF_GREATERTHAN_WINDOWTOP


End_Loop_PrintFlowMatrix:
    pop     Nbullet
    mov     i,bl
    pop     dx
    pop     si
    pop     Nbullet
    pop     cx
    ret
clearFlowMatrix:
    push    Nbullet
    push    cx
    push    dx

    mov     cx,0
    mov     cl,Bottom


    mov     dl,dh                       ;input X-axis is dh
    
loop_clearFlowMatrix:                   ;dh is Y-axis; dl is X-axis
    mov     dh,cl
    
    mov     bh,00h
    mov     bl,' '
    call    printCharAt

    loop    loop_clearFlowMatrix

    pop     dx
    pop     cx
    pop     Nbullet
    ret
random_number:              ;random number from dh to dl
    
    push    ax              ;backup value ax
    push    cx              ;backup value cx
    

    push    dx

    mov     ax,SEED
    mov     cx,17
    mul     cx
    add     ax,31
    mov     SEED,ax
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
printRandomCharAt:                          ;print random char at position (dh = row,dl = column)
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
    call    random_number                   ;random char decimal number

    mov     ah,bl                           ;store color data
    mov     al,dl                           ;store char
    stosw                                   ;write video ram

    pop     dx
    pop     cx
    pop     ax

    ret

printCharAt:                            ;print char at position (dh = row,dl = column)
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
    
    mov     ax,Nbullet                           ;store color data                                        ;store char
    stosw                                   ;write video ram

    pop     dx
    pop     cx
    pop     ax

    ret
printStringAt:                              ;print String at position (dh = row)
                                            ;Nbullet = String address
                                            ;ch = color
    
    push    ax
    push    cx
    push    dx
    mov     ax,0
    mov     al,dh
    mov     dx,0
    mul     dx
    mov     di,ax

loop_printStringAt:                         ;print char until find '$'
    

    mov     ax,0B800h                       ;select video ram address
    mov     es,ax                           
    mov     ax,[Nbullet]                          ;store color data  
    cmp     al,'$'                          ;if char is '$' -> stop print
    je      Exit_loop_printStringAt 
    mov     ah,ch                                      ;store char
    stosw                                   ;write video ram
    add     Nbullet,1

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
    push    Nbullet
    push    cx

    mov     Nbullet,offset   blankScreen
    mov     dh,0
    mov     ch,0h
    call    printStringAt
    pop     cx
    pop     Nbullet
    pop     dx
    ret
Exit:
    pop     si
    pop     dx
    pop     cx
    pop     Nbullet
    pop     ax
ret


end main
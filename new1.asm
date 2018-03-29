        .model tiny
        .data
m       DB     0
delay   DW     ?
; delay
easydelay       DW     04h
mediumdelay     DW     02h
harddelay       DW     01h


;--------------------Sound Data-----------------------------
OverSong DW	2711,16		;ÂÑ§äÁèä´éãÊèÃÍ©Ò¡¨º
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
	DB     '                                                                               ', 0
                                                    
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

        .code
        ORG    0100h

main:  			
	
	mov     ah, 		00h         
       	mov     al,		03h		 ; 80x25 mode
       	int     10h

			; Printing
        mov 	ah, 		09h
       	mov 	dx, 		offset tittxt
       	int 	21h
	
	Call 	SoundStart		;Startsong

	MOV     ah, 02h                 ; move cursor to
        MOV     dh, 15                  ;row 15
	MOV	dl, 0			;columm 0
        MOV     bh, 0
        INT     10h

	mov	ah,	09h
	mov	dx,	offset anyk
	int	21h

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

        RET

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
	END    main
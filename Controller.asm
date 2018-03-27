    .model  tiny

    .data
;------ variable for WINDOW -------------------------
WINDOW_TOP          db 0
WINDOW_LEFT         db 20
WINDOW_RIGHT        db 79
WINDOW_BOTTOM       db 20
;------ variable for ship ----------------------------
key		            db	0		;key status
ship_x	            db	40		;ship x axis
ship_y	            db	20		;ship y axis
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

;------------------------------------------------------
    .code 
    org     0100h   

main:
    call    displayScreen
    call    displayShip
    ;call   refreshLife
    ;call   initMatrix

    ;InfiLoop
    jmp    LoopInfi_main    
ret

LoopInfi_main:   ;PASS
    add     count_delay_matrix,1    ;count_delay_matrix++
;----------------------------------------------------
    call    InIf_One                ;if (count_delay_matrix == DELAY_MATRIX)
    call    Inif_two                ;if (kbhit())

;------------------------------------------------------
    call    sleep
    jmp     LoopInfi_main
ret

;--------- if count_delay_matrix == DELAY_MATRIX -------
InIf_One:   ;PASS

    mov     bx,0                        ;bx is temp
    mov     bl,DELAY_MATRIX             ;bx=DELAY_MATRIX
    cmp     count_delay_matrix,bl       ;count_delay_matrix == DELAY_MATRIX
    je      IfONE 
ret

IfONE:   ;Pass

    ;updateMatrix
    call updateBullet
    ;checkBulletCollisMatrix

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

;--------------------------- Display Screen ----------------------
displayScreen: ;Pass
    push    ax

    mov	    ah,	00
	mov	    al,	03h			;display 80*25
	int 	10h

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
sleep:
    push    cx
    mov     cx,0ffffh
loop_sleep:
    nop                                     ;do nothing
    loop    loop_sleep                 ;loop until cx is zero
    pop     cx
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
    mov     temp,0
    mov     temp,al             ; temp = tempAX
    sub     temp,1              ;
    
    mov     ax,0
    mov     al,temp
    mov     [si],al             ;bulletY[i]--

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
Exit:
    pop     si
    pop     dx
    pop     cx
    pop     bx
    pop     ax
ret

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

printTest:
    push bx
    push cx
    push dx
    mov     ah,0eh
    ;mov     bl,0
    mov     cx,1
    
    ;add     al,'0'
    int     10h

    pop dx
    pop cx
    pop bx
ret
; ;============== TEST ===================================
;     push    ax
;     push    bx
;     push    cx    
;     push    dx

;     mov     ax,0
;     mov     al,[si]
;     call    printTest

;     pop     dx
;     pop     cx
;     pop     bx
;     pop     ax
; ;=======================================================



end main
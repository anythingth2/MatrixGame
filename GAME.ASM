    .model  tiny
    ; .stack  0100h

    .data
logging         db  ?
seed            dw  13

character       db  ?

matrixColorCode db  0fh,0ah,0ah,02h,02h,00h,00h,00h
matrixLength    db  7

WINDOW_TOP      db  0
WINDOW_LEFT     db  20
WINDOW_RIGHT    db  50
WINDOW_BOTTOM   db  20

printFlowMatrix_X   db  ?
printFlowMatrix_Y   db  ?


START_MATRIX_Y  db  -150

matrixY         db  80 dup(?)

i               db  0h

xPos            db  0h

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
    call    displayShip


initMatrix:                             ;initilize matrix line
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
    
    pop     cx
    jmp     Exit_If_MatrixEnded
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
    mov     di,0

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

Exit:
    pop     si
    pop     dx
    pop     cx
    pop     bx
    pop     ax
ret


end main
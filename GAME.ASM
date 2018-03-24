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


START_MATRIX_Y  db  -30

matrixY         db  80 dup(?)

i               db  0h

letter          db  'opopopopopopopooop$'
    .code 
    org     0100h

main:

    mov     bx,offset letter
    mov     ch,02h
    call    printStringAt
    ret
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

    call    updateMatrix                ;update matrix function

    call    sleep                       ;delaying


    jmp     Game_loop
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
    mov     printFlowMatrix_Y,cl
    mov     ch,i
    mov     printFlowMatrix_X,ch
    call    printFlowMatrix
    
;END_LOOP_BODY

    mov     si,offset i
    add     [si],1
    jmp     loop_updateMatrix
End_loop_updateMatrix:
    pop     si
    pop     cx
    ret
    
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

logging_number:
    push    ax
    
    mov     ah,0eh
    mov     al,logging
    add     al,'0'
    int     10h
    
    pop     ax
    
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


    pop     cx
    pop     ax

    ret

printCharAt:                            ;print character at position (dh = row,dl = column)
                                            ;color ( bh = color code)
                                            ;chacracter (bl = ascii)

    push    ax
    push    cx
                                    
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


    pop     cx
    pop     ax

    ret
printStringAt:                              ;print String at position (dh = row)
                                            ;bx = String
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
    mov     cx,0ffffh
loop_sleep:
    nop                                     ;do nothing
    nop     
    nop
    loop    loop_sleep                      ;loop until cx is zero
    pop     cx
    ret

exit:
    ret


end main
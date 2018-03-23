    .model  tiny
    ; .stack  0100h

    .data
logging     db  ?
seed        dw  13

character   db  ?
    .code 
    org     0100h

main:
    mov     cx,20

startLoop:
    mov     logging,dl
    call    logging_number
    loop    startLoop
    
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
printRandomCharAt:                ;print random character at position (dh = row,dl = column)
                            ;with color ( bl = color code)
    ; call    test_print
    push    ax
    push    cx

    mov     ah,02h                          
    mov     bh,0h                           ;move cursor
    int     10h                             ;call move cursor interrupt                                     

    mov     dh,33
    mov     dl,126
    call    random_number                   ;random character decimal number


    mov     ah,09h                          ;print character
    mov     al,character                           ;store character
    mov     bh,0h                         
    mov     cx,1h
    int     10h                             ;call print character interrupt

    pop     cx
    pop     ax

    ret

sleep:
    push    cx
    mov     cx,0ffffh
loop_sleep:
    nop                                     ;do nothing
    loop    loop_sleep                 ;loop until cx is zero
    pop     cx
    ret

exit:
    ret


end main
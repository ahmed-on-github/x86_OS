puts:
    pusha
    cld     ;; clear direction flag for for auto increment of si (std will auto decrement si)

puts_loop:
    lodsb          ;; Copies memory byte [DS:SI] to AL and increments SI
    cmp al, 0
    je puts_done
    

    mov ah, 0x0e    ;; BIOS teletype output mode 
    mov bh, 0       ;; Select display page 0
    int 0x10
    jmp puts_loop   ;; Loop back for next character

puts_done: 
    popa
    ret 

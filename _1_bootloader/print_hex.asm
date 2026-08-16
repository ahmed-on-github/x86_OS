;; print hex value function
;; '0-9' : 0x30-0x39
;; 'A-F' : 0x41-46
;; 'a-f' : 0x61-66
;; Input passed via bx, Ex: bx= 0x89ab

include 'print_str.asm'
nop

print_hex: 
	pusha 			;; Push all registers
	xor cx, cx 		;; reset cx loop counter/string offset
	add cx, 5		;; start offset cx


	
	mov dx, bx ;; save value of bx in dx
print_hex_loop:

	xor ax, ax
	add ax , 0x0F 	;; Least significant nibble mask 
	
	cmp cx, 1	  	;; Stopping condition
	jle print_result	
	
	and bx, ax 		;; bx & 0x000F ==> Least significant nibble (0-15/F)
	add bx, 0x30	;; Convert digit to its ascii
	
	mov ah, bl		;; Save digit into ah as bx will be overwritten 

	cmp bx, 0x39	;; Ascii of '9'
	jle store_byte	;; If less than or equal, then it's a decimal value digit
	 	


hex_nibble:
	add ah, 7 		;; A->F (0x41->0x46): Add difference between 0x41 and 0x39 = 7 to the saved value in ah

store_byte:
	mov bx , result_str
	add bx, cx		;; Array/string offset index
	mov [bx], ah	;; Send the ascii value in ah to address/location pointed to by bx

		
	dec cx			;; Decrement dx for next iteration
	ror dx, 4		;; get next significant nibble
	mov bx, dx		;; restore vaue for bx again for next iteration
	jmp print_hex_loop
	
print_result:
	mov si, result_str
	call puts
print_hex_ret:
	popa
	ret
	
result_str: db '0x0000', 0x00



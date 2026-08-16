;;
;; File: bootloader.asm
;; Built as: 
;;    $ fasm bootloader.asm -o bootloader_mbr.bin
;;

org 0x7c00
use16

;; set up ES:BX (segment:offset) to load sector 2 binary into memory at address ES:BX = 0x1000:0x00
	mov bx, 0x1000 ;; segment registers are not writable with literal values
	mov es, bx
	mov bx, 0x00
 
;; set up disk IO interrupt (INT 13h) parameters
	mov dh, 0x00   ;; Head no 0
	mov dl, 0x00   ;; Drive 0 (1st floppy disk) 
	mov ch, 0x00   ;; Cylinder 0
	mov cl, 0x02   ;; Starting sector no. 2 (having assembled code of nano_kernel.asm)

disk_read:
	mov ah, 0x02   ;; Read from disk via int 13h/ah=2
	mov al, 0x01   ;; Number of sectors to read from disk
	int 13h

	jc disk_read   ;; Jump if carry: retry on error(s), indicated by carry flag = 1

;; Set segment registers for the kernel code we will jump to
	mov ax, 0x1000 
	mov ds, ax 	   ;; same as code segment (cs) and any string address (offset) will be inside ds
	mov es, ax 
	mov ss, ax

	;;mov sp, 0xfffe

	jmp 0x1000:0x00

times 510-($-$$) db 0
dw 0xAA55




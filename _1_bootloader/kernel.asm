;; 
;; Filename: kernel.asm
;;  In 8086 16-bit real mode, the 20-bit physical memory address is calculated using segment shifting
;; Referencing a memory location: 
;; segment:[base + index * scale + displacement]
;; All fields are optional:
;; segment: CS, DS, ES, FS, GS, SS (DS if unspecified, except if BP is used as a base, defaults to SS)
;; base: 
;;        (16 bits) BP/BX
;;         (32/64 bits) any general purpose register
;;  index:
;;         (16 bits) SI/DI
;;         (32/64 bits) any general purpose register
;;  scale: (32/64 bits only) 1, 2, 4 or 8
;;  displacement: a (signed) constant value
;;
;; physical address = (segment base address x 16) + effective address 

;; Makefile:
;; ASM = nasm

;; SRC_DIR = src
;; BUILD_DIR = build

;; $(BUILD_DIR)/main_floppy.img: $(BUILD_DIR)/main.bin
;;	cp $(BUILD_DIR)/main.bin $(BUILD_DIR)/main_floppy.img
;;	truncate -s 1440k $(BUILD_DIR)/main_floppy.img

;; $(BUILD_DIR)/main.bin: $(SRC_DIR)/main.asm
;;	$(ASM) $(SRC_DIR)/main.asm -f bin -o $(BUILD_DIR)/main.bin




;; %define ENDL 0x0D, 0x0A ;; ENDL equ 0x0D, 0x0A fasm syntax,replaces %define ENDL of nasm


ENDL equ 0x0D, 0x0A
VERSION equ 0x01

use16              ;; As CPU starts in 16-bit real mode, use ‘bits 16’ for nasm assembler

jmp main_local

;;include 'print_str.asm'
include 'print_hex.asm'
nop ;; separate incuded code with and next code with nop

main_local: 
    ;; Setup segment registers using AX (cannot load immediate values directly)
    ;; Already done by the bootloader
    ;;mov ax, 0    
    ;;mov ds, ax 
    ;;mov es, ax

    ;; Setup stack segment
    ;; mov ss, ax


     
    mov sp, 0x7c00

    mov si, hello_str
    call puts
    
	mov si, version_str
    call puts
    
	mov bx, VERSION
	call print_hex
	
    hlt 
    jmp $

  
hello_str: 		db "Hello world :)", ENDL, 0x00
version_str: 	db "Kernel version: ", 0x00
version: 		dw 0x0001 

times 512-($-$$) db 0x00






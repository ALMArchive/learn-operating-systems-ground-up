[bits 16]
[org 0x7c00]

boot:
  ; A20 Lines
  mov ax, 0x2401
  int 0x15

  ; VGA text mode 3
  mov ax, 0x3
  int 0x10

  mov [disk], dl

  mov ah, 0x2
  mov al, 6
  mov ch, 0
  mov dh, 0
  mov cl, 2
  mov dl, [disk]
  mov bx, copy_target
  int 0x13

  cli
  lgdt [gdt_pointer]
  mov eax, cr0
  or eax, 0x1
  mov cr0, eax
  mov ax, DATA_SEG
  mov ds, ax
  mov es, ax
  mov fs, ax
  mov gs, ax
  mov ss, ax
  jmp CODE_SEG:boot2
gdt_start:
  dq 0x0
gdt_code:
  dw 0xFFFF
  dw 0x0
  db 0x0
  db 10011010b
  db 11001111b
  db 0x0
gdt_data:
  dw 0xFFFF
  dw 0x0
  db 0x0
  db 10010010b
  db 11001111b
  db 0x0
gdt_end:
gdt_pointer:
  dw gdt_end - gdt_start
  dd gdt_start

disk:
  db 0x0

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start

times 510 - ($-$$) db 0
dw 0xaa55

copy_target:
[bits 32]
hello: db "Hello more than 512 bytes world!!",0
boot2:
  mov esi, hello
  mov ebx, 0xb8000
.loop:
  lodsb
  or al, al
  jz halt
  or eax, 0x0100
  mov word [ebx], ax
  add ebx,2
  jmp .loop
halt:
  cli
  hlt

section .bss
align 4
kernel_stack_bottom: equ $
  resb 16384 ; 16 KB
kernel_stack_top:

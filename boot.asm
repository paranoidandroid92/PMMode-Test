[BITS 16]

mov ax,0x07c0
mov ds,ax

cli
lgdt[gdtr]
mov eax,cr0
or al,1
mov cr0,eax

jmp 08h:(PMMode + 0x7c00)

end:
	sti
	hlt;
	jmp end;


PMMode:
	hlt

gdt_start:
null_seg dd 0
		 dd 0
code_seg_desc dw 0xFFFF		;SEG LIMIT 15:00
			  dw 0x0000		;BASE 15:00
			  db 0x00		;BASE 23:16 
			  db 0x9A		;FLAGS
			  db 0xCF
			  db 0x00		;BASE 31:24
data_seg_desc dw 0xFFFF		;SEG LIMIT 15:00
			  dw 0x0000		;BASE 15:00
			  db 0x00		;BASE 23:16 
			  db 0x94		;FLAGS
			  db 0xCF
			  db 0x00		;BASE 31:24
gdt_end:

gdtr dw gdt_end - gdt_start - 1
	 dw gdt_start + 0x7c00

times 510-($-$$) db 0
db 0x55
db 0xAA


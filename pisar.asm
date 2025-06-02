.8086
.model small
.stack 100h
.data
	cartel1		db "Ingresar texto:",0dh,0ah,24h
	cartel2		db "Ingresar char a eliminar:",0dh,0ah,24h
	texto 		db 255 dup (24h),0dh,0ah,24h
	auxtexto 	db 255 dup (24h),0dh,0ah,24h
	espacio 	db "",0dh,0ah,24h
.code
	main proc

	mov ax,@data
	mov ds,ax

	mov ah,9
	mov dx,offset cartel1
	int 21h

carga:
	mov ah,1
	int 21h

	cmp al,0dh
	je fincarga

	mov texto[bx],al 
	inc bx
jmp carga

fincarga:
	mov ah,9
	mov dx,offset texto
	int 21h

slcchar:

	mov ah,9
	mov dx,offset espacio
	int 21h

	mov ah,9
	mov dx,offset cartel2
	int 21h	

;---carga delchar en dl
	mov ah,1
	int 21h

	mov dl,al


mov bx,0 
mov si,0

pisar:
	cmp texto[bx],0dh
	je fin

	cmp texto[bx],dl
	je sinchar
	mov al,texto[bx]
	mov auxtexto[si],al
	inc bx
	inc si
jmp pisar

sinchar:
	inc bx
jmp pisar

fin:
	
	mov ah,9
	mov dx,offset espacio
	int 21h

	mov ah,9
	mov dx,offset auxtexto
	int 21h

	mov ah,4ch
	int 21h

	main endp
end
.8086
.model small
.stack 100h
.data
.code
;---DECLARO LIBRERIA EXTERNA
	extrn men:proc

	main proc

	mov ax,@data
	mov ds,ax

	call men

	mov ah,4ch
	int 21h

	main endp
end
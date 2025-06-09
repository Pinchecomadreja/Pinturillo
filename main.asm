.8086
.model small
.stack 100h
.data
	input 	db 24h,0dh,0ah,24h
	salida 	db "HAS SALIDO DEL JUEGO",0dh,0ah,24h
.code
;---DECLARO LIBRERIA EXTERNA
	extrn men:proc
	extrn cls:proc

	main proc

	mov ax,@data
	mov ds,ax

	call cls

	mov dx,offset input
	push dx
	call men

	lea bx,input

	opciones:
		cmp byte ptr[bx],'1'
		je sigue

		cmp byte ptr[bx],'2'
		je salir

	

	sigue:
	;prueba de redireccion
		mov ah,2
		mov dl,24h
		int 21h



	salir:
		
		mov dx,offset salida	
		call print

		mov ah,4ch
		int 21h
		
	main endp
;---------------------------
	print proc
	push ax

	mov ah,9
	int 21h

	pop ax
	ret
	print endp

end
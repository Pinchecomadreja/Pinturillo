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
	extrn print:proc
	extrn pincel:proc

	main proc

	mov ax,@data
	mov ds,ax

	call cls

	mov dx,offset input
	push dx
	call men

	lea bx,input
	call cls

	opciones:
		cmp byte ptr[bx],'1'
		je op1

		cmp byte ptr[bx],'2'
		je fin

	op1:
	;prueba de redireccion
		call pincel

	fin:

		mov ah,9
		mov dx, offset salida
		int 21h
		
		mov ah,4ch
		int 21h

	main endp

end
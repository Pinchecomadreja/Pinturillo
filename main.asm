.8086
.model small
.stack 100h
.data
	input 	db 24h,0dh,0ah,24h
	salida 	db "HAS SALIDO DEL JUEGO",0dh,0ah,24h
.code
;---DECLARO LIBRERIA EXTERNA
	extrn DelayTicks:proc
	extrn carteles:proc
						;RECIBE EN AL NRO DE CARTEL A MOSTRAR
						;IMPRIME CARTEL
	extrn leertxt:proc
						;RECIBE EN AL NRO DE PALABRA A BUSCAR
						;LEE ARCHIVO DE DIC.TXT
						;IMPRIME PALABRA EN INDEX[NRO]
	extrn men:proc
						;RECIBE INPUT POR STACK
						;IMPRIME MENU
						;INTERACCION INTERNA EN AL
						;1.CONTINUAR (SI)
						;2.SALIR (NO)
	extrn cls:proc
						;LIMPIA LA PANTALLA
	extrn print:proc
						;IMPRIME VARS
	extrn pincel:proc
						;IMPRIME ESPECIAL VARS

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
	;MUESTRA CARTEL PLAYER1
		xor ax,ax

		;IMPRIME CARTEL PLAYER1
		mov al,'1'
		call carteles

		mov cx,0B4h
		call DelayTicks

		xor ax,ax
		;PUT TIMER 5 SEG
		call pincel

		;IMPRIME CARTEL PLAYER1
		;mov al,'2'
		;call carteles

	
	fin:
		call cls
		mov ah,9
		mov dx, offset salida
		int 21h
		
		mov ah,4ch
		int 21h

	main endp

end
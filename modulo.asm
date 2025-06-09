.8086
.model small
.stack 100h
.data
	linea	db 77 dup(0cdh),24h
	menu	db 	"					MENU            		      ",24h
	espacio	db	"",0dh,0ah,24h
	ln1		db "	1. JUGADOR1 PINTARA                               		      ",24h
	ln2		db "	2. JUGADOR2 DEBERA ADIVINAR LA PALABRA            		      ",24h
	ln3		db "	3. TENDRA 60 SEGUNDOS POR RONDAS				      ",24h
	ln4		db "	4. GANA EL JUGADOR CON MAS RONDAS CORRECTAS      	              ",24h
	ln5		db "	5. RONDAS AL MEJOR DE 3                                               ",24h
	incio	db "		           CONFIRMAR INICIO:            		      ",24h
	yes		db "	1. SI                                           		      ",0dh,0ah,24h
	no		db "	2. NO                                           		      ",0dh,0ah,24h

.code
;---DECLARO MODULO

	public cls
			  ; Función limpiar la pantalla como el CLS desde el prompt del DOS
			  ; Llama al puerto de pantalla
			  ; Carga offset de 0dh en CX y lo imprime en pantalla
	public men
			  ;recibe en ss:[bp+4]-> offset input
			  ;Imprime el menu con las reglas
			  ;Imprime cartel de confirmacion de inico
			  ;Llama a int 21h-01h tomar input
			  ;input en al-->bx offset input
			  ;toma en dl opcion elegida:
			  ;							mov dl,1 ->YES
			  ;							mov dl,2 ->NO
			  ;Devuelve en dl respuesta


	cls proc ; 
		push ax
		push es
		push cx
		push di
		
		mov ax,3
		int 10h
		
		mov ax,0b800h
		mov es,ax

		mov cx,1000
		mov ax,7
		mov di,ax
		cld							; Setea el DF a 0, interpreta strings hacia arriba
		rep stosw					; 
		pop di
		pop cx
		pop es
		pop ax
		ret 
	cls endp

;---MODULO MENU---
	men proc 
				;-Registros que se tocan

		push bp
		mov bp,sp 

		push ax						
		push bx						
		push dx

		mov bx,ss:[bp+4];offset input

	;**************************
	;*	       MENU           *
	;**************************

	;---TOP LEFT
		mov dl,0c9h

		mov ah,6
		int 21h

	;---MEDIO

		mov ah,9
		mov dx,offset linea
		int 21h

	;---TOP RIGHT
		mov dl,0bbh

		mov ah,6
		int 21h

	;---ENTER
		xor dx,dx

		mov ah,9
		mov dx,offset espacio
		int 21h

	;---LAT IZQ
		xor dx,dx

		mov dl,0bah
		mov ah,2
		int 21h

	;---MENU
		xor dx,dx

		mov ah,9
		mov dx,offset menu
		int 21h

	;---LAT DER
		xor dx,dx

		mov dl,0bah
		mov ah,2
		int 21h

	;---ENTER
		xor dx,dx

		mov ah,9
		mov dx,offset espacio
		int 21h

	;---BOTM LEF
		xor dx,dx
		mov dl,0c8h

		mov ah,6
		int 21h

	;---MEDIO

		mov ah,9
		mov dx,offset linea
		int 21h	
		
	;---BOTM RIGHT
		xor dx,dx
		mov dl,0bch

		mov ah,6
		int 21h
	;---ENTER
		xor dx,dx

		mov ah,9
		mov dx,offset espacio
		int 21h


	;**************************
	;*	       LINEA 1        *
	;**************************

	;---TOP LEFT
		mov dl,0c9h

		mov ah,6
		int 21h

	;---MEDIO

		mov ah,9
		mov dx,offset linea
		int 21h

	;---TOP RIGHT
		mov dl,0bbh

		mov ah,6
		int 21h

	;---ENTER
		xor dx,dx

		mov ah,9
		mov dx,offset espacio
		int 21h

	;---LAT IZQ
		xor dx,dx

		mov dl,0bah
		mov ah,2
		int 21h
	;---texto
		xor dx,dx

		mov ah,9
		mov dx,offset ln1
		int 21h
	;---LAT DER
		xor dx,dx

		mov dl,0bah
		mov ah,2
		int 21h

	;---ENTER
		xor dx,dx

		mov ah,9
		mov dx,offset espacio
		int 21h

	;**************************
	;*	       LINEA 2       *
	;**************************

	;---LAT IZQ
		xor dx,dx

		mov dl,0bah
		mov ah,2
		int 21h
	;---texto
		xor dx,dx

		mov ah,9
		mov dx,offset ln2
		int 21h
	;---LAT DER
		xor dx,dx

		mov dl,0bah
		mov ah,2
		int 21h

	;---ENTER
		xor dx,dx

		mov ah,9
		mov dx,offset espacio
		int 21h

	;**************************
	;*	       LINEA 3       *
	;**************************

	;---LAT IZQ
		xor dx,dx

		mov dl,0bah
		mov ah,2
		int 21h
	;---texto
		xor dx,dx

		mov ah,9
		mov dx,offset ln3
		int 21h
	;---LAT DER
		xor dx,dx

		mov dl,0bah
		mov ah,2
		int 21h

	;---ENTER
		xor dx,dx

		mov ah,9
		mov dx,offset espacio
		int 21h

	;**************************
	;*	       LINEA 4        *
	;**************************

	;---LAT IZQ
		xor dx,dx

		mov dl,0bah
		mov ah,2
		int 21h
	;---texto
		xor dx,dx

		mov ah,9
		mov dx,offset ln4
		int 21h
	;---LAT DER
		xor dx,dx

		mov dl,0bah
		mov ah,2
		int 21h

	;---ENTER
		xor dx,dx

		mov ah,9
		mov dx,offset espacio
		int 21h

	;**************************
	;*	       LINEA 5        *
	;**************************

	;---LAT IZQ
		xor dx,dx

		mov dl,0bah
		mov ah,2
		int 21h
	;---texto
		xor dx,dx

		mov ah,9
		mov dx,offset ln5
		int 21h
	;---LAT DER
		xor dx,dx

		mov dl,0bah
		mov ah,2
		int 21h

	;---ENTER
		xor dx,dx

		mov ah,9
		mov dx,offset espacio
		int 21h
		
	;---ENTER
		xor dx,dx

		mov ah,9
		mov dx,offset espacio
		int 21h

;----CONFIRMACION DE INCIO

	;---PREGUNTA DE CONFIRMACION
		xor dx,dx

		mov ah,9
		mov dx,offset incio
		int 21h

	;---ENTER
		xor dx,dx

		mov ah,9
		mov dx,offset espacio
		int 21h

	;---1.YES
		xor dx,dx

		mov ah,9
		mov dx,offset yes
		int 21h

	;---2.NO
		xor dx,dx

		mov ah,9
		mov dx,offset no
		int 21h

	;CIERRE CAJA
	;---BOTM LEF
		xor dx,dx
		mov dl,0c8h

		mov ah,6
		int 21h

	;---MEDIO

		mov ah,9
		mov dx,offset linea
		int 21h	
		
	;---BOTM RIGHT
		xor dx,dx
		mov dl,0bch

		mov ah,6
		int 21h
	;--CARGA OPCION DE INICIO
	
	opciones:
		mov ah,1
		int 21h

		cmp al,0dh
		je finmenu

		mov [bx],al ;al->input[BX]

	jmp opciones

	finmenu:
	;-Registros que se tocan
		pop ax
		pop bx
		pop dx

		pop bp
	ret 2
	men endp
end
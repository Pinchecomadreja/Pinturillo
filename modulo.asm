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
	
.code
;---DECLARO MODULO
	public men

	men proc 
		mov ax,@data
		mov ds,ax

		xor dx,dx

	;-----------MENU-------
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
	;-----------MENU-------
	;----------------------

	;-----------L1---------
	;----------------------

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

	;-----------L2---------
	;----------------------

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

	;-----------L3---------
	;----------------------

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

	;-----------L4---------
	;----------------------

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

	;-----------L5---------
	;----------------------

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


		mov ah,4ch
		int 21h

	men endp
end
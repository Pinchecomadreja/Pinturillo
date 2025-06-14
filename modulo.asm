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
	yes		db "	1. SI                                           		      ",24h
	no		db "	2. NO                                           		      ",24h
;-------------------------------------------------------------------------------------------
;MODULO PINCEL VARS
;-------------------------------------------------------------------------------------------
   botones dw 00
   botonesT db "00000",24h
   posX     db "00000", 24h
   posY     db "00000", 24h
   antX     dw 0
   antY     dw 0
   ButtonL  db "Left        ",24h
   ButtonR  db "Right       ",24h
   ButtonN  db "Sin Botones ",24h
   maxMC    dw 639
   maxML    dw 199
   maxPC    dw 80
   maxPL    dw 25
.code
;---DECLARO MODULO
	public pincel
	public printspecial
			  ;recibe en dx offset imprimir
			  ;imprime ese valor como ascii especial
			  ;ej: 24h->"$" o 5C->"\"
	public print
			  ;recibe en dx offset imprimir
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
	;public ply1cartel
			  ; Imprime cartel que solo puede ver el player 1


	print proc
		push ax

		mov ah,9
		int 21h

		pop ax
		ret
	print endp


	printspecial proc
		push ax

		mov ah,6
		int 21h

		pop ax
		ret
	printspecial endp


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
		call printspecial

	;---MEDIO
		mov dx,offset linea
		call print

	;---TOP RIGHT
		mov dl,0bbh
		call printspecial

	;---ENTER
		mov dx,offset espacio
		call print 

	;---LAT IZQ
		mov dl,0bah
		call printspecial

	;---MENU
		mov dx,offset menu
		call print

	;---LAT DER
		mov dl,0bah
		call printspecial

	;---ENTER
		mov dx,offset espacio
		call print

	;---BOTM LEF
		mov dl,0c8h
		call printspecial

	;---MEDIO
		mov dx,offset linea
		call print
		
	;---BOTM RIGHT
		mov dl,0bch
		call printspecial

	;---ENTER
		mov dx,offset espacio
		call print


	;**************************
	;*	       LINEA 1        *
	;**************************

	;---TOP LEFT
		mov dl,0c9h
		call printspecial

	;---MEDIO
		mov dx,offset linea
		call print

	;---TOP RIGHT
		mov dl,0bbh
		call printspecial

	;---ENTER
		mov dx,offset espacio
		call print

	;---LAT IZQ
		mov dl,0bah
		call printspecial

	;---texto
		mov dx,offset ln1
		call print

	;---LAT DER
		mov dl,0bah
		call printspecial

	;---ENTER
		mov dx,offset espacio
		call print

	;**************************
	;*	       LINEA 2       *
	;**************************

	;---LAT IZQ
		mov dl,0bah
		call printspecial
	
	;---texto
		mov dx,offset ln2
		call print

	;---LAT DER
		mov dl,0bah
		call printspecial

	;---ENTER
		mov dx,offset espacio
		call print

	;**************************
	;*	       LINEA 3       *
	;**************************

	;---LAT IZQ
		mov dl,0bah
		call printspecial

	;---texto
		mov dx,offset ln3
		call print

	;---LAT DER
		mov dl,0bah
		call printspecial

	;---ENTER
		mov dx,offset espacio
		call print

	;**************************
	;*	       LINEA 4        *
	;**************************

	;---LAT IZQ
		mov dl,0bah
		call printspecial

	;---texto
		mov dx,offset ln4
		call print

	;---LAT DER
		mov dl,0bah
		call printspecial

	;---ENTER
		mov dx,offset espacio
		call print

	;**************************
	;*	       LINEA 5        *
	;**************************

	;---LAT IZQ
		mov dl,0bah
		call printspecial

	;---texto
		mov dx,offset ln5
		call print

	;---LAT DER
		mov dl,0bah
		call printspecial

	;---ENTER
		mov dx,offset espacio
		call print

	;---IZQ SPLIT
		mov dl,0cch
		call printspecial

	;---MEDIO
		mov dx,offset linea
		call print

	;---DER SPLIT
		mov dl,0B9H
		call printspecial
		
	;---ENTER
		mov dx,offset espacio
		call print
	
	;---IZQ SPLIT
		mov dl,0cch
		call printspecial

	;---MEDIO
		mov dx,offset linea
		call print

	;---DER SPLIT
		mov dl,0B9H
		call printspecial

	;---ENTER
		mov dx,offset espacio
		call print

;----CONFIRMACION DE INCIO

	;---LAT IZQ
		mov dl,0bah
		call printspecial

	;---PREGUNTA DE CONFIRMACION
		mov dx,offset incio
		call print

	;---LAT DER
		mov dl,0bah
		call printspecial

	;---ENTER
		mov dx,offset espacio
		call print

	;---LAT IZQ
		mov dl,0bah
		call printspecial

	;---1.YES
		mov dx,offset yes
		call print

	;---LAT DER
		mov dl,0bah
		call printspecial

	;---ENTER
		mov dx,offset espacio
		call print

	;---LAT IZQ
		mov dl,0bah
		call printspecial

	;---2.NO
		mov dx,offset no
		call print

	;---LAT DER
		mov dl,0bah
		call printspecial

	;---ENTER
		mov dx,offset espacio
		call print

	;CIERRE CAJA

	;---BOTM LEF
		mov dl,0c8h
		call printspecial

	;---MEDIO
		mov dx,offset linea
		call print

	;---BOTM RIGHT
		mov dl,0bch
		call printspecial

	;---ENTER
		mov dx,offset espacio
		call print

	;**************************
	;* CARGA OPCION DE INICIO *
	;**************************
	
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

	;**************************
	;*         PINCEL         *
	;**************************
	     pincel proc

	        mov ah, 0
	        mov al, 03h 
	        ;mov al, 12h ;ESTABA 03h 80x25 16 colores TEXTO
	        int 10h

	        mov ax, 1
	        int 33h

	        cmp ax, 0
	        je fin2

	      jmp arriba2
	fin2: jmp fin

	arriba2:  mov botones,bx
	arriba: 

	         in al, 60h
	         cmp al, 1
	         je fin2
	         
	         mov ax, 3
	         int 33h
	         push cx
	         push dx

	         cmp bx, 0
	         je nada
	         cmp bx, 1
	         je left
	         
	         push si
	         push dx
	         push bx
	         mov si, offset ButtonR
	         mov dl, 1
	         mov dh, 22
	         mov bl, 15 
	         call imprimirVideo

	         mov cx, antY
	         mov bx, antX
	         call posicionM
	         mov bl, 0
	         mov al, " "
	         call imprimirCaracter 
	         ;RECIBE EN AL el CARACTER a IMPRIMIR en DH y DL donde debe imprimir
	         ;EN BL el color


	         pop bx
	         pop dx
	         pop si
	         jmp cont
	nada: 
	         push si
	         push dx
	         push bx
	         mov si, offset ButtonN
	         mov dl, 1
	         mov dh, 22
	         mov bl, 15 
	         call imprimirVideo

	         pop bx
	         pop dx
	         pop si
	         jmp cont
	left:
	         push si
	         push dx
	         push bx
	         mov si, offset ButtonL
	         mov dl, 1
	         mov dh, 22
	         mov bl, 15 
	         call imprimirVideo

	         pop bx
	         pop dx
	         pop si

	         mov cx, antY
	         mov bx, antX
	         call posicionM
	         mov bl, 19
	         mov al, 219
	         call imprimirCaracter 
	         ;RECIBE EN AL el CARACTER a IMPRIMIR en DH y DL donde debe imprimir
	         ;EN BL el color




	cont:         
	      pop cx
	      cmp cx, antX
	      je otro
	         mov antX, cx
	         xor ax, ax


	         mov si, offset posX
	         call regToAscii16

	         push si
	         push dx
	         push bx
	         mov si, offset posX
	         mov dl, 1
	         mov dh, 23
	         mov bl, 10 
	         call imprimirVideo

	         pop bx
	         pop dx
	         pop si

	otro:    
	         pop dx
	         cmp dx, antY
	         je esto
	         jmp sige
	esto: jmp arriba

	sige:    
	         mov anty, dx
	         mov cx, dx
	         mov si, offset posY
	         call regToAscii16

	         push si
	         push dx
	         push bx
	         mov si, offset posY
	         mov dl, 1
	         mov dh, 24
	         mov bl, 10 
	         call imprimirVideo

	         pop bx
	         pop dx
	         pop si

	      jmp arriba


	fin: 
		ret
	    pincel endp

	imprimirVideo proc
	;RECIBE EN si el offset de la variable a imprimir y en DH y DL donde debe imprimir
	;EN BL el color

	;POSICION
	;AH = 02H
	;BH = Página de vídeo
	;DH = Línea donde situar el cursor
	;DL = Columna donde situar el cursor

	OtroCaracter:
	   cmp byte ptr [si], 24h
	   je termineImprimir
	   mov ah, 2
	   mov bh, 0
	   int 10h

	;IMPRESION
	;AH = 09H
	;AL = Código del carácter a escribir.
	;BH = Página de vídeo donde escribir el carácter.
	;BL = Atributo ó color que va a tener el carácter.
	;CX = Cantidad de veces que se debe escribir el carácter, uno a continuación de otro.

	  mov ah, 9
	  mov al, [si]
	  mov cx, 1
	  int 10h
	  inc dl
	  inc si
	  jmp OtroCaracter

	termineImprimir:
	   ret

	imprimirVideo endp


	imprimirCaracter proc
	;RECIBE EN AL el CARACTER a IMPRIMIR en DH y DL donde debe imprimir
	;EN BL el color

	;POSICION
	;AH = 02H
	;BH = Página de vídeo
	;DH = Línea donde situar el cursor
	;DL = Columna donde situar el cursor

	   mov ah, 2
	   mov bh, 0
	   int 10h

	;IMPRESION
	;AH = 09H
	;AL = Código del carácter a escribir.
	;BH = Página de vídeo donde escribir el carácter.
	;BL = Atributo ó color que va a tener el carácter.
	;CX = Cantidad de veces que se debe escribir el carácter, uno a continuación de otro.

	  mov ah, 9
	  mov cx, 1
	  int 10h


	   ret

	imprimirCaracter endp

	regToAscii16 proc
	   ;Recibe en CX un nro de 16 bits, lo guarda en una variable que viene por SI
	   push ax
	   push dx
	   push cx

	         xor ax, ax
	         xor dx, dx

	         mov ax, cx ; GUARDO EL NRO

	         mov cx, 10000
	         div cx ; AHORA QUE DIVIDÍ EN AH TENGO EL RESTO Y EN AL EL RESULTADO
	         add ax, 30h ; SUMO 30 h para convertir el nro en caracter ascii
	         mov byte ptr [si], al; guardo el caracter en la posición mas significativa de la variable nro
	        
	         
	         mov ax, dx ; GUARDO EL NUEVO VALOR A DIVIDIR EN AL
	         xor dx, dx ; LIMPIO AH (para que no me haga lio con la división)
	         mov cx, 1000 ; guardo el valor por el que voy a dividir en cl
	         div cx     ; VUELVO A DIVIDIR
	         add ax, 30h
	         mov byte ptr [si+1], al
	         

	         mov ax, dx ; GUARDO EL NUEVO VALOR A DIVIDIR EN AL
	         xor dx, dx ; LIMPIO AH (para que no me haga lio con la división)
	         mov cx, 100 ; guardo el valor por el que voy a dividir en cl
	         div cx     ; VUELVO A DIVIDIR
	         add ax, 30h
	         mov byte ptr [si+2], al
	         
	         mov ax, dx ; GUARDO EL NUEVO VALOR A DIVIDIR EN AL
	         xor dx, dx ; LIMPIO AH (para que no me haga lio con la división)
	         mov cx, 10 ; guardo el valor por el que voy a dividir en cl
	         div cx     ; VUELVO A DIVIDIR
	         add ax, 30h
	         mov byte ptr [si+3], al
	         

	         add dx, 30h
	         mov byte ptr [si+4] ,dl  
	        
	   pop cx
	   pop dx
	   pop ax
	ret

	regToAscii16 endp

	posicionM proc
	   ;este programa recibe en CX columna y en BX fila de la posición del mouse en pantalla
	   ; devuelve en DX LA POSICIÓN de la pantalla DONDE estaría

	   push bx
	   push ax
	   

	   mov ax, maxPC
	   mul cx
	   div maxMC
	   xor dx,dx
	   mov cl, al

	   mov ax, maxPL
	   mul BX
	   div maxML
	   xor dx,dx
	   mov dh, al
	   mov dl, cl

	   pop ax
	   pop bx 
	 ret
	posicionM endp

end
.8086
.model small
.stack 100h

.data
    input       db 24h,0dh,0ah,24h
    salida      db "HAS SALIDO DEL JUEGO",0dh,0ah,24h
    tiempo_mostrar dw 182    ; ≈3 segundos
    tiempo_dibujo dw 182     ; ≈10 segundos
    tiempo_adivinar dw 300   ; ≈5 segundos
    mensaje_tiempo db "TIEMPO RESTANTE: ", 24h
    input_adivinar db 20 dup(0)
    presione_enter db 0dh,0ah,"Presione ENTER para continuar...",24h
    instruccion db "Dibuja lo que viste!", 0dh, 0ah, 24h
    correcto db "Correcto pibeeeeeeeeeeeeee!$"
    incorrecto db "INCORRECTO!, no era tan dificil che ...$"
    sin_intentos db "SE TE ACABARON LOS INTENTOS, vuelve a intentarlo :($"
    mensaje_prediccion db 0dh, 0ah, "Escriba su prediccion: ", 24h
    intento1 db "1er intento: $"
    intento2 db "2do intento: $"
    intento3 db "3er intento: $"
    opciones_correcto db 0dh,0ah,"1. Salir",0dh,0ah,"2. Volver al menu",0dh,0ah,"Seleccione opcion: $"
    opciones_incorrecto db 0dh,0ah,"1. Salir",0dh,0ah,"2. Volver al menu",0dh,0ah,"Seleccione opcion: $"

    ; Variables para animales aleatorios
    filename_animales db "animales.txt",0
    handle_animales   dw 0
    buffer_animales   db 512 dup(0)
    animal_numero     db 0
    animal_actual     db 20 dup('$')
    animales_count    db 0
    intentos_restantes db 3  ; cuenta los intentos

.code
    extrn carteles:proc, leertxt:proc, men:proc, cls:proc
    extrn print:proc, pincel:proc, delayTicks:proc, semilla:proc

main proc
    mov ax, @data
    mov ds, ax

    ; Cargar animales
    call CargarAnimales
    
    call cls

    ; Mostrar menú principal
    mov dx, offset input
    push dx
    call men

    lea bx, input
    call cls

    opciones:
        cmp byte ptr[bx], '1'
        je op1
        cmp byte ptr[bx], '2'
        je prefin

    prefin: 
    jmp fin

    op1:
        ; Reiniciar intentos
        mov intentos_restantes, 3
        
        ; Seleccionar animal aleatorio
        call SeleccionarAnimalAleatorio
        
        ; Fase de visualización
        mov al, '1'
        call carteles
        mov dx, offset animal_actual
        call print
        mov cx, tiempo_mostrar
        call DelayTicks
        call cls

        ; Fase de dibujo
        mov dx, offset instruccion
        call print
        mov cx, tiempo_dibujo
        call pincel
        call cls
adivinar:
    call cls

    cmp intentos_restantes, 3
    je mostrar_intento1
    cmp intentos_restantes, 2
    je mostrar_intento2
    cmp intentos_restantes, 1
    je mostrar_intento3

mostrar_intento1:
    mov dx, offset intento1
    jmp continuar_adivinar
        
mostrar_intento2:
    mov dx, offset intento2
    jmp continuar_adivinar
        
mostrar_intento3:
    mov dx, offset intento3
        
continuar_adivinar:
    mov ah, 9
    int 21h
    
    ; cartelitos
    mov dx, offset mensaje_tiempo
    call print
    mov dx, offset mensaje_prediccion
    call print
    
    call limpiar_buffer
    call leer_respuesta_mejorada
    
    ; compara respuesta (resultado en AX)
    call comparar_respuesta
    test ax, ax
    jnz respuesta_correcta  ; Si AX != 0, respuesta correcta
    
    ; rta incorrecta
    call cls
    mov dx, offset incorrecto
    mov ah, 9
    int 21h
    
    ; decremento intentos
    dec intentos_restantes
    jz intentos_agotados
    
    ;continuar
    mov dx, offset presione_enter
    call print
    mov ah, 1
    int 21h
    
    jmp adivinar
respuesta_correcta:
    call cls
    mov dx, offset correcto
    mov ah, 9
    int 21h
    
    mov dx, offset opciones_correcto
    call print
    call leer_opcion
    
    cmp al, '1'
    je fin
    jmp main  ; Cualquier otra tecla vuelve al menu)

intentos_agotados:
    call cls
    mov dx, offset sin_intentos
    mov ah, 9
    int 21h
    
    mov dx, offset opciones_incorrecto
    call print
    call leer_opcion
    
    cmp al, '1'
    je fin
    jmp main  

    fin:
        call cls
        mov ah, 9
        mov dx, offset salida
        int 21h
        mov ah, 4ch
        int 21h
main endp
;------------------------------------------------------------------------------------------------------------------------------------------------
;procs!

leer_respuesta_mejorada proc
    push bx
    push cx
    push dx
    
    mov bx, offset input_adivinar  ; Buffer para almacenar
    xor cx, cx                    ; Contador de caracteres = 0

lectura:
    ; Leer tecla
    mov ah, 0
    int 16h
    
    cmp al, 0Dh      
    je fin_lectura
    
    cmp al, 8        ; ¿Es Backspace?
    je manejar_backspace
    
    ;  esto es para el limite del buffer
    cmp cx, 19       ; 20-1 para el '$'
    jae lectura
    
    ; Convertir a mayus si es minus
    cmp al, 'a'
    jb no_convertir
    cmp al, 'z'
    ja no_convertir
    sub al, 32
    
no_convertir:
    mov [bx], al
    inc bx
    inc cx
    mov dl, al
    mov ah, 2
    int 21h
    jmp lectura

manejar_backspace:
    cmp cx, 0
    je lectura
    dec bx
    dec cx

    mov dl, 8
    mov ah, 2
    int 21h
    mov dl, 20h
    int 21h
    mov dl, 8
    int 21h
    jmp lectura

fin_lectura:
    mov byte ptr [bx], '$'  
    
    pop dx
    pop cx
    pop bx
    ret
leer_respuesta_mejorada endp

leer_opcion proc
    esperar_opcion:
        mov ah, 1
        int 21h
        cmp al, '1'
        je opcion_valida
        cmp al, '2'
        je opcion_valida
        jmp esperar_opcion
    opcion_valida:
    ret
leer_opcion endp
;------------------------------------------------------------------------------------------------------------------------------------------------
comparar_respuesta proc
    push si
    push di
    push bx
    
    ; limpia CR/LF del animal
    mov si, offset animal_actual
    call limpiar_string
    
    ; Inicializar resultado (0 = incorrecto, 1 = correcto)
    xor bx, bx  ; BX = 0 (incorrecto por defecto)
    
    ; Compara
    mov si, offset animal_actual
    mov di, offset input_adivinar
    
comparar:
    mov al, [si]
    mov dl, [di]  ; Usamos DL en lugar de BL para no interferir con BX
    
    cmp al, 24h
    je verificar_fin
    
    cmp al, dl
    jne no_igual
    
    inc si
    inc di
    jmp comparar

verificar_fin:
    cmp byte ptr [di], 24h
    jne no_igual
    ;es correcto
    mov bx, 1  ; BX = 1 (correcto)
    jmp fin_comparacion

no_igual:
    ; BX ya esta en 0, (incorrecto)

fin_comparacion:
    ; Devolver resultado en AX
    mov ax, bx
    
    pop bx
    pop di
    pop si
    ret
comparar_respuesta endp
;------------------------------------------------------------------------------------------------------------------------------------------------
limpiar_string proc
    push si
buscar_fin:
    mov al, [si]
    cmp al, '$'
    je fin_limpieza
    cmp al, 0Dh
    je limpiar
    cmp al, 0Ah
    je limpiar
    inc si
    jmp buscar_fin
    
limpiar:
    mov byte ptr [si], '$'
    
fin_limpieza:
    pop si
    ret
limpiar_string endp

;-----------------------------------------------------------
; strlen - Calcula la longitud de un string terminado en $
; Entrada: DI = puntero al string
; Salida: AX = longitud
; Modifica: AX, DI
;-----------------------------------------------------------
strlen proc
    push di
    xor ax, ax
contar:
    cmp byte ptr [di], 24h
    je fin_strlen
    inc ax
    inc di
    jmp contar
fin_strlen:
    pop di
    ret
strlen endp

;-----------------------------------------------------------
; CargarAnimales - Carga la lista de animales desde archivo
; Modifica: AX, BX, CX, DX, SI
;-----------------------------------------------------------
CargarAnimales proc
    ; Abrir archivo
    mov ah, 3Dh
    mov al, 0           ; Modo lectura
    mov dx, offset filename_animales
    int 21h
    jc error_archivo
    mov [handle_animales], ax
    
    ; Leer archivo
    mov ah, 3Fh
    mov bx, [handle_animales]
    mov cx, 512         ; Máximo a leer
    mov dx, offset buffer_animales
    int 21h
    jc error_lectura
    
    ; Contar animales (cada uno en una línea)
    mov si, offset buffer_animales
    mov byte ptr [animales_count], 0
contar_animales:
    cmp byte ptr [si], '$'  
    je fin_contar
    cmp byte ptr [si], 0Dh 
    jne siguiente_char
    inc byte ptr [animales_count]
    add si, 2               ; Saltar CR+LF
siguiente_char:
    inc si
    jmp contar_animales
fin_contar:
    
    ; Cerrar archivo
    mov ah, 3Eh
    mov bx, [handle_animales]
    int 21h
    ret
    
error_archivo:
    ; Manejar error (puedes mostrar un mensaje)
    ret
    
error_lectura:
    ; Manejar error
    mov ah, 3Eh
    mov bx, [handle_animales]
    int 21h
    ret
CargarAnimales endp

;-----------------------------------------------------------
; SeleccionarAnimalAleatorio - Elige un animal al azar
; Salida: animal_actual contiene el animal seleccionado
; Modifica: AX, BX, CX, DX, SI, DI
;-----------------------------------------------------------
SeleccionarAnimalAleatorio proc
    ; Obtener número aleatorio (0 a animales_count-1)
    call semilla       ; AX = semilla basada en ticks
    xor si, si         ; Secuencia Weyl inicializada a 0
    xor di, di         ; Valor anterior inicializado a 0
    int 81h            ; Generar número (resultado en AL)
    
    ; Ajustar al rango de animales
    xor ah, ah
    mov bl, [animales_count]
    div bl             ; AH = resto (0 a count-1)
    mov [animal_numero], ah  ; Guardar número seleccionado
    
    ; Buscar el animal correspondiente en el buffer
    mov si, offset buffer_animales
    mov cl, [animal_numero]
    xor ch, ch
    jcxz copiar_animal  ; Si es el primero, saltar
    
buscar_animal:
    ; Avanzar hasta el siguiente animal
    cmp byte ptr [si], '$'
    je fin_busqueda
    cmp byte ptr [si], 0Dh
    jne siguiente_char_busqueda
    dec cx
    jz copiar_animal_prep
    add si, 2  ; Saltar CR+LF
siguiente_char_busqueda:
    inc si
    jmp buscar_animal
    
copiar_animal_prep:
    add si, 2  ; Saltar CR+LF
    
copiar_animal:
    ; copia el nombre del animal a animal_actual
    mov di, offset animal_actual

copiar_loop:
    mov al, [si]
    cmp al, 0Dh        
    je fin_copia
    cmp al, 24h      
    je fin_copia
    mov [di], al
    inc si
    inc di
    jmp copiar_loop
    
fin_copia:
    mov byte ptr [di], 24h  ; Terminar string
    ret
    
fin_busqueda:
    ; Si llegamos aca, hubo un error
    mov byte ptr [animal_actual], 24h
    ret
SeleccionarAnimalAleatorio endp

;-----------------------------------------------------------
; Limpia el buffer input_adivinar 
;-----------------------------------------------------------
limpiar_buffer proc
    push di
    push cx
    mov di, offset input_adivinar
    mov cx, 20

limpiar_loop:
    mov byte ptr [di], 0
    inc di
    loop limpiar_loop
    pop cx
    pop di
    ret
limpiar_buffer endp

end main
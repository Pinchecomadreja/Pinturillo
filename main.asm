.8086
.model small
.stack 100h

.data
    input       db 24h,0dh,0ah,24h
    salida      db "HAS SALIDO DEL JUEGO",0dh,0ah,24h
    tiempo_mostrar dw 182    ; ≈3 segundos (18.2 ticks/seg * 3)
    tiempo_dibujo dw 182    ; ≈10 segundos para dibujar
    tiempo_adivinar dw 300   ; ≈5 segundos para adivinar
    mensaje_tiempo db "TIEMPO RESTANTE: ", 24h
    input_adivinar db 20 dup(?) ; Buffer para la palabra a adivinar
    presione_enter db 0dh,0ah,"Presione ENTER para continuar...",24h
    animal db "ANIMAL: Leon", 0dh, 0ah, 24h
    instruccion db "Dibuja lo que viste!", 0dh, 0ah, 24h
.code
    extrn carteles:proc, leertxt:proc, men:proc, cls:proc
    extrn print:proc, pincel:proc, delayTicks:proc

main proc
    mov ax, @data
    mov ds, ax

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
        je fin

    op1:
        ; Fase de visualización - Jugador 1
        mov al, '1'
        call carteles
        
        ; Mostrar el animal a dibujar
        mov dx, offset animal
        call print
        
        ; Esperar 3 segundos
        mov cx, tiempo_mostrar
        call DelayTicks
        
        ; Limpiar pantalla
        call cls
        
        ; Mostrar instrucción para dibujar
        mov dx, offset instruccion
        call print
        
        ; Iniciar temporizador y herramienta de dibujo
        mov cx, tiempo_dibujo
        call pincel
        
        ; Limpiar pantalla
        call cls
        
        ; Fase de adivinar - Jugador 2
        mov al, '2'
        call carteles
        
        ; Mostrar mensaje de tiempo
        mov dx, offset mensaje_tiempo
        call print
        
        ; Esperar entrada del jugador 2
        mov cx, tiempo_adivinar
        call leer_respuesta
        
        ; Mensaje para continuar
        mov dx, offset presione_enter
        call print
        mov ah, 1
        int 21h
        
        jmp fin

    fin:
        call cls
        mov ah, 9
        mov dx, offset salida
        int 21h
        
        mov ah, 4ch
        int 21h
main endp

; Función para leer respuesta
leer_respuesta proc
    push bx
    push cx
    push dx
    
    mov bx, offset input_adivinar
    mov cx, 0  ; Contador de caracteres
    
lectura:
    ; Verificar tiempo
    mov ah, 1
    int 16h
    jz no_tecla
    
    ; Leer tecla
    mov ah, 0
    int 16h
    
    cmp al, 0Dh  ; Enter
    je fin_lectura
    
    ; Guardar caracter
    mov [bx], al
    inc bx
    inc cx
    
    ; Mostrar caracter
    mov dl, al
    mov ah, 2
    int 21h
    
no_tecla:
    ; Verificar tiempo restante
    ; (Aquí iría la lógica para verificar el timer)
    jmp lectura
    
fin_lectura:
    ; Terminar string
    mov byte ptr [bx], '$'
    
    pop dx
    pop cx
    pop bx
    ret
leer_respuesta endp

; Función DelayTicks corregida

end main
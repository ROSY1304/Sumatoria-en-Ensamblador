.MODEL SMALL
.STACK 100h
.DATA
    sumatoria DW 0   ; Variable para almacenar el resultado
    contador  DW 1   ; Variable que funcionar? como el ?ndice i
    mensaje DB 'Resultado de la sumatoria: $' ; Mensaje a mostrar
.CODE
START:
    MOV AX, _DATA    ; Inicializa el segmento de datos
    MOV DS, AX

    ; Muestra el mensaje en pantalla
    LEA DX, mensaje
    MOV AH, 09h      ; Funci?n para mostrar el mensaje
    INT 21h

    ; Bucle para la sumatoria de i + 2
SUM_LOOP:
    CMP contador, 6  ; Compara el valor del contador con 6 (cuando el ciclo debe detenerse)
    JGE FIN          ; Si el contador es mayor o igual a 6, salta al final

    MOV AX, contador ; AX = i
    ADD AX, 2        ; Suma 2 a i
    ADD sumatoria, AX ; Acumula el valor en sumatoria

    INC contador     ; Incrementa el contador i en 1
    JMP SUM_LOOP     ; Repite el ciclo

FIN:
    ; Convierte el resultado a cadena para mostrarlo
    MOV AX, sumatoria
    CALL IMPRIMIR_NUMERO

    MOV AX, 4C00h    ; Termina el programa
    INT 21h

; Subrutina para imprimir el n?mero en pantalla
IMPRIMIR_NUMERO PROC
    PUSH AX
    MOV BX, 10       ; Base decimal
    XOR CX, CX       ; CX servir? como contador de d?gitos

    ; Convierte el n?mero a d?gitos ASCII
CONVERTIR:
    XOR DX, DX       ; Limpia DX
    DIV BX           ; Divide AX entre 10
    ADD DL, '0'      ; Convierte el resto a car?cter ASCII
    PUSH DX          ; Guarda el d?gito en la pila
    INC CX           ; Incrementa el contador de d?gitos
    TEST AX, AX
    JNZ CONVERTIR    ; Repite mientras AX no sea 0

    ; Imprime los d?gitos
IMPRIMIR:
    POP DX           ; Recupera el d?gito
    MOV AH, 02h      ; Funci?n para imprimir un car?cter
    INT 21h
    LOOP IMPRIMIR

    POP AX
    RET
IMPRIMIR_NUMERO ENDP
END START

.func inicializarSysTick
inicializarSysTick:
    CPSID I // Se deshabilitan globalmente las interrupciones

    // Se configura prioridad de la interrupcion
    LDR R1,=SHPR3 // Se apunta al registro de prioridades
    LDR R0,[R1] // Se cargan las prioridades actuales
    MOV R2,#2 // Se fija la prioridad en 2
    BFI R0,R2,#29,#3 // Se inserta el valor en el campo
    STR R0,[R1] // Se actualizan las prioridades


    // Se habilita el SysTick con el reloj del nucleo
    LDR R1,=SYST_CSR
    MOV R0,#0x00
    STR R0,[R1] // Se quita el bit ENABLE

    // Se configura el desborde para un periodo de 1 ms
    LDR R1,=SYST_RVR
    LDR R0,=#(48000 - 1)
    STR R0,[R1] // Se especifica el valor de RELOAD

    // Se inicializa el valor actual del contador
    LDR R1,=SYST_CVR
    MOV R0,#0

    // Escribir cualquier valor limpia el contador
    STR R0,[R1] // Se limpia COUNTER y flag COUNT

    // Se habilita el SysTick con el reloj del nucleo
    LDR R1,=SYST_CSR
    MOV R0,#0x07
    STR R0,[R1] // Se fijan ENABLE, TICKINT y CLOCK_SRC


   

    CPSIE I // Se habilitan globalmente las interrupciones

    BX LR // Se retorna al programa principal

.pool // Se almacenan las constantes de codigo
.endfunc

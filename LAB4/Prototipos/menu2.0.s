
    LDR R2,=segundos
    LDR R3,=parada   


    LDR R4,=GPIO_PIN0 
    LDR R5, =modo //direccion de modo
    LDR R6,=teclaActual 
    LDR R7,=digito


lazoPrincipal:

    LDRB R8,[R5]

    CMP R8,#0
    ITE EQ 
    STREQ R3,[R7]
    STRNE R2,[R7]
    

    //LEO LA ENTRADA ACTUAL
    MOV R1,#0 //Contendra los valores teclas
    LDR R0,[R4,#BTN_OFFSET]
    //-----
    
    TST R0,BTN_ACCEPTAR_MASK
    ITT NE
    MOVNE R1,BTN_ACCEPTAR_MASK
    STRNE R1,[R6]

    TST R0,BTN_CANCELAR_MASK
    ITT NE
    MOVNE R1,BTN_CANCELAR_MASK
    STRNE R1,[R6]

    TST R0,BTN_4_MASK
    ITT NE
    MOVNE R1,BTN_4_MASK
    STRNE R1,[R6]

    CMP R0,#0
    ITT EQ
    MOVEQ R1,#0
    STREQ R1,[R6]


    LDR R1,[R6]  //CARGO TECLA ACTUAL EN R1
    LDR R0,=teclaAnterior
    LDR R0,[R0]  //CARGO TECLA ANTERIOR EN R0

    CMP R0,R1
    BEQ fin
    MOV R8,R0
    LDR R0,=teclaAnterior
    STR R1,[R0]

    //ANOTACIONES LDR R2,=segundos //LDR R3,=parada 
    //si
        LDRB R8,[R5]
        //Para evitar errores raros
        CMP R8,0x00
        BEQ teclaCancelar //Si estoy en modo 0 salto
        //-------
        TST R1,BTN_ACCEPTAR_MASK
        BEQ  teclaCancelar                                   
        LDR R8,[R2]     //Cargo en R8 los segundos actuales
        STR R8,[R3]    //Guardo los segundos actuales en parada
        MOV R8,#0
        STRB R8,[R5]    //Guardo estado como parado
    teclaCancelar:
        //Para evitar errores raros
        CMP R8,0x01
        BEQ tecla4 //Si estoy en modo 1 salto
        //-------
        TST R1,BTN_CANCELAR_MASK
        BEQ  tecla4 
        LDR R8,[R3]         //CARGO EL VALOR DE PARADA EN R3           
        STR R8,[R2]         //Guardo los segundos actuales el valor de parada
        MOV R8,#1           //R3 guardo la direccion de parada
        STRB R8,[R5]        //Cargo modo contando
    tecla4:
        TST R1,BTN_4_MASK   
        BEQ  fin
        MOV R8,0x020400     // Valor de reseto
        STR R8,[R3]     //CARGO EL VALOR R8 EN PARADA  
        MOV R8,#0                            
        STRB R8,[R5]    //Pongo en modo 0

  fin:  

B lazoPrincipal
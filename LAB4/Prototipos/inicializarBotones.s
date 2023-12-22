//BOTONES PONCHO

// Recursos utilizados por el BOTON ACCEPTAR
.equ BTN_ACCEPTAR_PORT, 3
.equ BTN_ACCEPTAR_PIN, 1
.equ BTN_ACCEPTAR_BIT, 8
.equ BTN_ACCEPTAR_MASK, (1 << BTN_ACCEPTAR_BIT)

// Recursos utilizados por el BOTON CANCELAR
.equ BTN_CANCELAR_PORT, 3
.equ BTN_CANCELAR_PIN, 2
.equ BTN_CANCELAR_BIT, 9
.equ BTN_CANCELAR_MASK, (1 << BTN_CANCELAR_BIT)

// Recursos utilizados por el BOTON 3
.equ BTN_3_PORT, 4
.equ BTN_3_PIN, 10
.equ BTN_3_BIT, 14
.equ BTN_3_MASK, (1 << BTN_3_BIT)

// Recursos utilizados por el BOTON 4
.equ BTN_4_PORT, 6
.equ BTN_4_PIN, 7
.equ BTN_4_BIT, 15
.equ BTN_4_MASK, (1 << BTN_4_BIT)


// Numero de puerto GPIO utilizado por todos los segmentos
.equ BTN_NUM_GPIO, 5

// Desplazamiento para acceder a los registros GPIO de los leds
.equ BTN_OFFSET, ( BTN_NUM_GPIO << 2 )

// Mascara de 32 bits con un 1 en los bits correspondiente a cada led
.equ BTN_MASK, ( BTN_3_MASK | BTN_4_MASK | BTN_ACCEPTAR_MASK | BTN_CANCELAR_MASK )

    // -------------------------------------------------------------------------


.func inicializarBotones
inicializarBotones:
    //Configuracion electrica Digitos son salidas
    LDR R0,=SCU_BASE

    MOV R1,#(SCU_MODE_PULLUP | SCU_MODE_INBUFF_EN | SCU_MODE_ZIF_DIS | SCU_MODE_FUNC4 )
    STR R1,[R0,#(BTN_ACCEPTAR_PORT<<7|BTN_ACCEPTAR_PIN<<2)]
    STR R1,[R0,#(BTN_CANCELAR_PORT<<7|BTN_CANCELAR_PIN<<2)]
    STR R1,[R0,#(BTN_3_PORT<<7|BTN_3_PIN<<2)]
    STR R1,[R0,#(BTN_4_PORT<<7|BTN_4_PIN<<2)]

    //PRIMERO COMO BUENA PRACTICA DEBERIA APAGAR TODO
    LDR R0,=GPIO_CLR0
    MOV R1,#BTN_MASK
    STR R1,[R0,#BTN_OFFSET]
    //-----

    //Configuro como ENTRADAS
    LDR R0,=GPIO_DIR0
    LDR R1,[R0,#BTN_OFFSET]
    LDR R2,=BTN_MASK
    BIC R1, R2   //salida si DIR =1 y entrada si Dir=0 por eso or
    STR R1,[R0,#BTN_OFFSET]

    BX LR // Se retorna al programa principal

.pool // Se almacenan las constantes de codigo
.endfunc


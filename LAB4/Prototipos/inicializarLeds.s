// Recursos utilizados por el led 1
.equ LED_1_PORT, 2
.equ LED_1_PIN, 10
.equ LED_1_BIT, 14
.equ LED_1_MASK, (1 << LED_1_BIT)
.equ LED_1_GPIO, 0
.equ LED_1_OFFSET, ( LED_1_GPIO << 2) //Esto es lo mismo que multiplicar por 4

// Recursos utilizados por el led 2
.equ LED_2_PORT, 2
.equ LED_2_PIN, 11
.equ LED_2_BIT, 11
.equ LED_2_MASK, (1 << LED_2_BIT)

// Recursos utilizados por el led 3
.equ LED_3_PORT, 2
.equ LED_3_PIN, 12
.equ LED_3_BIT, 12
.equ LED_3_MASK, (1 << LED_3_BIT)

// Recursos utilizados por los leds 2 y 3
.equ LED_N_GPIO, 1
.equ LED_N_OFFSET, ( LED_N_GPIO << 2)
.equ LED_N_MASK, ( LED_2_MASK | LED_3_MASK )
// -------------------------------------------------------------------------


.func inicializarLeds
inicializarLeds:
    //Configuracion electrica Digitos son salidas
    LDR R0,=SCU_BASE

    MOV R1,#(SCU_MODE_INACT | SCU_MODE_INBUFF_EN | SCU_MODE_ZIF_DIS | SCU_MODE_FUNC0)
    STR R1,[R0,#(LED_1_PORT<<7|LED_1_PIN<<2)]
    STR R1,[R0,#(LED_2_PORT<<7|LED_2_PIN<<2)]
    STR R1,[R0,#(LED_3_PORT<<7|LED_3_PIN<<2)]


    //PRIMERO COMO BUENA PRACTICA DEBERIA APAGAR TODO
    LDR R0,=GPIO_CLR0
    LDR R1,=LED_N_MASK
    STR R1,[R0,#LED_N_OFFSET]
    //-----
    //PRIMERO COMO BUENA PRACTICA DEBERIA APAGAR TODO
    LDR R0,=GPIO_CLR0
    LDR R1,=LED_1_MASK
    STR R1,[R0,#LED_1_OFFSET]
    //-----

    //Configuro como Salidas
    LDR R0,=GPIO_DIR0
    LDR R1,[R0,#LED_N_OFFSET]
    ORR R1,#LED_N_MASK            //salida si DIR =1 y entrada si Dir=0 por eso or
    STR R1,[R0,#LED_N_OFFSET]

    //Configuro como Salidas
    LDR R0,=GPIO_DIR0
    LDR R1,[R0,#LED_1_OFFSET]
    ORR R1,#LED_1_MASK            //salida si DIR =1 y entrada si Dir=0 por eso or
    STR R1,[R0,#LED_1_OFFSET]

    BX LR // Se retorna al programa principal

.pool // Se almacenan las constantes de codigo
.endfunc
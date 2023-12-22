//SEGMENTOS
// Recursos utilizados por el SEGMENTO A
.equ SEG_A_PORT, 4
.equ SEG_A_PIN, 0
.equ SEG_A_BIT, 0
.equ SEG_A_MASK, (1 << SEG_A_BIT)


// Recursos utilizados por el SEGMENTO B
.equ SEG_B_PORT, 4
.equ SEG_B_PIN, 1
.equ SEG_B_BIT, 1
.equ SEG_B_MASK, (1 << SEG_B_BIT)

// Recursos utilizados por el SEGMENTO C
.equ SEG_C_PORT, 4
.equ SEG_C_PIN, 2
.equ SEG_C_BIT, 2
.equ SEG_C_MASK, (1 << SEG_C_BIT)

// Recursos utilizados por el SEGMENTO D
.equ SEG_D_PORT, 4
.equ SEG_D_PIN, 3
.equ SEG_D_BIT, 3
.equ SEG_D_MASK, (1 << SEG_D_BIT)

// Recursos utilizados por el SEGMENTO E
.equ SEG_E_PORT, 4
.equ SEG_E_PIN, 4
.equ SEG_E_BIT, 4
.equ SEG_E_MASK, (1 << SEG_E_BIT)

// Recursos utilizados por el SEGMENTO F
.equ SEG_F_PORT, 4
.equ SEG_F_PIN, 5
.equ SEG_F_BIT, 5
.equ SEG_F_MASK, (1 << SEG_F_BIT)

// Recursos utilizados por el SEGMENTO G
.equ SEG_G_PORT, 4
.equ SEG_G_PIN, 6
.equ SEG_G_BIT, 6
.equ SEG_G_MASK, (1 << SEG_G_BIT)

// Numero de puerto GPIO utilizado por todos los segmentos
.equ SEG_NUM_GPIO, 2

// Desplazamiento para acceder a los registros GPIO de los leds
.equ SEG_OFFSET, ( 4 * SEG_NUM_GPIO )

// Mascara de 32 bits con un 1 en los bits correspondiente a cada led
.equ SEG_MASK,    (SEG_A_MASK | SEG_B_MASK | SEG_C_MASK | SEG_D_MASK | SEG_E_MASK | SEG_F_MASK | SEG_G_MASK)

// -------------------------------------------------------------------------

//DIGITOS

// Recursos utilizados por el digito1
.equ DIG_1_PORT, 0
.equ DIG_1_PIN, 0
.equ DIG_1_BIT, 0
.equ DIG_1_MASK, (1 << DIG_1_BIT)

// Recursos utilizados por el digito2
.equ DIG_2_PORT, 0
.equ DIG_2_PIN, 1
.equ DIG_2_BIT, 1
.equ DIG_2_MASK, (1 << DIG_2_BIT)

// Recursos utilizados por el digito3
.equ DIG_3_PORT, 1
.equ DIG_3_PIN, 15
.equ DIG_3_BIT, 2
.equ DIG_3_MASK, (1 << DIG_3_BIT)

// Recursos utilizados por el digito3
.equ DIG_4_PORT, 1
.equ DIG_4_PIN, 17
.equ DIG_4_BIT, 3
.equ DIG_4_MASK, (1 << DIG_4_BIT)

// Numero de puerto GPIO utilizado por todos los digitos
.equ DIG_NUM_GPIO, 0

// Recursos utilizados por el led RGB

// Desplazamiento para acceder a los registros GPIO de los leds
.equ DIG_OFFSET, ( 4 * DIG_NUM_GPIO )

// Mascara de 32 bits con un 1 en los bits correspondiente a cada led
.equ DIG_MASK, ( DIG_1_MASK | DIG_2_MASK | DIG_3_MASK | DIG_4_MASK )

// -------------------------------------------------------------------------




.func inicializarSegmentos
inicializarSegmentos:
    //Configuracion electrica Digitos son salidas
    LDR R0,=SCU_BASE

    MOV R1,#(SCU_MODE_INACT | SCU_MODE_INBUFF_EN | SCU_MODE_ZIF_DIS | SCU_MODE_FUNC0)
    STR R1,[R0,#(SEG_A_PORT<<7|SEG_A_PIN<<2)]
    STR R1,[R0,#(SEG_B_PORT<<7|SEG_B_PIN<<2)]
    STR R1,[R0,#(SEG_C_PORT<<7|SEG_C_PIN<<2)]
    STR R1,[R0,#(SEG_D_PORT<<7|SEG_D_PIN<<2)]
    STR R1,[R0,#(SEG_E_PORT<<7|SEG_E_PIN<<2)]
    STR R1,[R0,#(SEG_F_PORT<<7|SEG_F_PIN<<2)]
    STR R1,[R0,#(SEG_G_PORT<<7|SEG_G_PIN<<2)]

    //PRIMERO COMO BUENA PRACTICA DEBERIA APAGAR TODO
    LDR R0,=GPIO_CLR0
    LDR R1,=SEG_MASK
    STR R1,[R0,#SEG_OFFSET]
    //-----

    //Configuro como Salidas
    LDR R0,=GPIO_DIR0
    LDR R1,[R0,#SEG_OFFSET]
    ORR R1,#SEG_MASK            //salida si DIR =1 y entrada si Dir=0 por eso or
    STR R1,[R0,#SEG_OFFSET]

    BX LR // Se retorna al programa principal

.pool // Se almacenan las constantes de codigo
.endfunc

.func inicializarDigitos
inicializarDigitos:
    //Configuracion electrica Digitos son salidas
    LDR R0,=SCU_BASE
            
    MOV R1,#(SCU_MODE_INACT | SCU_MODE_INBUFF_EN | SCU_MODE_ZIF_DIS | SCU_MODE_FUNC0)
    STR R1,[R0,#(DIG_1_PORT<<7|DIG_1_PIN<<2)]
    STR R1,[R0,#(DIG_2_PORT<<7|DIG_2_PIN<<2)]
    STR R1,[R0,#(DIG_3_PORT<<7|DIG_3_PIN<<2)]
    STR R1,[R0,#(DIG_4_PORT<<7|DIG_4_PIN<<2)]

    //Configuracion GPIO

    //PRIMERO COMO BUENA PRACTICA DEBERIA APAGAR TODO
    LDR R0,=GPIO_CLR0
    LDR R1,=DIG_MASK
    STR R1,[R0,#DIG_OFFSET]
    //-----

    //Configuro como Salidas
    LDR R0,=GPIO_DIR0
    LDR R1,[R0,#DIG_OFFSET]
    ORR R1,#DIG_MASK            //salida si DIR =1 y entrada si Dir=0 por eso or
    STR R1,[R0,#DIG_OFFSET]
 
    BX LR // Se retorna al programa principal

.pool // Se almacenan las constantes de codigo
.endfunc


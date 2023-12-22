//FUNCION PARA CONVERTIR DE BCD A 7 SEGMENTOS

.func convertirBCDa7Segmentos
convertirBCDa7Segmentos :
        LDR R1,=TABLA
        LDRB R0,[R1,R0]
        BX LR

.pool // Se almacenan las constantes de codigo
.endfunc

//-------------------------------------------------------------------------------------
//FUNCION PARA CONVERTIR DE BINARIO NATURAL A BCD
//Recibe en R0 direccion memoria donde esta el num natural
//recibe en R1 direccion donde guardar el numero
.func convertirBINARIOaBCD
convertirBINARIOaBCD:
    PUSH {R4,R5}

    //Carga de valores en registros R4 y R5
    LDRB R4,[R0] // CArgo el numero natural R4 tambien sirve para guardar unidades
    MOV R5,#0 //Inicializo las decenas
    
    lazoConversion:
        //While(R4>=10):
        CMP R4,#10
        BLO finLazoConversion
        //----

        SUB R4,#10 //Resto 10 y sumo a las decenas
        ADD R5,#1
        B lazoConversion
    finLazoConversion:
    STRB R5,[R1],#1 //Guardo la decena en la primera posicion de memoria
    STRB R4,[R1],#1    //Guardo la unidad en la segunda posicion y aumenta uno a R1

    POP {R4,R5}
    BX LR

.endfunc

//-------------------------------------------------------------------------------------

//FUNCION PARA INCREMENTAR LAS HORAS SI RECIBE EN R0 UN 1 SINO SOLO CALCULA DESBORDAMIENTOS
//Recibe en R0 si debo o no incrementar horas, R1 direccion a horas
.func incrementarHoras
incrementarHoras:
        PUSH {R4-R5}
        //Recibe el valor numerico 1 en R0
        //EN R4 y R5 guardare el valor de los segundos(NO lo deseo conservar asi que no hay drama)
        LDRB R4,[R1] //Menos signif
        LDRB R5,[R1,#1] //Mas significativo

        //COndicion SI el valor de R0 es 1
        CMP R0,0x01
        IT EQ  
        ADDEQ R4,#1 //Sumo 01 hora
        //----

    primeraCondicion:
        CMP R5,#2
        BEQ segundaCondicion
        B FinSentencia
    segundaCondicion:
        CMP R4,#3
        BHI sentencia
        B FinSentencia
    sentencia:
        MOV R4,#0
        MOV R5,#0

    FinSentencia:

        //Condicion dig menos significativo mayor a 9
        CMP R4,0x09
        ITT HI
        MOVHI R4,#0 //Si el dig menos sig llega 9 vuelve a cero
        ADDHI R5,#1 //Sumo 1 al dig mas significativo
        //----------------

        //Realizo guardado de los segundos correspondientes
        STRB R4,[R1] //Menos signif
        STRB R5,[R1,#1] //Mas significativo

        POP {R4-R5}
        BX LR  //Salto colocando en el pc la instruccion en LR



.pool // Se almacenan las constantes de codigo
.endfunc

//-------------------------------------------------------------------------------------


//FUNCION PARA INCREMENTAR MINUTOS O SEGUNDOS SI RECIBE EN R0 UN 1
//Recibe en R1 la direccion donde se encuentra el valor de los minutos o segundos
.func incrementarSegundosYMinutos
incrementarSegundosYMinutos:
        PUSH {R4-R5}
        //Recibe el valor numerico 1 en R0
        //EN R4 y R5 guardare el valor de los segundos(NO lo deseo conservar asi que no hay drama)
        LDRB R4,[R1] //Menos signif
        LDRB R5,[R1,#1] //Mas significativo

        //COndicion SI el valor de R0 es 1
        CMP R0,0x01
        IT EQ  
        ADDEQ R4,#1 //Sumo 01 seg
        //----

        MOV R0,#0 //Establezco por defecto la bandera R0 en 0

        //Condicion dig menos significativo mayor a 9
        CMP R4,0x09
        ITT HI
        MOVHI R4,#0 //Si el dig menos sig llega 9 vuelve a cero
        ADDHI R5,#1 //Sumo 1 al dig mas significativo
        //----

        CMP R5,0x05
        ITT HI
        MOVHI R5,#0
        MOVHI R0,#1 //Bandera en 1 para indicar desbordamiento

        //Realizo guardado de los segundos correspondientes
        STRB R4,[R1] //Menos signif
        STRB R5,[R1,#1] //Mas significativo

        POP {R4-R5}
        BX LR  //Salto colocando en el pc la instruccion en LR



.pool // Se almacenan las constantes de codigo
.endfunc

//-------------------------------------------------------------------------------------
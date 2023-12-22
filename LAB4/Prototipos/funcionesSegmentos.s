
//FUNCION PARA DETERMINAR LA MASCARA DEL DIGITO A PARTIR DE UN NUMERO 0 AL 3
.func seleccionarDigito
seleccionarDigito:
    MOV R1,R0
    CMP R1,0x00
    IT EQ
    MOVEQ R0,#DIG_1_MASK

    CMP R1,0x01
    IT EQ
    MOVEQ R0,#DIG_2_MASK

    CMP R1,0x02
    IT EQ
    MOVEQ R0,#DIG_3_MASK

    CMP R1,0x03
    IT EQ
    MOVEQ R0,#DIG_4_MASK

    BX LR // Se retorna al programa principal

.pool // Se almacenan las constantes de codigo
.endfunc

//-------------------------------------------------------------------------------------

//FUNCION PARA DETERMINAR QUE DIGITO SE TIENE QUE PRENDER
//Devuelve en R0 el numero de refresco sirve para multiplexar los digitos- necesita una variable para guardar el numero digito que va(refresco)
.func refrescoDigito
refrescoDigito:
    MOV R2,#0
    LDR R1, =refresco //Cargo lo guardado en refresco
    LDRB R2,[R1] //GUARDO en R2 el valor del numero refresco
    MOV R0,R2   //Guardo el valor actual de refresco en R0 para devolver en la funcion

    ADD R2,#1 //Sumo 1 
    CMP R2,#4   //Si llegue al valor de 4, debo resetear el refresco
    IT EQ   
    MOVEQ R2,#0

    STRB R2,[R1] //Guardo el nuevo valor de refresco de digito

    //Devuelvo en R0 el valor de digito que corresponde prender
    BX LR // Se retorna al programa principal

.pool // Se almacenan las constantes de codigo
.endfunc

//-------------------------------------------------------------------------------------

//FUNCION PARA APAGAR TODOS LOS DIGITOS
.func apagarDigitos
apagarDigitos:
    LDR R0,=GPIO_CLR0
    LDR R1,=DIG_MASK
    STR R1,[R0,#DIG_OFFSET]
 
    BX LR // Se retorna al programa principal

.pool // Se almacenan las constantes de codigo
.endfunc

//-------------------------------------------------------------------------------------

//FUNCION PARA PRENDER EL DIGITO DESEADO
//Recibe en R0 el numero de digito que debo prender
.func prenderDigito
prenderDigito:
    PUSH {LR}
    BL seleccionarDigito
    LDR R1,=GPIO_PIN0
    LDR R2,[R1,#DIG_OFFSET] //TRAIGO LO QUE YA ESTA EN EL GPIO
    ORR R0,R2               //HAGO UN OR entre la mask del digito que quiero y lo que habia en el prender digito
    STR R0,[R1,#DIG_OFFSET]

    POP {PC}  // Se retorna al programa principal

.pool // Se almacenan las constantes de codigo
.endfunc

//-------------------------------------------------------------------------------------





//FUNCION PARA PRENDER SEGMENTO

//Recibe en R0 los valores de 0 y 1 para prender una determinada cifra en el segmento (Apaga todo y prende lo deseado)
.func prenderSegmento
prenderSegmento:
    //Limpio lo que haya en el segmento (APAGO TODO)
    LDR R1,=GPIO_CLR0
    LDR R2,=SEG_MASK
    STR R2,[R1,#SEG_OFFSET]

    //Cargo el segmento
    LDR R1,=GPIO_PIN0
    LDR R2,[R1,#SEG_OFFSET] //TRAIGO LO QUE YA ESTA EN EL GPIO
    ORR R0,R2               //HAGO UN OR entre lo que quiero mostrar y lo que habia en el GPIO
    STR R0,[R1,#SEG_OFFSET] //Cargo el segmento que quiero que se vea

    BX LR // Se retorna al programa principal

.pool // Se almacenan las constantes de codigo
.endfunc

//-------------------------------------------------------------------------------------
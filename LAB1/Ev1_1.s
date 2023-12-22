            .cpu cortex-m4          // Indica el procesador de destino  
            .syntax unified         // Habilita las instrucciones Thumb-2
            .thumb                  // Usar instrucciones Thumb y no ARM

            .section .data
base:       .byte   1, 2, 3             //Numeros a comprobar
            .space  3, 0xFF             //Espacio para guardar los resultados
count:      .byte   0        

            .align

            .section .text
            .global reset
reset:
            LDR R0,=base             //Carga el puntero de la cadena
            LDR R2,=count            //Carga el puntero del contador
            LDRB R3, [R2]            //Carga el contador
lazo:
            LDRB R1,[R0],#1          //Carga el primer elemento de la cadena y se mueve 1
            CMP R1, 0xFF             //Comprueba el final del vector
            ITT EQ                   //Si es igual a 0xFF Guarda el contador y salta al final
            STRBEQ R3,[R0,#4]        //Guarda el contador en Byte en la dirección de memoria base+4
            
            BEQ final               
            MOVS R1, R1,LSR #1        //Mueve el LSB para comprobar si es impar o no
            BCS suma                  //Comprueba si C=1
            B lazo
suma:
            ADD R3,R3,0x01          //Si C=1, suma 1 en R2
            B lazo

final:
 stop:
        B stop
    

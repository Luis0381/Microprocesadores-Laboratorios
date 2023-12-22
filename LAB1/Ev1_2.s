                .cpu cortex-m4          // Indica el procesador de destino  
                .syntax unified         // Habilita las instrucciones Thumb-2
                .thumb                  // Usar instrucciones Thumb y no ARM

                .section .data 
origen:         .byte 22,4,17,9,12
                .space 15,0xFF
destino:        .space 20,0x00

                .section .text
                .global reset

reset:          LDR R0,=origen
                LDR R1,=destino         // Apunta R1 al bloque de destino
                LDR R3,=tabla

lazo:           LDRB R2,[R0],#1         // Carga en R2 el elemento a convertir
                CMP R2,0xFF             // Determina si es el fin de conversión
                BEQ final               // Terminar si es fin de conversión
                B conversion
                STRB R2,[R1],#1         // Guardar el elemento convertido
                B lazo                  // Repetir el lazo de conversión
conversion:
                CMP R2, 0x09
                ITEE CS
                LDRBCS R2,[R3,R2]       // Cargar en R2 el elemento convertido 
                SUBCC R2, R2, 0x0A
                BCC conversion
                B lazo


final:          STRB R2,[R1]            // Guardar el fin de conversión en destino
stop:           B stop                  // Lazo infinito para terminar la ejecución


                .pool                   // Almacenar las constantes fijas (FLASH)
tabla:          .byte 0xFC,0x60,0xDA,0xF2,0x66
                .byte 0xB6,0xBE,0xE0,0xFE,0xF6
PROCESSOR 16F887
#include <xc.inc>
    
;CONFIG word1 ;obligatorio para iniciar un progrma
config FOSC = INTRC_CLKOUT
 config WDTE = OFF       
 config PWRTE = OFF       
 config MCLRE = ON      
 config CP = OFF         
 config CPD = OFF       
 config BOREN = ON       
 config IESO = ON        
 config FCMEN = ON     
 config LVP = OFF       
 config DEBUG=ON
 
;CONFIG word2 ;obligatorio para iniciar un progrma
 config BOR4V = BOR40V   
 config WRT = OFF        
 
PSECT udata;obligatorio para declarar variables
tick:;Variables editables
    DS 1
counter:;Variables editables
    DS 1
counter2:;Variables editables
    DS 1
paro2:;Variables editables
    DS 1
paro1:
    DS 1
operador:;Variables editables
    DS 1
        
PSECT code
delay: ;Delay
movlw 0xff
movwf counter
counter_loop:
movlw 0xff
movwf tick
tick_loop:
decfsz tick,f
goto tick_loop
decfsz counter,f
goto counter_loop
return

PSECT code
delay_2s:
movlw 0x05
movwf paro1
call delay
decfsz  paro1
goto $-2
return

PSECT code
delay2:
movlw 0xff
movwf counter
counter_loop2:
movlw 0xff
movwf tick
tick_loop2:
decfsz tick,f
goto tick_loop2
decfsz counter,f
goto counter_loop2
return
    
PSECT resetVec,class=CODE,delta=2
resetVec:
goto main
    
PSECT isr,class=CODE,delta=2
isr:
BANKSEL PORTD
btfss INTCON,0
retfie
clrf PORTD 
control:
btfss PORTB,1
goto evaluar
goto lento
evaluar:
btfss PORTB,7
retfie
goto rapido
lento:
bcf INTCON,0
bcf PORTD,0
bcf PORTB,1
retfie
rapido:
bcf INTCON,0
bsf PORTD,0
bcf PORTB,7
retfie
    
PSECT main,class=CODE,delta=2
main:
BANKSEL OPTION_REG
movlw 0b11000000
movwf OPTION_REG
BANKSEL WPUB
movlw 0b10000010
movwf WPUB
clrf INTCON
movlw 0b11001000
movwf INTCON
BANKSEL IOCB
movlw 0b10000010
movwf IOCB
BANKSEL OSCCON
movlw 0b01110000
Movwf OSCCON
BANKSEL ANSELH
movlw 0b00000000
movwf ANSELH
BANKSEL ANSEL
movlw 0b00000000
movwf ANSEL
BANKSEL TRISB
movlw 0b10000010
movwf TRISB    
clrf TRISD
movlw 0b00000000
movwf TRISA 
BANKSEL PORTB
clrf PORTB
movlw 0b00000000
movwf PORTD
BANKSEL PORTA
movlw 0b00000000
movwf PORTA
INICIO:
btfss PORTD,0
goto caso2
goto caso1
caso1:
bsf PORTA,0
call delay2
bcf PORTA,0
call delay2
goto INICIO
caso2:
btfss PORTD,0
goto subcaso
goto caso1
subcaso:
bsf PORTA,0
call delay_2s
bcf PORTA,0
call delay_2s
goto INICIO
END resetVec



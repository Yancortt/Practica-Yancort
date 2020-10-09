PROCESSOR 16F887
#include <xc.inc>

;CONFIG word1 ;obligatorio para iniciar un progrma
CONFIG FOSC = INTRC_NOCLKOUT
CONFIG WDTE = OFF
CONFIG PWRTE = ON
CONFIG MCLRE = OFF
CONFIG CP = OFF
CONFIG CPD = OFF
CONFIG BOREN = OFF
CONFIG IESO = OFF
CONFIG FCMEN = ON
CONFIG DEBUG = ON

;CONFIG word2 ;obligatorio para iniciar un progrma
CONFIG BOR4V=BOR40V
CONFIG WRT = OFF

PSECT udata ;obligatorio para declarar variables
Lol0: ;Variables editables
    DS 1
Lol2: ;Variables editables
    DS 1
Lol3: ;Variables editables
    DS 1
PSECT resetVec,class=CODE,delta=2 ;obligatorio para declarar variables

resetVec:

PAGESEL Wii

goto Wii

PSECT code
n0:
BANKSEL PORTB
movlw 0b00111111
movwf PORTB
PAGESEL Wii
return

PSECT code
n1:
BANKSEL PORTB
movlw 0b00000110
movwf PORTB
PAGESEL Wii
return
    
PSECT code
n2:
BANKSEL PORTB
movlw 0b01011011
movwf PORTB
PAGESEL Wii
return

PSECT code
n3:
BANKSEL PORTB
movlw 0b01001111
movwf PORTB
PAGESEL Wii
return    

PSECT code
n4:
BANKSEL PORTB
movlw 0b01100110
movwf PORTB
PAGESEL Wii
return

PSECT code
n5:
BANKSEL PORTB
movlw 0b01101101
movwf PORTB
PAGESEL Wii
return

PSECT code
n6:
BANKSEL PORTB
movlw 0b01111101
movwf PORTB
PAGESEL Wii
return

PSECT code
n7:
BANKSEL PORTB
movlw 0b00000111
movwf PORTB
PAGESEL Wii
return
    
PSECT code
n8:
BANKSEL PORTB
movlw 0b01111111
movwf PORTB
PAGESEL Wii
return

PSECT code
n9:
BANKSEL PORTB
movlw 0b01101111
movwf PORTB
PAGESEL Wii
return

PSECT code
delay_255us:
movlw   255

movwf Lol3

decfsz Lol3
goto $-1
return

PSECT code
delay_65ms:
movlw   255

movwf Lol2

call delay_255us
decfsz Lol2
goto $-2
return

PSECT code
delay_500ms:
movlw   0x08
movwf Lol0
call delay_65ms
decfsz Lol0
goto $-2
return

PSECT code
Wii:
bcf STATUS,0
bcf STATUS,5
bcf STATUS,6
BANKSEL ANSELH
CLRF ANSELH
BANKSEL TRISB
MOVLW 0b00000000
MOVWF TRISB
BANKSEL PORTB
CLRF PORTB

BANKSEL OSCCON
MOVLW  0b01110000
MOVWF  OSCCON

INICIO:
call n0
call delay_500ms
call n1
call delay_500ms
call n2
call delay_500ms   
call n3
call delay_500ms
call n4
call delay_500ms
call n5
call delay_500ms
call n6
call delay_500ms
call n7
call delay_500ms
call n8
call delay_500ms
call n9
call delay_500ms

GOTO INICIO ;ir a inicio

END ;Finalizar el codigo
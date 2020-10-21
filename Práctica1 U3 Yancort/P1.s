PROCESSOR 16F887
    #include <xc.inc>
    
;CONFIG word1 ;obligatorio para iniciar un progrma
    CONFIG FOSC=INTRC_NOCLKOUT
    CONFIG WDTE=OFF
    CONFIG PWRTE=ON
    CONFIG MCLRE=OFF
    CONFIG CP=OFF
    CONFIG CPD=OFF
    CONFIG BOREN=OFF               
    CONFIG IESO=OFF
    CONFIG FCMEN=OFF
    CONFIG LVP=OFF
    CONFIG DEBUG=ON
    
;CONFIG word2 ;obligatorio para iniciar un progrma
    CONFIG BOR4V=BOR40V
    CONFIG WRT=OFF

    PSECT udata;obligatorio para declarar variables
 tick:;Variables editables
    DS 1
 counter:;Variables editables
    DS 1
 counter2:;Variables editables
    DS 1
   
    PSECT code
    delay:               ;Delay        
    movlw 0xFF
    movwf counter
    counter_loop:
    movlw 0xFF
    movwf tick
    tick_loop:
    decfsz tick,f
    goto tick_loop
    decfsz counter,f
    goto counter_loop
    return
   
PSECT resetVec,class=CODE,delta=2
	PAGESEL main
	goto main
	
PSECT isr,class=CODE,delta=2
	
isr:
        btfss INTCON,1
	retfie
	btfss PORTA, 0
	goto prender
	goto apagar
	
prender:	
        bcf INTCON, 1
	movlw 0b11111111
	movwf PORTC
	retfie
apagar:
	bcf INTCON,1
	movlw 0b00000000
	movwf PORTC
	retfie
	
PSECT main,class=CODE,delta=2
main:
    BANKSEL ANSELH
    bcf ANSELH,4
  
    clrf INTCON
    movlw 0b11010000    
    movwf INTCON
   
    BANKSEL OSCCON
    movlw 0b01110101    
    movwf OSCCON
    
    BANKSEL PORTB
    clrf    PORTB
    BANKSEL TRISB      
    movlw   0xFF         
    movwf   TRISB
   
    BANKSEL ANSELH
    bcf ANSELH,4
   
    BANKSEL WPUB
    movlw 0xFF
    movwf WPUB
   
    BANKSEL PORTC
	clrf PORTC    
    BANKSEL TRISC
	clrf TRISC
    
    BANKSEL ANSEL
    movlw   0x00         
    movwf   ANSEL
   
    BANKSEL PORTA  
    clrf    PORTA
    BANKSEL TRISA   
    clrf    TRISA

    loop:
    BANKSEL PORTA  
    call delay      
    movlw 0x01                                                 
    xorwf PORTA     
    goto loop
    END
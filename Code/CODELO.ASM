                      ROW0             EQU          P2.0
                      ROW1             EQU          P2.1
                      ROW2             EQU          P2.2            
                      ROW3             EQU          P2.3

                      CLMN0            EQU          P2.7
                      CLMN1            EQU          P2.6
                      CLMN2            EQU          P2.5
                      CLMN3            EQU          P2.4

;ALERT            EQU          P3.7   ;goes low when any key's pressed
					
WTCMD   EQU     10100000B       ;WRITE DATA COMMAND Note 3
RDCMD   EQU     10100001B       ;READ DATA COMMAND Note 3
RDEND   EQU     01000000B       ;READ HIGH-ENDURANCE BLOCK NUMBER COMMAND
ADDRH   EQU     0
ADDRL   EQU     0               
BYTCNT  EQU     8
	

;_________________________________________________________________
;-------------------------main code------------------------------
;_________________________________________________________________
	org  0000h
    	LJMP ks_main

	ORG 0003H
	LCALL ISR
	

		org 0100h
ks_main: 

		MOV R0,#40H
		MOV R1,#30H
		MOV IE,#81H
		MOV IP,#01H
		SETB P3.2
		clr p3.7
		clr p3.6
		setb p1.7
	
		MOV A,#38h
		LCALL COMNWRT
	 
		MOV A,#0eh
		LCALL COMNWRT
	
		MOV A,#01
		LCALL COMNWRT
	
		MOV A,#06h
		LCALL COMNWRT
	
		MOV A,#80h
		LCALL COMNWRT
        
         MOV A,#01H
	    LCALL COMNWRT
	    MOV A,#80H
	    LCALL COMNWRT
	    MOV A,#'S'
	    LCALL DATAWRT
	    MOV A,#'T'
	    LCALL DATAWRT
	    MOV A,#'R'
	    LCALL DATAWRT
	    MOV A,#'O'
	    LCALL DATAWRT
	    MOV A,#'N'
	    LCALL DATAWRT
	    MOV A,#'G'
	    LCALL DATAWRT
	    MOV A,#' '
	    LCALL DATAWRT
	    MOV A,#'&'
	    LCALL DATAWRT
	    MOV A,#' '
	    LCALL DATAWRT
	    MOV A,#'S'
	    LCALL DATAWRT
	    MOV A,#'A'
	    LCALL DATAWRT
	    MOV A,#'F'
	    LCALL DATAWRT
	    MOV A,#'E'
	    LCALL DATAWRT
	    MOV A,#' '
	    LCALL DATAWRT
	    
	    
	    MOV A,#0C0H
	    LCALL COMNWRT

	    MOV A,#'S'
	    LCALL DATAWRT
	    MOV A,#'E'
	    LCALL DATAWRT
	    MOV A,#'C'
	    LCALL DATAWRT
	    MOV A,#'U'
	    LCALL DATAWRT
	    MOV A,#'R'
	    LCALL DATAWRT
	    MOV A,#'I'
	    LCALL DATAWRT
	    MOV A,#'T'
	    LCALL DATAWRT
	    MOV A,#'Y'
	    LCALL DATAWRT
	    MOV A,#' '
	    LCALL DATAWRT
	    MOV A,#'S'
	    LCALL DATAWRT
	    MOV A,#'Y'
	    LCALL DATAWRT
	    MOV A,#'S'
	    LCALL DATAWRT
	    MOV A,#'T'
	    LCALL DATAWRT
	    MOV A,#'E'
	    LCALL DATAWRT
	    MOV A,#'M'
	    LCALL DATAWRT
	    MOV A,#'S'
	    LCALL DATAWRT
	    
	    
		 MOV A,#01H
	    LCALL COMNWRT
	    MOV A,#80H
	    LCALL COMNWRT
        
		LCALL BLOKRD
		
		

		LJMP YYY

BLOKRD: MOV     R6,#00H       ;LOAD ADDRESS POINTER FOR HIGH DENSITY ONLY
        MOV     R7,#00h       ;LOAD ADDRESS POINTER FOR ALL DEVICES
        MOV     R1,#30H      ;LOAD DATA POINTER
        MOV     R5,#06     ;LOAD BYTE COUNT
        CALL    BLKRD           ;CALL BLOCK READ ROUTINE
        RET
        

BLKRD:  MOV     A,#WTCMD        ;LOAD WRITE COMMAND TO SEND ADDRESS
        CALL    OUTS            ;SEND IT
        MOV     A,R7           ;GET LOW BYTE ADDRESS
        CALL    OUT             ;SEND IT
        MOV     A,#RDCMD        ;LOAD READ COMMAND
        CALL    OUTS            ;SEND IT
BRDLP:  CALL    IN              ;READ DATA
        MOV     @R1,a           ;STORE DATA
        INC     R1             ;INCREMENT DATA POINTER
        DJNZ    R5,AKLP         ;DECREMENT LOOP COUNTER
        CALL    STOP            ;IF DONE, ISSUE STOP CONDITION
        RET                     ;DONE, EXIT ROUTINE

AKLP:   CLR     P1.1            ;NOT DONE, ISSUE ACK
        SETB   P1.0            
        NOP                     ;NOTE 1
        NOP
        NOP
        NOP                     ;NOTE 2
        NOP
        CLR    P1.0
        JMP     BRDLP           ;CONTINUE WITH READS
  

YYY:


	    MOV A,#'E'
	    LCALL DATAWRT
	    MOV A,#'N'
	    LCALL DATAWRT
	    MOV A,#'T'
	    LCALL DATAWRT
	    MOV A,#'E'
	    LCALL DATAWRT
	    MOV A,#'R'
	    LCALL DATAWRT
	    MOV A,#' '
	    LCALL DATAWRT
	    MOV A,#'P'
	    LCALL DATAWRT
	    MOV A,#'A'
	    LCALL DATAWRT
	    MOV A,#'S'
	    LCALL DATAWRT
	    MOV A,#'S'
	    LCALL DATAWRT
	    MOV A,#'W'
	    LCALL DATAWRT
	    MOV A,#'O'
	    LCALL DATAWRT
	    MOV A,#'R'
	    LCALL DATAWRT
	    MOV A,#'D'
	    LCALL DATAWRT

	    MOV A,#0C5H
	    LCALL COMNWRT

        MOV R0,#40H

		mov p2,#0ffh					;make input ports
            	;mov p3,#00h	;make output ports; never make this mistake => 3.0 n 3.1 are serial pins
;	    	setb ALERT						              
            
	

ks_main1:   	mov p2,#0f0h                    ;all columns high n rows low
            	mov a,p2
            	anl a,#11110000b                ;consider only columns
            	cjne a,#11110000b,ks_main1      ;initially check for all keys released
;-------------------------------------------------------------------                      
ks_loop1:   	LCALL DELAY
            	mov a,p2
            	anl a,#11110000b                            ;scan columns
            	cjne a,#11110000b,debounce         ;if key pressed, check debounce
            	sjmp ks_loop1                       ;if not, keep checking for key pressed
;-------------------------------------------------------------------
debounce:   	LCALL DELAY
            	mov a,p2
            	anl a,#11110000b 
            	cjne a,#11110000b,check_row
            	sjmp ks_loop1
;--------------------------------------------------------------------
check_row:           
						
            	clr ROW0
	    	setb ROW1
	    	setb ROW2
	    	setb ROW3

	    	mov a,p2
            	anl a,#11111110b 			 ;test row zero
            	cjne a,#11111110b,row_0
;--------------------------------------------------------------------			
		setb ROW0
		clr ROW1
		setb ROW2
		setb ROW3
			
            	mov a,p2
            	anl a,#11111101b 			 ;test row one
            	cjne a,#11111101b,row_1
;---------------------------------------------------------------------
            	setb ROW0
		setb ROW1
		clr ROW2
		setb ROW3
			
                mov a,p2
            	anl a,#11111011b			 ;test row two
            	cjne a,#11111011b,row_2
;--------------------------------------------------------------------- 			
		setb ROW0
		setb ROW1
		setb ROW2
		clr ROW3
			
            	mov a,p2
            	anl a,#11110111b  		    ;test row three
            	cjne a,#11110111b,row_3
;----------------------------------------------------------------------
            	sjmp ks_loop1
;----------------------------------------------------------------------
row_0:      mov dptr,#disp_kcode0
             sjmp find_num

row_1:      mov dptr,#disp_kcode1
             sjmp find_num

row_2:      mov dptr,#disp_kcode2
             sjmp find_num
			
row_3:      mov dptr,#disp_kcode3
             sjmp find_num
;----------------------------------------------------------------------
find_num:   rlc a
            jnc found_num      ;which column is pressed/grounded
            inc dptr
            sjmp find_num
;----------------------------------------------------------------------
found_num:  ;clr ALERT ;notify main MC that key has been pressed
            
	    clr a
            movc a,@a+dptr
	    MOV @R0,A	   
	    CJNE A,#'E',DOWN	    
	    SJMP DOWN1
DOWN:	    CJNE A,#'C',DOWN2
	    LJMP CNG_PASS
DOWN2:	    MOV A,#'*'
	    LCALL DATAWRT
	    INC R0
	    jmp ks_main1

DOWN1:	
	    MOV R0,#40H
	    MOV A,@R0
	    CJNE A,30H,WR_DISP
	    INC R0
	    MOV A,@R0
	    CJNE A,31H,WR_DISP
	    INC R0
	    MOV A,@R0
	    CJNE A,32H,WR_DISP
	    INC R0
	    MOV A,@R0
	    CJNE A,33H,WR_DISP
	    INC R0
	    MOV A,@R0
	    CJNE A,34H,WR_DISP
	    INC R0
	    MOV A,@R0
	    CJNE A,35H,WR_DISP

	    LJMP CRT_PASS

WR_DISP:
	    MOV A,#01H
	    LCALL COMNWRT
	    MOV A,#80H
	    LCALL COMNWRT
	    MOV A,#'W'
	    LCALL DATAWRT
	    MOV A,#'R'
	    LCALL DATAWRT
	    MOV A,#'O'
	    LCALL DATAWRT
	    MOV A,#'N'
	    LCALL DATAWRT
	    MOV A,#'G'
	    LCALL DATAWRT
	    MOV A,#' '
	    LCALL DATAWRT
	    MOV A,#'P'
	    LCALL DATAWRT
	    MOV A,#'A'
	    LCALL DATAWRT
	    MOV A,#'S'
	    LCALL DATAWRT
	    MOV A,#'S'
	    LCALL DATAWRT
	    MOV A,#'W'
	    LCALL DATAWRT
	    MOV A,#'O'
	    LCALL DATAWRT
	    MOV A,#'R'
	    LCALL DATAWRT
	    MOV A,#'D'
	    LCALL DATAWRT
	
	      setb p3.6
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	   clr p3.6
	    LJMP ks_main



CRT_PASS:

	    MOV A,#01H
	    LCALL COMNWRT
	    MOV A,#80H
	    LCALL COMNWRT
	    MOV A,#'C'
	    LCALL DATAWRT
	    MOV A,#'O'
	    LCALL DATAWRT
	    MOV A,#'R'
	    LCALL DATAWRT
	    MOV A,#'R'
	    LCALL DATAWRT
	    MOV A,#'E'
	    LCALL DATAWRT
	    MOV A,#'C'
	    LCALL DATAWRT
	    MOV A,#'T'
	    LCALL DATAWRT
	    MOV A,#' '
	    LCALL DATAWRT
	    MOV A,#'P'
	    LCALL DATAWRT
	    MOV A,#'A'
	    LCALL DATAWRT
	    MOV A,#'S'
	    LCALL DATAWRT
	    MOV A,#'S'
	    LCALL DATAWRT
	    MOV A,#'W'
	    LCALL DATAWRT
	    MOV A,#'O'
	    LCALL DATAWRT
	    MOV A,#'R'
	    LCALL DATAWRT
	    MOV A,#'D'
	    LCALL DATAWRT

	    SETB P3.7
        
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY

	    
	;   LJMP ks_main

ZZZ:    MOV R0,#40H
	    MOV A,#01H
	    LCALL COMNWRT

	    MOV A,#80H
	    LCALL COMNWRT

	    MOV A,#'E'
	    LCALL DATAWRT
	    MOV A,#'N'
	    LCALL DATAWRT
	    MOV A,#'T'
	    LCALL DATAWRT
	    MOV A,#'E'
	    LCALL DATAWRT
	    MOV A,#'R'
	    LCALL DATAWRT
	    MOV A,#' '
	    LCALL DATAWRT
	    MOV A,#'P'
	    LCALL DATAWRT
	    MOV A,#'A'
	    LCALL DATAWRT
	    MOV A,#'S'
	    LCALL DATAWRT
	    MOV A,#'S'
	    LCALL DATAWRT
	    MOV A,#'W'
	    LCALL DATAWRT
	    MOV A,#'O'
	    LCALL DATAWRT
	    MOV A,#'R'
	    LCALL DATAWRT
	    MOV A,#'D'
	    LCALL DATAWRT

	    MOV A,#0C5H
	    LCALL COMNWRT



		mov p2,#0ffh					;make input ports
            	;mov p3,#00h	;make output ports; never make this mistake => 3.0 n 3.1 are serial pins
;	    	setb ALERT						              
            
	

ks_main13:   	mov p2,#0f0h                    ;all columns high n rows low
            	mov a,p2
            	anl a,#11110000b                ;consider only columns
            	cjne a,#11110000b,ks_main13      ;initially check for all keys released
;-------------------------------------------------------------------                      
ks_loop13:   	LCALL DELAY
            	mov a,p2
            	anl a,#11110000b                            ;scan columns
            	cjne a,#11110000b,debounce3         ;if key pressed, check debounce
            	sjmp ks_loop13                       ;if not, keep checking for key pressed
;-------------------------------------------------------------------
debounce3:   	LCALL DELAY
            	mov a,p2
            	anl a,#11110000b 
            	cjne a,#11110000b,check_row3
            	sjmp ks_loop13
;--------------------------------------------------------------------
check_row3:           
						
            	clr ROW0
	    	setb ROW1
	    	setb ROW2
	    	setb ROW3

	    	mov a,p2
            	anl a,#11111110b 			 ;test row zero
            	cjne a,#11111110b,row_03
;--------------------------------------------------------------------			
		setb ROW0
		clr ROW1
		setb ROW2
		setb ROW3
			
            	mov a,p2
            	anl a,#11111101b 			 ;test row one
            	cjne a,#11111101b,row_13
;---------------------------------------------------------------------
            	setb ROW0
		setb ROW1
		clr ROW2
		setb ROW3
			
                mov a,p2
            	anl a,#11111011b			 ;test row two
            	cjne a,#11111011b,row_23
;--------------------------------------------------------------------- 			
		setb ROW0
		setb ROW1
		setb ROW2
		clr ROW3
			
            	mov a,p2
            	anl a,#11110111b  		    ;test row three
            	cjne a,#11110111b,row_33
;----------------------------------------------------------------------
            	sjmp ks_loop13
;----------------------------------------------------------------------
row_03:      mov dptr,#disp_kcode03
             sjmp find_num3

row_13:      mov dptr,#disp_kcode13
             sjmp find_num3

row_23:      mov dptr,#disp_kcode23
             sjmp find_num3
			
row_33:      mov dptr,#disp_kcode33
             sjmp find_num3
;----------------------------------------------------------------------
find_num3:   rlc a
            jnc found_num3      ;which column is pressed/grounded
            inc dptr
            sjmp find_num3
;----------------------------------------------------------------------
found_num3:  ;clr ALERT ;notify main MC that key has been pressed
            
	    clr a
            movc a,@a+dptr
	    MOV @R0,A	   
	    CJNE A,#'E',DOWN3	    
	    SJMP DOWN13
DOWN3:	    CJNE A,#'C',DOWN23
	    LJMP CNG_PASS
DOWN23:	    MOV A,#'*'
	    LCALL DATAWRT
	    INC R0
	    jmp ks_main13

DOWN13:	
	    MOV R0,#40H
	    MOV A,@R0
	    CJNE A,30H,WR_DISP3
	    INC R0
	    MOV A,@R0
	    CJNE A,31H,WR_DISP3
	    INC R0
	    MOV A,@R0
	    CJNE A,32H,WR_DISP3
	    INC R0
	    MOV A,@R0
	    CJNE A,33H,WR_DISP3
	    INC R0
	    MOV A,@R0
	    CJNE A,34H,WR_DISP3
	    INC R0
	    MOV A,@R0
	    CJNE A,35H,WR_DISP3

	    LJMP CRT_PASS3
WR_DISP3:
	    
	    MOV A,#01H
	    LCALL COMNWRT
	    MOV A,#80H
	    LCALL COMNWRT
	    MOV A,#'W'
	    LCALL DATAWRT
	    MOV A,#'R'
	    LCALL DATAWRT
	    MOV A,#'O'
	    LCALL DATAWRT
	    MOV A,#'N'
	    LCALL DATAWRT
	    MOV A,#'G'
	    LCALL DATAWRT
	    MOV A,#' '
	    LCALL DATAWRT
	    MOV A,#'P'
	    LCALL DATAWRT
	    MOV A,#'A'
	    LCALL DATAWRT
	    MOV A,#'S'
	    LCALL DATAWRT
	    MOV A,#'S'
	    LCALL DATAWRT
	    MOV A,#'W'
	    LCALL DATAWRT
	    MOV A,#'O'
	    LCALL DATAWRT
	    MOV A,#'R'
	    LCALL DATAWRT
	    MOV A,#'D'
	    LCALL DATAWRT
	    setb p3.6
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	   clr p3.6
	    LJMP ZZZ

CRT_PASS3:

	    MOV A,#01H
	    LCALL COMNWRT
	    MOV A,#80H
	    LCALL COMNWRT
	    MOV A,#'C'
	    LCALL DATAWRT
	    MOV A,#'O'
	    LCALL DATAWRT
	    MOV A,#'R'
	    LCALL DATAWRT
	    MOV A,#'R'
	    LCALL DATAWRT
	    MOV A,#'E'
	    LCALL DATAWRT
	    MOV A,#'C'
	    LCALL DATAWRT
	    MOV A,#'T'
	    LCALL DATAWRT
	    MOV A,#' '
	    LCALL DATAWRT
	    MOV A,#'P'
	    LCALL DATAWRT
	    MOV A,#'A'
	    LCALL DATAWRT
	    MOV A,#'S'
	    LCALL DATAWRT
	    MOV A,#'S'
	    LCALL DATAWRT
	    MOV A,#'W'
	    LCALL DATAWRT
	    MOV A,#'O'
	    LCALL DATAWRT
	    MOV A,#'R'
	    LCALL DATAWRT
	    MOV A,#'D'
	    LCALL DATAWRT
        CLR P3.7
        
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY

	   
	   LJMP ks_main
	    
CNG_PASS:
	     MOV R0,#40H
	    MOV A,#01H
	    LCALL COMNWRT
	    MOV A,#80H
	    LCALL COMNWRT
	    MOV A,#'C'
	    LCALL DATAWRT
	    MOV A,#'H'
	    LCALL DATAWRT
	    MOV A,#'A'
	    LCALL DATAWRT
	    MOV A,#'N'
	    LCALL DATAWRT
	    MOV A,#'G'
	    LCALL DATAWRT
	    MOV A,#'E'
	    LCALL DATAWRT
	    MOV A,#' '
	    LCALL DATAWRT
	    MOV A,#'P'
	    LCALL DATAWRT
	    MOV A,#'A'
	    LCALL DATAWRT
	    MOV A,#'S'
	    LCALL DATAWRT
	    MOV A,#'S'
	    LCALL DATAWRT
	    MOV A,#'W'
	    LCALL DATAWRT
	    MOV A,#'O'
	    LCALL DATAWRT
	    MOV A,#'R'
	    LCALL DATAWRT
	    MOV A,#'D'
	    LCALL DATAWRT

	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY

	    MOV A,#01H
	    LCALL COMNWRT
	    MOV A,#80H
	    LCALL COMNWRT
	    MOV A,#'E'
	    LCALL DATAWRT
	    MOV A,#'N'
	    LCALL DATAWRT
	    MOV A,#'T'
	    LCALL DATAWRT
	    MOV A,#'E'
	    LCALL DATAWRT
	    MOV A,#'R'
	    LCALL DATAWRT
	    MOV A,#' '
	    LCALL DATAWRT
	    MOV A,#'O'
	    LCALL DATAWRT
	    MOV A,#'L'
	    LCALL DATAWRT
	    MOV A,#'D'
	    LCALL DATAWRT
	    MOV A,#' '
	    LCALL DATAWRT
	    MOV A,#'P'
	    LCALL DATAWRT
	    MOV A,#'A'
	    LCALL DATAWRT
	    MOV A,#'S'
	    LCALL DATAWRT
	    MOV A,#'S'
	    LCALL DATAWRT
	   
	    MOV A,#0C5H
	    LCALL COMNWRT

ks_main12:   	mov p2,#0f0h                    ;all columns high n rows low
            	mov a,p2
            	anl a,#11110000b                ;consider only columns
            	cjne a,#11110000b,ks_main12     ;initially check for all keys released
;-------------------------------------------------------------------                      
ks_loop12:   	LCALL DELAY
            	mov a,p2
            	anl a,#11110000b                            ;scan columns
            	cjne a,#11110000b,debounce12         ;if key pressed, check debounce
            	sjmp ks_loop12                       ;if not, keep checking for key pressed
;-------------------------------------------------------------------
debounce12:   	LCALL DELAY
            	mov a,p2
            	anl a,#11110000b 
            	cjne a,#11110000b,check_row2
            	sjmp ks_loop12
;--------------------------------------------------------------------
check_row2:           
						
            	clr ROW0
	    	setb ROW1
	    	setb ROW2
	    	setb ROW3

	    	mov a,p2
            	anl a,#11111110b 			 ;test row zero
            	cjne a,#11111110b,row_02
;--------------------------------------------------------------------			
		setb ROW0
		clr ROW1
		setb ROW2
		setb ROW3
			
            	mov a,p2
            	anl a,#11111101b 			 ;test row one
            	cjne a,#11111101b,row_12
;---------------------------------------------------------------------
            	setb ROW0
		setb ROW1
		clr ROW2
		setb ROW3
			
                mov a,p2
            	anl a,#11111011b			 ;test row two
            	cjne a,#11111011b,row_22
;--------------------------------------------------------------------- 			
		setb ROW0
		setb ROW1
		setb ROW2
		clr ROW3
			
            	mov a,p2
            	anl a,#11110111b  		    ;test row three
            	cjne a,#11110111b,row_32
;----------------------------------------------------------------------
            	sjmp ks_loop12
;----------------------------------------------------------------------
row_02:      mov dptr,#disp_kcode02
             sjmp find_num2

row_12:      mov dptr,#disp_kcode12
             sjmp find_num2

row_22:      mov dptr,#disp_kcode22
             sjmp find_num2
			
row_32:      mov dptr,#disp_kcode3
             sjmp find_num2
;----------------------------------------------------------------------
find_num2:   rlc a
            jnc found_num2      ;which column is pressed/grounded
            inc dptr
            sjmp find_num2
;----------------------------------------------------------------------
found_num2:  ;clr ALERT ;notify main MC that key has been pressed
            
	    clr a
            movc a,@a+dptr
	    MOV @R0,A
	    CJNE A,#'E',DOWNC2	    
	    SJMP DOWN12
DOWNC2:	     MOV A,#'*'
	    LCALL DATAWRT
	    INC R0
	    jmp ks_main12

DOWN12:	    
	    MOV R0,#40H
	    MOV A,@R0
	    CJNE A,30H,WR_DISP1
	    INC R0
	    MOV A,@R0
	    CJNE A,31H,WR_DISP1
	    INC R0
	    MOV A,@R0
	    CJNE A,32H,WR_DISP1
	    INC R0
	    MOV A,@R0
	    CJNE A,33H,WR_DISP1
	    INC R0
	    MOV A,@R0
	    CJNE A,34H,WR_DISP1
	    INC R0
	    MOV A,@R0
	    CJNE A,35H,WR_DISP1	

	    LJMP ENTR_PASS

WR_DISP1:
	    MOV A,#01H
	    LCALL COMNWRT
	    MOV A,#80H
	    LCALL COMNWRT
	    MOV A,#'W'
	    LCALL DATAWRT
	    MOV A,#'R'
	    LCALL DATAWRT
	    MOV A,#'O'
	    LCALL DATAWRT
	    MOV A,#'N'
	    LCALL DATAWRT
	    MOV A,#'G'
	    LCALL DATAWRT
	    MOV A,#' '
	    LCALL DATAWRT
	    MOV A,#'P'
	    LCALL DATAWRT
	    MOV A,#'A'
	    LCALL DATAWRT
	    MOV A,#'S'
	    LCALL DATAWRT
	    MOV A,#'S'
	    LCALL DATAWRT
	    MOV A,#'W'
	    LCALL DATAWRT
	    MOV A,#'O'
	    LCALL DATAWRT
	    MOV A,#'R'
	    LCALL DATAWRT
	    MOV A,#'D'
	    LCALL DATAWRT
	   setb p3.6
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	   clr p3.6
	    LJMP ks_main
   	    
ENTR_PASS:	    
	     MOV A,#01H
	    LCALL COMNWRT
	    MOV A,#80H
	    LCALL COMNWRT
	    MOV A,#'C'
	    LCALL DATAWRT
	    MOV A,#'O'
	    LCALL DATAWRT
	    MOV A,#'R'
	    LCALL DATAWRT
	    MOV A,#'R'
	    LCALL DATAWRT
	    MOV A,#'E'
	    LCALL DATAWRT
	    MOV A,#'C'
	    LCALL DATAWRT
	    MOV A,#'T'
	    LCALL DATAWRT
	    MOV A,#' '
	    LCALL DATAWRT
	    MOV A,#'P'
	    LCALL DATAWRT
	    MOV A,#'A'
	    LCALL DATAWRT
	    MOV A,#'S'
	    LCALL DATAWRT
	    MOV A,#'S'
	    LCALL DATAWRT
	    MOV A,#'W'
	    LCALL DATAWRT
	    MOV A,#'O'
	    LCALL DATAWRT
	    MOV A,#'R'
	    LCALL DATAWRT
	    MOV A,#'D'
	    LCALL DATAWRT

	     LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    LCALL DELAY
	    

	    MOV A,#01H
	    LCALL COMNWRT
	    MOV A,#80H
	    LCALL COMNWRT
	    MOV A,#'E'
	    LCALL DATAWRT
	    MOV A,#'N'
	    LCALL DATAWRT
	    MOV A,#'T'
	    LCALL DATAWRT
	    MOV A,#'E'
	    LCALL DATAWRT
	    MOV A,#'R'
	    LCALL DATAWRT
	    MOV A,#' '
	    LCALL DATAWRT
	    MOV A,#'N'
	    LCALL DATAWRT
	    MOV A,#'E'
	    LCALL DATAWRT
	    MOV A,#'W'
	    LCALL DATAWRT
	    MOV A,#' '
	    LCALL DATAWRT
	    MOV A,#'P'
	    LCALL DATAWRT
	    MOV A,#'A'
	    LCALL DATAWRT
	    MOV A,#'S'
	    LCALL DATAWRT
	    MOV A,#'S'
	    LCALL DATAWRT
	   
	    MOV A,#0C5H
	    LCALL COMNWRT

	    MOV R1,#30H

ks_main11:   	mov p2,#0f0h                    ;all columns high n rows low
            	mov a,p2
            	anl a,#11110000b                ;consider only columns
            	cjne a,#11110000b,ks_main11      ;initially check for all keys released
;-------------------------------------------------------------------                      
ks_loop11:   	LCALL DELAY
            	mov a,p2
            	anl a,#11110000b                            ;scan columns
            	cjne a,#11110000b,debounce1         ;if key pressed, check debounce
            	sjmp ks_loop11                       ;if not, keep checking for key pressed
;-------------------------------------------------------------------
debounce1:   	LCALL DELAY
            	mov a,p2
            	anl a,#11110000b 
            	cjne a,#11110000b,check_row1
            	sjmp ks_loop11
;--------------------------------------------------------------------
check_row1:           
						
            	clr ROW0
	    	setb ROW1
	    	setb ROW2
	    	setb ROW3

	    	mov a,p2
            	anl a,#11111110b 			 ;test row zero
            	cjne a,#11111110b,row_01
;--------------------------------------------------------------------			
		setb ROW0
		clr ROW1
		setb ROW2
		setb ROW3
			
            	mov a,p2
            	anl a,#11111101b 			 ;test row one
            	cjne a,#11111101b,row_11
;---------------------------------------------------------------------
            	setb ROW0
		setb ROW1
		clr ROW2
		setb ROW3
			
                mov a,p2
            	anl a,#11111011b			 ;test row two
            	cjne a,#11111011b,row_21
;--------------------------------------------------------------------- 			
		setb ROW0
		setb ROW1
		setb ROW2
		clr ROW3
			
            	mov a,p2
            	anl a,#11110111b  		    ;test row three
            	cjne a,#11110111b,row_31
;----------------------------------------------------------------------
            	sjmp ks_loop11
;----------------------------------------------------------------------
row_01:      mov dptr,#disp_kcode01
             sjmp find_num1

row_11:      mov dptr,#disp_kcode11
             sjmp find_num1

row_21:      mov dptr,#disp_kcode21
             sjmp find_num1
			
row_31:      mov dptr,#disp_kcode31
             sjmp find_num1
;----------------------------------------------------------------------
find_num1:   rlc a
            jnc found_num1      ;which column is pressed/grounded
            inc dptr
            sjmp find_num1
;----------------------------------------------------------------------
found_num1:  ;clr ALERT ;notify main MC that key has been pressed
            
	    clr a
            movc a,@a+dptr
	    MOV @R1,A	   	
            CJNE A,#'E',DOWN111	    
	    SJMP DOWN11
DOWN111:     MOV A,#'*'
	    LCALL DATAWRT
	    INC R1	   
	    LJMP ks_main11

;;;;;;;;;;; EEPROM WRITE ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DOWN11:
	LCALL BLKWR

	LJMP ks_main	
		


BLKWR:  MOV     R6,#00H     ;LOAD ADDRESS POINTER FOR HIGH DENSITY ONLY
        MOV     R7,#00H     ;LOAD ADDRESS POINTER FOR ALL DEVICES
        MOV     R1,#30H    ;LOAD BYTE POINTER
        MOV     R5,#06    ;LOAD BYTE COUNT
        CALL    PAGEW         ;CALL PAGE WRITE ROUTINE
        RET

PAGEW:  MOV     A,#WTCMD        ;LOAD WRITE COMMAND
        CALL    OUTS            ;SEND IT
        MOV     A,R7            ;GET LOW BYTE ADDRESS
        CALL    OUT             ;SEND IT
BTLP:   MOV     A,@R1          ;GET DATA
        CALL    OUT             ;SEND IT
        INC     R1              ;INCREMENT DATA POINTER
        DJNZ    R5,BTLP         ;LOOP TILL DONE
        CALL    STOP            ;SEND STOP CONDITION
        RET      





ACKTST: MOV     A,#WTCMD        ;LOAD WRITE COMMAND TO SEND ADDRESS
        MOV     R2,#8           ;LOOP COUNT -- EQUAL TO BIT COUNT
        CLR     P1.1            ;START CONDITION -- DATA = 0
        NOP                     ;NOTE 1
        NOP
        NOP
        NOP                     ;NOTE 2
        NOP     
        CLR    P1.0            ;CLOCK = 0
AKTLP:  RLC     A               ;SHIFT BIT
        JNC     AKTLS
        SETB    P1.1            ;DATA = 1
        JMP     AKTL1           ;CONTINUE
AKTLS:  CLR     P1.1            ;DATA = 0
AKTL1:  SETB   P1.0            ;CLOCK HI
        NOP                     ;NOTE 1
        NOP
        NOP
        NOP                     ;NOTE 2
        NOP
        CLR    P1.0            ;CLOCK LOW
        DJNZ    R2,AKTLP        ;DECREMENT COUNTER
        SETB    P1.1            ;TURN PIN INTO INPUT
        NOP                     ;NOTE 1
        NOP                     ;NOTE 2
        SETB   P1.0            ;CLOCK ACK
        NOP                     ;NOTE 1
        NOP
        NOP
        NOP                     ;NOTE 2
        NOP
        JNB     P1.1,EXIT       ;EXIT IF ACK (WRITE DONE)
        JMP     ACKTST          ;START OVER
EXIT:   CLR    P1.0            ;CLOCK LOW
        CLR     P1.1            ;DATA LOW
        NOP                     ;NOTE 1
        NOP
        NOP
        NOP                     ;NOTE 2
        NOP
        SETB   P1.0            ;CLOCK HIGH
        NOP
        NOP
        SETB    P1.1            ;STOP CONDITION
        RET

OUTS:   MOV     R2,#8           ;LOOP COUNT -- EQUAL TO BIT COUNT
        SETB    P1.1            ;INSURE DATA IS HI               
        SETB   P1.0            ;INSURE CLOCK IS HI
        NOP                     ;NOTE 1
        NOP                     
        NOP
        NOP                     ;NOTE 2
        NOP
        CLR     P1.1            ;START CONDITION -- DATA = 0
        NOP                     ;NOTE 1
        NOP      
        NOP
        NOP                     ;NOTE 2
        NOP
        CLR    P1.0            ;CLOCK = 0
OTSLP:  RLC     A               ;SHIFT BIT
        JNC     BITLS
        SETB    P1.1            ;DATA = 1
        JMP     OTSL1           ;CONTINUE
BITLS:  CLR     P1.1            ;DATA = 0
OTSL1:  SETB   P1.0            ;CLOCK HI
        NOP                     ;NOTE 1
        NOP
        NOP
        NOP                     ;NOTE 2
        NOP
        CLR    P1.0            ;CLOCK LOW
        DJNZ    R2,OTSLP        ;DECREMENT COUNTER
        SETB    P1.1            ;TURN PIN INTO INPUT
        NOP                     ;NOTE 1
        NOP                     ;NOTE 2
        NOP                     
        SETB   P1.0            ;CLOCK ACK
        NOP                     ;NOTE 1
        NOP
        NOP
        NOP                     ;NOTE 2
        NOP
        CLR    P1.0
        RET

OUT:    MOV     R2,#8           ;LOOP COUNT -- EQUAL TO BIT COUNT
OTLP:   RLC     A               ;SHIFT BIT
        JNC     BITL            
        SETB    P1.1            ;DATA = 1
        JMP     OTL1            ;CONTINUE
BITL:   CLR     P1.1            ;DATA = 0
OTL1:   SETB   P1.0            ;CLOCK HI
        NOP                     ;NOTE 1
        NOP
        NOP
        NOP                     ;NOTE 2
        NOP
        CLR    P1.0            ;CLOCK LOW
        DJNZ    R2,OTLP         ;DECREMENT COUNTER
        SETB    P1.1            ;TURN PIN INTO INPUT
        NOP                     ;NOTE 1
        NOP                     ;NOTE 2
        NOP
        SETB   P1.0            ;CLOCK ACK
        NOP                     ;NOTE 1
        NOP
        NOP
        NOP                     ;NOTE 2
        NOP
        CLR    P1.0
        RET

IN:     MOV     R2,#8           ;LOOP COUNT
        SETB    P1.1            ;SET DATA BIT HIGH FOR INPUT
INLP:   CLR    P1.0            ;CLOCK LOW
        NOP                     ;NOTE 1
        NOP
        NOP
        NOP
        NOP                     ;NOTE 2
        NOP
        SETB   P1.0            ;CLOCK HIGH
        CLR     C               ;CLEAR CARRY
        JNB     P1.1,INL1       ;JUMP IF DATA = 0
        CPL     C               ;SET CARRY IF DATA = 1
INL1:   RLC     A               ;ROTATE DATA INTO ACCUMULATOR
        DJNZ    R2,INLP         ;DECREMENT COUNTER
        CLR    P1.0            ;CLOCK LOW
        RET
        

STOP:   CLR     P1.1            ;STOP CONDITION SET DATA LOW
        NOP                     ;NOTE 1
        NOP
        NOP
        NOP                     ;NOTE 2
        NOP
        SETB   P1.0            ;SET CLOCK HI
        NOP                     ;NOTE 1
        NOP
        NOP
        NOP                     ;NOTE 2
        NOP
        SETB    P1.1            ;SET DATA HIGH		
        RET


ISR:
	
		MOV A,#38h
		LCALL COMNWRT
	 
		MOV A,#0eh
		LCALL COMNWRT
	
		MOV A,#01
		LCALL COMNWRT
	
		MOV A,#06h
		LCALL COMNWRT
	
		MOV A,#80h
		LCALL COMNWRT

	    MOV A,#01H
	    LCALL COMNWRT
	    MOV A,#80H
	    LCALL COMNWRT
	    MOV A,#'D'
	    LCALL DATAWRT
	    MOV A,#'E'
	    LCALL DATAWRT
	    MOV A,#'F'
	    LCALL DATAWRT
	    MOV A,#'U'
	    LCALL DATAWRT
	    MOV A,#'L'
	    LCALL DATAWRT
	    MOV A,#'T'
	    LCALL DATAWRT
	    MOV A,#' '
	    LCALL DATAWRT
	    MOV A,#'M'
	    LCALL DATAWRT
	    MOV A,#'O'
	    LCALL DATAWRT
	    MOV A,#'D'
	    LCALL DATAWRT
	    MOV A,#'E'
	    LCALL DATAWRT
	    
	    MOV 30H,#'0'
	    MOV 31H,#'0'
	    MOV 32H,#'0'
	    MOV 33H,#'0'
	    MOV 34H,#'0'
	    MOV 35H,#'0'
	
	    LCALL BLKWR
	
	    RET
	    


;----------------------------------------------------------------------
;------------------------------20ms delay----------------------------------


COMNWRT: 
        	mov p0,a
		clr p3.3
		clr p3.4
		setb p3.5
		LCALL DELAY
		clr p3.5
		ret


DATAWRT:
        	mov p0,a
		setb p3.3
		clr p3.4
		setb P3.5
		LCALL DELAY
		clr p3.5
		ret
DELAY:
        mov r3,#150
here2:	mov r4,#255
here:   djnz r4,here
         djnz r3,here2
		 ret



            
;-----------------------------------------------------------------------
disp_kcode0:DB '1','2','3'
disp_kcode1:DB '4','5','6' 
disp_kcode2:DB '7','8','9' 
disp_kcode3:DB 'C','0','E' 
;-----------------------------------------------------------------------


;-----------------------------------------------------------------------
disp_kcode01:DB '1','2','3'
disp_kcode11:DB '4','5','6' 
disp_kcode21:DB '7','8','9' 
disp_kcode31:DB 'C','0','E' 
;-----------------------------------------------------------------------

;-----------------------------------------------------------------------
disp_kcode02:DB '1','2','3'
disp_kcode12:DB '4','5','6' 
disp_kcode22:DB '7','8','9' 
disp_kcode32:DB 'C','0','E' 
;-----------------------------------------------------------------------

;-----------------------------------------------------------------------
disp_kcode03:DB '1','2','3'
disp_kcode13:DB '4','5','6' 
disp_kcode23:DB '7','8','9' 
disp_kcode33:DB 'C','0','E' 
;-----------------------------------------------------------------------





end   

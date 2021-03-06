.data
.align 2
board1: .word 0x00020004 0x00020004 0x00020004
              0x00040002 0x00040002 0x00040002
              0x00020004 0x00020004 0x00020004
              0x00040002 0x00040002 0x00040002
              
board2: .half 0x0004 0x0002 0x0002 0xffff 0x0004 0xffff 0xffff
	      0xffff 0x0004 0xffff 0xffff 0x0002 0xffff 0xffff
	      0xffff 0x0004 0x0002 0xffff 0x0002 0x0004 0xffff
	      0xffff 0xffff 0xffff 0xffff 0xffff 0x0004 0xffff
	      0xffff 0xffff 0xffff 0xffff 0xffff 0xffff 0xffff
	      0xffff 0x0004 0x0002 0xffff 0x0002 0x0004 0xffff
	      0xffff 0x0004 0x0002 0xffff 0xffff 0x0004 0xffff
	      0xffff 0xffff 0x0004 0xffff 0x0002 0x0002 0x0004

board3: .word 0x00020004 0x00040002 0x00020002
	      0x00020002 0x00020004 0x00040002
	      0x00020004 0x00040002 0x00020002
	      0x00020002 0x00020004 0x00040002
                    
board4: .word 0x00020002 0x00020002
	      0x00020002 0x00020002
	      0xffffffff 0x0004ffff
	      0xffffffff 0x0004ffff
	      
board5: .half 0x0010 0x0020 0x0004 0x0004 0x0004 0x0004 0x0004 0x0010 0x0020
	      0x0010 0x0020 0x0004 0x0004 0x0004 0x0004 0x0004 0x0010 0x0020
	      0x0020 0x0010 0x0004 0x0004 0x0004 0x0004 0x0004 0x0020 0x0010
	      0x0020 0x0010 0x0004 0x0004 0x0004 0x0004 0x0004 0x0020 0x0010
	      
myGame: .half 	0x0100 0x0100 0x0100 0x0100 0x0100
		0xffff 0xffff 0xffff 0xffff 0xffff
		0x0100 0xffff 0xffff 0xffff 0xffff 
		0x0200 0xffff 0xffff 0xffff 0xffff 
		
shiftLeftE: .half 0xffff 0xffff 0xffff 0xffff 0x0002
		 0x0002 0x0002 0xffff 0xffff 0xffff
		 0x0002 0xffff 0xffff 0xffff 0x0002
		 0xffff 0xffff 0xffff 0x0002 0x0002
		 0xffff 0x0002 0xffff 0x0002 0xffff 
		 
shiftRightE: .half 0x0002 0xffff 0xffff 0xffff 0xffff
		  0xffff 0xffff 0xffff 0x0002 0x0002
		  0x0002 0xffff 0xffff 0xffff 0x0002
		  0x0002 0x0002 0xffff 0xffff 0xffff
		  0xffff 0x0002 0xffff 0x0002 0xffff
		  
shiftUpE: .half 	0xffff 0x0002 0x0002 0xffff 0xffff
		0xffff 0x0002 0xffff 0xffff 0x0002
		0xffff 0xffff 0xffff 0xffff 0xffff
		0xffff 0xffff 0xffff 0x0002 0x0002
		0x0002 0xffff 0x0002 0x0002 0xffff
		
shiftDownE: .half 0x0002 0xffff 0x0002 0x0002 0xffff
	0xffff 0xffff 0xffff 0x0002 0x0002
	0xffff 0xffff 0xffff 0xffff 0xffff
	0xffff 0x0002 0xffff 0xffff 0x0002
	0xffff 0x0002 0x0002 0xffff 0xffff

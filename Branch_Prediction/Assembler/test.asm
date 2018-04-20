Start:		addi $1, $0, 2			#store 2 into $1. This is a constant.
		addi $2, $0, 0			#store  into $1
		slti $3, $1, 1			#check if $1 = 2 > 1
		bne $3, $0, Notake1		#it is, thus the branch is not taken
		addi $2, $2, 1			#increment $2
Notake1:	slti $3, $1, 3			#check if $1 = 2 > 3
		bne $3, $0, Take1		#it is not, thus the branch is taken
		addi $2, $2, 1			#this code is not reached
Take1:		slti $3, $1, 1			#--
		bne $3, $0, Notake2		
		addi $2, $2, 1
Notake2:	slti $3, $1, 3			
		bne $3, $0, Take2
		addi $2, $2, 1
Take2:		slti $3, $1, 1			#--
		bne $3, $0, Notake3	
		addi $2, $2, 1
Notake3:	slti $3, $1, 3			
		bne $3, $0, Take3
		addi $2, $2, 1
Take3:		slti $3, $1, 1			#--
		bne $3, $0, Notake4
		addi $2, $2, 1
Notake4:	slti $3, $1, 3			
		bne $3, $0, Take4
		addi $2, $2, 1
Take4:		slti $3, $1, 1			#--
		bne $3, $0, Notake5
		addi $2, $2, 1
Notake5:	slti $3, $1, 3			
		bne $3, $0, Take5
		addi $2, $2, 1
Take5:		slti $3, $1, 1			#--
		bne $3, $0, Notake6
		addi $2, $2, 1
Notake6:	slti $3, $1, 3			
		bne $3, $0, Take6
		addi $2, $2, 1
Take6:		slti $3, $1, 1			#--
		bne $3, $0, Notake7
		addi $2, $2, 1
Notake7:	slti $3, $1, 3			
		bne $3, $0, Take7
		addi $2, $2, 1
Take7:		slti $3, $1, 1			#--
		bne $3, $0, Notake8
		addi $2, $2, 1
Notake8:	slti $3, $1, 3			
		bne $3, $0, Take8
		addi $2, $2, 1
Take8:		slti $3, $1, 1			#--
		bne $3, $0, Notake9
		addi $2, $2, 1
Notake9:	slti $3, $1, 3			
		bne $3, $0, Take9
		addi $2, $2, 1
Take9:		slti $3, $1, 1			#check if $1 = 2 > 1
		bne $3, $0, Notake10		#it is, thus the branch is not taken
		addi $2, $2, 1			#increment $2
Notake10:	slti $3, $1, 3			#check if $1 = 2 > 3
		bne $3, $0, Take10		#it is not, thus the branch is taken
		addi $2, $2, 1			#this code is not reached
Take10:		add $0, $0, $0			#stall before terminating
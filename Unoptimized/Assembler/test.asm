Start:		addi $1, $0, 2			#store 2 into $1. This is a constant.
		addi $2, $0, 0			#store  into $1
		slti $3, $1, 3			#check if $1 = 2 > 3
		add $0, $0, $0
		add $0, $0, $0
		add $0, $0, $0
		bne $3, $0, Take1		#it is not, thus the branch is taken
		add $0, $0, $0			
Take1:		slti $3, $1, 3			#check if $1 = 2 > 3
		bne $3, $0, Take2		#it is not, thus the branch is taken
		add $0, $0, $0		
Take2:		slti $3, $1, 3			#--
		bne $3, $0, Take3		
		add $0, $0, $0
Take3:		slti $3, $1, 3			
		bne $3, $0, Take4
		add $0, $0, $0
Take4:		slti $3, $1, 3			#--
		bne $3, $0, Take5	
		add $0, $0, $0
Take5:		slti $3, $1, 3			#--
		bne $3, $0, Take6
		add $0, $0, $0
Take6:		slti $3, $1, 3			#--
		bne $3, $0, Take7
		add $0, $0, $0
Take7:		slti $3, $1, 3			
		bne $3, $0, Take8
		add $0, $0, $0
Take8:		slti $3, $1, 3			#--
		bne $3, $0, Take9
		add $0, $0, $0
Take9:		slti $3, $1, 3			
		bne $3, $0, Take10
		add $0, $0, $0
Take10:		slti $3, $1, 3			#--
		bne $3, $0, Take11
		add $0, $0, $0
Take11:		slti $3, $1, 3			
		bne $3, $0, Take12
		add $0, $0, $0
Take12:		slti $3, $1, 3			#--
		bne $3, $0, Take13
		add $0, $0, $0
Take13:		slti $3, $1, 3			
		bne $3, $0, Take14
		add $0, $0, $0
Take14:		slti $3, $1, 3			#--
		bne $3, $0, Take15
		add $0, $0, $0
Take15:		slti $3, $1, 3			
		bne $3, $0, Take16
		add $0, $0, $0
Take16:		slti $3, $1, 3			#check if $1 = 2 > 3
		bne $3, $0, Take17		#it is not, thus the branch is taken
		add $0, $0, $0			
Take17:		slti $3, $1, 3			#check if $1 = 2 > 3
		bne $3, $0, Take18		#it is not, thus the branch is taken
		add $0, $0, $0	
Take18:		slti $3, $1, 3			
		bne $3, $0, Take19
		add $0, $0, $0
Take19:		slti $3, $1, 3			
		bne $3, $0, Take20
		add $0, $0, $0			
Take20:		add $0, $0, $0			#stall before terminating



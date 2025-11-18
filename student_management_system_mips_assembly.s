.data
	arrayIndex: .space 40 
	arrayMark: .space 40	
	promtMenu: .asciiz "1. Add Student\n2. Display All Students\n3. Search by Index Number\n4. Display Average Marks\n5. Exit\n" 
	promtChoice: .asciiz "Enter your choice: "
	promtIndexSrch: .asciiz "Enter index number to search: "
	promtInIndex: .asciiz "Enter index number: "
	promtInMarks: .asciiz "Enter marks: "
	msgSuccess: .asciiz "Student added successfully!\n"
	msgAvg: .asciiz "Average Marks: "
	msgIndex: .asciiz "Index No: "
	msgMark: .asciiz "Marks: "
	msgNotFound: .asciiz "Student not found.\n"
	msgOverr1: .asciiz "Student "
	msgOverr2: .asciiz " already exists. Are you sure you want to override? [y/n] "
	msgIndexErr: .asciiz "Choose a valid index.\n"
	msgChoiceErr: .asciiz "Choose a valid option.\n"
	msgExit: .asciiz "Exiting program.\n"
	comma: .asciiz ", "
	newline: .asciiz "\n"

.text
.globl main

main:

	la $s0, arrayIndex
	la $s1, arrayMark

	menu:
	li $v0, 4
	la $a0, promtMenu
	syscall
	la $a0, promtChoice
	syscall
	
	li $v0, 5
	syscall
	add $t0, $v0, $zero # t0: choice
	
	# 1. Add Student
	addi $t1, $zero, 1
	bne $t0, $t1, option2
	jal addStudent
	j menu
	
	option2:
	# 2. Display All Students
	addi $t1, $zero, 2
	bne $t0, $t1, option3
	jal displayStudents
	j menu
	
	option3:
	# 3. Search by Index Number
	addi $t1, $zero, 3
	bne $t0, $t1, option4
	jal searchbyIndex
	j menu
	
	option4:
	# 4. Display Average Marks
	addi $t1, $zero, 4
	bne $t0, $t1, option5
	jal displayAvgMarks
	j menu
	
	option5:
	# Exit
	addi $t1, $zero, 5
	bne $t0, $t1, choiceError
	li $v0, 10
	syscall
	
	choiceError:
	# Not a valid option error
	li $v0, 4
	la $a0, msgChoiceErr
	syscall
	li $v0, 4
	la $a0, newline
	syscall
	j menu
	
addStudent:
	li $v0, 4
	la $a0, promtInIndex
	syscall
	li $v0, 5
	syscall
	add $t2, $v0, $zero # t2: student's index
	addi $t3, $zero, 1
	addi $t4, $zero, 10
	addStudentLoop:
	slt $t5, $t4, $t3
	bne $t5, $zero, indexErr
	j indexCheckCont
	indexErr:
	li $v0, 4
	la $a0, msgIndexErr
	syscall
	j addStudent
	indexCheckCont:
	beq $t2, $t3, indexChecked
	addi $t3, $t3, 1
	j addStudentLoop
	indexChecked:
	
	addi $t3, $t2, -1
	sll $t3, $t3, 2
	add $t3, $t3, $s0 # t3: address of the indexed position in the Index array
	lw $t4, 0($t3)
	
	beq $t2, $t4, warning
	j addCont
	
	warning:
	li $v0, 4
	la $a0, msgOverr1
	syscall
	li $v0, 1
	add $a0, $t2, $zero
	syscall
	li $v0, 4
	la $a0, msgOverr2
	syscall
	li $v0, 12
	syscall
	add $t0, $v0, $zero
	li $v0, 4
	la $a0, newline
	syscall
	syscall
	beq $t0, 121, addCont # y
	beq $t0, 89, addCont # Y
	j menu
	
	addCont:
	sw $t2, 0($t3)
	li $v0, 4
	la $a0, promtInMarks
	syscall
	li $v0, 5
	syscall
	add $t1, $v0, $zero
	
	addi $t3, $t2, -1
	sll $t3, $t3, 2
	add $t3, $t3, $s1 # t3: address of the indexed position in the Marks array
	sw $t1, 0($t3)
	
	li $v0, 4
	la $a0, msgSuccess
	syscall
	la $a0, newline
	syscall	
	jr $ra	
	
displayStudents:
	li $v0, 4
	la $a0, newline
	syscall
	
	addi $s2, $zero, 0
	addi $s3, $zero, 9
	
	displayStudentsLoop:
	slt $t2, $s3, $s2
	bne $t2, $zero, exit
	add $a0, $s2, $zero
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal displayStudent
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $s2, $s2, 1
	j displayStudentsLoop
	
	exit: 
	jr $ra
	
displayStudent: # display 1 student at each call
	add $t2, $a0, $zero
	sll $a0, $a0, 2
	add $t0, $a0, $s0 # Index
	add $t1, $a0, $s1 # Mark
	lw $t0, 0($t0)
	lw $t1, 0($t1)
	add $t2, $t2, 1
	beq $t0, $t2, studentExists
	addi $v0, $zero, 1
	j returnDisSt
	
	studentExists:
	li $v0, 4
	la $a0, msgIndex
	syscall
	add $a0, $t0, $zero
	li $v0, 1
	syscall
	li $v0, 4
	la $a0, comma
	syscall
	li $v0, 4
	la $a0, msgMark
	syscall
	add $a0, $t1, $zero
	li $v0, 1
	syscall
	li $v0, 4
	la $a0, newline
	syscall
	syscall
	add $v0, $zero, $zero
	
	returnDisSt:
	jr $ra
	
searchbyIndex:
	li $v0, 4
	la $a0, promtIndexSrch
	syscall
	li $v0, 5
	syscall
	
	add $a0, $v0, -1
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal displayStudent
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	bne $v0, $zero, searchbyIndexStudentNotFound
	j searchbyIndexCont
	
	searchbyIndexStudentNotFound:
	li $v0, 4
	la $a0, msgNotFound
	syscall
	li $v0, 4
	la $a0, newline
	syscall
	syscall
	
	searchbyIndexCont:
	jr $ra
	
displayAvgMarks:
	addi $t0, $zero, 0 # index
	addi $t1, $zero, 9
	addi $t2, $zero, 0 # student counter
	addi $t3, $zero, 0 # mark sum
	
	displayAvgMarksLoop1:
	slt $t4, $t1, $t0
	bne $t4, $zero, displayAvgMarksCont
	add $t4, $t0, $zero
	sll $t4, $t4, 2
	add $t4, $t4, $s0
	lw $t4, 0($t4)
	addi $t5, $t0, 1
	beq $t4, $t5, displayAvgMarksStudentFound
	addi $t0, $t0, 1
	j displayAvgMarksLoop1
	
	displayAvgMarksStudentFound:
	add $t2, $t2, 1
	sll $t4, $t0, 2
	add $t4, $t4, $s1
	lw $t4, 0($t4)
	add $t3, $t3, $t4
	addi $t0, $t0, 1
    j displayAvgMarksLoop1
	
	displayAvgMarksCont:
	beq $t2, $zero, displayAvgMarksStudentNotFound
	j displayAvgMarksCont2
	displayAvgMarksStudentNotFound:
	li $v0, 4
	la $a0, msgNotFound
	syscall
	jr $ra
	
	displayAvgMarksCont2:
	addi $t0, $zero, 0
	# t0: quotient (result)	
	# t2: student counter
	# t3: mark sum
	displayAvgMarksDivLoop:
	sub $t3, $t3, $t2
	slt $t4, $t3, $zero
	bne $t4, $zero, displayAvgMarksDivFinish
	addi $t0, $t0, 1
	j displayAvgMarksDivLoop
	
	displayAvgMarksDivFinish:
	li $v0, 4
	la $a0, msgAvg
	syscall
	add $a0, $t0, $zero
	li $v0, 1
	syscall
	li $v0, 4
	la $a0, newline
	syscall
	syscall	
	jr $ra
	
	
	

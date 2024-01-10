.data
mes1: .asciiz "Grapse enan arithmo sto dyadiko systhma arithmishs\n"
mes2: .asciiz "Arithmos sto dyadiko!\n"
mes3: .asciiz "Den einai arithmos sto dyadiko..."
bsn: .asciiz "\n"
num: .word 0
num1 : .word 0
count: .word 0
val: .word 0
decim: .word 0
base: .word 0
lastdigit: .word 0

.text

.globl main

main:

li $v0, 4 #Zητηση αριθμου απο τον χρηστη
la $a0, mes1
syscall

la $s0, num #Φορτωση διευθυνσης λεξεων σε καταχωρητες
la $s1, num1
la $s2, count
la $s3, val
la $s4, decim
la $s5, base
la $s6, lastdigit

li $v0, 5 #Διάβασμα δυαδικού αριθμού
syscall
sw $v0, 0($s0)

lw $t0, 0($s0)

sw $t0, 0($s1)

lw $t0, 0($s1)

lw $t2, 0($s3)

lw $t4, 0($s2)
loop:  #Αρχή while loop για έλεγχο εγκυρότητας δεδομένων
beq $t0, $zero,  exit #Εαν ο καταχωρητης $t0 (που είναι το αντίγραφο του αρχικού αριθμού) γίνει ίσος με το μηδεν, βγές από την επανάληψη

addi $t1, $zero, 10  #Δίνω σε καταχωρητη τιμή 1

div $t0, $t1  #Διαδικασία για mod 
mfhi $t2

addi $t3, $zero, 1 #Δίνω σε καταχωρητη τιμή 1

beq $t2, $t3, s       #Eαν ο αριθμός είναι 1
beq $t2, $zero, s  #Ή εαν ο αριθμός είναι 0
addi $t4, $t4, 1      #Αύξησε το count κατά 1
addi $t5, $zero, 10  #Θέτω τιμή 10 σε καταχωρητή
div $t0, $t0, $t5  #Διαίρεση αριθμού που έδωσε ο χρήστης με το 10
j loop  #Πήγαινε πάνω, στην αρχή του loop

s:
addi $t5, $zero, 10  #Θέτω τιμή 10 σε καταχωρητή
div $t0, $t0, $t5  #Διαίρεση αριθμού που έδωσε ο χρήστης με το 10
j loop  #Πήγαινε πάνω, στην αρχή του loop

exit: #Label exit για όταν η συνθήκη στη while γίνει ψευδής

li $v0, 4
la $a0, bsn
syscall

bne $t4, $zero, no  #Αν η μεταβλητή count ΔΕΝ είναι ίση με 0, πήγαινε στην ετικέτα no

li $v0, 4 #Εμφάνιση μυνήματος επιβεβαίωσης πως ο αριθμός που εισήγαγε ο χρήστης, ήταν όντως στο δυαδικό
la $a0, mes2
syscall

lw $t0, 0($s0)  #num 
lw $t1, 0  ($s4)  #dec
lw $t2, 0($s5) #base
lw $t3, 0($s6) #lastdigit

addi $t2, $zero, 1  #Δίνω σε καταχωρητη αρχική τιμή 1 για τη βάση

loop1:  #While loop για μεταροπή αριθμού στο δυαδικό
beq $t0, $zero, out   #Αν η τιμή που εισήγαγε ο χρήστης γίνει ίση με 0
addi $t5, $zero, 10    #Θέτω τιμή 10 σε καταχωρητή

div $t0, $t5 #Διαδικασία για mod
mfhi $t3 #Kρατάμε το αποτέλεσμα του mod ως το προσωρινά τελευταίο ψηφίο
div $t0, $t0, $t5   #Διαίρεση αριθμού που έδωσε ο χρηστης με το 10
mul $t6, $t3, $t2  #Πολλαπλασιασμός τελευταίου ψηφίου με τη βάση
add $t4, $t4, $t6  #Και πρόσθεση του αποτελέσματος του πολλαπλασιασμού με τη τιμή του δεκαδικού συστήματος που φτιάχνεται
addi $t7, $zero, 2 #Δίνω τιμή 2 σε καταχωρητή
mul $t2, $t2, $t7  #Πολλαπλασιασμός της βάσης επί 2 για κάθε επανάληψη που γίνεται, ώστε να δηλωθεί η θέση. του κάθε ψηφίου
j loop1  #Πήγαινε πάνω στην αρχή δηλαδή της επανάληψης
out:  #Σε περίπτωση που η συνθήκη στη while γίνει ψευδής

li $v0, 1  #Εμφάνιση δεκαδικού αριθμού στην οθόνη
move $a0, $t4
syscall 

j skip  #Πήγαινε στο label skip

no: #Αν το count είναι διάφορο του 0

li $v0, 4 #Εκτύπωσε μήνυμα σφάλματος στον χρήστη
la $a0, mes3
syscall

skip:

li $v0, 10 #ΤΕΛΟΣ ΠΡΟΓΡΑΜΜΑΤΟΣ
syscall

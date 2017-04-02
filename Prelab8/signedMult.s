.text
  addi $s0, $s0, 0x19   # Put 25 in $0
  addi $s1, $s1, 0x04   # Put 4 in $1
  # Mult. Algo:
  # Muiltiply/AND both mutiplicand bits
  #   If there is a carry, add it to multiplicand and next bit
  #   Else shift multiplicand
loop:
  andi $2, $0, 1
  beq $2, $0, next
  addu $s3, $s3, $s1
  sltu

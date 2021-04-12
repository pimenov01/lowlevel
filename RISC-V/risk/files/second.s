.text
start:
.globl start
call main # ����� �������� ������������
main:
.globl main
addi sp, sp, -16 # ��������� ������ � �����
sw ra, 12(sp) # ���������� ra
li a0, 5 # ���������� ������������ �������
add a1, a0, a3 # ���������� �������� ��� ������ ���������� ���������
li a0, 9 # a0 = 9
ecall # ��������� �����
mv s0, a0 # �������� ����� ��������
mv s1, a1 # � ������
addi s1, s1, 1
mv a2, s0 # �������� �� � ���������
mv a3, s1 # a3 = s1
jal ra, pascal # ������� pascal
mv a2, s0 # ��������� ���������
mv a3, s1 # a3 = s1
jal ra, print # ������� print
mv a2, s0 # �������� ���������
mv a3, s1 # a3 = s1
li a0, 10 # a0 = 10
ecall # ��������� �����
lw ra, 12(sp) # �������������� ra
addi sp, sp, 16
finish: # �-��� ���������� ���������
mv a1, a0 # a1 = a0
li a0, 17 # a0 = 17
ecall # ��������� �����
pascal: # void (int *a2, int a3)
li t0, 1 # const 1
li t1, 4 # const 4
sw t0, 0(a2) # �������� 4 ����� �� ������ a2
li t2, 1 # ������������� �������� t2
loopPascal: # for (t2 = 1; t2 <= a3; t2++)
mv t3, t2 #������������� �������� t3
subPascal: # for (t3 = t2; t3 >= 1; t3--)
sub t4, t3, t0 # ����������� ����� ������ c[t3-1]
mul t4, t4, t1 # ����������� t4 = t4 * t1
add t5, a2, t4 # t5 = a2 + t4
lw t6, 0(t5) # ������� 4 ����� �� ������ t5
mul t4, t3, t1 # ����������� ����� ������ c[t3]
add t5, a2, t4 # t5 = a2 + t4
lw t4, 0(t5) # ������� 4 ����� �� ������ t5
add t4, t4, t6 # c[t3] = c[t3-1]+c[t3]
sw t4, 0(t5) # �������� 4 ����� �� ������ t5 �� t4
sub t3, t3, t0 # t3 = t3 - t0
bge t3, t0, subPascal # t3 >= 1, subloop
add t2, t2, t0 # t2 = t2 + t0
blt t2, a3, loopPascal # t1 < a1, loop
jr ra # return
print:
# ���������� ���������� �������� a2 �������� a3
li t0, 0 # t0 = 0
conPrint:
# ��������� �����
li a0, 1 # a0 = 1
lw a1, 0(a2) # a1 = a2
ecall # ��������� �����
li a0, 11 # a0 = 11
# ��������� ������
li a1, ' ' # a1 = ' '
ecall # ��������� �����
addi a2, a2, 4 # a2 = a2 & 4
addi t0, t0, 1 # t0 = t0 & 1
bne t0, a3, conPrint # t0 != a3 ����� �������� ������
li a1, '\n' # a1 = '\n'
ecall # ��������� �����
jr ra # �������
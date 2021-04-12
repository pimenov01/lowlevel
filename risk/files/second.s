.text
start:
.globl start
call main # вызов основной подпрограммы
main:
.globl main
addi sp, sp, -16 # выделение памяти в стеке
sw ra, 12(sp) # сохранение ra
li a0, 5 # показатель треугольника Паскаля
add a1, a0, a3 # резервация сегмента под нужное количество элементов
li a0, 9 # a0 = 9
ecall # системный вызов
mv s0, a0 # сохранил адрес сегмента
mv s1, a1 # и размер
addi s1, s1, 1
mv a2, s0 # прописал их в параметры
mv a3, s1 # a3 = s1
jal ra, pascal # вызвали pascal
mv a2, s0 # приписали параметры
mv a3, s1 # a3 = s1
jal ra, print # вызвали print
mv a2, s0 # прописал параметры
mv a3, s1 # a3 = s1
li a0, 10 # a0 = 10
ecall # системный вызов
lw ra, 12(sp) # восстановление ra
addi sp, sp, 16
finish: # ф-ция завершения программы
mv a1, a0 # a1 = a0
li a0, 17 # a0 = 17
ecall # системный вызов
pascal: # void (int *a2, int a3)
li t0, 1 # const 1
li t1, 4 # const 4
sw t0, 0(a2) # записать 4 байта по адресу a2
li t2, 1 # инициализация счетчика t2
loopPascal: # for (t2 = 1; t2 <= a3; t2++)
mv t3, t2 #инициализация счетчика t3
subPascal: # for (t3 = t2; t3 >= 1; t3--)
sub t4, t3, t0 # синтезируем адрес памяти c[t3-1]
mul t4, t4, t1 # перемножить t4 = t4 * t1
add t5, a2, t4 # t5 = a2 + t4
lw t6, 0(t5) # считать 4 байта по адресу t5
mul t4, t3, t1 # синтезируем адрес памяти c[t3]
add t5, a2, t4 # t5 = a2 + t4
lw t4, 0(t5) # считать 4 байта по адресу t5
add t4, t4, t6 # c[t3] = c[t3-1]+c[t3]
sw t4, 0(t5) # записать 4 байта по адресу t5 из t4
sub t3, t3, t0 # t3 = t3 - t0
bge t3, t0, subPascal # t3 >= 1, subloop
add t2, t2, t0 # t2 = t2 + t0
blt t2, a3, loopPascal # t1 < a1, loop
jr ra # return
print:
# напечатать содержимое сегмента a2 размером a3
li t0, 0 # t0 = 0
conPrint:
# напечатал число
li a0, 1 # a0 = 1
lw a1, 0(a2) # a1 = a2
ecall # системный вызов
li a0, 11 # a0 = 11
# напечатал пробел
li a1, ' ' # a1 = ' '
ecall # системный вызов
addi a2, a2, 4 # a2 = a2 & 4
addi t0, t0, 1 # t0 = t0 & 1
bne t0, a3, conPrint # t0 != a3 вызов корутины печати
li a1, '\n' # a1 = '\n'
ecall # системный вызов
jr ra # возврат
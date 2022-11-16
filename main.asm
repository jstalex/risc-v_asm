# Задание: 20. В памяти размещается массив, необходимо произвести его сортировку, при этом выкинув все нечетные числа;
# Входные данные записываются в строку ниже, в s4 нужно записать количество элементов
# Выходные данные лежать в Memory, адрес начала массива s0 = 0x10000000
.data
    arr: .word 1, 4, 5, 8, 11, 3, 1, 4, 2, 7 # source data
.text
    # s0 = base adress
    la s0, arr
    li s1, 0 # i
    li s2, 0 # j
    li s4, 10 # len of array
    # s5 len for j 
    
    loop:
        bge s1, s4, endloop
        slli t0, s1, 2 # t0 = i*4
        add t0, t0, s0 # get arr[i] adress

        lw t1, 0(t0) #get arr[i] value

        srli t2, t1, 1 # t2 = arr[i] // 2
        slli t2, t2, 1 # t2 = t2 * 2

        beq t2, t1, L0 # if t2 != arr[i] shift array
            add s2, zero, s1 # j = i
            interloop:
                bge s2, s4, endinterloop
                slli t3, s2, 2 # t3 = j*4
                add t3, t3, s0 # get arr[j] adress

                lw t4, 4(t3) # get arr[j+1] value

                sw t4, 0(t3)

                addi s2, s2, 1 # j += 1
                j interloop
            endinterloop:
            sw zero, 4(t3) # last element of arr = 0
            addi s4, s4, -1 # len -= 1
            addi s1, s1, -1 # i -= 1, it is required after shifting
        L0:

        addi s1, s1, 1 # i += 1
        j loop
    endloop:
    
    # t0 = adress arr[j+1]
    # t1 = arr[j+1]
    # t2 = adress arr[j]
    # t3 = arr[j] 

    add s1, zero, zero # i = 0
    add s2, zero, zero # j = 0

    for:
        bge s1, s4, done
        for_inter:
            sub s5, s4, s1 # jmax = imax - i
            bge s2, s5, done_inter # if j >= jmax

            slli t2, s2, 2 # t2 = j*4
            add t2, t2, s0 # get arr[j] adress

            addi t0, t2, 4 # t0 = get arr[j+1] adress

            lw t3, 0(t2) # get arr[j] value
            lw t1, 0(t0) # get arr[j+1] value
        
            bge t3, t1, L1 # if t3 < t1 => change
            mv a2, t3 # save t3 old value
            mv t3, t1
            mv t1, a2
            L1: 
            
            sw t1, 0(t0) # save new values
            sw t3, 0(t2) # save new values

            addi s2, s2, 1 # j++
            j for_inter
        done_inter:
        add s2, zero, zero # j = 0
        addi s1, s1, 1 # i += 1
        j for 
    done:
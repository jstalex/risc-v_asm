.data
    arr: .word 3, 1, 4, 2 # source data
.text
    # s0 = base adress, s1 - i, s2 - j
    la s0, arr
    li s1, 0
    li s2, 0
    li s4, 3 # len of array
    li s5, 3 # for j
    # t0 = *arr[j+1]
    # t1 = arr[j+1]
    # t2 = *arr[j]
    # t3 = arr[j]  
    for:
        bge s1, s4, done
        for_inter:
            sub s5, s4, s1 # jmax = imax - i
            bge s2, s5, done_inter # if j >= jmax

            slli t2, s2, 2 # t2 = j*4
            add t2, t2, s0 # get arr[j] adress

            addi t0, t2, 4 # t0 = *arr[j+1]

            lw t3, 0(t2) # get arr[j] value
            lw t1, 0(t0) #get arr[j+1] value
        
            bge t3, t1, L1 # if t3 >= t1 change
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
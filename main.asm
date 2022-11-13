.data
    arr: .word 3, 1, 4, 2 # source data
.text
    # s0 = base adress, s1 - i, s2 - j

    li s1, 0
    li s2, 1
    la s0, arr
    li s4, 4 # len of array
    # t0 = *arr[i]
    # t1 = arr[i]
    # t2 = *arr[j]
    # t3 = *arr[j]  
    for:
        bge s1, s4, done
        slli t0, s1, 2 # t0 = i*4
        add t0, t0, s0 # get arr[i] adress
        lw t1, 0(t0) #get arr[i] value

        for_inter:
            bge s2, s4, done_inter
            slli t2, s2, 2 # t2 = j*4
            add t2, t2, s0 # get arr[j] adress
            lw t3, 0(t2) # get arr[j] value
        
            blt t3, t1, change
            L1:
            sw t1, 0(t0) # save new values
            sw t3, 0(t2) # save new values

            addi s2, s2, 1
            j for_inter
        done_inter:

        addi s1, s1, 1 # i += 1
        j for 
    done: j L2

    change:
        mv t4, t3 # save t3 old value
        mv t3, t1
        mv t1, t4
        j L1
    L2:    

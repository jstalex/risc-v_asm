.data
    arr: .word 3, 1, 4, 2 # source data
.text
    # s0 = base adress, s1 - i, s2 - j
    la s0, arr
    li s1, 0
    li s2, 0
    li s4, 5 # len of array
    # t0 = *arr[i]
    # t1 = arr[i]
    # t2 = *arr[j]
    # t3 = *arr[j]

    add t2, t2, s0 # get arr[j] adress
    add t0, t0, s0 # get arr[j] adress    

    change:
        mv a2, t3 # save t3 old value
        mv t3, t1
        mv t1, a2
        j return

    for:
        lw t3, 0(t2) # get arr[j] value
        lw t1, 0(t0) #get arr[i] value

        blt t3, t1, change
    
    return:
        sw t1, 0(t0) # save new values
        sw t3, 0(t2) # save new values

        # internal cycle
        addi s2, s2, 1
        slli t2, s2, 2 # t2 = j*4
        add t2, t2, s0 # get arr[j] adress

        blt s2, s4, for
        # external cycle
        addi s1, s1, 1 # i += 1
        slli t0, s1, 2 # t0 = i*4
        add t0, t0, s0 # get arr[i] adress

        addi s2, s1, 1 # j = i+1
        slli t2, s2, 2 # t2 = j*4
        add t2, t2, s0 # get arr[j] adress

        blt s1, s4, for

        j done        

    done: 

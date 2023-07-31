dn = {'A': [1, 0, 0, 0], 'T': [0, 1, 0, 0], 'C': [0, 0, 1, 0], 'G': [0, 0, 0, 1]}

seqtest = 'GAAAAATCTCG'
c_seqtest = []

for i in range(len(seqtest)):
    print(seqtest[i])

    convertido = seqtest[i]
    a = dn[convertido]

    c_seqtest.append(a)

print(c_seqtest)

print('Finalizado')
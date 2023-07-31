# Promoter sequence

# Letter to Code

dn = {'A':0, 'T':1, 'C':2, 'G':3}

seqtest = 'GAAAAAAAAAAATCTCG'

c_seqtest = []

print(dn)

for i in range(len(seqtest)):
    print(seqtest[i])

    convertido = seqtest[i]

    c_seqtest.append(dn[convertido])

print(c_seqtest)
print('Finalizado')
# Promoter sequence

# Letter to Code

s = 'GAAAAAAAAAAATCTCG'

a = s.replace('A', '1000')
t = a.replace('T', '0100')
c = t.replace('C', '0010')
g = c.replace('G', '0001')

print(g)

print(len(s), len(g))

code = []

for i in range(len(g)):
    code.append(g[i])
    print(code)

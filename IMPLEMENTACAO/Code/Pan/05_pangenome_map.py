import matplotlib.pyplot as plt
import matplotlib.patches as patches
import numpy as np

# Definir os elementos do plasmídeo
features = [
    ('Promotor lac', 0, 40, 'blue'),
    ('luxC', 40, 90, 'green'),
    ('luxD', 90, 140, 'green'),
    ('luxA', 140, 190, 'green'),
    ('luxB', 190, 240, 'green'),
    ('luxE', 240, 290, 'green'),
    ('T1/T2 Terminador', 290, 320, 'red'),
    ('Ori', 320, 360, 'purple'),
    ('ampR', 360, 400, 'orange')
]

# Criar a figura
fig, ax = plt.subplots(figsize=(6, 6))
ax.set_xlim([-1.2, 1.2])
ax.set_ylim([-1.2, 1.2])
ax.set_xticks([])
ax.set_yticks([])
ax.axis('off')

# Desenhar o círculo do plasmídeo
circle = plt.Circle((0, 0), 1, color='black', fill=False, linewidth=2)
ax.add_patch(circle)

# Adicionar as features
for feature in features:
    name, start, end, color = feature
    theta1, theta2 = (start / 400) * 360, (end / 400) * 360
    arc = patches.Arc((0, 0), 2, 2, theta1=theta1, theta2=theta2, color=color, linewidth=4)
    ax.add_patch(arc)
    
    # Calcular posição do texto
    theta = np.radians((theta1 + theta2) / 2)
    x, y = 1.1 * np.cos(theta), 1.1 * np.sin(theta)
    ax.text(x, y, name, ha='center', va='center', fontsize=8, rotation=(theta1 + theta2) / 2 - 90)

plt.show()

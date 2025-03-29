import matplotlib.pyplot as plt
import cartopy.crs as ccrs
import cartopy.feature as cfeature
import numpy as np
import matplotlib.colors as mcolors

# Criar figura e eixos com projeção geográfica
fig, ax = plt.subplots(figsize=(12, 6), subplot_kw={'projection': ccrs.PlateCarree()})
ax.set_global()
ax.set_facecolor("white")

# Adicionar continentes e bordas
ax.add_feature(cfeature.LAND, color="white", edgecolor="black")
ax.add_feature(cfeature.BORDERS, linestyle=":", edgecolor="black")
ax.add_feature(cfeature.COASTLINE, edgecolor="black")

# Locais de interesse: (latitude, longitude, métrica 1, métrica 2)
locations = {
    "Brasil": (-14.2350, -51.9253, 20, 50),
    "EUA": (37.0902, -95.7129, 40, 80),
    "Alemanha": (51.1657, 10.4515, 70, 30),
    "Japão": (36.2048, 138.2529, 90, 20),
    "Austrália": (-25.2744, 133.7751, 30, 60)
}

# Extrair valores para normalização das cores
metric1_values = [m1 for _, _, m1, _ in locations.values()]
metric2_values = [m2 for _, _, _, m2 in locations.values()]
norm1 = mcolors.Normalize(vmin=min(metric1_values), vmax=max(metric1_values))
norm2 = mcolors.Normalize(vmin=min(metric2_values), vmax=max(metric2_values))

# Mapas de cores (gradientes)
cmap1 = plt.cm.Blues  # Métrica 1 → Azul
cmap2 = plt.cm.Reds   # Métrica 2 → Vermelho

# Criar scatter plot
for (lat, lon, m1, m2) in locations.values():
    ax.scatter(lon, lat, s=100, color=cmap1(norm1(m1)), edgecolor="black", alpha=0.8, label="Métrica 1")
    ax.scatter(lon, lat, s=100, color=cmap2(norm2(m2)), edgecolor="black", alpha=0.5, label="Métrica 2")

# Criar colorbars para cada métrica
cbar1 = plt.colorbar(plt.cm.ScalarMappable(norm=norm1, cmap=cmap1), ax=ax, orientation='vertical', fraction=0.03, pad=0.02)
cbar1.set_label('Métrica 1 (Azul)', rotation=270, labelpad=15)

cbar2 = plt.colorbar(plt.cm.ScalarMappable(norm=norm2, cmap=cmap2), ax=ax, orientation='vertical', fraction=0.03, pad=0.12)
cbar2.set_label('Métrica 2 (Vermelho)', rotation=270, labelpad=15)

# Adicionar título
plt.title("Scatter Plot com Duas Métricas Coloridas no Mapa", fontsize=14)

# Mostrar figura
plt.show()

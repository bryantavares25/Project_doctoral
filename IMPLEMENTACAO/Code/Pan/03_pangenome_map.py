import matplotlib.pyplot as plt
import cartopy.crs as ccrs
import cartopy.feature as cfeature
import numpy as np
import matplotlib.colors as mcolors
import pylustrator

#pylustrator.start()

# Criar figura e eixos com projeção geográfica
fig, ax = plt.subplots(figsize=(12, 6), subplot_kw={'projection': ccrs.PlateCarree()})
ax.set_global()
ax.set_facecolor("white")

# Adicionar continentes e bordas
ax.add_feature(cfeature.LAND, color="white", edgecolor="black")
ax.add_feature(cfeature.BORDERS, linestyle=":", edgecolor="black")
ax.add_feature(cfeature.COASTLINE, edgecolor="black")

# Locais de interesse: (latitude, longitude, métrica 1, métrica 2)
'''locations = {
    "Brasil - Santa Catarina ": (-27.244641, -50.492310, 5.71, 00 ),
    "Brasil - Minas Gerais": (-18.456328, -44.673395, 5.71, 00),
    "France - Brittany": (48.534226, -4.640869, 00, 00),
    "Holanda - Boxmeer": (51.648813, 5.947951, 5.71, 00),
    "Bélgica": (51.053658, 3.722278, 20, 00),
    "Austria": (47.516232, 14.550072, 8.57, 00),
    "Suiça": (46.818188, 8.227512, 2.86, 75),
    "China - Er-hua-nian": (23.919916, 121.504574, 2.86, 00),
    "China - Tibet": (31.703827, 88.162642, 2.86, 00),
    "China - Hubei": (30.975283, 112.267729, 5.71, 00),
    "China - Jiangsu Nanjing": (32.051965, 118.778029, 2.86, 00),
    "China": (35.861660, 104.195396, 2.86, 00),
    "France - Brittany - MFC": (47.609288, -2.299219, 00, 75), #MFC
    "Dinamarca": (-14.2350, -51.9253, 00, 12.50), #MFC
}'''

locations = {
    "Brasil - Santa Catarina ": (-27.244641, -50.492310, 2, 00 ),
    "Brasil - Minas Gerais": (-18.456328, -44.673395, 2, 00),
    "France - Brittany": (48.534226, -4.640869, 9, 00),
    "Holanda - Boxmeer": (51.648813, 5.947951, 2, 00),
    "Bélgica": (51.053658, 3.722278, 7, 00),
    "Austria": (47.516232, 14.550072, 3, 00),
    "Suiça": (46.818188, 8.227512, 1, 00),
    "China - Er-hua-nian": (23.919916, 121.504574, 1, 00),
    "China - Tibet": (31.703827, 88.162642, 1, 00),
    "China - Hubei": (30.975283, 112.267729, 2, 00),
    "China - Jiangsu Nanjing": (32.051965, 118.778029, 1, 00),
    "China": (35.861660, 104.195396, 1, 00),
    "France - Brittany - MFC": (47.609288, -2.299219, 00, 6), #MFC
    "Dinamarca": (-14.2350, -51.9253, 00, 1), #MFC
}

# Extrair valores para normalização das cores
metric1_values = [m1 for _, _, m1, _ in locations.values()]
metric2_values = [m2 for _, _, _, m2 in locations.values()]
norm1 = mcolors.Normalize(vmin=0, vmax=max(metric1_values))
norm2 = mcolors.Normalize(vmin=0, vmax=max(metric2_values))

# Mapas de cores (gradientes)
#cmap1 = plt.cm.Greens # Métrica 1 → Azul
#cmap2 = plt.cm.Oranges   # Métrica 2 → Vermelho

cmap1 = mcolors.LinearSegmentedColormap.from_list("custom_blue", ["plum", "purple"])
cmap2 = mcolors.LinearSegmentedColormap.from_list("custom_orange", ["lightgreen", "darkgreen"])

# Criar scatter plot
for (lat, lon, m1, m2) in locations.values():
    ax.scatter(lon, lat, s=50, color=cmap1(norm1(m1)), edgecolor="black", alpha=0.9, label="Métrica 1")
    ax.scatter(lon, lat, s=50, color=cmap2(norm2(m2)), edgecolor="black", alpha=0.9, label="Métrica 2")

# Criar colorbars para cada métrica
cbar1 = plt.colorbar(plt.cm.ScalarMappable(norm=norm1, cmap=cmap1), ax=ax, orientation='vertical', fraction=0.03, pad=0.02)
cbar1.set_label('Métrica 1 (Azul)', rotation=270, labelpad=15)

cbar2 = plt.colorbar(plt.cm.ScalarMappable(norm=norm2, cmap=cmap2), ax=ax, orientation='vertical', fraction=0.03, pad=0.12)
cbar2.set_label('Métrica 2 (Vermelho)', rotation=270, labelpad=15)

# Adicionar título
plt.title("Scatter Plot com Duas Métricas Coloridas no Mapa", fontsize=14)

# Mostrar figura
plt.show()

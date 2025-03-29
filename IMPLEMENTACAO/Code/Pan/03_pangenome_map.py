import matplotlib.pyplot as plt
import cartopy.crs as ccrs
import cartopy.feature as cfeature
import matplotlib.colors as mcolors

# Criar a figura e definir a projeção
fig, ax = plt.subplots(figsize=(10, 5), subplot_kw={'projection': ccrs.PlateCarree()})
ax.set_global()  # Garante que o mapa não seja cortado
ax.set_facecolor("white")  # Fundo branco

# Adicionar continentes e bordas
ax.add_feature(cfeature.LAND, color="white", edgecolor="black")  
ax.add_feature(cfeature.BORDERS, linestyle=":", edgecolor="black")  
ax.add_feature(cfeature.COASTLINE, edgecolor="black")  

# Locais e número de amostras + cor base
locations = {
    "Brasil": (-14.2350, -51.9253, 10, "blue"),
    "EUA": (37.0902, -95.7129, 25, "red"),
    "Alemanha": (51.1657, 10.4515, 15, "blue"),
    "Japão": (36.2048, 138.2529, 30, "red"),
    "Austrália": (-25.2744, 133.7751, 8, "blue")
}

# Normalizar intensidade da cor com base na quantidade de amostras
max_samples = max([s for _, _, s, _ in locations.values()])

# Mapas de cores (gradientes)
cmap_blue = plt.cm.Blues
cmap_red = plt.cm.Reds
norm = mcolors.Normalize(vmin=0, vmax=max_samples)

# Criar dicionário para legenda
legend_handles = {}

# Adicionar pontos no mapa com intensidade variável
for (lat, lon, samples, color) in locations.values():
    if color == "blue":
        adjusted_color = cmap_blue(norm(samples))
    else:
        adjusted_color = cmap_red(norm(samples))
    
    scatter = ax.scatter(lon, lat, s=100, color=adjusted_color, edgecolor="black", alpha=0.8, transform=ccrs.PlateCarree(), label=color)

# Adicionar colorbar (legenda de intensidade)
cbar = plt.colorbar(plt.cm.ScalarMappable(cmap=cmap_blue, norm=norm), ax=ax, orientation='vertical', fraction=0.03, pad=0.04)
cbar.set_label('Quantidade de amostras', rotation=270, labelpad=15)

# Título e exibição
plt.title("Mapa com intensidade de cor proporcional à quantidade de amostras", fontsize=12)
plt.show()

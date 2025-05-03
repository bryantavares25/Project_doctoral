import matplotlib.pyplot as plt
import cartopy.crs as ccrs
import cartopy.feature as cfeature
import numpy as np
import matplotlib.colors as mcolors
import pylustrator

pylustrator.start()

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
    "Brasil - Santa Catarina ": (-27.244641, -50.492310, 2, 0),
    "Brasil - Minas Gerais": (-18.456328, -44.673395, 2, 0),
    "France - Brittany": (48.534226, -4.640869, 9, 0),
    "Holanda - Boxmeer": (51.648813, 5.947951, 2, 0),
    "Bélgica": (51.053658, 3.722278, 7, 0),
    "Austria": (47.516232, 14.550072, 3, 0),
    "Suiça": (46.818188, 8.227512, 1, 0),
    "China - Er-hua-nian": (23.919916, 121.504574, 1, 0),
    "China - Tibet": (31.703827, 88.162642, 1, 0),
    "China - Hubei": (30.975283, 112.267729, 2, 0),
    "China - Jiangsu Nanjing": (32.051965, 118.778029, 1, 0),
    "China": (35.861660, 104.195396, 1, 0),
    # "EUA": (37.839333, -84.270020, 1, 0),
    "France - Brittany - MFC": (47.609288, -2.299219, 0, 6),
    "Dinamarca - MFC": (56.263920, 9.501785, 0, 1),
}

# Separar métricas em vetores distintos
lat_m1, lon_m1, metric1_values = [], [], []
lat_m2, lon_m2, metric2_values = [], [], []

for lat, lon, m1, m2 in locations.values():
    if m1 > 0:
        lat_m1.append(lat)
        lon_m1.append(lon)
        metric1_values.append(m1)
    if m2 > 0:
        lat_m2.append(lat)
        lon_m2.append(lon)
        metric2_values.append(m2)

# Normalizar cores
norm1 = mcolors.Normalize(vmin=1, vmax=35)
norm2 = mcolors.Normalize(vmin=1, vmax=8)

# Mapas de cores
#cmap1 = plt.cm.Blues  # Métrica 1 → Verde
#cmap2 = plt.cm.Reds  # Métrica 2 → Laranja

cmap1 = mcolors.LinearSegmentedColormap.from_list("custom_blue", ["lightblue", "darkblue"])
cmap2 = mcolors.LinearSegmentedColormap.from_list("custom_orange", ["lightpink", "darkred"])

# Criar scatter plots separados
sc1 = ax.scatter(lon_m1, lat_m1, s=50, c=metric1_values, cmap=cmap1, norm=norm1, edgecolor="black", alpha=0.9, label="Métrica 1")
sc2 = ax.scatter(lon_m2, lat_m2, s=50, c=metric2_values, cmap=cmap2, norm=norm2, edgecolor="black", alpha=0.9, label="Métrica 2")

# Criar colorbars para cada métrica
cbar1 = plt.colorbar(sc1, ax=ax, orientation='vertical', fraction=0.03, pad=0.02)
cbar1.set_label(r"$\mathit{M.\ hyopneumoniae}$", rotation=270, labelpad=15)

cbar2 = plt.colorbar(sc2, ax=ax, orientation='vertical', fraction=0.03, pad=0.12)
cbar2.set_label(r"$\mathit{M.\ flocculare}$", rotation=270, labelpad=15)

# Adicionar legenda
ax.legend()

# Mostrar figura
#% start: automatic generated code from pylustrator
#plt.figure(1).ax_dict = {ax.get_label(): ax for ax in plt.figure(1).axes}
#import matplotlib as mpl
#getattr(plt.figure(1), '_pylustrator_init', lambda: ...)()
#plt.figure(1).ax_dict["<colorbar>"].set(position=[0.8415, 0.1194, 0.01922, 0.77])
#plt.figure(1).axes[0].set(position=[0.03459, 0.1193, 0.7705, 0.7717])
#plt.figure(1).axes[0].title.set(visible=False)
#plt.figure(1).axes[0].get_legend().set(visible=False)
#% end: automatic generated code from pylustrator
#% start: automatic generated code from pylustrator
plt.figure(1).ax_dict = {ax.get_label(): ax for ax in plt.figure(1).axes}
import matplotlib as mpl
getattr(plt.figure(1), '_pylustrator_init', lambda: ...)()
plt.figure(1).ax_dict["<colorbar>"].set(position=[0.8108, 0.11, 0.02209, 0.77])
plt.figure(1).ax_dict["<colorbar>"].set(position=[0.8775, 0.11, 0.02325, 0.77])
plt.figure(1).axes[0].set(position=[0.07551, 0.11, 0.6983, 0.77], xlim=(-95.08, 162.6), ylim=(-58.32, 83.65))
plt.figure(1).axes[0].get_legend().set(visible=False)
#% end: automatic generated code from pylustrator
plt.show()

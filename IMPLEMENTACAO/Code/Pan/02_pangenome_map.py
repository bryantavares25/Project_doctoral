import folium

# Lista de locais de interesse com coordenadas (latitude, longitude)
locations = {
    "Brasil": (-14.2350, -51.9253),
    "Estados Unidos": (37.0902, -95.7129),
    "Alemanha": (51.1657, 10.4515),
    "Japão": (36.2048, 138.2529),
    "Austrália": (-25.2744, 133.7751)
}

# Criar o mapa centralizado
m = folium.Map(location=[0, 0], zoom_start=2)

# Adicionar marcadores
for place, coords in locations.items():
    folium.Marker(coords, popup=place).add_to(m)

# Salvar o mapa em um arquivo HTML
m.save("mapa_interativo.html")

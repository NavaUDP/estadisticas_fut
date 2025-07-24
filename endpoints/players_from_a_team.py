# Buscamos obtener una lista de todos los jugadores de un equipo en específico
import psycopg2
import os
import json
from db import get_connection

#Necesitamos el id del equipo
def get_players_from_team(team_id):
    conn = get_connection()
    cur = conn.cursor()

    try:
        cur.execute("SELECT * FROM jugadores WHERE id_equipo = %s;", (team_id,))
        rows = cur.fetchall()
        
        # Procesamos los resultados a un formato JSON
        players = []
        for row in rows:
            player = {
                "id_jugador": row[0],
                "nombre": row[1],
                "apellido": row[2],
                "nacionalidad": row[3],
                "fecha_nacimiento": row[4].isoformat() if row[4] else None,
                "posicion": row[5],
                "id_equipo": row[6],
                "dorsal": row[7],
            }
            players.append(player)

        return json.dumps(players, ensure_ascii=False)
    
    except Exception as e:
        print(f"Error al obtener los jugadores del equipo {team_id}: {e}")
        return []
    
print(get_players_from_team(1))  
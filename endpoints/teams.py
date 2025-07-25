#Buscamos obtener una lista en JSON de todos los equipos
import psycopg2
import os
import json
from db import get_connection

def get_teams():
    conn = get_connection()
    cur = conn.cursor()

    try:
        cur.execute("SELECT * FROM equipos;")
        rows = cur.fetchall()
        #Hasta aquí obtenemos los datos.

        # Proceso para pasar los resultados a un formato JSON
        teams = []
        for row in rows:
            team = {
                "id": row[0],
                "nombre": row[1],
                "pais": row[2],
                "entrenador": row[3],
                "id_liga": row[4],
            }
            teams.append(team)

        return json.dumps(teams, ensure_ascii=False)

    except Exception as e:
        print(f"Error al obtener los equipos: {e}")
        return []

    finally:
        cur.close()
        conn.close()

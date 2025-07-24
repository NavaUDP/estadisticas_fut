#Para iniciar un partdo, debemos obtener los equipos que juegan y fecha.
import psycopg2
import os
import json
from db import get_connection

def get_match_details(match_id):
    conn = get_connection()
    cur = conn.cursor()

    try:
        # Obtenemos los detalles del partido
        cur.execute("SELECT * FROM partidos WHERE id_partido = %s;", (match_id,))
        match_row = cur.fetchone()
        
        if not match_row:
            return json.dumps({"error": "Partido no encontrado"}, ensure_ascii=False)

        match_details = {
            "id_partido": match_row[0],
            "fecha": match_row[1].isoformat() if match_row[1] else None,
            "estadio": match_row[2],
            "equipo_local": match_row[3],
            "equipo_visitante": match_row[4],
            "resultado_local": match_row[5],
            "resultado_visita": match_row[6],
            "estado": match_row[7],
        }

        return json.dumps(match_details, ensure_ascii=False)
    
    except Exception as e:
        print(f"Error al obtener los detalles del partido {match_id}: {e}")
        return json.dumps({"error": str(e)}, ensure_ascii=False)
    
print(get_match_details(1))
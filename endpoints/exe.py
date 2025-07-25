import psycopg2
import os
import json
from db import get_connection
from match import get_match_details
from players_from_a_team import get_players_from_team
from teams import get_teams

#Buscamos que nos muestre los detalles de un partido programado.
def main():
    conn = get_connection()
    cur = conn.cursor()

    #Obtenemos los partidos programados
    cur.execute("SELECT * FROM partidos WHERE estado = 'Programado';")
    matches = cur.fetchall()

    # Muestra un Json de todos los partidos programados
    if matches:
        scheduled_matches_list = []
        for match in matches:
            scheduled_match = {
                "id_partido": match[0],
                "fecha": match[1].isoformat() if match[1] else None,
                "estadio": match[2],
                "equipo_local": match[3],
                "equipo_visitante": match[4],
            }
            scheduled_matches_list.append(scheduled_match)
        print(json.dumps(scheduled_matches_list, ensure_ascii=False))
    else:
        print("No hay partidos programados.")
        return

    #El usuario debe elegir una id (en un futuro sera un botón) para iniciar el siguiente proceso.
    #En este caso elegimos el partido con id.
    try:
        selected_match_id = int(input("Ingrese el ID del partido programado: "))
    except ValueError:
        print("ID inválida.")
        return

    selected_match = next((m for m in scheduled_matches_list if m["id_partido"] == selected_match_id), None)

    if selected_match:
        equipo_local_id = selected_match["equipo_local"]
        equipo_visitante_id = selected_match["equipo_visitante"]
        print(f"ID equipo local: {equipo_local_id}")
        print(f"ID equipo visitante: {equipo_visitante_id}\n\n")

        #A partir de la id, obtenemos jugadores de los equipos que juegan el partido.
        players_local = get_players_from_team(equipo_local_id)
        print(f"Jugadores del equipo local: {players_local}\n\n")
        players_visit = get_players_from_team(equipo_visitante_id)
        print(f"Jugadores del equipo visitante: {players_visit}")
    else:
        print("Partido no encontrado.")

main()
import psycopg2
import random
from datetime import date

# --- CONFIGURACIÓN DE LA BASE DE DATOS ---
# Cambia estos valores por los de tu configuración de PostgreSQL
DB_NAME = "estadisticas_fut"
DB_USER = "postgres"
DB_PASS = "postgres"
DB_HOST = "localhost"
DB_PORT = "5432"

# --- LÓGICA DE SIMULACIÓN ---

def get_data_from_db():
    """Obtiene partidos y jugadores de la base de datos."""
    conn = None
    try:
        conn = psycopg2.connect(
            dbname=DB_NAME, user=DB_USER, password=DB_PASS, host=DB_HOST, port=DB_PORT
        )
        cur = conn.cursor()

        # Obtener partidos
        cur.execute("SELECT id_partido, equipo_local, equipo_visita, resultado_local, resultado_visita FROM partidos ORDER BY id_partido;")
        partidos = cur.fetchall()

        # Obtener jugadores
        cur.execute("SELECT id_jugador, posicion, id_equipo FROM jugadores;")
        jugadores_raw = cur.fetchall()
        
        jugadores_por_equipo = {}
        for jug in jugadores_raw:
            id_jugador, posicion, id_equipo = jug
            if id_equipo not in jugadores_por_equipo:
                jugadores_por_equipo[id_equipo] = []
            jugadores_por_equipo[id_equipo].append({'id': id_jugador, 'pos': posicion})

        cur.close()
        return partidos, jugadores_por_equipo

    except (Exception, psycopg2.DatabaseError) as error:
        print(f"Error al conectar o leer de la base de datos: {error}")
        return None, None
    finally:
        if conn is not None:
            conn.close()

def simular_estadisticas_partido(partido, jugadores_por_equipo):
    """Genera todas las sentencias SQL para un único partido."""
    
    id_partido, id_local, id_visita, goles_local, goles_visita = partido
    sql_statements = []

    # 1. Simular Estadísticas de Equipo
    posesion_local = round(random.uniform(30, 70), 1)
    posesion_visita = 100 - posesion_local
    faltas_cometidas = random.randint(8, 22)
    tiros_esquina = random.randint(2, 12)
    
    # Stats del equipo local
    sql_statements.append("-- Estadísticas del Partido ID: {}".format(id_partido))
    sql_statements.append(f"INSERT INTO public.est_basicas_equipo (id_partido, id_equipo, goles_a_favor, goles_en_contra, tiros_totales, tiros_a_puerta, posesion, faltas_cometidas, faltas_recibidas, tiros_de_esquina, amarillas, rojas) VALUES "
                          f"({id_partido}, {id_local}, {goles_local}, {goles_visita}, {random.randint(goles_local, goles_local + 10)}, {random.randint(goles_local, goles_local + 5)}, {posesion_local}, {faltas_cometidas}, {faltas_cometidas + random.randint(-2, 2)}, {tiros_esquina}, {random.randint(0, 5)}, {random.choice([0,0,0,1])});")
    sql_statements.append(f"INSERT INTO public.est_intermedias_equipo (id_partido, id_equipo, pases_completados, pases_intentados, presicion_pases, duelos_ganados) VALUES "
                          f"({id_partido}, {id_local}, {random.randint(250, 500)}, {random.randint(350, 650)}, {round(random.uniform(75, 90), 1)}, {random.randint(40, 70)});")

    # Stats del equipo visitante
    sql_statements.append(f"INSERT INTO public.est_basicas_equipo (id_partido, id_equipo, goles_a_favor, goles_en_contra, tiros_totales, tiros_a_puerta, posesion, faltas_cometidas, faltas_recibidas, tiros_de_esquina, amarillas, rojas) VALUES "
                          f"({id_partido}, {id_visita}, {goles_visita}, {goles_local}, {random.randint(goles_visita, goles_visita + 10)}, {random.randint(goles_visita, goles_visita + 5)}, {posesion_visita}, {faltas_cometidas + random.randint(-2, 2)}, {faltas_cometidas}, {14 - tiros_esquina}, {random.randint(0, 5)}, {random.choice([0,0,0,1])});")
    sql_statements.append(f"INSERT INTO public.est_intermedias_equipo (id_partido, id_equipo, pases_completados, pases_intentados, presicion_pases, duelos_ganados) VALUES "
                          f"({id_partido}, {id_visita}, {random.randint(250, 500)}, {random.randint(350, 650)}, {round(random.uniform(75, 90), 1)}, {random.randint(40, 70)});")

    # 2. Simular Estadísticas de Jugador
    for equipo_id, goles_equipo in [(id_local, goles_local), (id_visita, goles_visita)]:
        plantilla = jugadores_por_equipo.get(equipo_id, [])
        if not plantilla: continue
        
        # Seleccionar jugadores para el partido (11 titulares + 5 suplentes)
        jugadores_partido = random.sample(plantilla, min(len(plantilla), 16))
        
        # Asignar goles
        goleadores = []
        if goles_equipo > 0:
            posibles_goleadores = [p['id'] for p in jugadores_partido if p['pos'] != 'Portero']
            goleadores = random.choices(posibles_goleadores, k=goles_equipo)
        
        for i, jugador in enumerate(jugadores_partido):
            minutos = 90 if i < 11 else random.randint(5, 30)
            goles = goleadores.count(jugador['id'])
            asistencias = random.randint(0, 1) if goles == 0 else 0
            amarillas = random.choice([0,0,0,1])
            
            sql_statements.append(f"INSERT INTO public.est_basica_jugador (id_jugador, id_partido, minutos_jugados, goles, asistencias, tiros, tiros_a_puerta, amarillas, rojas) VALUES "
                                  f"({jugador['id']}, {id_partido}, {minutos}, {goles}, {asistencias}, {random.randint(0, 4)}, {random.randint(0, 2)}, {amarillas}, 0);")
            
            pases_intentados = random.randint(10, 60)
            pases_completados = int(pases_intentados * random.uniform(0.7, 0.95))
            sql_statements.append(f"INSERT INTO public.est_intermedias_jugador (id_jugador, id_partido, pases_completados, pases_intentados, duelos_ganados, recuperaciones, perdidas) VALUES "
                                  f"({jugador['id']}, {id_partido}, {pases_completados}, {pases_intentados}, {random.randint(1, 10)}, {random.randint(2, 15)}, {random.randint(2, 15)});")
    
    return sql_statements

def main():
    """Función principal para generar el archivo SQL."""
    print("Conectando a la base de datos para obtener datos iniciales...")
    partidos, jugadores_por_equipo = get_data_from_db()

    if partidos is None or jugadores_por_equipo is None:
        print("No se pudo continuar debido a un error con la base de datos.")
        return

    print(f"Datos obtenidos: {len(partidos)} partidos y plantillas para {len(jugadores_por_equipo)} equipos.")
    
    all_sql = [
        "-- #############################################################",
        "-- SCRIPT DE INSERCIÓN DE ESTADÍSTICAS GENERADO AUTOMÁTICAMENTE",
        f"-- Generado el: {date.today()}",
        "-- #############################################################\n"
    ]
    
    # Vaciar tablas para evitar duplicados si se corre de nuevo
    all_sql.append("DELETE FROM public.est_intermedias_jugador;")
    all_sql.append("DELETE FROM public.est_basica_jugador;")
    all_sql.append("DELETE FROM public.est_intermedias_equipo;")
    all_sql.append("DELETE FROM public.est_basicas_equipo;\n")
    all_sql.append("ALTER SEQUENCE est_basica_jugador_id_est_seq RESTART WITH 1;")
    all_sql.append("ALTER SEQUENCE est_basicas_equipo_id_estadistica_seq RESTART WITH 1;")
    all_sql.append("ALTER SEQUENCE est_intermedias_equipo_id_estadistica_seq RESTART WITH 1;")
    all_sql.append("ALTER SEQUENCE est_intermedias_jugador_id_estadistica_seq RESTART WITH 1;\n")


    print("Generando estadísticas para cada partido...")
    for i, partido in enumerate(partidos):
        print(f"  ...Procesando partido {i+1}/{len(partidos)}")
        stats_partido_sql = simular_estadisticas_partido(partido, jugadores_por_equipo)
        all_sql.extend(stats_partido_sql)
        all_sql.append("\n")

    output_filename = "estadisticas_completas.sql"
    with open(output_filename, "w", encoding="utf-8") as f:
        f.write("\n".join(all_sql))

    print("-" * 50)
    print("¡Proceso completado!")
    print(f"Se ha generado el archivo '{output_filename}' con todas las sentencias SQL.")
    print("Puedes ejecutar este archivo en tu base de datos PostgreSQL.")
    print("-" * 50)

if __name__ == "__main__":
    main()
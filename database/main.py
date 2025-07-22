import psycopg2

# Realizamos la conexión con la base de datos

conn =  psycopg2.connect(
    host="localhost",
    database="estadisticas_fut",
    user="postgres",
    password="postgres",
    port="5432"
)

cur = conn.cursor()

#comienza el código para trabajar

#--Prueba para la conexion
cur.execute("SELECT * FROM equipos;")
resultados = cur.fetchall()
print(resultados)

# Una vez termina el código cerramos sesion

cur.close()
conn.close()
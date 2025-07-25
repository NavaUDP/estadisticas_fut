--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3
-- Dumped by pg_dump version 16.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: equipos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.equipos (
    id_equipo integer NOT NULL,
    nombre text NOT NULL,
    pasi text,
    entrenador text,
    liga text
);


ALTER TABLE public.equipos OWNER TO postgres;

--
-- Name: equipos_id_equipo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.equipos_id_equipo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.equipos_id_equipo_seq OWNER TO postgres;

--
-- Name: equipos_id_equipo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.equipos_id_equipo_seq OWNED BY public.equipos.id_equipo;


--
-- Name: est_basica_jugador; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.est_basica_jugador (
    id_est integer NOT NULL,
    id_jugador integer,
    id_partido integer,
    minutos_jugados integer,
    goles integer,
    asistencias integer,
    tiros integer,
    tiros_a_puerta integer,
    fueras_de_juego integer,
    faltas_cometidas integer,
    faltas_recibidas integer,
    amarillas integer,
    rojas integer,
    saques_de_banda integer,
    tiros_de_esquina integer,
    saque_de_porteria integer
);


ALTER TABLE public.est_basica_jugador OWNER TO postgres;

--
-- Name: est_basica_jugador_id_est_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.est_basica_jugador_id_est_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.est_basica_jugador_id_est_seq OWNER TO postgres;

--
-- Name: est_basica_jugador_id_est_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.est_basica_jugador_id_est_seq OWNED BY public.est_basica_jugador.id_est;


--
-- Name: est_basicas_equipo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.est_basicas_equipo (
    id_estadistica integer NOT NULL,
    id_equipo integer,
    id_partido integer,
    goles_a_favor integer,
    goles_en_contra integer,
    tiros_totales integer,
    tiros_a_puerta integer,
    posesion numeric,
    faltas_cometidas integer,
    faltas_recibidas integer,
    tiros_de_esquina integer,
    saques_de_banda integer,
    fueras_de_juego integer,
    amarillas integer,
    rojas integer
);


ALTER TABLE public.est_basicas_equipo OWNER TO postgres;

--
-- Name: est_basicas_equipo_id_estadistica_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.est_basicas_equipo_id_estadistica_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.est_basicas_equipo_id_estadistica_seq OWNER TO postgres;

--
-- Name: est_basicas_equipo_id_estadistica_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.est_basicas_equipo_id_estadistica_seq OWNED BY public.est_basicas_equipo.id_estadistica;


--
-- Name: est_intermedias_equipo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.est_intermedias_equipo (
    id_estadistica integer NOT NULL,
    id_equipo integer,
    id_partido integer,
    pases_completados integer,
    pases_intentados integer,
    presicion_pases numeric,
    duelos_ganados integer,
    duelos_perdidos integer,
    centros_completados integer,
    centros_intentados integer,
    toques_area_rival integer,
    entradas_totales integer,
    intercepciones integer,
    bloqueos integer,
    posesiones_recuperadas integer,
    tiempo_medio_posesion text
);


ALTER TABLE public.est_intermedias_equipo OWNER TO postgres;

--
-- Name: est_intermedias_equipo_id_estadistica_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.est_intermedias_equipo_id_estadistica_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.est_intermedias_equipo_id_estadistica_seq OWNER TO postgres;

--
-- Name: est_intermedias_equipo_id_estadistica_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.est_intermedias_equipo_id_estadistica_seq OWNED BY public.est_intermedias_equipo.id_estadistica;


--
-- Name: est_intermedias_jugador; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.est_intermedias_jugador (
    id_estadistica integer NOT NULL,
    id_jugador integer,
    id_partido integer,
    pases_completados integer,
    pases_intentados integer,
    centros_completados integer,
    centros_intentados integer,
    regates_intentados integer,
    regates_completados integer,
    duelos_ganados integer,
    duelos_perdidos integer,
    entradas_realizadas integer,
    intercepciones integer,
    despejes integer,
    bloqueos integer,
    recuperaciones integer,
    perdidas integer,
    toques_totales integer,
    toques_en_area_rival integer
);


ALTER TABLE public.est_intermedias_jugador OWNER TO postgres;

--
-- Name: est_intermedias_jugador_id_estadistica_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.est_intermedias_jugador_id_estadistica_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.est_intermedias_jugador_id_estadistica_seq OWNER TO postgres;

--
-- Name: est_intermedias_jugador_id_estadistica_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.est_intermedias_jugador_id_estadistica_seq OWNED BY public.est_intermedias_jugador.id_estadistica;


--
-- Name: jugadores; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jugadores (
    id_jugador integer NOT NULL,
    nombre text NOT NULL,
    apellido text NOT NULL,
    nacionalidad text,
    fecha_nacimiento date,
    posicion text,
    id_equipo integer
);


ALTER TABLE public.jugadores OWNER TO postgres;

--
-- Name: jugadores_id_jugador_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.jugadores_id_jugador_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.jugadores_id_jugador_seq OWNER TO postgres;

--
-- Name: jugadores_id_jugador_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.jugadores_id_jugador_seq OWNED BY public.jugadores.id_jugador;


--
-- Name: partidos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.partidos (
    id_partido integer NOT NULL,
    fecha date NOT NULL,
    estadio text,
    equipo_local integer,
    equipo_visita integer,
    resultado_local integer,
    resultado_visita integer
);


ALTER TABLE public.partidos OWNER TO postgres;

--
-- Name: partidos_id_partido_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.partidos_id_partido_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.partidos_id_partido_seq OWNER TO postgres;

--
-- Name: partidos_id_partido_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.partidos_id_partido_seq OWNED BY public.partidos.id_partido;


--
-- Name: equipos id_equipo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.equipos ALTER COLUMN id_equipo SET DEFAULT nextval('public.equipos_id_equipo_seq'::regclass);


--
-- Name: est_basica_jugador id_est; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.est_basica_jugador ALTER COLUMN id_est SET DEFAULT nextval('public.est_basica_jugador_id_est_seq'::regclass);


--
-- Name: est_basicas_equipo id_estadistica; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.est_basicas_equipo ALTER COLUMN id_estadistica SET DEFAULT nextval('public.est_basicas_equipo_id_estadistica_seq'::regclass);


--
-- Name: est_intermedias_equipo id_estadistica; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.est_intermedias_equipo ALTER COLUMN id_estadistica SET DEFAULT nextval('public.est_intermedias_equipo_id_estadistica_seq'::regclass);


--
-- Name: est_intermedias_jugador id_estadistica; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.est_intermedias_jugador ALTER COLUMN id_estadistica SET DEFAULT nextval('public.est_intermedias_jugador_id_estadistica_seq'::regclass);


--
-- Name: jugadores id_jugador; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jugadores ALTER COLUMN id_jugador SET DEFAULT nextval('public.jugadores_id_jugador_seq'::regclass);


--
-- Name: partidos id_partido; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partidos ALTER COLUMN id_partido SET DEFAULT nextval('public.partidos_id_partido_seq'::regclass);


--
-- Name: equipos equipos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.equipos
    ADD CONSTRAINT equipos_pkey PRIMARY KEY (id_equipo);


--
-- Name: est_basica_jugador est_basica_jugador_id_jugador_id_partido_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.est_basica_jugador
    ADD CONSTRAINT est_basica_jugador_id_jugador_id_partido_key UNIQUE (id_jugador, id_partido);


--
-- Name: est_basica_jugador est_basica_jugador_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.est_basica_jugador
    ADD CONSTRAINT est_basica_jugador_pkey PRIMARY KEY (id_est);


--
-- Name: est_basicas_equipo est_basicas_equipo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.est_basicas_equipo
    ADD CONSTRAINT est_basicas_equipo_pkey PRIMARY KEY (id_estadistica);


--
-- Name: est_intermedias_equipo est_intermedias_equipo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.est_intermedias_equipo
    ADD CONSTRAINT est_intermedias_equipo_pkey PRIMARY KEY (id_estadistica);


--
-- Name: est_intermedias_jugador est_intermedias_jugador_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.est_intermedias_jugador
    ADD CONSTRAINT est_intermedias_jugador_pkey PRIMARY KEY (id_estadistica);


--
-- Name: jugadores jugadores_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jugadores
    ADD CONSTRAINT jugadores_pkey PRIMARY KEY (id_jugador);


--
-- Name: partidos partidos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partidos
    ADD CONSTRAINT partidos_pkey PRIMARY KEY (id_partido);


--
-- Name: est_basica_jugador est_basica_jugador_id_jugador_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.est_basica_jugador
    ADD CONSTRAINT est_basica_jugador_id_jugador_fkey FOREIGN KEY (id_jugador) REFERENCES public.jugadores(id_jugador) ON DELETE CASCADE;


--
-- Name: est_basica_jugador est_basica_jugador_id_partido_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.est_basica_jugador
    ADD CONSTRAINT est_basica_jugador_id_partido_fkey FOREIGN KEY (id_partido) REFERENCES public.partidos(id_partido) ON DELETE CASCADE;


--
-- Name: est_basicas_equipo est_basicas_equipo_id_equipo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.est_basicas_equipo
    ADD CONSTRAINT est_basicas_equipo_id_equipo_fkey FOREIGN KEY (id_equipo) REFERENCES public.equipos(id_equipo) ON DELETE CASCADE;


--
-- Name: est_basicas_equipo est_basicas_equipo_id_partido_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.est_basicas_equipo
    ADD CONSTRAINT est_basicas_equipo_id_partido_fkey FOREIGN KEY (id_partido) REFERENCES public.partidos(id_partido) ON DELETE CASCADE;


--
-- Name: est_intermedias_equipo est_intermedias_equipo_id_equipo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.est_intermedias_equipo
    ADD CONSTRAINT est_intermedias_equipo_id_equipo_fkey FOREIGN KEY (id_equipo) REFERENCES public.equipos(id_equipo) ON DELETE CASCADE;


--
-- Name: est_intermedias_equipo est_intermedias_equipo_id_partido_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.est_intermedias_equipo
    ADD CONSTRAINT est_intermedias_equipo_id_partido_fkey FOREIGN KEY (id_partido) REFERENCES public.partidos(id_partido) ON DELETE CASCADE;


--
-- Name: est_intermedias_jugador est_intermedias_jugador_id_jugador_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.est_intermedias_jugador
    ADD CONSTRAINT est_intermedias_jugador_id_jugador_fkey FOREIGN KEY (id_jugador) REFERENCES public.jugadores(id_jugador) ON DELETE CASCADE;


--
-- Name: est_intermedias_jugador est_intermedias_jugador_id_partido_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.est_intermedias_jugador
    ADD CONSTRAINT est_intermedias_jugador_id_partido_fkey FOREIGN KEY (id_partido) REFERENCES public.partidos(id_partido) ON DELETE CASCADE;


--
-- Name: jugadores jugadores_id_equipo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jugadores
    ADD CONSTRAINT jugadores_id_equipo_fkey FOREIGN KEY (id_equipo) REFERENCES public.equipos(id_equipo) ON DELETE SET NULL;


--
-- Name: partidos partidos_equipo_local_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partidos
    ADD CONSTRAINT partidos_equipo_local_fkey FOREIGN KEY (equipo_local) REFERENCES public.equipos(id_equipo) ON DELETE CASCADE;


--
-- Name: partidos partidos_equipo_visita_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partidos
    ADD CONSTRAINT partidos_equipo_visita_fkey FOREIGN KEY (equipo_visita) REFERENCES public.equipos(id_equipo) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--


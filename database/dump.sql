--
-- PostgreSQL database dump
--

-- Dumped from database version 10.12 (Ubuntu 10.12-0ubuntu0.18.04.1)
-- Dumped by pg_dump version 10.12 (Ubuntu 10.12-0ubuntu0.18.04.1)

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

DROP TRIGGER set_timestamp ON public.users;
DROP TRIGGER set_timestamp ON public.pokeboxes;
ALTER TABLE ONLY public.users DROP CONSTRAINT users_pk;
ALTER TABLE ONLY public.pokemon DROP CONSTRAINT pokemon_v2_pk;
ALTER TABLE ONLY public.pokeboxes DROP CONSTRAINT pokeboxes_pk;
ALTER TABLE ONLY public.items DROP CONSTRAINT items_pk;
ALTER TABLE ONLY public.backpack_items DROP CONSTRAINT "backpackItems_pk";
ALTER TABLE public.users ALTER COLUMN user_id DROP DEFAULT;
ALTER TABLE public.pokeboxes ALTER COLUMN pokebox_id DROP DEFAULT;
ALTER TABLE public.items ALTER COLUMN item_id DROP DEFAULT;
ALTER TABLE public.backpack_items ALTER COLUMN backpack_id DROP DEFAULT;
DROP SEQUENCE public."users_userId_seq";
DROP TABLE public.users;
DROP TABLE public.pokemon;
DROP SEQUENCE public."pokeboxes_pokeboxId_seq";
DROP TABLE public.pokeboxes;
DROP SEQUENCE public."items_itemId_seq";
DROP TABLE public.items;
DROP SEQUENCE public."backpackItems_backpackId_seq";
DROP TABLE public.backpack_items;
DROP FUNCTION public.trigger_set_timestamp();
DROP EXTENSION plpgsql;
DROP SCHEMA public;
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA public;


--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: trigger_set_timestamp(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.trigger_set_timestamp() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW."updated_at" = NOW();
  RETURN NEW;
END;
$$;


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: backpack_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.backpack_items (
    backpack_id integer NOT NULL,
    user_id integer NOT NULL,
    item_id integer NOT NULL,
    quantity integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: backpackItems_backpackId_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."backpackItems_backpackId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: backpackItems_backpackId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."backpackItems_backpackId_seq" OWNED BY public.backpack_items.backpack_id;


--
-- Name: items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.items (
    item_id integer NOT NULL,
    name character varying(20) NOT NULL,
    item_type character varying(20) NOT NULL,
    item_description text NOT NULL,
    effect character varying(255) NOT NULL,
    sprite character varying(255) NOT NULL
);


--
-- Name: items_itemId_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."items_itemId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: items_itemId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."items_itemId_seq" OWNED BY public.items.item_id;


--
-- Name: pokeboxes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pokeboxes (
    pokebox_id integer NOT NULL,
    user_id character varying(16) NOT NULL,
    pokemon_id integer NOT NULL,
    name character varying(16) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    is_shiny boolean
);


--
-- Name: pokeboxes_pokeboxId_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."pokeboxes_pokeboxId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pokeboxes_pokeboxId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."pokeboxes_pokeboxId_seq" OWNED BY public.pokeboxes.pokebox_id;


--
-- Name: pokemon; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pokemon (
    pokemon_id smallint NOT NULL,
    name character varying(20) NOT NULL,
    type character varying(20) NOT NULL,
    type_secondary character varying(20),
    sprite_front_default text NOT NULL,
    sprite_back_default text NOT NULL,
    sprite_front_shiny text NOT NULL,
    sprite_back_shiny text NOT NULL,
    height smallint NOT NULL,
    weight smallint NOT NULL,
    habitat character varying(15) NOT NULL,
    flavor_text text NOT NULL,
    flavor_text_new text NOT NULL,
    growth_rate character varying(20) NOT NULL,
    species character varying(25) NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    miles_walked integer NOT NULL,
    encounters integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    time_walked integer
);


--
-- Name: users_userId_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."users_userId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_userId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."users_userId_seq" OWNED BY public.users.user_id;


--
-- Name: backpack_items backpack_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.backpack_items ALTER COLUMN backpack_id SET DEFAULT nextval('public."backpackItems_backpackId_seq"'::regclass);


--
-- Name: items item_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.items ALTER COLUMN item_id SET DEFAULT nextval('public."items_itemId_seq"'::regclass);


--
-- Name: pokeboxes pokebox_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pokeboxes ALTER COLUMN pokebox_id SET DEFAULT nextval('public."pokeboxes_pokeboxId_seq"'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public."users_userId_seq"'::regclass);


--
-- Data for Name: backpack_items; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.backpack_items (backpack_id, user_id, item_id, quantity, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: items; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.items (item_id, name, item_type, item_description, effect, sprite) FROM stdin;
\.


--
-- Data for Name: pokeboxes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.pokeboxes (pokebox_id, user_id, pokemon_id, name, created_at, updated_at, is_shiny) FROM stdin;
1	2	1	Bulbasaur	2020-06-24 07:52:33.331801+00	2020-06-24 07:52:33.331801+00	\N
2	2	4	Charmander	2020-06-24 07:53:09.859013+00	2020-06-24 07:53:09.859013+00	\N
3	2	7	Squirtle	2020-06-24 07:53:18.274833+00	2020-06-24 07:53:18.274833+00	\N
4	1	7	Turtle	2020-06-24 20:23:59.20849+00	2020-06-24 20:26:20.314579+00	\N
5	1	7	Squirtle	2020-06-25 07:54:18.994215+00	2020-06-25 07:54:18.994215+00	\N
6	1	7	Squirtle	2020-06-25 07:54:21.043486+00	2020-06-25 07:54:21.043486+00	\N
7	1	7	Squirtle	2020-06-25 07:54:22.060805+00	2020-06-25 07:54:22.060805+00	\N
10	6	1	Bulbasaur	2020-06-26 00:49:23.739248+00	2020-06-26 17:41:39.413317+00	\N
9	6	4	Charmander	2020-06-26 00:49:18.082235+00	2020-06-26 17:41:51.82505+00	\N
8	6	7	Squirtle	2020-06-26 00:49:08.630756+00	2020-06-26 17:41:54.144032+00	\N
\.


--
-- Data for Name: pokemon; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.pokemon (pokemon_id, name, type, type_secondary, sprite_front_default, sprite_back_default, sprite_front_shiny, sprite_back_shiny, height, weight, habitat, flavor_text, flavor_text_new, growth_rate, species) FROM stdin;
63	abra	psychic	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/63.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/63.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/63.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/63.png	9	195	urban	Using its ability to read minds, it will identify impending danger and TELEPORT to safety.	ABRA needs to sleep for eighteen hours a day. If it doesn’t, this POKéMON loses its ability to use telekinetic powers. If it is attacked, ABRA escapes using TELEPORT while it is still sleeping.	medium-slow	Psi Pokémon
57	primeape	fighting	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/57.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/57.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/57.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/57.png	10	320	mountain	Always furious and tenacious to boot. It will not abandon chasing its quarry until it is caught.	When PRIMEAPE becomes furious, its blood circulation is boosted. In turn, its muscles are made even stronger. However, it also becomes much less intelligent at the same time.	medium	Pig Monkey Pokémon
42	golbat	poison	flying	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/42.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/42.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/42.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/42.png	16	550	cave	Once it strikes, it will not stop draining energy from the victim even if it gets too heavy to fly.	GOLBAT bites down on prey with its four fangs and drinks the victim’s blood. It becomes active on inky dark moonless nights, flying around to attack people and POKéMON.	medium	Bat Pokémon
19	rattata	normal	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/19.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/19.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/19.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/19.png	3	35	grassland	Bites anything when it attacks. Small and very quick, it is a common sight in many places.	RATTATA is cautious in the extreme. Even while it is asleep, it constantly listens by moving its ears around. It is not picky about where it lives - it will make its nest anywhere.	medium	Mouse Pokémon
40	wigglytuff	normal	fairy	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/40.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/40.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/40.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/40.png	10	120	grassland	The body is soft and rubbery. When angered, it will suck in air and inflate itself to an enormous size.	WIGGLYTUFF’s body is very flexible. By inhaling deeply, this POKéMON can inflate itself seemingly without end. Once inflated, WIGGLYTUFF bounces along lightly like a balloon.	fast	Balloon Pokémon
62	poliwrath	water	fighting	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/62.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/62.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/62.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/62.png	13	540	waters-edge	An adept swimmer at both the front crawl and breast stroke. Easily overtakes the best human swimmers.	POLIWRATH’s highly developed, brawny muscles never grow fatigued, however much it exercises. It is so tirelessly strong, this POKéMON can swim back and forth across the Pacific Ocean without effort.	medium-slow	Tadpole Pokémon
41	zubat	poison	flying	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/41.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/41.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/41.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/41.png	8	75	cave	Forms colonies in perpetually dark places. Uses ultrasonic waves to identify and approach targets.	ZUBAT avoids sunlight because exposure causes it to become unhealthy. During the daytime, it stays in caves or under the eaves of old houses, sleeping while hanging upside down.	medium	Bat Pokémon
24	arbok	poison	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/24.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/24.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/24.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/24.png	35	650	grassland	It is rumored that the ferocious warning markings on its belly differ from area to area.	This POKéMON is terrifically strong in order to constrict things with its body. It can even flatten steel oil drums. Once ARBOK wraps its body around its foe, escaping its crunching embrace is impossible.	medium	Cobra Pokémon
93	haunter	ghost	poison	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/93.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/93.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/93.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/93.png	16	1	cave	Because of its ability to slip through block walls, it is said to be from an­ other dimension.	HAUNTER is a dangerous POKéMON. If one beckons you while floating in darkness, you must never approach it. This POKéMON will try to lick you with its tongue and steal your life away.	medium-slow	Gas Pokémon
45	vileplume	grass	poison	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/45.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/45.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/45.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/45.png	12	186	grassland	The larger its petals, the more toxic pollen it contains. Its big head is heavy and hard to hold up.	VILEPLUME has the world’s largest petals. They are used to attract prey that are then doused with toxic spores. Once the prey are immobilized, this POKéMON catches and devours them.	medium-slow	Flower Pokémon
105	marowak	ground	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/105.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/105.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/105.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/105.png	10	450	mountain	The bone it holds is its key weapon. It throws the bone skillfully like a boomerang to KO targets.	MAROWAK is the evolved form of a CUBONE that has overcome its sadness at the loss of its mother and grown tough. This POKéMON’s tempered and hardened spirit is not easily broken.	medium	Bone Keeper Pokémon
68	machamp	fighting	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/68.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/68.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/68.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/68.png	16	1300	mountain	Using its heavy muscles, it throws powerful punches that can send the victim clear over the horizon.	MACHAMP is known as the POKéMON that has mastered every kind of martial arts. If it grabs hold of the foe with its four arms, the battle is all but over. The hapless foe is thrown far over the horizon.	medium-slow	Superpower Pokémon
37	vulpix	fire	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/37.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/37.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/37.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/37.png	6	99	grassland	At the time of birth, it has just one tail. The tail splits from its tip as it grows older.	Inside VULPIX’s body burns a flame that never goes out. During the daytime, when the temperatures rise, this POKéMON releases flames from its mouth to prevent its body from growing too hot.	medium	Fox Pokémon
117	seadra	water	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/117.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/117.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/117.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/117.png	12	250	sea	Its spines provide protection. Its fins and bones are prized as traditional medicine ingredients.	SEADRA sleeps after wriggling itself between the branches of coral. Those trying to harvest coral are occasionally stung by this POKéMON’s poison barbs if they fail to notice it.	medium	Dragon Pokémon
86	seel	water	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/86.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/86.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/86.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/86.png	11	900	sea	The protruding horn on its head is very hard. It is used for bashing through thick ice.	SEEL hunts for prey in the frigid sea underneath sheets of ice. When it needs to breathe, it punches a hole through the ice with the sharply protruding section of its head.	medium	Sea Lion Pokémon
69	bellsprout	grass	poison	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/69.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/69.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/69.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/69.png	7	40	forest	A carnivorous POKéMON that traps and eats bugs. It uses its root feet to soak up needed moisture.	BELLSPROUT’s thin and flexible body lets it bend and sway to avoid any attack, however strong it may be. From its mouth, this POKéMON spits a corrosive fluid that melts even iron.	medium-slow	Flower Pokémon
58	growlithe	fire	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/58.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/58.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/58.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/58.png	7	190	grassland	Very protective of its territory. It will bark and bite to repel intruders from its space.	GROWLITHE has a superb sense of smell. Once it smells anything, this POKéMON won’t forget the scent, no matter what. It uses its advanced olfactory sense to determine the emotions of other living things.	slow	Puppy Pokémon
92	gastly	ghost	poison	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/92.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/92.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/92.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/92.png	13	1	cave	Almost invisible, this gaseous POKéMON cloaks the target and puts it to sleep without notice.	GASTLY is largely composed of gaseous matter. When exposed to a strong wind, the gaseous body quickly dwindles away. Groups of this POKéMON cluster under the eaves of houses to escape the ravages of wind.	medium-slow	Gas Pokémon
103	exeggutor	grass	psychic	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/103.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/103.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/103.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/103.png	20	1200	forest	Legend has it that on rare occasions, one of its heads will drop off and continue on as an EXEGGCUTE.	EXEGGUTOR originally came from the tropics. Its heads steadily grow larger from exposure to strong sunlight. It is said that when the heads fall off, they group together to form EXEGGCUTE.	slow	Coconut Pokémon
90	shellder	water	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/90.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/90.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/90.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/90.png	3	40	sea	Its hard shell repels any kind of attack. It is vulnerable only when its shell is open.	At night, this POKéMON uses its broad tongue to burrow a hole in the seafloor sand and then sleep in it. While it is sleeping, SHELLDER closes its shell, but leaves its tongue hanging out.	slow	Bivalve Pokémon
131	lapras	water	ice	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/131.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/131.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/131.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/131.png	25	2200	sea	A POKéMON that has been over­ hunted almost to extinction. It can ferry people across the water.	People have driven LAPRAS almost to the point of extinction. In the evenings, this POKéMON is said to sing plaintively as it seeks what few others of its kind still remain.	slow	Transport Pokémon
82	magneton	electric	steel	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/82.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/82.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/82.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/82.png	10	600	rough-terrain	Formed by several MAGNEMITEs linked together. They frequently appear when sunspots flare up.	MAGNETON emits a powerful magnetic force that is fatal to electronics and precision instruments. Because of this, it is said that some towns warn people to keep this POKéMON inside a POKé BALL.	medium	Magnet Pokémon
70	weepinbell	grass	poison	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/70.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/70.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/70.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/70.png	10	64	forest	It spits out POISONPOWDER to immobilize the enemy and then finishes it with a spray of ACID.	WEEPINBELL has a large hook on its rear end. At night, the POKéMON hooks on to a tree branch and goes to sleep. If it moves around in its sleep, it may wake up to find itself on the ground.	medium-slow	Flycatcher Pokémon
100	voltorb	electric	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/100.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/100.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/100.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/100.png	5	104	urban	Usually found in power plants. Easily mistaken for a Poké Ball, they have zapped many people.	VOLTORB was first sighted at a company that manufactures POKé BALLS. The link between that sighting and the fact that this POKéMON looks very similar to a POKé BALL remains a mystery.	medium	Ball Pokémon
107	hitmonchan	fighting	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/107.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/107.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/107.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/107.png	14	502	urban	While apparently doing nothing, it fires punches in lightning fast volleys that are impossible to see.	HITMONCHAN is said to possess the spirit of a boxer who had been working towards a world championship. This POKéMON has an indomitable spirit and will never give up in the face of adversity.	medium	Punching Pokémon
35	clefairy	fairy	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/35.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/35.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/35.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/35.png	6	75	mountain	Its magical and cute appeal has many admirers. It is rare and found only in certain areas.	On every night of a full moon, groups of this POKéMON come out to play. When dawn arrives, the tired CLEFAIRY return to their quiet mountain retreats and go to sleep nestled up against each other.	fast	Fairy Pokémon
89	muk	poison	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/89.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/89.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/89.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/89.png	12	300	urban	Thickly covered with a filthy, vile sludge. It is so toxic, even its footprints contain poison.	This POKéMON’s favorite food is anything that is repugnantly filthy. In dirty towns where people think nothing of throwing away litter on the streets, MUK are certain to gather.	medium	Sludge Pokémon
137	porygon	normal	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/137.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/137.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/137.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/137.png	8	365	urban	A POKéMON that consists entirely of programming code. Capable of moving freely in cyberspace.	PORYGON is capable of reverting itself entirely back to program data and entering cyberspace. This POKéMON is copy-protected so it cannot be duplicated by copying.	medium	Virtual Pokémon
104	cubone	ground	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/104.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/104.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/104.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/104.png	4	65	mountain	Because it never removes its skull helmet, no one has ever seen this POKéMON''s real face.	CUBONE pines for the mother it will never see again. Seeing a likeness of its mother in the full moon, it cries. The stains on the skull the POKéMON wears are made by the tears it sheds.	medium	Lonely Pokémon
108	lickitung	normal	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/108.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/108.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/108.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/108.png	12	655	grassland	Its tongue can be extended like a chameleon''s. It leaves a tingling sensation when it licks enemies.	Whenever LICKITUNG comes across something new, it will unfailingly give it a lick. It does so because it memorizes things by texture and by taste. It is somewhat put off by sour things.	medium	Licking Pokémon
141	kabutops	rock	water	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/141.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/141.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/141.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/141.png	13	405	sea	Its sleek shape is perfect for swim­ ming. It slashes prey with its claws and drains the body fluids.	KABUTOPS swam underwater to hunt for its prey in ancient times. The POKéMON was apparently evolving from being a water-dweller to living on land as evident from the beginnings of change in its gills and legs.	medium	Shellfish Pokémon
101	electrode	electric	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/101.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/101.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/101.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/101.png	12	666	urban	It stores electric energy under very high pressure. It often explodes with little or no provocation.	One of ELECTRODE’s characteristics is its attraction to electricity. It is a problematical POKéMON that congregates mostly at electrical power plants to feed on electricity that has just been generated.	medium	Ball Pokémon
73	tentacruel	water	poison	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/73.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/73.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/73.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/73.png	16	550	sea	The tentacles are normally kept short. On hunts, they are extended to ensnare and immobilize prey.	TENTACRUEL has tentacles that can be freely elongated and shortened at will. It ensnares prey with its tentacles and weakens the prey by dosing it with a harsh toxin. It can catch up to 80 prey at the same time.	slow	Jellyfish Pokémon
106	hitmonlee	fighting	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/106.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/106.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/106.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/106.png	15	498	urban	When in a hurry, its legs lengthen progressively. It runs smoothly with extra long, loping strides.	HITMONLEE’s legs freely contract and stretch. Using these springlike legs, it bowls over foes with devastating kicks. After battle, it rubs down its legs and loosens the muscles to overcome fatigue.	medium	Kicking Pokémon
20	raticate	normal	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/20.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/20.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/20.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/20.png	7	185	grassland	It uses its whis­ kers to maintain its balance. It apparently slows down if they are cut off.	RATICATE’s sturdy fangs grow steadily. To keep them ground down, it gnaws on rocks and logs. It may even chew on the walls of houses.	medium	Mouse Pokémon
79	slowpoke	water	psychic	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/79.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/79.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/79.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/79.png	12	360	waters-edge	Incredibly slow and dopey. It takes 5 seconds for it to feel pain when under attack.	SLOWPOKE uses its tail to catch prey by dipping it in water at the side of a river. However, this POKéMON often forgets what it’s doing and often spends entire days just loafing at water’s edge.	medium	Dopey Pokémon
60	poliwag	water	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/60.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/60.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/60.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/60.png	6	124	waters-edge	Its newly grown legs prevent it from running. It appears to prefer swimming than trying to stand.	POLIWAG has a very thin skin. It is possible to see the POKéMON’s spiral innards right through the skin. Despite its thinness, however, the skin is also very flexible. Even sharp fangs bounce right off it.	medium-slow	Tadpole Pokémon
98	krabby	water	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/98.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/98.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/98.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/98.png	4	65	waters-edge	Its pincers are not only powerful weapons, they are used for balance when walking sideways.	KRABBY live on beaches, burrowed inside holes dug into the sand. On sandy beaches with little in the way of food, these POKéMON can be seen squabbling with each other over territory.	medium	River Crab Pokémon
74	geodude	rock	ground	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/74.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/74.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/74.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/74.png	4	200	mountain	Many live on mountain trails and remain half buried while keeping an eye on climbers.	The longer a GEODUDE lives, the more its edges are chipped and worn away, making it more rounded in appearance. However, this POKéMON’s heart will remain hard, craggy, and rough always.	medium-slow	Rock Pokémon
76	golem	rock	ground	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/76.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/76.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/76.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/76.png	14	3000	mountain	Its boulder-like body is extremely hard. It can easily withstand dynamite blasts without damage.	GOLEM is known for rolling down from mountains. To prevent them from rolling into the homes of people downhill, grooves have been dug into the sides of mountains to serve as guideways for diverting this POKéMON’s course.	medium-slow	Megaton Pokémon
71	victreebel	grass	poison	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/71.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/71.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/71.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/71.png	17	155	forest	Said to live in huge colonies deep in jungles, although no one has ever returned from there.	VICTREEBEL has a long vine that extends from its head. This vine is waved and flicked about as if it were an animal to attract prey. When an unsuspecting prey draws near, this POKéMON swallows it whole.	medium-slow	Flycatcher Pokémon
51	dugtrio	ground	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/51.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/51.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/51.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/51.png	7	333	cave	A team of DIGLETT triplets. It triggers huge earthquakes by burrowing 60 miles underground.	DUGTRIO are actually triplets that emerged from one body. As a result, each triplet thinks exactly like the other two triplets. They work cooperatively to burrow endlessly.	medium	Mole Pokémon
33	nidorino	poison	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/33.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/33.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/33.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/33.png	9	195	grassland	An aggressive POKéMON that is quick to attack. The horn on its head secretes a powerful venom.	NIDORINO has a horn that is harder than a diamond. If it senses a hostile presence, all the barbs on its back bristle up at once, and it challenges the foe with all its might.	medium-slow	Poison Pin Pokémon
109	koffing	poison	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/109.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/109.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/109.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/109.png	6	10	urban	Because it stores several kinds of toxic gases in its body, it is prone to exploding without warning.	KOFFING embodies toxic substances. It mixes the toxins with raw garbage to set off a chemical reaction that results in a terribly powerful poison gas. The higher the temperature, the more gas is concocted by this POKéMON.	medium	Poison Gas Pokémon
87	dewgong	water	ice	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/87.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/87.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/87.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/87.png	17	1200	sea	Stores thermal energy in its body. Swims at a steady 8 knots even in intensely cold waters.	DEWGONG loves to snooze on bitterly cold ice. The sight of this POKéMON sleeping on a glacier was mistakenly thought to be a mermaid by a mariner long ago.	medium	Sea Lion Pokémon
124	jynx	ice	psychic	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/124.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/124.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/124.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/124.png	14	406	urban	It seductively wiggles its hips as it walks. It can cause people to dance in unison with it.	JYNX walks rhythmically, swaying and shaking its hips as if it were dancing. Its motions are so bouncingly alluring, people seeing it are compelled to shake their hips without giving any thought to what they are doing.	medium	Human Shape Pokémon
102	exeggcute	grass	psychic	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/102.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/102.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/102.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/102.png	4	25	forest	Its six eggs converse using telepathy. They can quickly gather if they become separated.	This POKéMON consists of six eggs that form a closely knit cluster. The six eggs attract each other and spin around. When cracks increasingly appear on the eggs, EXEGGCUTE is close to evolution.	slow	Egg Pokémon
88	grimer	poison	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/88.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/88.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/88.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/88.png	9	300	urban	Appears in filthy areas. Thrives by sucking up polluted sludge that is pumped out of factories.	GRIMER emerged from the sludge that settled on a polluted seabed. This POKéMON loves anything filthy. It constantly leaks a horribly germ- infested fluid from all over its body.	medium	Sludge Pokémon
91	cloyster	water	ice	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/91.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/91.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/91.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/91.png	15	1325	sea	When attacked, it launches its horns in quick volleys. Its innards have never been seen.	CLOYSTER is capable of swimming in the sea. It does so by swallowing water, then jetting it out toward the rear. This POKéMON shoots spikes from its shell using the same system.	slow	Bivalve Pokémon
83	farfetchd	normal	flying	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/83.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/83.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/83.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/83.png	8	150	grassland	The sprig of green onions it holds is its weapon. It is used much like a metal sword.	FARFETCH’D is always seen with a stick from a plant of some sort. Apparently, there are good sticks and bad sticks. This POKéMON has been known to fight with others over sticks.	medium	Wild Duck Pokémon
80	slowbro	water	psychic	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/80.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/80.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/80.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/80.png	16	785	waters-edge	The SHELLDER that is latched onto SLOWPOKE''s tail is said to feed on the host''s left over scraps.	SLOWBRO’s tail has a SHELLDER firmly attached with a bite. As a result, the tail can’t be used for fishing anymore. This causes SLOWBRO to grudgingly swim and catch prey instead.	medium	Hermit Crab Pokémon
15	beedrill	bug	poison	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/15.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/15.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/15.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/15.png	10	295	forest	Flies at high speed and attacks using its large venomous stingers on its forelegs and tail.	BEEDRILL is extremely territorial. No one should ever approach its nest - this is for their own safety. If angered, they will attack in a furious swarm.	medium	Poison Bee Pokémon
121	starmie	water	psychic	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/121.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/121.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/121.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/121.png	11	800	sea	Its central core glows with the seven colors of the rainbow. Some people value the core as a gem.	STARMIE swims through water by spinning its star-shaped body as if it were a propeller on a ship. The core at the center of this POKéMON’s body glows in seven colors.	slow	Mysterious Pokémon
30	nidorina	poison	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/30.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/30.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/30.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/30.png	8	200	grassland	The female''s horn develops slowly. Prefers physical attacks such as clawing and biting.	When NIDORINA are with their friends or family, they keep their barbs tucked away to prevent hurting each other. This POKéMON appears to become nervous if separated from the others.	medium-slow	Poison Pin Pokémon
116	horsea	water	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/116.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/116.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/116.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/116.png	4	80	sea	Known to shoot down flying bugs with precision blasts of ink from the surface of the water.	If HORSEA senses danger, it will reflexively spray a dense black ink from its mouth and try to escape. This POKéMON swims by cleverly flapping the fins on its back.	medium	Dragon Pokémon
38	ninetales	fire	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/38.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/38.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/38.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/38.png	11	199	grassland	According to an enduring legend, 9 noble saints were united and reincarnated as this Pokémon. 	NINETALES casts a sinister light from its bright red eyes to gain total control over its foe’s mind. This POKéMON is said to live for a thousand years.	medium	Fox Pokémon
13	weedle	bug	poison	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/13.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/13.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/13.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/13.png	3	32	forest	Often found in forests, eating leaves. It has a sharp venomous stinger on its head.	WEEDLE has an extremely acute sense of smell. It is capable of distinguishing its favorite kinds of leaves from those it dislikes just by sniffing with its big red proboscis (nose).	medium	Hairy Bug Pokémon
14	kakuna	bug	poison	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/14.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/14.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/14.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/14.png	6	100	forest	Almost incapable of moving, this POKéMON can only harden its shell to protect itself from predators.	KAKUNA remains virtually immobile as it clings to a tree. However, on the inside, it is extremely busy as it prepares for its coming evolution. This is evident from how hot the shell becomes to the touch.	medium	Cocoon Pokémon
59	arcanine	fire	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/59.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/59.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/59.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/59.png	19	1550	grassland	Its proud and regal appearance has captured the hearts of people since long ago.	ARCANINE is known for its high speed. It is said to be capable of running over 6,200 miles in a single day and night. The fire that blazes wildly within this POKéMON’s body is its source of power.	slow	Legendary Pokémon
72	tentacool	water	poison	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/72.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/72.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/72.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/72.png	9	455	sea	Drifts in shallow seas. Anglers who hook them by accident are often punished by its stinging acid.	TENTACOOL absorbs sunlight and refracts it using water inside its body to convert it into beam energy. This POKéMON shoots beams from its crystal-like eyes.	slow	Jellyfish Pokémon
119	seaking	water	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/119.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/119.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/119.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/119.png	13	390	waters-edge	In the autumn spawning season, they can be seen swimming powerfully up rivers and creeks.	In the autumn, SEAKING males can be seen performing courtship dances in riverbeds to woo females. During this season, this POKéMON’s body coloration is at its most beautiful.	medium	Goldfish Pokémon
112	rhydon	ground	rock	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/112.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/112.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/112.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/112.png	19	1200	rough-terrain	Protected by an armor-like hide, it is capable of living in molten lava of 3,600 degrees.	RHYDON has a horn that serves as a drill. It is used for destroying rocks and boulders. This POKéMON occasionally rams into streams of magma, but the armor-like hide prevents it from feeling the heat.	slow	Drill Pokémon
44	gloom	grass	poison	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/44.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/44.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/44.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/44.png	8	86	grassland	The fluid that oozes from its mouth isn''t drool. It is a nectar that is used to attract prey.	From its mouth GLOOM drips honey that smells absolutely horrible. Apparently, it loves the horrid stench. It sniffs the noxious fumes and then drools even more of its honey.	medium-slow	Weed Pokémon
149	dragonite	dragon	flying	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/149.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/149.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/149.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/149.png	22	2100	waters-edge	An extremely rarely seen marine Pokémon. Its intelligence is said to match that of humans.	DRAGONITE is capable of circling the globe in just sixteen hours. It is a kindhearted POKéMON that leads lost and foundering ships in a storm to the safety of land.	slow	Dragon Pokémon
126	magmar	fire	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/126.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/126.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/126.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/126.png	13	445	mountain	Its body always burns with an orange glow that enables it to hide perfectly among flames.	In battle, MAGMAR blows out intensely hot flames from all over its body to intimidate its opponent. This POKéMON’s fiery bursts create heat waves that ignite grass and trees in its surroundings.	medium	Spitfire Pokémon
75	graveler	rock	ground	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/75.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/75.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/75.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/75.png	10	1050	mountain	Rolls down slopes to move. It rolls over any obstacle without slowing or changing its direction.	Rocks are GRAVELER’s favorite food. This POKéMON will climb a mountain from the base to the summit, crunchingly feasting on rocks all the while. Upon reaching the peak, it rolls back down to the bottom.	medium-slow	Rock Pokémon
78	rapidash	fire	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/78.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/78.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/78.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/78.png	17	950	grassland	Very competitive, this POKéMON will chase anything that moves fast in the hopes of racing it.	RAPIDASH usually can be seen casually cantering in the fields and plains. However, when this POKéMON turns serious, its fiery manes flare and blaze as it gallops its way up to 150 mph.	medium	Fire Horse Pokémon
11	metapod	bug	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/11.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/11.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/11.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/11.png	7	99	forest	A steel-hard shell protects its tender body. It quietly endures hardships while awaiting evolution.	The shell covering this POKéMON’s body is as hard as an iron slab. METAPOD does not move very much. It stays still because it is preparing its soft innards for evolution inside the hard shell.	medium	Cocoon Pokémon
113	chansey	normal	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/113.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/113.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/113.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/113.png	11	346	urban	A rare and elusive POKéMON that is said to bring happiness to those who manage to get it.	CHANSEY lays nutritionally excellent eggs on an everyday basis. The eggs are so delicious, they are easily and eagerly devoured by even those people who have lost their appetite.	fast	Egg Pokémon
49	venomoth	bug	poison	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/49.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/49.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/49.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/49.png	15	125	forest	The dust-like scales covering its wings are color coded to indicate the kinds of poison it has.	VENOMOTH is nocturnal - it is a POKéMON that only becomes active at night. Its favorite prey are small insects that gather around streetlights, attracted by the light in the darkness.	medium	Poison Moth Pokémon
120	staryu	water	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/120.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/120.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/120.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/120.png	8	345	sea	An enigmatic POKéMON that can effortlessly regenerate any appendage it loses in battle.	STARYU apparently communicates with the stars in the night sky by flashing the red core at the center of its body. If parts of its body are torn, this POKéMON simply regenerates the missing pieces and limbs.	slow	Star Shape Pokémon
26	raichu	electric	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/26.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/26.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/26.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/26.png	8	300	forest	Its long tail serves as a ground to protect itself from its own high-voltage power.	If the electrical sacks become excessively charged, RAICHU plants its tail in the ground and discharges. Scorched patches of ground will be found near this POKéMON’s nest.	medium	Mouse Pokémon
3	venusaur	grass	poison	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/3.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/3.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/3.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/3.png	20	1000	grassland	The plant blooms when it is absorbing solar energy. It stays on the move to seek sunlight.	There is a large flower on VENUSAUR’s back. The flower is said to take on vivid colors if it gets plenty of nutrition and sunlight. The flower’s aroma soothes the emotions of people.	medium-slow	Seed Pokémon
127	pinsir	bug	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/127.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/127.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/127.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/127.png	15	550	forest	If it fails to crush the victim in its pincers, it will swing it around and toss it hard.	PINSIR has a pair of massive horns Protruding from the surface of these horns are thorns. These thorns are driven deeply into the foe’s body when the pincer closes, making it tough for the foe to escape.	slow	Stag Beetle Pokémon
8	wartortle	water	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/8.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/8.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/8.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/8.png	10	225	waters-edge	When tapped, this Pokémon will pull in its head, but its tail will still stick out a little bit.	Its tail is large and covered with a rich, thick fur. The tail becomes increasingly deeper in color as WARTORTLE ages. The scratches on its shell are evidence of this POKéMON’s toughness as a battler.	medium-slow	Turtle Pokémon
94	gengar	ghost	poison	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/94.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/94.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/94.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/94.png	15	405	cave	Under a full moon, this POKéMON likes to mimic the shadows of people and laugh at their fright.	Sometimes, on a dark night, your shadow thrown by a streetlight will suddenly and startlingly overtake you. It is actually a GENGAR running past you, pretending to be your shadow.	medium-slow	Shadow Pokémon
36	clefable	fairy	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/36.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/36.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/36.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/36.png	13	400	mountain	A timid fairy POKéMON that is rarely seen. It will run and hide the moment it senses people.	CLEFABLE moves by skipping lightly as if it were flying using its wings. Its bouncy step lets it even walk on water. It is known to take strolls on lakes on quiet, moonlit nights.	fast	Fairy Pokémon
10	caterpie	bug	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/10.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/10.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/10.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/10.png	3	29	forest	Its short feet are tipped with suction pads that enable it to tirelessly climb slopes and walls.	CATERPIE has a voracious appetite. It can devour leaves bigger than its body right before your eyes. From its antenna, this POKéMON releases a terrifically strong odor.	medium	Worm Pokémon
134	vaporeon	water	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/134.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/134.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/134.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/134.png	10	290	urban	Lives close to water. Its long tail is ridged with a fin which is often mistaken for a mermaids.	It prefers beauti­ful shores. With cells similar to water molecules, it could melt in water.	medium	Bubble Jet Pokémon
129	magikarp	water	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/129.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/129.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/129.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/129.png	9	100	waters-edge	In the distant past, it was somewhat stronger than the horribly weak descendants that exist today.	MAGIKARP is a pathetic excuse for a POKéMON that is only capable of flopping and splashing. This behavior prompted scientists to undertake research into it.	slow	Fish Pokémon
1	bulbasaur	grass	poison	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/1.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/1.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/1.png	7	69	grassland	A strange seed was planted on its back at birth. The plant sprouts and grows with this POKéMON.	BULBASAUR can be seen napping in bright sunlight. There is a seed on its back. By soaking up the sun’s rays, the seed grows progressively larger.	medium-slow	Seed Pokémon
61	poliwhirl	water	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/61.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/61.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/61.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/61.png	10	200	waters-edge	The skin on most of its body is moist. However, the skin on its belly spiral feels smooth.	The surface of POLIWHIRL’s body is always wet and slick with an oily fluid. Because of this greasy covering, it can easily slip and slide out of the clutches of any enemy in battle.	medium-slow	Tadpole Pokémon
16	pidgey	normal	flying	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/16.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/16.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/16.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/16.png	3	18	forest	It is docile and prefers to avoid conflict. If disturbed, however, it can ferociously strike back.	PIDGEY has an extremely sharp sense of direction. It is capable of unerringly returning home to its nest, however far it may be removed from its familiar surroundings.	medium-slow	Tiny Bird Pokémon
50	diglett	ground	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/50.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/50.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/50.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/50.png	2	8	cave	Lives about one yard underground where it feeds on plant roots. It sometimes appears above ground.	DIGLETT are raised in most farms. The reason is simple - wherever this POKéMON burrows, the soil is left perfectly tilled for planting crops. This soil is made ideal for growing delicious vegetables.	medium	Mole Pokémon
140	kabuto	rock	water	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/140.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/140.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/140.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/140.png	5	115	sea	A POKéMON that was resurrected from a fossil found in what was once the ocean floor eons ago.	KABUTO is a POKéMON that has been regenerated from a fossil. However, in extremely rare cases, living examples have been discovered. The POKéMON has not changed at all for 300 million years.	medium	Shellfish Pokémon
48	venonat	bug	poison	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/48.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/48.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/48.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/48.png	10	300	forest	Its big eyes are actually clusters of tiny eyes. At night, its kind is drawn by light.	The small bugs it eats appear only at night, so it sleeps in a hole in a tree until night falls.	medium	Insect Pokémon
142	aerodactyl	rock	flying	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/142.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/142.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/142.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/142.png	18	590	mountain	A Pokémon that roamed the skies in the dinosaur era. Its teeth are like saw blades.	In prehistoric times, this POKéMON flew freely and fearlessly through the skies.	slow	Fossil Pokémon
27	sandshrew	ground	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/27.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/27.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/27.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/27.png	6	120	rough-terrain	Burrows deep underground in arid locations far from water. It only emerges to hunt for food.	SANDSHREW has a very dry hide that is extremely tough. The POKéMON can roll into a ball that repels any attack. At night, it burrows into the desert sand to sleep.	medium	Mouse Pokémon
125	electabuzz	electric	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/125.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/125.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/125.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/125.png	11	300	grassland	Normally found near power plants, they can wander away and cause major blackouts in cities.	When a storm arrives, gangs of this POKéMON compete with each other to scale heights that are likely to be stricken by lightning bolts. Some towns use ELECTABUZZ in place of lightning rods.	medium	Electric Pokémon
52	meowth	normal	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/52.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/52.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/52.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/52.png	4	42	urban	Adores circular objects. Wanders the streets on a nightly basis to look for dropped loose change.	MEOWTH withdraws its sharp claws into its paws to slinkily sneak about without making any incriminating footsteps. For some reason, this POKéMON loves shiny coins that glitter with light.	medium	Scratch Cat Pokémon
22	fearow	normal	flying	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/22.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/22.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/22.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/22.png	12	380	rough-terrain	With its huge and magnificent wings, it can keep aloft without ever having to land for rest.	It uses its long beak to attack. It has a surprisingly long reach, so it must be treated with caution.	medium	Beak Pokémon
123	scyther	bug	flying	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/123.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/123.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/123.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/123.png	15	560	grassland	With ninja-like agility and speed, it can create the illusion that there is more than one.	SCYTHER is blindingly fast. Its blazing speed enhances the effectiveness of the twin scythes on its forearms. This POKéMON’s scythes are so effective, they can slice through thick logs in one wicked stroke.	medium	Mantis Pokémon
128	tauros	normal	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/128.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/128.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/128.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/128.png	14	884	grassland	When it targets an enemy, it charges furiously while whipping its body with its long tails.	This POKéMON is not satisfied unless it is rampaging at all times. If there is no opponent for TAUROS to battle, it will charge at thick trees and knock them down to calm itself.	slow	Wild Bull Pokémon
34	nidoking	poison	ground	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/34.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/34.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/34.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/34.png	14	620	grassland	One swing of its mighty tail can snap a telephone pole as if it were a matchstick.	Its tail is thick and powerful. If it binds an enemy, it can snap the victim''s spine quite easily.	medium-slow	Drill Pokémon
122	mr-mime	psychic	fairy	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/122.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/122.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/122.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/122.png	13	545	urban	If interrupted while it is miming, it will slap around the offender with its broad hands.	MR. MIME is a master of pantomime. Its gestures and motions convince watchers that something unseeable actually exists. Once it is believed, it will exist as if it were a real thing.	medium	Barrier Pokémon
132	ditto	normal	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/132.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/132.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/132.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/132.png	3	40	urban	Capable of copying an enemy''s genetic code to instantly transform itself into a duplicate of the enemy.	DITTO rearranges its cell structure to transform itself into other shapes. However, if it tries to transform itself into something by relying on its memory, this POKéMON manages to get details wrong.	medium	Transform Pokémon
144	articuno	ice	flying	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/144.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/144.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/144.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/144.png	17	554	rare	A legendary bird POKéMON that is said to appear to doomed people who are lost in icy mountains.	ARTICUNO is a legendary bird POKéMON that can control ice. The flapping of its wings chills the air. As a result, it is said that when this POKéMON flies, snow will fall.	slow	Freeze Pokémon
84	doduo	normal	flying	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/84.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/84.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/84.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/84.png	14	392	grassland	A bird that makes up for its poor flying with its fast foot speed. Leaves giant footprints.	DODUO’s two heads contain completely identical brains. A scientific study reported that on rare occasions, there will be examples of this POKéMON possessing different sets of brains.	medium	Twin Bird Pokémon
115	kangaskhan	normal	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/115.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/115.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/115.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/115.png	22	800	grassland	The infant rarely ventures out of its mother''s protective pouch until it is 3 years old.	If you come across a young KANGASKHAN playing by itself, you must never disturb it or attempt to catch it. The baby POKéMON’s parent is sure to be in the area, and it will become violently enraged at you.	medium	Parent Pokémon
9	blastoise	water	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/9.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/9.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/9.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/9.png	16	855	waters-edge	A brutal POKéMON with pressurized water jets on its shell. They are used for high speed tackles.	BLASTOISE has water spouts that protrude from its shell. The water spouts are very accurate. They can shoot bullets of water with enough accuracy to strike empty cans from a distance of over 160 feet.	medium-slow	Shellfish Pokémon
32	nidoran-m	poison	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/32.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/32.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/32.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/32.png	5	90	grassland	Stiffens its ears to sense danger. The larger its horns, the more powerful its secreted venom.	The male NIDORAN has developed muscles for moving its ears. Thanks to them, the ears can be freely moved in any direction. Even the slightest sound does not escape this POKéMON’s notice.	medium-slow	Poison Pin Pokémon
110	weezing	poison	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/110.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/110.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/110.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/110.png	12	95	urban	Where two kinds of poison gases meet, 2 KOFFINGs can fuse into a WEEZING over many years.	WEEZING alternately shrinks and inflates its twin bodies to mix together toxic gases inside. The more the gases are mixed, the more powerful the toxins become. The POKéMON also becomes more putrid.	medium	Poison Gas Pokémon
12	butterfree	bug	flying	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/12.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/12.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/12.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/12.png	11	320	forest	In battle, it flaps its wings at high speed to release highly toxic dust into the air.	BUTTERFREE has a superior ability to search for delicious honey from flowers. It can even search out, extract, and carry honey from flowers that are blooming over six miles from its nest.	medium	Butterfly Pokémon
150	mewtwo	psychic	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/150.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/150.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/150.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/150.png	20	1220	rare	It was created by a scientist after years of horrific gene splicing and DNA engineering experiments.	MEWTWO is a POKéMON that was created by genetic manipulation. However, even though the scientific power of humans created this POKéMON’s body, they failed to endow MEWTWO with a compassionate heart.	slow	Genetic Pokémon
97	hypno	psychic	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/97.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/97.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/97.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/97.png	16	756	grassland	When it locks eyes with an enemy, it will use a mix of PSI moves such as HYPNOSIS and CONFUSION.	HYPNO holds a pendulum in its hand. The arcing movement and glitter of the pendulum lull the foe into a deep state of hypnosis. While this POKéMON searches for prey, it polishes the pendulum.	medium	Hypnosis Pokémon
65	alakazam	psychic	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/65.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/65.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/65.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/65.png	15	480	urban	Its brain can out­ perform a super­ computer. Its intelligence quotient is said to be 5,000.	ALAKAZAM’s brain continually grows, infinitely multiplying brain cells. This amazing brain gives this POKéMON an astoundingly high IQ of 5,000. It has a thorough memory of everything that has occurred in the world.	medium-slow	Psi Pokémon
46	paras	bug	grass	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/46.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/46.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/46.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/46.png	3	54	forest	Burrows to suck tree roots. The mushrooms on its back grow by draw­ ing nutrients from the bug host.	PARAS has parasitic mushrooms growing on its back called tochukaso. They grow large by drawing nutrients from this BUG POKéMON host. They are highly valued as a medicine for extending life.	medium	Mushroom Pokémon
17	pidgeotto	normal	flying	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/17.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/17.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/17.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/17.png	11	300	forest	Very protective of its sprawling territorial area, this POKéMON will fiercely peck at any intruder.	PIDGEOTTO claims a large area as its own territory. This POKéMON flies around, patrolling its living space. If its territory is violated, it shows no mercy in thoroughly punishing the foe with its sharp claws.	medium-slow	Bird Pokémon
145	zapdos	electric	flying	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/145.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/145.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/145.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/145.png	16	526	rare	A legendary bird POKéMON that is said to appear from clouds while dropping enormous lightning bolts.	ZAPDOS is a legendary bird POKéMON that has the ability to control electricity. It usually lives in thunderclouds. The POKéMON gains power if it is stricken by lightning bolts.	slow	Electric Pokémon
43	oddish	grass	poison	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/43.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/43.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/43.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/43.png	5	54	grassland	Awakened by moonlight, it roams actively at night. In the day, it stays quietly underground.	During the daytime, ODDISH buries itself in soil to absorb nutrients from the ground using its entire body. The more fertile the soil, the glossier its leaves become.	medium-slow	Weed Pokémon
130	gyarados	water	flying	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/130.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/130.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/130.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/130.png	65	2350	waters-edge	Rarely seen in the wild. Huge and vicious, it is capable of destroying entire cities in a rage.	Once GYARADOS goes on a rampage, its ferociously violent blood doesn’t calm until it has burned everything down. There are records of this POKéMON’s rampages lasting a whole month.	slow	Atrocious Pokémon
28	sandslash	ground	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/28.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/28.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/28.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/28.png	10	295	rough-terrain	Curls up into a spiny ball when threatened. It can roll while curled up to attack or escape.	SANDSLASH can roll up its body as if it were a ball covered with large spikes. In battle, this POKéMON will try to make the foe flinch by jabbing it with its spines. It then leaps at the stunned foe to tear wildly with its sharp claws.	medium	Mouse Pokémon
114	tangela	grass	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/114.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/114.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/114.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/114.png	10	350	grassland	The whole body is swathed with wide vines that are similar to sea­ weed. Its vines shake as it walks.	TANGELA’s vines snap off easily if they are grabbed. This happens without pain, allowing it to make a quick getaway. The lost vines are replaced by newly grown vines the very next day.	medium	Vine Pokémon
39	jigglypuff	normal	fairy	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/39.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/39.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/39.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/39.png	5	55	grassland	When its huge eyes light up, it sings a mysteriously soothing melody that lulls its enemies to sleep.	When this POKéMON sings, it never pauses to breathe. If it is in a battle against an opponent that does not easily fall asleep, JIGGLYPUFF cannot breathe, endangering its life.	fast	Balloon Pokémon
21	spearow	normal	flying	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/21.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/21.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/21.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/21.png	3	20	rough-terrain	Eats bugs in grassy areas. It has to flap its short wings at high speed to stay airborne.	SPEAROW has a very loud cry that can be heard over half a mile away. If its high, keening cry is heard echoing all around, it is a sign that they are warning each other of danger.	medium	Tiny Bird Pokémon
77	ponyta	fire	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/77.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/77.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/77.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/77.png	10	300	grassland	Its hooves are 10 times harder than diamonds. It can trample anything completely flat in little time.	PONYTA is very weak at birth. It can barely stand up. This POKéMON becomes stronger by stumbling and falling to keep up with its parent.	medium	Fire Horse Pokémon
99	kingler	water	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/99.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/99.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/99.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/99.png	13	600	waters-edge	The large pincer has 10000 hp of crushing power. However, its huge size makes it unwieldy to use.	KINGLER has an enormous, oversized claw. It waves this huge claw in the air to communicate with others. However, because the claw is so heavy, the POKéMON quickly tires.	medium	Pincer Pokémon
147	dratini	dragon	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/147.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/147.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/147.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/147.png	18	33	waters-edge	Long considered a mythical POKéMON until recently when a small colony was found living underwater.	DRATINI continually molts and sloughs off its old skin. It does so because the life energy within its body steadily builds to reach uncontrollable levels.	slow	Dragon Pokémon
143	snorlax	normal	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/143.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/143.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/143.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/143.png	21	4600	mountain	Very lazy. Just eats and sleeps. As its rotund bulk builds, it becomes steadily more slothful.	SNORLAX’s typical day consists of nothing more than eating and sleeping. It is such a docile POKéMON that there are children who use its expansive belly as a place to play.	slow	Sleeping Pokémon
67	machoke	fighting	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/67.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/67.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/67.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/67.png	15	705	mountain	It happily carries heavy cargo to toughen up. It willingly does hard work for people.	MACHOKE’s thoroughly toned muscles possess the hardness of steel. This POKéMON has so much strength, it can easily hold aloft a sumo wrestler on just one finger.	medium-slow	Superpower Pokémon
85	dodrio	normal	flying	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/85.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/85.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/85.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/85.png	18	852	grassland	Uses its three brains to execute complex plans. While two heads sleep, one head stays awake.	Apparently, the heads aren’t the only parts of the body that DODRIO has three of. It has three sets of hearts and lungs as well, so it is capable of running long distances without rest.	medium	Triple Bird Pokémon
96	drowzee	psychic	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/96.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/96.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/96.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/96.png	10	324	grassland	Puts enemies to sleep then eats their dreams. Occasionally gets sick from eating bad dreams.	If your nose becomes itchy while you are sleeping, it’s a sure sign that one of these POKéMON is standing above your pillow and trying to eat your dream through your nostrils.	medium	Hypnosis Pokémon
2	ivysaur	grass	poison	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/2.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/2.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/2.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/2.png	10	130	grassland	When the bulb on its back grows large, it appears to lose the ability to stand on its hind legs.	There is a bud on this POKéMON’s back. To support its weight, IVYSAUR’s legs and trunk grow thick and strong. If it starts spending more time lying in the sunlight, it’s a sign that the bud will bloom into a large flower soon.	medium-slow	Seed Pokémon
146	moltres	fire	flying	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/146.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/146.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/146.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/146.png	20	600	rare	One of the legendary bird Pokémon. It is said that its appearance indicates the coming of spring.	Legendary bird POKéMON. It is said to migrate from the south along with the spring.	slow	Flame Pokémon
133	eevee	normal	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/133.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/133.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/133.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/133.png	3	65	urban	Its genetic code is irregular. It may mutate if it is exposed to radiation from element STONEs. Known to have an unusual affection for Jenn.	EEVEE has an unstable genetic makeup that suddenly mutates due to the environment in which it lives. Radiation from various STONES causes this POKéMON to evolve.	medium	Evolution Pokémon
23	ekans	poison	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/23.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/23.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/23.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/23.png	20	69	grassland	Moves silently and stealthily. Eats the eggs of birds, such as PIDGEY and SPEAROW, whole.	EKANS curls itself up in a spiral while it rests. Assuming this position allows it to quickly respond to a threat from any direction with a glare from its upraised head.	medium	Snake Pokémon
7	squirtle	water	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/7.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/7.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/7.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/7.png	5	90	waters-edge	After birth, its back swells and hardens into a shell. Powerfully sprays foam from its mouth.	SQUIRTLE’s shell is not merely used for protection. The shell’s rounded shape and the grooves on its surface help minimize resistance in water, enabling this POKéMON to swim at high speeds.	medium-slow	Tiny Turtle Pokémon
55	golduck	water	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/55.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/55.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/55.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/55.png	17	766	waters-edge	Often seen swim­ ming elegantly by lake shores. It is often mistaken for the Japanese monster, Kappa.	GOLDUCK is the fastest swimmer among all POKéMON. It swims effortlessly, even in a rough, stormy sea. It sometimes rescues people from wrecked ships floundering in high seas.	medium	Duck Pokémon
6	charizard	fire	flying	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/6.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/6.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/6.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/6.png	17	905	mountain	Spits fire that is hot enough to melt boulders. Known to cause forest fires unintentionally.	CHARIZARD flies around the sky in search of powerful opponents. It breathes fire of such great heat that it melts anything. However, it never turns its fiery breath on any opponent weaker than itself.	medium-slow	Flame Pokémon
151	mew	psychic	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/151.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/151.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/151.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/151.png	4	40	rare	So rare that it is still said to be a mirage by many experts. Only a few people have seen it worldwide.	MEW is said to possess the genetic composition of all POKéMON. It is capable of making itself invisible at will, so it entirely avoids notice even if it approaches people.	medium-slow	New Species Pokémon
47	parasect	bug	grass	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/47.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/47.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/47.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/47.png	10	295	forest	A host-parasite pair in which the parasite mushroom has taken over the host bug. Prefers damp places.	PARASECT is known to infest large trees en masse and drain nutrients from the lower trunk and roots. When an infested tree dies, they move onto another tree all at once.	medium	Mushroom Pokémon
139	omastar	rock	water	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/139.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/139.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/139.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/139.png	10	350	sea	Once wrapped around its prey, it never lets go. It eats the prey by tearing at it with sharp fangs.	OMASTAR uses its tentacles to capture its prey. It is believed to have become extinct because its shell grew too large and heavy, causing its movements to become too slow and ponderous.	medium	Spiral Pokémon
54	psyduck	water	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/54.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/54.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/54.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/54.png	8	196	waters-edge	While lulling its enemies with its vacant look, this wily POKéMON will use psychokinetic powers.	If it uses its mysterious power, PSYDUCK can’t remember having done so. It apparently can’t form a memory of such an event because it goes into an altered state that is much like deep sleep.	medium	Duck Pokémon
66	machop	fighting	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/66.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/66.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/66.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/66.png	8	195	mountain	Loves to build its muscles. It trains in all styles of martial arts to become even stronger.	MACHOP exercises by hefting around a GRAVELER as if it were a barbell. There are some MACHOP that travel the world in a quest to master all kinds of martial arts.	medium-slow	Superpower Pokémon
56	mankey	fighting	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/56.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/56.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/56.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/56.png	5	280	mountain	It lives in treetop colonies. If one becomes enraged, the whole colony rampages for no reason.	When MANKEY starts shaking and its nasal breathing turns rough, it’s a sure sign that it is becoming angry. However, because it goes into a towering rage almost instantly, it is impossible for anyone to flee its wrath.	medium	Pig Monkey Pokémon
95	onix	rock	ground	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/95.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/95.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/95.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/95.png	88	2100	cave	As it grows, the stone portions of its body harden to become similar to a diamond, but colored black.	ONIX has a magnet in its brain. It acts as a compass so that this POKéMON does not lose direction while it is tunneling. As it grows older, its body becomes increasingly rounder and smoother.	medium	Rock Snake Pokémon
31	nidoqueen	poison	ground	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/31.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/31.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/31.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/31.png	13	600	grassland	Its hard scales provide strong protection. It uses its hefty bulk to execute powerful moves.	NIDOQUEEN’s body is encased in extremely hard scales. It is adept at sending foes flying with harsh tackles. This POKéMON is at its strongest when it is defending its young.	medium-slow	Drill Pokémon
148	dragonair	dragon	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/148.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/148.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/148.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/148.png	40	165	waters-edge	A mystical POKéMON that exudes a gentle aura. Has the ability to change climate conditions.	DRAGONAIR stores an enormous amount of energy inside its body. It is said to alter weather conditions in its vicinity by discharging energy from the crystals on its neck and tail.	slow	Dragon Pokémon
111	rhyhorn	ground	rock	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/111.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/111.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/111.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/111.png	10	1150	rough-terrain	Its massive bones are 1000 times harder than human bones. It can easily knock a trailer flying.	RHYHORN’s brain is very small. It is so dense, while on a run it forgets why it started running in the first place. It apparently remembers sometimes if it demolishes something.	slow	Spikes Pokémon
135	jolteon	electric	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/135.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/135.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/135.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/135.png	8	245	urban	It accumulates negative ions in the atmosphere to blast out 10000- volt lightning bolts.	JOLTEON’s cells generate a low level of electricity. This power is amplified by the static electricity of its fur, enabling the POKéMON to drop thunderbolts. The bristling fur is made of electrically charged needles.	medium	Lightning Pokémon
136	flareon	fire	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/136.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/136.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/136.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/136.png	9	250	urban	When storing thermal energy in its body, its temperature could soar to over 1600 degrees.	FLAREON’s fluffy fur has a functional purpose - it releases heat into the air so that its body does not get excessively hot. This POKéMON’s body temperature can rise to a maximum of 1,650 degrees F.	medium	Flame Pokémon
64	kadabra	psychic	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/64.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/64.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/64.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/64.png	13	565	urban	It emits special alpha waves from its body that induce headaches just by being close by.	KADABRA holds a silver spoon in its hand. The spoon is used to amplify the alpha waves in its brain. Without the spoon, the POKéMON is said to be limited to half the usual amount of its telekinetic powers.	medium-slow	Psi Pokémon
18	pidgeot	normal	flying	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/18.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/18.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/18.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/18.png	15	395	forest	When hunting, it skims the surface of water at high speed to pick off unwary prey such as MAGIKARP.	This POKéMON has a dazzling plumage of beautifully glossy feathers. Many TRAINERS are captivated by the striking beauty of the feathers on its head, compelling them to choose PIDGEOT as their POKéMON.	medium-slow	Bird Pokémon
118	goldeen	water	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/118.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/118.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/118.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/118.png	6	150	waters-edge	Its tail fin billows like an elegant ballroom dress, giving it the nickname of the Water Queen.	GOLDEEN loves swimming wild and free in rivers and ponds. If one of these POKéMON is placed in an aquarium, it will shatter even the thickest glass with one ram of its horn and make its escape.	medium	Goldfish Pokémon
138	omanyte	rock	water	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/138.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/138.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/138.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/138.png	4	75	sea	Although long extinct, in rare cases, it can be genetically resurrected from fossils.	OMANYTE is one of the ancient and long- since-extinct POKéMON that have been regenerated from fossils by people. If attacked by an enemy, it withdraws itself inside its hard shell.	medium	Spiral Pokémon
29	nidoran-f	poison	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/29.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/29.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/29.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/29.png	4	70	grassland	Although small, its venomous barbs render this Pokémon dangerous. The female has smaller horns.	NIDORAN has barbs that secrete a powerful poison. They are thought to have developed as protection for this small-bodied POKéMON. When enraged, it releases a horrible toxin from its horn.	medium-slow	Poison Pin Pokémon
4	charmander	fire	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/4.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/4.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/4.png	6	85	mountain	The fire on the tip of its tail is a measure of its life. If healthy, its tail burns intensely.	The flame that burns at the tip of its tail is an indication of its emotions. The flame wavers when CHARMANDER is enjoying itself. If the POKéMON becomes enraged, the flame burns fiercely.	medium-slow	Lizard Pokémon
25	pikachu	electric	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/25.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/25.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/25.png	4	60	forest	When several of these POKéMON gather, their electricity could build and cause lightning storms.	This POKéMON has electricity-storing pouches on its cheeks. These appear to become electrically charged during the night while PIKACHU sleeps. It occasionally discharges electricity when it is dozy after waking up.	medium	Mouse Pokémon
5	charmeleon	fire	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/5.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/5.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/5.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/5.png	11	190	mountain	When it swings its burning tail, it elevates the temperature to unbearably high levels.	CHARMELEON mercilessly destroys its foes using its sharp claws. If it encounters a strong foe, it turns aggressive. In this excited state, the flame at the tip of its tail flares with a bluish white color.	medium-slow	Flame Pokémon
53	persian	normal	\N	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/53.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/53.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/53.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/53.png	10	320	urban	Although its fur has many admirers, it is tough to raise as a pet because of its fickle meanness.	PERSIAN has six bold whiskers that give it a look of toughness. The whiskers sense air movements to determine what is in the POKéMON’s surrounding vicinity. It becomes docile if grabbed by the whiskers.	medium	Classy Cat Pokémon
81	magnemite	electric	steel	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/81.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/81.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/81.png	https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/81.png	3	60	rough-terrain	Uses anti-gravity to stay suspended. Appears without warning and uses THUNDER WAVE and similar moves.	MAGNEMITE floats in the air by emitting electromagnetic waves from the units at its sides. These waves block gravity. This POKéMON becomes incapable of flight if its internal electrical supply is depleted.	medium	Magnet Pokémon
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.users (user_id, miles_walked, encounters, created_at, updated_at, time_walked) FROM stdin;
2	0	0	2020-06-24 20:53:49.892899+00	2020-06-24 20:53:49.892899+00	\N
3	0	0	2020-06-25 07:36:12.390305+00	2020-06-25 07:36:12.390305+00	\N
4	0	0	2020-06-25 07:36:14.63789+00	2020-06-25 07:36:14.63789+00	\N
1	3	6	2020-06-24 18:23:31.445757+00	2020-06-25 21:50:50.612513+00	\N
5	3	2	2020-06-25 18:32:21.109893+00	2020-06-26 08:48:20.927327+00	\N
6	0	0	2020-06-26 17:32:45.568468+00	2020-06-26 17:32:45.568468+00	\N
7	0	0	2020-06-26 18:26:57.796025+00	2020-06-26 18:26:57.796025+00	\N
8	0	0	2020-06-26 18:29:54.653006+00	2020-06-26 18:29:54.653006+00	\N
9	0	0	2020-06-26 18:32:35.153231+00	2020-06-26 18:32:35.153231+00	\N
10	0	0	2020-06-26 18:33:01.564755+00	2020-06-26 18:33:01.564755+00	\N
11	0	0	2020-06-26 18:34:16.658712+00	2020-06-26 18:34:16.658712+00	\N
12	0	0	2020-06-26 18:36:44.985178+00	2020-06-26 18:36:44.985178+00	\N
13	0	0	2020-06-26 18:56:58.476857+00	2020-06-26 18:56:58.476857+00	\N
14	0	0	2020-06-26 21:29:25.038443+00	2020-06-26 21:29:25.038443+00	\N
\.


--
-- Name: backpackItems_backpackId_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."backpackItems_backpackId_seq"', 1, false);


--
-- Name: items_itemId_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."items_itemId_seq"', 1, false);


--
-- Name: pokeboxes_pokeboxId_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."pokeboxes_pokeboxId_seq"', 10, true);


--
-- Name: users_userId_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."users_userId_seq"', 14, true);


--
-- Name: backpack_items backpackItems_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.backpack_items
    ADD CONSTRAINT "backpackItems_pk" PRIMARY KEY (backpack_id);


--
-- Name: items items_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT items_pk PRIMARY KEY (item_id);


--
-- Name: pokeboxes pokeboxes_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pokeboxes
    ADD CONSTRAINT pokeboxes_pk PRIMARY KEY (pokebox_id);


--
-- Name: pokemon pokemon_v2_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pokemon
    ADD CONSTRAINT pokemon_v2_pk PRIMARY KEY (pokemon_id);


--
-- Name: users users_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pk PRIMARY KEY (user_id);


--
-- Name: pokeboxes set_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER set_timestamp BEFORE UPDATE ON public.pokeboxes FOR EACH ROW EXECUTE PROCEDURE public.trigger_set_timestamp();


--
-- Name: users set_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER set_timestamp BEFORE UPDATE ON public.users FOR EACH ROW EXECUTE PROCEDURE public.trigger_set_timestamp();


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: -
--

GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--


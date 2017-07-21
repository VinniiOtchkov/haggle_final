--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.3
-- Dumped by pg_dump version 9.6.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: haggles; Type: TABLE; Schema: public; Owner: vinniiotchkov
--

CREATE TABLE haggles (
    id integer NOT NULL,
    seller_id integer,
    buyer_id integer,
    haggle_price integer,
    item_id integer,
    status_id integer DEFAULT 1
);


ALTER TABLE haggles OWNER TO vinniiotchkov;

--
-- Name: items; Type: TABLE; Schema: public; Owner: vinniiotchkov
--

CREATE TABLE items (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    initial_price integer NOT NULL,
    description character varying(255) NOT NULL,
    sold boolean DEFAULT false,
    img_url character varying(255),
    seller_id integer
);


ALTER TABLE items OWNER TO vinniiotchkov;

--
-- Name: locations; Type: TABLE; Schema: public; Owner: vinniiotchkov
--

CREATE TABLE locations (
    id integer NOT NULL,
    city character varying(255),
    state_id integer
);


ALTER TABLE locations OWNER TO vinniiotchkov;

--
-- Name: statuses; Type: TABLE; Schema: public; Owner: vinniiotchkov
--

CREATE TABLE statuses (
    id integer NOT NULL,
    status character varying(255)
);


ALTER TABLE statuses OWNER TO vinniiotchkov;

--
-- Name: users; Type: TABLE; Schema: public; Owner: vinniiotchkov
--

CREATE TABLE users (
    id integer NOT NULL,
    name character varying(255),
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    location_id integer
);


ALTER TABLE users OWNER TO vinniiotchkov;

--
-- Name: buyer_by_id; Type: VIEW; Schema: public; Owner: vinniiotchkov
--

CREATE VIEW buyer_by_id AS
 SELECT u.name AS buyer_name,
    u.id AS buyer_id,
    u2.name AS seller_name,
    u2.id AS seller_id,
    i.name AS item_name,
    i.description,
    i.img_url,
    h.haggle_price,
    s.status,
    l.city
   FROM (((((haggles h
     JOIN users u ON ((u.id = h.buyer_id)))
     JOIN users u2 ON ((u2.id = h.seller_id)))
     JOIN items i ON ((h.item_id = i.id)))
     JOIN statuses s ON ((h.status_id = s.id)))
     JOIN locations l ON ((l.id = u2.location_id)));


ALTER TABLE buyer_by_id OWNER TO vinniiotchkov;

--
-- Name: categories; Type: TABLE; Schema: public; Owner: vinniiotchkov
--

CREATE TABLE categories (
    id integer NOT NULL,
    name character varying(255)
);


ALTER TABLE categories OWNER TO vinniiotchkov;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: vinniiotchkov
--

CREATE SEQUENCE categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE categories_id_seq OWNER TO vinniiotchkov;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vinniiotchkov
--

ALTER SEQUENCE categories_id_seq OWNED BY categories.id;


--
-- Name: haggles_id_seq; Type: SEQUENCE; Schema: public; Owner: vinniiotchkov
--

CREATE SEQUENCE haggles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE haggles_id_seq OWNER TO vinniiotchkov;

--
-- Name: haggles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vinniiotchkov
--

ALTER SEQUENCE haggles_id_seq OWNED BY haggles.id;


--
-- Name: items_by_location; Type: VIEW; Schema: public; Owner: vinniiotchkov
--

CREATE VIEW items_by_location AS
 SELECT i.id,
    i.img_url,
    i.name,
    i.description,
    i.initial_price,
    i.sold,
    l.city,
    l.id AS location_id,
    u.name AS seller_name
   FROM ((items i
     JOIN users u ON ((i.seller_id = u.id)))
     JOIN locations l ON ((u.location_id = l.id)));


ALTER TABLE items_by_location OWNER TO vinniiotchkov;

--
-- Name: items_id_seq; Type: SEQUENCE; Schema: public; Owner: vinniiotchkov
--

CREATE SEQUENCE items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE items_id_seq OWNER TO vinniiotchkov;

--
-- Name: items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vinniiotchkov
--

ALTER SEQUENCE items_id_seq OWNED BY items.id;


--
-- Name: knex_migrations; Type: TABLE; Schema: public; Owner: vinniiotchkov
--

CREATE TABLE knex_migrations (
    id integer NOT NULL,
    name character varying(255),
    batch integer,
    migration_time timestamp with time zone
);


ALTER TABLE knex_migrations OWNER TO vinniiotchkov;

--
-- Name: knex_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: vinniiotchkov
--

CREATE SEQUENCE knex_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE knex_migrations_id_seq OWNER TO vinniiotchkov;

--
-- Name: knex_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vinniiotchkov
--

ALTER SEQUENCE knex_migrations_id_seq OWNED BY knex_migrations.id;


--
-- Name: knex_migrations_lock; Type: TABLE; Schema: public; Owner: vinniiotchkov
--

CREATE TABLE knex_migrations_lock (
    is_locked integer
);


ALTER TABLE knex_migrations_lock OWNER TO vinniiotchkov;

--
-- Name: locations_id_seq; Type: SEQUENCE; Schema: public; Owner: vinniiotchkov
--

CREATE SEQUENCE locations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE locations_id_seq OWNER TO vinniiotchkov;

--
-- Name: locations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vinniiotchkov
--

ALTER SEQUENCE locations_id_seq OWNED BY locations.id;


--
-- Name: seller_item_list; Type: VIEW; Schema: public; Owner: vinniiotchkov
--

CREATE VIEW seller_item_list AS
 SELECT u2.email,
    h.id AS haggle_id,
    h.name AS item_name,
    h.seller_id,
    h.haggle_price,
    h.buyer_id,
    h.status_id,
    h.img_url,
    u.name AS seller_name
   FROM ((users u
     RIGHT JOIN ( SELECT i.seller_id,
            i.id,
            i.name,
            i.description,
            i.img_url,
            i.initial_price,
            h_1.haggle_price,
            h_1.buyer_id,
            h_1.status_id
           FROM (items i
             LEFT JOIN haggles h_1 ON ((i.id = h_1.item_id)))) h ON ((u.id = h.seller_id)))
     LEFT JOIN users u2 ON ((h.buyer_id = u2.id)));


ALTER TABLE seller_item_list OWNER TO vinniiotchkov;

--
-- Name: selling_by_id; Type: VIEW; Schema: public; Owner: vinniiotchkov
--

CREATE VIEW selling_by_id AS
 SELECT u.name AS seller_name,
    u.id AS seller_id,
    u2.name AS buyer_name,
    u2.id AS buyer_id,
    i.name AS item_name,
    i.description,
    i.initial_price,
    i.img_url,
    h.haggle_price,
    s.status
   FROM ((((haggles h
     JOIN users u ON ((h.seller_id = u.id)))
     LEFT JOIN users u2 ON ((h.buyer_id = u2.id)))
     LEFT JOIN items i ON ((h.item_id = i.id)))
     JOIN statuses s ON ((h.status_id = s.id)));


ALTER TABLE selling_by_id OWNER TO vinniiotchkov;

--
-- Name: states; Type: TABLE; Schema: public; Owner: vinniiotchkov
--

CREATE TABLE states (
    id integer NOT NULL,
    name character varying(255),
    abreviation character varying(255)
);


ALTER TABLE states OWNER TO vinniiotchkov;

--
-- Name: states_id_seq; Type: SEQUENCE; Schema: public; Owner: vinniiotchkov
--

CREATE SEQUENCE states_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE states_id_seq OWNER TO vinniiotchkov;

--
-- Name: states_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vinniiotchkov
--

ALTER SEQUENCE states_id_seq OWNED BY states.id;


--
-- Name: statuses_id_seq; Type: SEQUENCE; Schema: public; Owner: vinniiotchkov
--

CREATE SEQUENCE statuses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE statuses_id_seq OWNER TO vinniiotchkov;

--
-- Name: statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vinniiotchkov
--

ALTER SEQUENCE statuses_id_seq OWNED BY statuses.id;


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: vinniiotchkov
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_id_seq OWNER TO vinniiotchkov;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vinniiotchkov
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: vinniiotchkov
--

ALTER TABLE ONLY categories ALTER COLUMN id SET DEFAULT nextval('categories_id_seq'::regclass);


--
-- Name: haggles id; Type: DEFAULT; Schema: public; Owner: vinniiotchkov
--

ALTER TABLE ONLY haggles ALTER COLUMN id SET DEFAULT nextval('haggles_id_seq'::regclass);


--
-- Name: items id; Type: DEFAULT; Schema: public; Owner: vinniiotchkov
--

ALTER TABLE ONLY items ALTER COLUMN id SET DEFAULT nextval('items_id_seq'::regclass);


--
-- Name: knex_migrations id; Type: DEFAULT; Schema: public; Owner: vinniiotchkov
--

ALTER TABLE ONLY knex_migrations ALTER COLUMN id SET DEFAULT nextval('knex_migrations_id_seq'::regclass);


--
-- Name: locations id; Type: DEFAULT; Schema: public; Owner: vinniiotchkov
--

ALTER TABLE ONLY locations ALTER COLUMN id SET DEFAULT nextval('locations_id_seq'::regclass);


--
-- Name: states id; Type: DEFAULT; Schema: public; Owner: vinniiotchkov
--

ALTER TABLE ONLY states ALTER COLUMN id SET DEFAULT nextval('states_id_seq'::regclass);


--
-- Name: statuses id; Type: DEFAULT; Schema: public; Owner: vinniiotchkov
--

ALTER TABLE ONLY statuses ALTER COLUMN id SET DEFAULT nextval('statuses_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: vinniiotchkov
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: vinniiotchkov
--

COPY categories (id, name) FROM stdin;
1	Electronics
2	Music equimpment
\.


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vinniiotchkov
--

SELECT pg_catalog.setval('categories_id_seq', 2, true);


--
-- Data for Name: haggles; Type: TABLE DATA; Schema: public; Owner: vinniiotchkov
--

COPY haggles (id, seller_id, buyer_id, haggle_price, item_id, status_id) FROM stdin;
1	2	1	20000	5	2
\.


--
-- Name: haggles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vinniiotchkov
--

SELECT pg_catalog.setval('haggles_id_seq', 1, true);


--
-- Data for Name: items; Type: TABLE DATA; Schema: public; Owner: vinniiotchkov
--

COPY items (id, name, initial_price, description, sold, img_url, seller_id) FROM stdin;
5	2014 Nissan Altima car	14000	only 28,000 miles	f	https://cars.usnews.com/static/images/Auto/izmo/i4495/2014_nissan_altima_angularfront.jpg	2
6	2013 Frontier car	21000	quad cab, cherry red	f	https://www.cstatic-images.com/car-pictures/xl/CAC30NIT123A021001.png	3
7	Nintendo Wii U electronics	150	selling to buy the Switch	f	https://upload.wikimedia.org/wikipedia/commons/4/4a/Wii_U_Console_and_Gamepad.png	2
8	iMac 27" electronics	1500	32 GB RAM, Intel core i7	f	https://store.storeimages.cdn-apple.com/4974/as-images.apple.com/is/image/AppleInc/aos/published/images/I/MA/IMAC/IMAC?wid=1200&hei=630&fmt=jpeg&qlt=95&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp&.v=8oel91	3
9	Drum set music	300	son no longer uses them	f	https://s3.amazonaws.com/images.static.steveweissmusic.com/products/images/uploads/1133742_28255_popup.jpg	3
10	Drobo 5N electronics	600	4 x 3TB drives included	f	http://www.drobo.com/wp-content/uploads/2014/02/5bay-front-header.png	3
4	guitar pick music	1000	used by Eric Clapton	f	https://multimedia.bbycastatic.ca/multimedia/products/1500x1500/102/10262/10262918.jpg	2
3	bass guitar music	3000	Got it from Eddie Van Halen himself	f	http://media.guitarcenter.com/is/image/MMGS7/LX200B-Series-III-Electric-Bass-Guitar-Metallic-Blue/H11151000001000-00-500x500.jpg	1
2	tv electronics	100	47 inch 1080p but has burnt out pixels	f	http://4k.com/wp-content/uploads/2015/12/Samsung-TV-Apps-5@2x.jpg	1
1	amplifier music	1000	Like new	f	https://images-na.ssl-images-amazon.com/images/G/01/electronics/detail-page/PTAU45.jpg	1
\.


--
-- Name: items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vinniiotchkov
--

SELECT pg_catalog.setval('items_id_seq', 10, true);


--
-- Data for Name: knex_migrations; Type: TABLE DATA; Schema: public; Owner: vinniiotchkov
--

COPY knex_migrations (id, name, batch, migration_time) FROM stdin;
1	20170717132211_create_state_table.js	1	2017-07-21 10:46:11.04-07
2	20170717132223_create_location_table.js	1	2017-07-21 10:46:11.055-07
3	20170717132236_create_users_table.js	1	2017-07-21 10:46:11.07-07
4	20170717132250_create_categories_table.js	1	2017-07-21 10:46:11.079-07
5	20170717132302_create_items_table.js	1	2017-07-21 10:46:11.091-07
6	20170717132314_create_statuses_table.js	1	2017-07-21 10:46:11.099-07
7	20170717132328_create_haggles_table.js	1	2017-07-21 10:46:11.117-07
\.


--
-- Name: knex_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vinniiotchkov
--

SELECT pg_catalog.setval('knex_migrations_id_seq', 7, true);


--
-- Data for Name: knex_migrations_lock; Type: TABLE DATA; Schema: public; Owner: vinniiotchkov
--

COPY knex_migrations_lock (is_locked) FROM stdin;
0
\.


--
-- Data for Name: locations; Type: TABLE DATA; Schema: public; Owner: vinniiotchkov
--

COPY locations (id, city, state_id) FROM stdin;
1	Phoenix	3
2	Mesa	3
3	Tempe	3
4	Glendale	3
5	Chandler	3
6	Queen Creek	3
7	Peoria	3
8	Gilbert	3
9	Ahwatukee	3
10	Laveen	3
\.


--
-- Name: locations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vinniiotchkov
--

SELECT pg_catalog.setval('locations_id_seq', 10, true);


--
-- Data for Name: states; Type: TABLE DATA; Schema: public; Owner: vinniiotchkov
--

COPY states (id, name, abreviation) FROM stdin;
1	Alabama	AL
2	Alaska	AK
3	Arizona	AZ
4	Arkansas	AR
5	California	CA
6	Colorado	CO
7	Connecticut	CT
8	Deleware	DE
9	Florida	FL
10	Georgia	GA
11	Hawaii	HI
12	Idaho	ID
13	Illinois	IL
14	Indiana	IN
15	Iowa	IA
16	Kansas	KS
17	Kentucky	KY
18	Louisiana	LA
19	Maine	ME
20	Maryland	MD
21	Massachusetts	MA
22	Michigan	MI
23	Minnesota	MN
24	Mississippi	MS
25	Missouri	MO
26	Montana	MT
27	Nebraska	NE
28	Nevada	NV
29	New Hampshire	NH
30	New Jersey	NJ
31	New Mexico	NM
32	New York	NY
33	North Carolina	NC
34	North Dakota	ND
35	Ohio	OH
36	Oklahoma	OK
37	Oregon	OR
38	Pennsylvania	PA
39	Rhode Island	RI
40	South Carolina	SC
41	South Dakota	SD
42	Tennessee	TN
43	Texas	TX
44	Utah	UT
45	Vermont	VT
46	Virginia	VA
47	Washington	WA
48	West Virginia	WV
49	Wisconsin	WI
50	Wyoming	WY
\.


--
-- Name: states_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vinniiotchkov
--

SELECT pg_catalog.setval('states_id_seq', 50, true);


--
-- Data for Name: statuses; Type: TABLE DATA; Schema: public; Owner: vinniiotchkov
--

COPY statuses (id, status) FROM stdin;
1	Pending
2	Accepted
3	Rejected
\.


--
-- Name: statuses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vinniiotchkov
--

SELECT pg_catalog.setval('statuses_id_seq', 3, true);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: vinniiotchkov
--

COPY users (id, name, email, password, location_id) FROM stdin;
1	Race Carpenter	racecarpenter@gmail.com	$2a$10$40brwUHOWWb4Hdxr1bXEjOMwxfiAYIGIVrevoXmk8jRmEOqPp8bbu	1
2	Vinnii Otchkov	vinniiotchkov@gmail.com	$2a$10$40brwUHOWWb4Hdxr1bXEjOMwxfiAYIGIVrevoXmk8jRmEOqPp8bbu	4
3	Tom Martin	tom.martinaz@gmail.com	$2a$10$40brwUHOWWb4Hdxr1bXEjOMwxfiAYIGIVrevoXmk8jRmEOqPp8bbu	6
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vinniiotchkov
--

SELECT pg_catalog.setval('users_id_seq', 3, true);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: vinniiotchkov
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: haggles haggles_pkey; Type: CONSTRAINT; Schema: public; Owner: vinniiotchkov
--

ALTER TABLE ONLY haggles
    ADD CONSTRAINT haggles_pkey PRIMARY KEY (id);


--
-- Name: items items_pkey; Type: CONSTRAINT; Schema: public; Owner: vinniiotchkov
--

ALTER TABLE ONLY items
    ADD CONSTRAINT items_pkey PRIMARY KEY (id);


--
-- Name: knex_migrations knex_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: vinniiotchkov
--

ALTER TABLE ONLY knex_migrations
    ADD CONSTRAINT knex_migrations_pkey PRIMARY KEY (id);


--
-- Name: locations locations_pkey; Type: CONSTRAINT; Schema: public; Owner: vinniiotchkov
--

ALTER TABLE ONLY locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);


--
-- Name: states states_pkey; Type: CONSTRAINT; Schema: public; Owner: vinniiotchkov
--

ALTER TABLE ONLY states
    ADD CONSTRAINT states_pkey PRIMARY KEY (id);


--
-- Name: statuses statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: vinniiotchkov
--

ALTER TABLE ONLY statuses
    ADD CONSTRAINT statuses_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: vinniiotchkov
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: haggles haggles_buyer_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: vinniiotchkov
--

ALTER TABLE ONLY haggles
    ADD CONSTRAINT haggles_buyer_id_foreign FOREIGN KEY (buyer_id) REFERENCES users(id);


--
-- Name: haggles haggles_item_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: vinniiotchkov
--

ALTER TABLE ONLY haggles
    ADD CONSTRAINT haggles_item_id_foreign FOREIGN KEY (item_id) REFERENCES items(id);


--
-- Name: haggles haggles_seller_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: vinniiotchkov
--

ALTER TABLE ONLY haggles
    ADD CONSTRAINT haggles_seller_id_foreign FOREIGN KEY (seller_id) REFERENCES users(id);


--
-- Name: haggles haggles_status_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: vinniiotchkov
--

ALTER TABLE ONLY haggles
    ADD CONSTRAINT haggles_status_id_foreign FOREIGN KEY (status_id) REFERENCES statuses(id);


--
-- Name: items items_seller_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: vinniiotchkov
--

ALTER TABLE ONLY items
    ADD CONSTRAINT items_seller_id_foreign FOREIGN KEY (seller_id) REFERENCES users(id);


--
-- Name: locations locations_state_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: vinniiotchkov
--

ALTER TABLE ONLY locations
    ADD CONSTRAINT locations_state_id_foreign FOREIGN KEY (state_id) REFERENCES states(id);


--
-- Name: users users_location_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: vinniiotchkov
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_location_id_foreign FOREIGN KEY (location_id) REFERENCES locations(id);


--
-- PostgreSQL database dump complete
--


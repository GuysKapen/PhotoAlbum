--
-- PostgreSQL database dump
--

-- Dumped from database version 14.5 (Debian 14.5-1.pgdg110+1)
-- Dumped by pg_dump version 14.5 (Debian 14.5-1.pgdg110+1)

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

--
-- Name: photobook; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA photobook;


ALTER SCHEMA photobook OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: album_photobook; Type: TABLE; Schema: photobook; Owner: postgres
--

CREATE TABLE photobook.album_photobook (
    album_id integer NOT NULL,
    photobook_id integer NOT NULL
);


ALTER TABLE photobook.album_photobook OWNER TO postgres;

--
-- Name: albums; Type: TABLE; Schema: photobook; Owner: postgres
--

CREATE TABLE photobook.albums (
    id integer NOT NULL,
    name character varying(64),
    cover text,
    owner integer,
    favorite smallint DEFAULT 0 NOT NULL
);


ALTER TABLE photobook.albums OWNER TO postgres;

--
-- Name: albums_id_seq; Type: SEQUENCE; Schema: photobook; Owner: postgres
--

CREATE SEQUENCE photobook.albums_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE photobook.albums_id_seq OWNER TO postgres;

--
-- Name: albums_id_seq; Type: SEQUENCE OWNED BY; Schema: photobook; Owner: postgres
--

ALTER SEQUENCE photobook.albums_id_seq OWNED BY photobook.albums.id;


--
-- Name: photobooks; Type: TABLE; Schema: photobook; Owner: postgres
--

CREATE TABLE photobook.photobooks (
    id integer NOT NULL,
    name character varying(64),
    cover text,
    owner integer,
    favorite smallint DEFAULT 0 NOT NULL,
    description text
);


ALTER TABLE photobook.photobooks OWNER TO postgres;

--
-- Name: photobooks_id_seq; Type: SEQUENCE; Schema: photobook; Owner: postgres
--

CREATE SEQUENCE photobook.photobooks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE photobook.photobooks_id_seq OWNER TO postgres;

--
-- Name: photobooks_id_seq; Type: SEQUENCE OWNED BY; Schema: photobook; Owner: postgres
--

ALTER SEQUENCE photobook.photobooks_id_seq OWNED BY photobook.photobooks.id;


--
-- Name: photopages; Type: TABLE; Schema: photobook; Owner: postgres
--

CREATE TABLE photobook.photopages (
    id integer NOT NULL,
    photobook_id integer,
    image text,
    content text
);


ALTER TABLE photobook.photopages OWNER TO postgres;

--
-- Name: photopages_id_seq; Type: SEQUENCE; Schema: photobook; Owner: postgres
--

CREATE SEQUENCE photobook.photopages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE photobook.photopages_id_seq OWNER TO postgres;

--
-- Name: photopages_id_seq; Type: SEQUENCE OWNED BY; Schema: photobook; Owner: postgres
--

ALTER SEQUENCE photobook.photopages_id_seq OWNED BY photobook.photopages.id;


--
-- Name: users; Type: TABLE; Schema: photobook; Owner: postgres
--

CREATE TABLE photobook.users (
    id integer NOT NULL,
    name character varying(32),
    email character varying(64),
    password character varying(128)
);


ALTER TABLE photobook.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: photobook; Owner: postgres
--

CREATE SEQUENCE photobook.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE photobook.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: photobook; Owner: postgres
--

ALTER SEQUENCE photobook.users_id_seq OWNED BY photobook.users.id;


--
-- Name: album_photobook; Type: TABLE; Schema: public; Owner: photobook
--

CREATE TABLE public.album_photobook (
    album_id integer NOT NULL,
    photobook_id integer NOT NULL
);


ALTER TABLE public.album_photobook OWNER TO photobook;

--
-- Name: albums; Type: TABLE; Schema: public; Owner: photobook
--

CREATE TABLE public.albums (
    id integer NOT NULL,
    name character varying(64),
    cover text,
    owner integer,
    favorite smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.albums OWNER TO photobook;

--
-- Name: albums_id_seq; Type: SEQUENCE; Schema: public; Owner: photobook
--

CREATE SEQUENCE public.albums_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.albums_id_seq OWNER TO photobook;

--
-- Name: albums_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: photobook
--

ALTER SEQUENCE public.albums_id_seq OWNED BY public.albums.id;


--
-- Name: photobooks; Type: TABLE; Schema: public; Owner: photobook
--

CREATE TABLE public.photobooks (
    id integer NOT NULL,
    name character varying(64),
    cover text,
    owner integer,
    favorite smallint DEFAULT 0 NOT NULL,
    description text
);


ALTER TABLE public.photobooks OWNER TO photobook;

--
-- Name: photobooks_id_seq; Type: SEQUENCE; Schema: public; Owner: photobook
--

CREATE SEQUENCE public.photobooks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.photobooks_id_seq OWNER TO photobook;

--
-- Name: photobooks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: photobook
--

ALTER SEQUENCE public.photobooks_id_seq OWNED BY public.photobooks.id;


--
-- Name: photopages; Type: TABLE; Schema: public; Owner: photobook
--

CREATE TABLE public.photopages (
    id integer NOT NULL,
    photobook_id integer,
    image text,
    content text
);


ALTER TABLE public.photopages OWNER TO photobook;

--
-- Name: photopages_id_seq; Type: SEQUENCE; Schema: public; Owner: photobook
--

CREATE SEQUENCE public.photopages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.photopages_id_seq OWNER TO photobook;

--
-- Name: photopages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: photobook
--

ALTER SEQUENCE public.photopages_id_seq OWNED BY public.photopages.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: photobook
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying(32),
    email character varying(64),
    password character varying(128)
);


ALTER TABLE public.users OWNER TO photobook;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: photobook
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO photobook;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: photobook
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: albums id; Type: DEFAULT; Schema: photobook; Owner: postgres
--

ALTER TABLE ONLY photobook.albums ALTER COLUMN id SET DEFAULT nextval('photobook.albums_id_seq'::regclass);


--
-- Name: photobooks id; Type: DEFAULT; Schema: photobook; Owner: postgres
--

ALTER TABLE ONLY photobook.photobooks ALTER COLUMN id SET DEFAULT nextval('photobook.photobooks_id_seq'::regclass);


--
-- Name: photopages id; Type: DEFAULT; Schema: photobook; Owner: postgres
--

ALTER TABLE ONLY photobook.photopages ALTER COLUMN id SET DEFAULT nextval('photobook.photopages_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: photobook; Owner: postgres
--

ALTER TABLE ONLY photobook.users ALTER COLUMN id SET DEFAULT nextval('photobook.users_id_seq'::regclass);


--
-- Name: albums id; Type: DEFAULT; Schema: public; Owner: photobook
--

ALTER TABLE ONLY public.albums ALTER COLUMN id SET DEFAULT nextval('public.albums_id_seq'::regclass);


--
-- Name: photobooks id; Type: DEFAULT; Schema: public; Owner: photobook
--

ALTER TABLE ONLY public.photobooks ALTER COLUMN id SET DEFAULT nextval('public.photobooks_id_seq'::regclass);


--
-- Name: photopages id; Type: DEFAULT; Schema: public; Owner: photobook
--

ALTER TABLE ONLY public.photopages ALTER COLUMN id SET DEFAULT nextval('public.photopages_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: photobook
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: album_photobook; Type: TABLE DATA; Schema: photobook; Owner: postgres
--

COPY photobook.album_photobook (album_id, photobook_id) FROM stdin;
8	2
8	3
8	6
8	8
8	9
\.


--
-- Data for Name: albums; Type: TABLE DATA; Schema: photobook; Owner: postgres
--

COPY photobook.albums (id, name, cover, owner, favorite) FROM stdin;
8	Favorite album	./uploads/media/2/images/309cdf11-451c-46af-bbf1-8b940201413f.jpg	2	0
16	Old fashion	./uploads/media/2/images/b5630f2f-c594-4292-a35c-8934f78ffd8b.jpg	2	0
17	Journey	./uploads/media/2/images/d20bd67d-35e8-4a0e-bd8e-b62159394bc2.jpg	2	0
18	Memory	./uploads/media/4/images/af534523-6870-4830-a919-fea2c6958336.jpg	4	0
22	Test	\N	9	0
\.


--
-- Data for Name: photobooks; Type: TABLE DATA; Schema: photobook; Owner: postgres
--

COPY photobook.photobooks (id, name, cover, owner, favorite, description) FROM stdin;
1	My book	./uploads/media/2/images/27ff93fb-890d-4bc1-8f3c-605de4453621.jpg	2	1	Risus diam quidem platea tempus cupiditate, blandit impedit culpa cupiditate per natoque, unde accusantium fugiat, quisquam, erat hac, quisquam porta maiores varius accusamus? Felis. Sed minus aliquam! Dictumst blandit assumenda, pharetra ultrices, incididunt varius. Lacus, alias, varius tortor magnam laoreet, sodales nullam, dolor ex tincidunt natoque delectus voluptatibus.
2	Peace	./uploads/media/2/images/2b3d68af-dd72-4da9-9feb-fb06274d33be.jpg	2	1	Eum varius, eaque tempore suscipit odit tristique mollis molestias veritatis, in dolores, nisi dui corporis. Turpis? Cum quae et numquam eiusmod, laoreet inventore sodales aenean animi proident et wisi. Volutpat cupiditate hendrerit, dis, accusamus. Scelerisque facere! Primis corrupti magnam! Bibendum nam inventore eget illum nibh? Dictumst beatae, magnam.
3	Love	./uploads/media/2/images/32e12a21-ef24-4b30-93c1-1b956bb189bd.jpg	2	1	Sapiente scelerisque libero earum fames elit occaecat nostrud lacus officiis risus nulla? Odit mi, excepteur mattis voluptatum harum? Sequi, animi sociis taciti cumque aptent suscipit sagittis? Cumque fames, hymenaeos orci? Quaerat aute adipisci exercitationem aliquip montes, repellat earum placeat diamlorem! Unde quia tellus minim, nesciunt, officia consequatur quam.
4	Happy	./uploads/media/2/images/fc1a359e-7e22-4e20-bac1-dd9fe09c58ea.jpg	2	0	Tellus voluptas convallis eos malesuada excepteur. Nunc sint neque natus illum hendrerit quaerat facilis feugiat lacus, potenti aliquid, fuga platea, illo, tempor accusamus felis, repellendus do eligendi ex fames netus quibusdam, excepturi nibh lacinia tempora dictum lectus occaecat doloribus illum, malesuada odit perspiciatis quo, praesentium, felis, dui consequuntur.
6	Falling	./uploads/media/2/images/1ad84df8-8cc6-43db-8356-eeab585c77f4.jpg	2	0	Ullamcorper ullamco, ornare luctus consectetur cupiditate, tristique earum dolore diamlorem, elit quos, voluptate? Malesuada? Doloremque fugit, dolores sit, cumque fugit hic, felis, hac laboris veritatis laoreet, turpis iaculis! Gravida laboriosam voluptatum exercitationem? Nibh tenetur optio, vero! Gravida nemo, tristique hic, inceptos necessitatibus id inventore deleniti ea etiam recusandae.
7	On Ice	./uploads/media/2/images/c019b9c3-fa46-4b66-ba8a-5c9eb4fef501.jpg	2	0	\N
8	My first photobook	./uploads/media/3/images/556d6493-bfce-46c7-bd0f-25c2ddd16ebd.png	3	0	\N
9	Snow wolf	./uploads/media/4/images/0929bd0a-8280-45d2-b0b4-0a8995d67a85.jpg	4	0	\N
10	Wonderland	./uploads/media/4/images/4e5b504f-f69f-4da1-8ec8-e5c48cba4a94.jpg	4	0	\N
11	A little star	./uploads/media/4/images/0faab02f-664e-4af9-847a-6bd711f80060.jpg	4	0	\N
30	Love book	./uploads/media/2/images/4ea42d9e-c8ac-4e32-a3ea-362068074f19.jpg	2	0	"But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, but because those who do not know how to pursue pleasure rationally encounter consequences that are extremely painful. Nor again is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain, but because occasionally circumstances occur in which toil and pain can procure him some great pleasure. To take a trivial example, which of us ever undertakes laborious physical exercise, except to obtain some advantage from it? But who has any right to find fault with a man who chooses to enjoy a pleasure that has no annoying consequences, or one who avoids a pain that produces no resultant pleasure?"
39	Hic consectetuer	./uploads/media/2/images/b493c4ae-547c-45d4-a4ec-6dba359fa41c.jpg	2	0	Nesciunt dicta suscipit culpa, illo, earum lacinia nunc omnis habitant gravida, impedit viverra a suscipit magnam cursus ut luctus! Vitae ipsa, porttitor molestie debitis occaecat tortor occaecati excepturi illum donec, porta, cras, eros et ut elit? Parturient lacus feugiat dicta maecenas faucibus, quod, semper temporibus, aliquip quod class.
40	Nostrud id cras dolores.	./uploads/media/4/images/655dc38b-5b4d-4e9e-b2ca-a7445eb51b9d.jpg	4	0	Tortor quibusdam arcu cras lacus. Est proident, nobis adipisci semper quia fusce, magni turpis iste cillum, itaque voluptas? Maiores dicta amet maecenas facere? Dignissim potenti eleifend. Proin minus primis hendrerit placeat at. Integer, porta netus, congue cursus ut, dignissim, tortor, tristique volutpat! Egestas elementum ab, hic. Sociosqu augue.
\.


--
-- Data for Name: photopages; Type: TABLE DATA; Schema: photobook; Owner: postgres
--

COPY photobook.photopages (id, photobook_id, image, content) FROM stdin;
1	6	./uploads/media/2/images/ff17195b-97d5-47c6-ada5-ac30cdc477d6.png	First page
2	7	./uploads/media/2/images/5090b65a-8982-4dcc-b74e-14c47fa99e3a.png	A New Way of Life
3	7	./uploads/media/2/images/455bee34-23d1-4bf8-8c66-8d5774ae954a.jpg	Becoming a Creative Channel
4	8	./uploads/media/3/images/40c2900e-b225-4373-867d-5567417db096.png	Blind Forest
5	10	./uploads/media/4/images/db116838-599d-4d20-9e0e-8d352a98b89e.png	Land of giant
6	11	./uploads/media/4/images/c56bb4e7-0463-4508-b3fa-d66a11a01a91.jpg	First star
7	11	./uploads/media/4/images/c3bf62fd-5adf-48c7-b54f-5661e3f3e823.png	Falling stars
8	11	./uploads/media/4/images/905f1611-93f8-4680-8644-28217a793344.jpg	Wander stars
9	11	./uploads/media/4/images/95a358c6-ed96-4cc0-8666-35f14fac1d44.jpg	Nebula
16	30	./uploads/media/2/images/7c806a3a-cff6-4c9f-befb-d435b222e6ec.jpg	Self love
17	2	./uploads/media/2/images/6dbc0d35-2d3f-4706-9864-8d0ec8030418.jpg	Tellus esse tempora, proin.
18	2	./uploads/media/2/images/16be4303-5125-4909-9cc6-3051f9b925bd.jpg	Labore odit! Iaculis pulvinar.
19	2	\N	\N
20	2	\N	\N
21	2	./uploads/media/2/images/8bd98fcf-6128-4e31-85a0-9a3afe6c1646.jpg	Mollis reiciendis eveniet quas.
22	4	./uploads/media/2/images/839cbccb-38e1-4c96-b225-ac7da72d157a.jpg	Suscipit ullam proident quisque.
23	4	./uploads/media/2/images/c6819f84-66aa-4a2a-95e9-c6e2bca92656.png	Quis conubia exercitationem eleifend.
24	4	./uploads/media/2/images/353b8c5a-c2de-451e-b06a-d532deaef02b.jpg	Deleniti nostrud proident autem.
25	4	./uploads/media/2/images/839cbccb-38e1-4c96-b225-ac7da72d157a.jpg	Suscipit ullam proident quisque.
26	4	./uploads/media/2/images/c6819f84-66aa-4a2a-95e9-c6e2bca92656.png	Quis conubia exercitationem eleifend.
27	4	./uploads/media/2/images/4a93b46b-73ee-4302-9cd7-572c5bc89995.jpg	Deleniti nostrud proident autem.
28	4	./uploads/media/2/images/839cbccb-38e1-4c96-b225-ac7da72d157a.jpg	Suscipit ullam proident quisque.
29	4	./uploads/media/2/images/c6819f84-66aa-4a2a-95e9-c6e2bca92656.png	Quis conubia exercitationem eleifend.
30	4	./uploads/media/2/images/4a93b46b-73ee-4302-9cd7-572c5bc89995.jpg	Deleniti nostrud proident autem.
31	4	./uploads/media/2/images/839cbccb-38e1-4c96-b225-ac7da72d157a.jpg	Suscipit ullam proident quisque.
32	4	./uploads/media/2/images/c6819f84-66aa-4a2a-95e9-c6e2bca92656.png	Quis conubia exercitationem eleifend.
33	4	./uploads/media/2/images/4a93b46b-73ee-4302-9cd7-572c5bc89995.jpg	Deleniti nostrud proident autem.
34	1	./uploads/media/2/images/02d08555-fa5f-46da-a068-ba35fdd39e87.jpg	Nesciunt vero, inceptos enim.
35	1	./uploads/media/2/images/0fda7fdf-5bba-4147-a7b2-ec6e46ec4ac5.jpg	Praesent perferendis etiam vulputate.
36	1	./uploads/media/2/images/1d5db5ea-c68b-4216-8d81-6897e96f3d9a.jpg	Perferendis phasellus ipsam animi.
37	1	./uploads/media/2/images/02d08555-fa5f-46da-a068-ba35fdd39e87.jpg	Nesciunt vero, inceptos enim.
38	1	./uploads/media/2/images/0fda7fdf-5bba-4147-a7b2-ec6e46ec4ac5.jpg	Praesent perferendis etiam vulputate.
39	1	./uploads/media/2/images/587d6870-544f-4898-af20-8abdaba47455.jpg	Perferendis phasellus ipsam animi.
40	3	./uploads/media/2/images/2dd6cd60-be99-44db-a7d2-b554cd9f1159.jpg	Deserunt etiam donec. Sagittis.
41	3	./uploads/media/2/images/9c0bbbfd-eb3f-4973-ac5f-4bd5c2bdeb10.jpg	Ea curabitur, ridiculus neque.
42	3	./uploads/media/2/images/20c9070a-7ca1-4a6d-b953-cf167860bd4c.jpg	Exercitationem, magna tristique. Augue.
43	39	./uploads/media/2/images/94abb7aa-ec07-4ed4-bb04-612387bd9150.jpg	Nostrum enim, rhoncus nihil.
44	39	./uploads/media/2/images/b465e860-9e13-4ebe-86e8-189dbb8f6fa9.jpg	Cillum conubia quas? Aptent.
45	40	./uploads/media/4/images/303f94af-5e08-4109-b2e6-9a3932c99fc4.jpg	Dui! Felis tellus nesciunt.
46	40	./uploads/media/4/images/4823a6a4-5cf7-4dde-9fc0-ca0484999ee3.jpg	Parturient. Id sunt facilisis.
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: photobook; Owner: postgres
--

COPY photobook.users (id, name, email, password) FROM stdin;
2	Student	student@gmail.com	$2a$10$8mIe7T4/YhXg/BJ983cI1OCNcfvZMjBPGX2cuqXNJr6vKU.7ugb8u
3	User	user@gmail.com	$2a$10$8mIe7T4/YhXg/BJ983cI1OCNcfvZMjBPGX2cuqXNJr6vKU.7ugb8u
4	Guys	guys@gmail.com	$2a$10$8mIe7T4/YhXg/BJ983cI1OCNcfvZMjBPGX2cuqXNJr6vKU.7ugb8u
5	Nghia	nghia@gmail.com	$2a$10$8mIe7T4/YhXg/BJ983cI1OCNcfvZMjBPGX2cuqXNJr6vKU.7ugb8u
8	Rose	rose@gmail.com	$2b$10$kbBJbPwFWlMNy5QsmLkdnePGbiPCNV0InnPEosQ6R7QXe8H0EwpZ6
9	XXX	xxx@gmail.com	$2b$10$aSzCe50.TzTeo7i4wuqVhub0tUDBzEtkGdDjvPsN20ee0cRvGUbXC
10	Abc	abc@gmail.com	$2b$10$AusE7f.u3NKoeSHnLn.oouS/jDgl5T3ZcPb4aJ1dmZkzm6VfhYC0m
\.


--
-- Data for Name: album_photobook; Type: TABLE DATA; Schema: public; Owner: photobook
--

COPY public.album_photobook (album_id, photobook_id) FROM stdin;
8	2
8	3
8	6
8	8
8	9
\.


--
-- Data for Name: albums; Type: TABLE DATA; Schema: public; Owner: photobook
--

COPY public.albums (id, name, cover, owner, favorite) FROM stdin;
8	Favorite album	./uploads/media/2/images/309cdf11-451c-46af-bbf1-8b940201413f.jpg	2	0
16	Old fashion	./uploads/media/2/images/b5630f2f-c594-4292-a35c-8934f78ffd8b.jpg	2	0
17	Journey	./uploads/media/2/images/d20bd67d-35e8-4a0e-bd8e-b62159394bc2.jpg	2	0
18	Memory	./uploads/media/4/images/af534523-6870-4830-a919-fea2c6958336.jpg	4	0
22	Test	\N	9	0
\.


--
-- Data for Name: photobooks; Type: TABLE DATA; Schema: public; Owner: photobook
--

COPY public.photobooks (id, name, cover, owner, favorite, description) FROM stdin;
1	My book	./uploads/media/2/images/27ff93fb-890d-4bc1-8f3c-605de4453621.jpg	2	1	Risus diam quidem platea tempus cupiditate, blandit impedit culpa cupiditate per natoque, unde accusantium fugiat, quisquam, erat hac, quisquam porta maiores varius accusamus? Felis. Sed minus aliquam! Dictumst blandit assumenda, pharetra ultrices, incididunt varius. Lacus, alias, varius tortor magnam laoreet, sodales nullam, dolor ex tincidunt natoque delectus voluptatibus.
2	Peace	./uploads/media/2/images/2b3d68af-dd72-4da9-9feb-fb06274d33be.jpg	2	1	Eum varius, eaque tempore suscipit odit tristique mollis molestias veritatis, in dolores, nisi dui corporis. Turpis? Cum quae et numquam eiusmod, laoreet inventore sodales aenean animi proident et wisi. Volutpat cupiditate hendrerit, dis, accusamus. Scelerisque facere! Primis corrupti magnam! Bibendum nam inventore eget illum nibh? Dictumst beatae, magnam.
3	Love	./uploads/media/2/images/32e12a21-ef24-4b30-93c1-1b956bb189bd.jpg	2	1	Sapiente scelerisque libero earum fames elit occaecat nostrud lacus officiis risus nulla? Odit mi, excepteur mattis voluptatum harum? Sequi, animi sociis taciti cumque aptent suscipit sagittis? Cumque fames, hymenaeos orci? Quaerat aute adipisci exercitationem aliquip montes, repellat earum placeat diamlorem! Unde quia tellus minim, nesciunt, officia consequatur quam.
4	Happy	./uploads/media/2/images/fc1a359e-7e22-4e20-bac1-dd9fe09c58ea.jpg	2	0	Tellus voluptas convallis eos malesuada excepteur. Nunc sint neque natus illum hendrerit quaerat facilis feugiat lacus, potenti aliquid, fuga platea, illo, tempor accusamus felis, repellendus do eligendi ex fames netus quibusdam, excepturi nibh lacinia tempora dictum lectus occaecat doloribus illum, malesuada odit perspiciatis quo, praesentium, felis, dui consequuntur.
6	Falling	./uploads/media/2/images/1ad84df8-8cc6-43db-8356-eeab585c77f4.jpg	2	0	Ullamcorper ullamco, ornare luctus consectetur cupiditate, tristique earum dolore diamlorem, elit quos, voluptate? Malesuada? Doloremque fugit, dolores sit, cumque fugit hic, felis, hac laboris veritatis laoreet, turpis iaculis! Gravida laboriosam voluptatum exercitationem? Nibh tenetur optio, vero! Gravida nemo, tristique hic, inceptos necessitatibus id inventore deleniti ea etiam recusandae.
7	On Ice	./uploads/media/2/images/c019b9c3-fa46-4b66-ba8a-5c9eb4fef501.jpg	2	0	\N
8	My first photobook	./uploads/media/3/images/556d6493-bfce-46c7-bd0f-25c2ddd16ebd.png	3	0	\N
9	Snow wolf	./uploads/media/4/images/0929bd0a-8280-45d2-b0b4-0a8995d67a85.jpg	4	0	\N
10	Wonderland	./uploads/media/4/images/4e5b504f-f69f-4da1-8ec8-e5c48cba4a94.jpg	4	0	\N
11	A little star	./uploads/media/4/images/0faab02f-664e-4af9-847a-6bd711f80060.jpg	4	0	\N
30	Love book	./uploads/media/2/images/4ea42d9e-c8ac-4e32-a3ea-362068074f19.jpg	2	0	"But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, but because those who do not know how to pursue pleasure rationally encounter consequences that are extremely painful. Nor again is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain, but because occasionally circumstances occur in which toil and pain can procure him some great pleasure. To take a trivial example, which of us ever undertakes laborious physical exercise, except to obtain some advantage from it? But who has any right to find fault with a man who chooses to enjoy a pleasure that has no annoying consequences, or one who avoids a pain that produces no resultant pleasure?"
39	Hic consectetuer	./uploads/media/2/images/b493c4ae-547c-45d4-a4ec-6dba359fa41c.jpg	2	0	Nesciunt dicta suscipit culpa, illo, earum lacinia nunc omnis habitant gravida, impedit viverra a suscipit magnam cursus ut luctus! Vitae ipsa, porttitor molestie debitis occaecat tortor occaecati excepturi illum donec, porta, cras, eros et ut elit? Parturient lacus feugiat dicta maecenas faucibus, quod, semper temporibus, aliquip quod class.
40	Nostrud id cras dolores.	./uploads/media/4/images/655dc38b-5b4d-4e9e-b2ca-a7445eb51b9d.jpg	4	0	Tortor quibusdam arcu cras lacus. Est proident, nobis adipisci semper quia fusce, magni turpis iste cillum, itaque voluptas? Maiores dicta amet maecenas facere? Dignissim potenti eleifend. Proin minus primis hendrerit placeat at. Integer, porta netus, congue cursus ut, dignissim, tortor, tristique volutpat! Egestas elementum ab, hic. Sociosqu augue.
\.


--
-- Data for Name: photopages; Type: TABLE DATA; Schema: public; Owner: photobook
--

COPY public.photopages (id, photobook_id, image, content) FROM stdin;
1	6	./uploads/media/2/images/ff17195b-97d5-47c6-ada5-ac30cdc477d6.png	First page
2	7	./uploads/media/2/images/5090b65a-8982-4dcc-b74e-14c47fa99e3a.png	A New Way of Life
3	7	./uploads/media/2/images/455bee34-23d1-4bf8-8c66-8d5774ae954a.jpg	Becoming a Creative Channel
4	8	./uploads/media/3/images/40c2900e-b225-4373-867d-5567417db096.png	Blind Forest
5	10	./uploads/media/4/images/db116838-599d-4d20-9e0e-8d352a98b89e.png	Land of giant
6	11	./uploads/media/4/images/c56bb4e7-0463-4508-b3fa-d66a11a01a91.jpg	First star
7	11	./uploads/media/4/images/c3bf62fd-5adf-48c7-b54f-5661e3f3e823.png	Falling stars
8	11	./uploads/media/4/images/905f1611-93f8-4680-8644-28217a793344.jpg	Wander stars
9	11	./uploads/media/4/images/95a358c6-ed96-4cc0-8666-35f14fac1d44.jpg	Nebula
16	30	./uploads/media/2/images/7c806a3a-cff6-4c9f-befb-d435b222e6ec.jpg	Self love
17	2	./uploads/media/2/images/6dbc0d35-2d3f-4706-9864-8d0ec8030418.jpg	Tellus esse tempora, proin.
18	2	./uploads/media/2/images/16be4303-5125-4909-9cc6-3051f9b925bd.jpg	Labore odit! Iaculis pulvinar.
19	2	\N	\N
20	2	\N	\N
21	2	./uploads/media/2/images/8bd98fcf-6128-4e31-85a0-9a3afe6c1646.jpg	Mollis reiciendis eveniet quas.
22	4	./uploads/media/2/images/839cbccb-38e1-4c96-b225-ac7da72d157a.jpg	Suscipit ullam proident quisque.
23	4	./uploads/media/2/images/c6819f84-66aa-4a2a-95e9-c6e2bca92656.png	Quis conubia exercitationem eleifend.
24	4	./uploads/media/2/images/353b8c5a-c2de-451e-b06a-d532deaef02b.jpg	Deleniti nostrud proident autem.
25	4	./uploads/media/2/images/839cbccb-38e1-4c96-b225-ac7da72d157a.jpg	Suscipit ullam proident quisque.
26	4	./uploads/media/2/images/c6819f84-66aa-4a2a-95e9-c6e2bca92656.png	Quis conubia exercitationem eleifend.
27	4	./uploads/media/2/images/4a93b46b-73ee-4302-9cd7-572c5bc89995.jpg	Deleniti nostrud proident autem.
28	4	./uploads/media/2/images/839cbccb-38e1-4c96-b225-ac7da72d157a.jpg	Suscipit ullam proident quisque.
29	4	./uploads/media/2/images/c6819f84-66aa-4a2a-95e9-c6e2bca92656.png	Quis conubia exercitationem eleifend.
30	4	./uploads/media/2/images/4a93b46b-73ee-4302-9cd7-572c5bc89995.jpg	Deleniti nostrud proident autem.
31	4	./uploads/media/2/images/839cbccb-38e1-4c96-b225-ac7da72d157a.jpg	Suscipit ullam proident quisque.
32	4	./uploads/media/2/images/c6819f84-66aa-4a2a-95e9-c6e2bca92656.png	Quis conubia exercitationem eleifend.
33	4	./uploads/media/2/images/4a93b46b-73ee-4302-9cd7-572c5bc89995.jpg	Deleniti nostrud proident autem.
34	1	./uploads/media/2/images/02d08555-fa5f-46da-a068-ba35fdd39e87.jpg	Nesciunt vero, inceptos enim.
35	1	./uploads/media/2/images/0fda7fdf-5bba-4147-a7b2-ec6e46ec4ac5.jpg	Praesent perferendis etiam vulputate.
36	1	./uploads/media/2/images/1d5db5ea-c68b-4216-8d81-6897e96f3d9a.jpg	Perferendis phasellus ipsam animi.
37	1	./uploads/media/2/images/02d08555-fa5f-46da-a068-ba35fdd39e87.jpg	Nesciunt vero, inceptos enim.
38	1	./uploads/media/2/images/0fda7fdf-5bba-4147-a7b2-ec6e46ec4ac5.jpg	Praesent perferendis etiam vulputate.
39	1	./uploads/media/2/images/587d6870-544f-4898-af20-8abdaba47455.jpg	Perferendis phasellus ipsam animi.
40	3	./uploads/media/2/images/2dd6cd60-be99-44db-a7d2-b554cd9f1159.jpg	Deserunt etiam donec. Sagittis.
41	3	./uploads/media/2/images/9c0bbbfd-eb3f-4973-ac5f-4bd5c2bdeb10.jpg	Ea curabitur, ridiculus neque.
42	3	./uploads/media/2/images/20c9070a-7ca1-4a6d-b953-cf167860bd4c.jpg	Exercitationem, magna tristique. Augue.
43	39	./uploads/media/2/images/94abb7aa-ec07-4ed4-bb04-612387bd9150.jpg	Nostrum enim, rhoncus nihil.
44	39	./uploads/media/2/images/b465e860-9e13-4ebe-86e8-189dbb8f6fa9.jpg	Cillum conubia quas? Aptent.
45	40	./uploads/media/4/images/303f94af-5e08-4109-b2e6-9a3932c99fc4.jpg	Dui! Felis tellus nesciunt.
46	40	./uploads/media/4/images/4823a6a4-5cf7-4dde-9fc0-ca0484999ee3.jpg	Parturient. Id sunt facilisis.
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: photobook
--

COPY public.users (id, name, email, password) FROM stdin;
2	Student	student@gmail.com	$2a$10$8mIe7T4/YhXg/BJ983cI1OCNcfvZMjBPGX2cuqXNJr6vKU.7ugb8u
3	User	user@gmail.com	$2a$10$8mIe7T4/YhXg/BJ983cI1OCNcfvZMjBPGX2cuqXNJr6vKU.7ugb8u
4	Guys	guys@gmail.com	$2a$10$8mIe7T4/YhXg/BJ983cI1OCNcfvZMjBPGX2cuqXNJr6vKU.7ugb8u
5	Nghia	nghia@gmail.com	$2a$10$8mIe7T4/YhXg/BJ983cI1OCNcfvZMjBPGX2cuqXNJr6vKU.7ugb8u
8	Rose	rose@gmail.com	$2b$10$kbBJbPwFWlMNy5QsmLkdnePGbiPCNV0InnPEosQ6R7QXe8H0EwpZ6
9	XXX	xxx@gmail.com	$2b$10$aSzCe50.TzTeo7i4wuqVhub0tUDBzEtkGdDjvPsN20ee0cRvGUbXC
10	Abc	abc@gmail.com	$2b$10$AusE7f.u3NKoeSHnLn.oouS/jDgl5T3ZcPb4aJ1dmZkzm6VfhYC0m
\.


--
-- Name: albums_id_seq; Type: SEQUENCE SET; Schema: photobook; Owner: postgres
--

SELECT pg_catalog.setval('photobook.albums_id_seq', 23, true);


--
-- Name: photobooks_id_seq; Type: SEQUENCE SET; Schema: photobook; Owner: postgres
--

SELECT pg_catalog.setval('photobook.photobooks_id_seq', 41, true);


--
-- Name: photopages_id_seq; Type: SEQUENCE SET; Schema: photobook; Owner: postgres
--

SELECT pg_catalog.setval('photobook.photopages_id_seq', 47, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: photobook; Owner: postgres
--

SELECT pg_catalog.setval('photobook.users_id_seq', 11, true);


--
-- Name: albums_id_seq; Type: SEQUENCE SET; Schema: public; Owner: photobook
--

SELECT pg_catalog.setval('public.albums_id_seq', 23, true);


--
-- Name: photobooks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: photobook
--

SELECT pg_catalog.setval('public.photobooks_id_seq', 41, true);


--
-- Name: photopages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: photobook
--

SELECT pg_catalog.setval('public.photopages_id_seq', 47, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: photobook
--

SELECT pg_catalog.setval('public.users_id_seq', 11, true);


--
-- Name: album_photobook PRIMARY; Type: CONSTRAINT; Schema: photobook; Owner: postgres
--

ALTER TABLE ONLY photobook.album_photobook
    ADD CONSTRAINT "PRIMARY" PRIMARY KEY (album_id, photobook_id);


--
-- Name: albums PRIMARY00000; Type: CONSTRAINT; Schema: photobook; Owner: postgres
--

ALTER TABLE ONLY photobook.albums
    ADD CONSTRAINT "PRIMARY00000" PRIMARY KEY (id);


--
-- Name: photobooks PRIMARY00001; Type: CONSTRAINT; Schema: photobook; Owner: postgres
--

ALTER TABLE ONLY photobook.photobooks
    ADD CONSTRAINT "PRIMARY00001" PRIMARY KEY (id);


--
-- Name: photopages PRIMARY00002; Type: CONSTRAINT; Schema: photobook; Owner: postgres
--

ALTER TABLE ONLY photobook.photopages
    ADD CONSTRAINT "PRIMARY00002" PRIMARY KEY (id);


--
-- Name: users PRIMARY00003; Type: CONSTRAINT; Schema: photobook; Owner: postgres
--

ALTER TABLE ONLY photobook.users
    ADD CONSTRAINT "PRIMARY00003" PRIMARY KEY (id);


--
-- Name: album_photobook PRIMARY; Type: CONSTRAINT; Schema: public; Owner: photobook
--

ALTER TABLE ONLY public.album_photobook
    ADD CONSTRAINT "PRIMARY" PRIMARY KEY (album_id, photobook_id);


--
-- Name: albums PRIMARY00000; Type: CONSTRAINT; Schema: public; Owner: photobook
--

ALTER TABLE ONLY public.albums
    ADD CONSTRAINT "PRIMARY00000" PRIMARY KEY (id);


--
-- Name: photobooks PRIMARY00001; Type: CONSTRAINT; Schema: public; Owner: photobook
--

ALTER TABLE ONLY public.photobooks
    ADD CONSTRAINT "PRIMARY00001" PRIMARY KEY (id);


--
-- Name: photopages PRIMARY00002; Type: CONSTRAINT; Schema: public; Owner: photobook
--

ALTER TABLE ONLY public.photopages
    ADD CONSTRAINT "PRIMARY00002" PRIMARY KEY (id);


--
-- Name: users PRIMARY00003; Type: CONSTRAINT; Schema: public; Owner: photobook
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT "PRIMARY00003" PRIMARY KEY (id);


--
-- Name: owner; Type: INDEX; Schema: photobook; Owner: postgres
--

CREATE INDEX owner ON photobook.albums USING btree (owner);


--
-- Name: owner00000; Type: INDEX; Schema: photobook; Owner: postgres
--

CREATE INDEX owner00000 ON photobook.photobooks USING btree (owner);


--
-- Name: photobook_id; Type: INDEX; Schema: photobook; Owner: postgres
--

CREATE INDEX photobook_id ON photobook.album_photobook USING btree (photobook_id);


--
-- Name: photobook_id00000; Type: INDEX; Schema: photobook; Owner: postgres
--

CREATE INDEX photobook_id00000 ON photobook.photopages USING btree (photobook_id);


--
-- Name: owner; Type: INDEX; Schema: public; Owner: photobook
--

CREATE INDEX owner ON public.albums USING btree (owner);


--
-- Name: owner00000; Type: INDEX; Schema: public; Owner: photobook
--

CREATE INDEX owner00000 ON public.photobooks USING btree (owner);


--
-- Name: photobook_id; Type: INDEX; Schema: public; Owner: photobook
--

CREATE INDEX photobook_id ON public.album_photobook USING btree (photobook_id);


--
-- Name: photobook_id00000; Type: INDEX; Schema: public; Owner: photobook
--

CREATE INDEX photobook_id00000 ON public.photopages USING btree (photobook_id);


--
-- PostgreSQL database dump complete
--


--
-- PostgreSQL database dump
--

-- Dumped from database version 12.0
-- Dumped by pg_dump version 12.12 (Ubuntu 12.12-0ubuntu0.20.04.1)

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
-- Name: auth_group; Type: TABLE; Schema: public; Owner: app_dev
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO app_dev;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: app_dev
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO app_dev;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: app_dev
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: app_dev
--

CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO app_dev;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: app_dev
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO app_dev;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: app_dev
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: app_dev
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO app_dev;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: app_dev
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO app_dev;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: app_dev
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: app_dev
--

CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO app_dev;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: app_dev
--

CREATE TABLE public.auth_user_groups (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO app_dev;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: app_dev
--

CREATE SEQUENCE public.auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_groups_id_seq OWNER TO app_dev;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: app_dev
--

ALTER SEQUENCE public.auth_user_groups_id_seq OWNED BY public.auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: app_dev
--

CREATE SEQUENCE public.auth_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_id_seq OWNER TO app_dev;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: app_dev
--

ALTER SEQUENCE public.auth_user_id_seq OWNED BY public.auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: app_dev
--

CREATE TABLE public.auth_user_user_permissions (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO app_dev;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: app_dev
--

CREATE SEQUENCE public.auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_user_permissions_id_seq OWNER TO app_dev;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: app_dev
--

ALTER SEQUENCE public.auth_user_user_permissions_id_seq OWNED BY public.auth_user_user_permissions.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: app_dev
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO app_dev;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: app_dev
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO app_dev;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: app_dev
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: app_dev
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO app_dev;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: app_dev
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO app_dev;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: app_dev
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: app_dev
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO app_dev;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: app_dev
--

CREATE SEQUENCE public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO app_dev;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: app_dev
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: app_dev
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO app_dev;

--
-- Name: foodcartapp_restaurant; Type: TABLE; Schema: public; Owner: app_dev
--

CREATE TABLE public.foodcartapp_restaurant (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    address character varying(100) NOT NULL,
    contact_phone character varying(50) NOT NULL
);


ALTER TABLE public.foodcartapp_restaurant OWNER TO app_dev;

--
-- Name: foodcartapp_hotel_id_seq; Type: SEQUENCE; Schema: public; Owner: app_dev
--

CREATE SEQUENCE public.foodcartapp_hotel_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.foodcartapp_hotel_id_seq OWNER TO app_dev;

--
-- Name: foodcartapp_hotel_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: app_dev
--

ALTER SEQUENCE public.foodcartapp_hotel_id_seq OWNED BY public.foodcartapp_restaurant.id;


--
-- Name: foodcartapp_order; Type: TABLE; Schema: public; Owner: app_dev
--

CREATE TABLE public.foodcartapp_order (
    id integer NOT NULL,
    firstname character varying(20) NOT NULL,
    lastname character varying(20) NOT NULL,
    phonenumber character varying(15) NOT NULL,
    address character varying(200) NOT NULL,
    status character varying(11) NOT NULL,
    comment text NOT NULL,
    called_at timestamp with time zone,
    delivered_at timestamp with time zone,
    registrated_at timestamp with time zone NOT NULL,
    payment_method character varying(15) NOT NULL,
    restaurant_id integer
);


ALTER TABLE public.foodcartapp_order OWNER TO app_dev;

--
-- Name: foodcartapp_order_id_seq; Type: SEQUENCE; Schema: public; Owner: app_dev
--

CREATE SEQUENCE public.foodcartapp_order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.foodcartapp_order_id_seq OWNER TO app_dev;

--
-- Name: foodcartapp_order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: app_dev
--

ALTER SEQUENCE public.foodcartapp_order_id_seq OWNED BY public.foodcartapp_order.id;


--
-- Name: foodcartapp_orderproduct; Type: TABLE; Schema: public; Owner: app_dev
--

CREATE TABLE public.foodcartapp_orderproduct (
    id integer NOT NULL,
    quantity integer NOT NULL,
    order_id integer NOT NULL,
    product_id integer NOT NULL,
    cost numeric(8,2) NOT NULL,
    CONSTRAINT foodcartapp_orderproduct_quantity_check CHECK ((quantity >= 0))
);


ALTER TABLE public.foodcartapp_orderproduct OWNER TO app_dev;

--
-- Name: foodcartapp_orderproduct_id_seq; Type: SEQUENCE; Schema: public; Owner: app_dev
--

CREATE SEQUENCE public.foodcartapp_orderproduct_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.foodcartapp_orderproduct_id_seq OWNER TO app_dev;

--
-- Name: foodcartapp_orderproduct_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: app_dev
--

ALTER SEQUENCE public.foodcartapp_orderproduct_id_seq OWNED BY public.foodcartapp_orderproduct.id;


--
-- Name: foodcartapp_product; Type: TABLE; Schema: public; Owner: app_dev
--

CREATE TABLE public.foodcartapp_product (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    price numeric(8,2) NOT NULL,
    image character varying(100) NOT NULL,
    special_status boolean NOT NULL,
    description text NOT NULL,
    category_id integer
);


ALTER TABLE public.foodcartapp_product OWNER TO app_dev;

--
-- Name: foodcartapp_product_id_seq; Type: SEQUENCE; Schema: public; Owner: app_dev
--

CREATE SEQUENCE public.foodcartapp_product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.foodcartapp_product_id_seq OWNER TO app_dev;

--
-- Name: foodcartapp_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: app_dev
--

ALTER SEQUENCE public.foodcartapp_product_id_seq OWNED BY public.foodcartapp_product.id;


--
-- Name: foodcartapp_productcategory; Type: TABLE; Schema: public; Owner: app_dev
--

CREATE TABLE public.foodcartapp_productcategory (
    id integer NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.foodcartapp_productcategory OWNER TO app_dev;

--
-- Name: foodcartapp_productcategory_id_seq; Type: SEQUENCE; Schema: public; Owner: app_dev
--

CREATE SEQUENCE public.foodcartapp_productcategory_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.foodcartapp_productcategory_id_seq OWNER TO app_dev;

--
-- Name: foodcartapp_productcategory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: app_dev
--

ALTER SEQUENCE public.foodcartapp_productcategory_id_seq OWNED BY public.foodcartapp_productcategory.id;


--
-- Name: foodcartapp_restaurantmenuitem; Type: TABLE; Schema: public; Owner: app_dev
--

CREATE TABLE public.foodcartapp_restaurantmenuitem (
    id integer NOT NULL,
    availability boolean NOT NULL,
    product_id integer NOT NULL,
    restaurant_id integer NOT NULL
);


ALTER TABLE public.foodcartapp_restaurantmenuitem OWNER TO app_dev;

--
-- Name: foodcartapp_restaurantmenuitem_id_seq; Type: SEQUENCE; Schema: public; Owner: app_dev
--

CREATE SEQUENCE public.foodcartapp_restaurantmenuitem_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.foodcartapp_restaurantmenuitem_id_seq OWNER TO app_dev;

--
-- Name: foodcartapp_restaurantmenuitem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: app_dev
--

ALTER SEQUENCE public.foodcartapp_restaurantmenuitem_id_seq OWNED BY public.foodcartapp_restaurantmenuitem.id;


--
-- Name: location_location; Type: TABLE; Schema: public; Owner: app_dev
--

CREATE TABLE public.location_location (
    id bigint NOT NULL,
    address character varying(150) NOT NULL,
    lat double precision,
    lon double precision,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE public.location_location OWNER TO app_dev;

--
-- Name: location_location_id_seq; Type: SEQUENCE; Schema: public; Owner: app_dev
--

CREATE SEQUENCE public.location_location_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.location_location_id_seq OWNER TO app_dev;

--
-- Name: location_location_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: app_dev
--

ALTER SEQUENCE public.location_location_id_seq OWNED BY public.location_location.id;


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: app_dev
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: app_dev
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: app_dev
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: auth_user id; Type: DEFAULT; Schema: public; Owner: app_dev
--

ALTER TABLE ONLY public.auth_user ALTER COLUMN id SET DEFAULT nextval('public.auth_user_id_seq'::regclass);


--
-- Name: auth_user_groups id; Type: DEFAULT; Schema: public; Owner: app_dev
--

ALTER TABLE ONLY public.auth_user_groups ALTER COLUMN id SET DEFAULT nextval('public.auth_user_groups_id_seq'::regclass);


--
-- Name: auth_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: app_dev
--

ALTER TABLE ONLY public.auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_user_user_permissions_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: app_dev
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: app_dev
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: app_dev
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: foodcartapp_order id; Type: DEFAULT; Schema: public; Owner: app_dev
--

ALTER TABLE ONLY public.foodcartapp_order ALTER COLUMN id SET DEFAULT nextval('public.foodcartapp_order_id_seq'::regclass);


--
-- Name: foodcartapp_orderproduct id; Type: DEFAULT; Schema: public; Owner: app_dev
--

ALTER TABLE ONLY public.foodcartapp_orderproduct ALTER COLUMN id SET DEFAULT nextval('public.foodcartapp_orderproduct_id_seq'::regclass);


--
-- Name: foodcartapp_product id; Type: DEFAULT; Schema: public; Owner: app_dev
--

ALTER TABLE ONLY public.foodcartapp_product ALTER COLUMN id SET DEFAULT nextval('public.foodcartapp_product_id_seq'::regclass);


--
-- Name: foodcartapp_productcategory id; Type: DEFAULT; Schema: public; Owner: app_dev
--

ALTER TABLE ONLY public.foodcartapp_productcategory ALTER COLUMN id SET DEFAULT nextval('public.foodcartapp_productcategory_id_seq'::regclass);


--
-- Name: foodcartapp_restaurant id; Type: DEFAULT; Schema: public; Owner: app_dev
--

ALTER TABLE ONLY public.foodcartapp_restaurant ALTER COLUMN id SET DEFAULT nextval('public.foodcartapp_hotel_id_seq'::regclass);


--
-- Name: foodcartapp_restaurantmenuitem id; Type: DEFAULT; Schema: public; Owner: app_dev
--

ALTER TABLE ONLY public.foodcartapp_restaurantmenuitem ALTER COLUMN id SET DEFAULT nextval('public.foodcartapp_restaurantmenuitem_id_seq'::regclass);


--
-- Name: location_location id; Type: DEFAULT; Schema: public; Owner: app_dev
--

ALTER TABLE ONLY public.location_location ALTER COLUMN id SET DEFAULT nextval('public.location_location_id_seq'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: app_dev
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: app_dev
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: app_dev
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add permission	1	add_permission
2	Can change permission	1	change_permission
3	Can delete permission	1	delete_permission
4	Can view permission	1	view_permission
5	Can add group	2	add_group
6	Can change group	2	change_group
7	Can delete group	2	delete_group
8	Can view group	2	view_group
9	Can add user	3	add_user
10	Can change user	3	change_user
11	Can delete user	3	delete_user
12	Can view user	3	view_user
13	Can add content type	4	add_contenttype
14	Can change content type	4	change_contenttype
15	Can delete content type	4	delete_contenttype
16	Can view content type	4	view_contenttype
17	Can add session	5	add_session
18	Can change session	5	change_session
19	Can delete session	5	delete_session
20	Can view session	5	view_session
21	Can add log entry	6	add_logentry
22	Can change log entry	6	change_logentry
23	Can delete log entry	6	delete_logentry
24	Can view log entry	6	view_logentry
25	Can add товар	7	add_product
26	Can change товар	7	change_product
27	Can delete товар	7	delete_product
28	Can view товар	7	view_product
29	Can add ресторан	8	add_restaurant
30	Can change ресторан	8	change_restaurant
31	Can delete ресторан	8	delete_restaurant
32	Can view ресторан	8	view_restaurant
33	Can add пункт меню ресторана	9	add_restaurantmenuitem
34	Can change пункт меню ресторана	9	change_restaurantmenuitem
35	Can delete пункт меню ресторана	9	delete_restaurantmenuitem
36	Can view пункт меню ресторана	9	view_restaurantmenuitem
37	Can add категория	10	add_productcategory
38	Can change категория	10	change_productcategory
39	Can delete категория	10	delete_productcategory
40	Can view категория	10	view_productcategory
41	Can add заказ	11	add_order
42	Can change заказ	11	change_order
43	Can delete заказ	11	delete_order
44	Can view заказ	11	view_order
45	Can add товар в заказе	12	add_orderproduct
46	Can change товар в заказе	12	change_orderproduct
47	Can delete товар в заказе	12	delete_orderproduct
48	Can view товар в заказе	12	view_orderproduct
49	Can add локация	13	add_location
50	Can change локация	13	change_location
51	Can delete локация	13	delete_location
52	Can view локация	13	view_location
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: app_dev
--

COPY public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
1	pbkdf2_sha256$260000$BF9FM0ly2Nvi6MIFgqOJwZ$fGgvKhPbj1tfY9Dzc83upuVW2vmDCsgU5CSr/kcN90A=	2022-09-12 06:20:35.138944+00	t	superuser			superuser@super.email	t	t	2022-09-12 06:20:04.463084+00
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: app_dev
--

COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: app_dev
--

COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: app_dev
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2022-09-12 06:21:29.522734+00	1	Star Burger Арбат	1	[{"added": {}}]	8	1
2	2022-09-12 06:21:55.816058+00	2	Star Burger Цветной	1	[{"added": {}}]	8	1
3	2022-09-12 06:22:27.316902+00	3	Star Burger Европейский	1	[{"added": {}}]	8	1
4	2022-09-12 06:23:33.696396+00	1	Бургер	1	[{"added": {}}]	10	1
5	2022-09-12 06:24:17.742405+00	1	Стейкхаус	1	[{"added": {}}, {"added": {"name": "\\u043f\\u0443\\u043d\\u043a\\u0442 \\u043c\\u0435\\u043d\\u044e \\u0440\\u0435\\u0441\\u0442\\u043e\\u0440\\u0430\\u043d\\u0430", "object": "Star Burger \\u0410\\u0440\\u0431\\u0430\\u0442 - \\u0421\\u0442\\u0435\\u0439\\u043a\\u0445\\u0430\\u0443\\u0441"}}, {"added": {"name": "\\u043f\\u0443\\u043d\\u043a\\u0442 \\u043c\\u0435\\u043d\\u044e \\u0440\\u0435\\u0441\\u0442\\u043e\\u0440\\u0430\\u043d\\u0430", "object": "Star Burger \\u0426\\u0432\\u0435\\u0442\\u043d\\u043e\\u0439 - \\u0421\\u0442\\u0435\\u0439\\u043a\\u0445\\u0430\\u0443\\u0441"}}, {"added": {"name": "\\u043f\\u0443\\u043d\\u043a\\u0442 \\u043c\\u0435\\u043d\\u044e \\u0440\\u0435\\u0441\\u0442\\u043e\\u0440\\u0430\\u043d\\u0430", "object": "Star Burger \\u0415\\u0432\\u0440\\u043e\\u043f\\u0435\\u0439\\u0441\\u043a\\u0438\\u0439 - \\u0421\\u0442\\u0435\\u0439\\u043a\\u0445\\u0430\\u0443\\u0441"}}]	7	1
6	2022-09-12 06:25:07.885351+00	2	Лонг Чизбургер	1	[{"added": {}}, {"added": {"name": "\\u043f\\u0443\\u043d\\u043a\\u0442 \\u043c\\u0435\\u043d\\u044e \\u0440\\u0435\\u0441\\u0442\\u043e\\u0440\\u0430\\u043d\\u0430", "object": "Star Burger \\u0410\\u0440\\u0431\\u0430\\u0442 - \\u041b\\u043e\\u043d\\u0433 \\u0427\\u0438\\u0437\\u0431\\u0443\\u0440\\u0433\\u0435\\u0440"}}, {"added": {"name": "\\u043f\\u0443\\u043d\\u043a\\u0442 \\u043c\\u0435\\u043d\\u044e \\u0440\\u0435\\u0441\\u0442\\u043e\\u0440\\u0430\\u043d\\u0430", "object": "Star Burger \\u0426\\u0432\\u0435\\u0442\\u043d\\u043e\\u0439 - \\u041b\\u043e\\u043d\\u0433 \\u0427\\u0438\\u0437\\u0431\\u0443\\u0440\\u0433\\u0435\\u0440"}}]	7	1
7	2022-09-12 06:25:56.318215+00	3	Тройной Воппер	1	[{"added": {}}, {"added": {"name": "\\u043f\\u0443\\u043d\\u043a\\u0442 \\u043c\\u0435\\u043d\\u044e \\u0440\\u0435\\u0441\\u0442\\u043e\\u0440\\u0430\\u043d\\u0430", "object": "Star Burger \\u0410\\u0440\\u0431\\u0430\\u0442 - \\u0422\\u0440\\u043e\\u0439\\u043d\\u043e\\u0439 \\u0412\\u043e\\u043f\\u043f\\u0435\\u0440"}}, {"added": {"name": "\\u043f\\u0443\\u043d\\u043a\\u0442 \\u043c\\u0435\\u043d\\u044e \\u0440\\u0435\\u0441\\u0442\\u043e\\u0440\\u0430\\u043d\\u0430", "object": "Star Burger \\u0426\\u0432\\u0435\\u0442\\u043d\\u043e\\u0439 - \\u0422\\u0440\\u043e\\u0439\\u043d\\u043e\\u0439 \\u0412\\u043e\\u043f\\u043f\\u0435\\u0440"}}, {"added": {"name": "\\u043f\\u0443\\u043d\\u043a\\u0442 \\u043c\\u0435\\u043d\\u044e \\u0440\\u0435\\u0441\\u0442\\u043e\\u0440\\u0430\\u043d\\u0430", "object": "Star Burger \\u0415\\u0432\\u0440\\u043e\\u043f\\u0435\\u0439\\u0441\\u043a\\u0438\\u0439 - \\u0422\\u0440\\u043e\\u0439\\u043d\\u043e\\u0439 \\u0412\\u043e\\u043f\\u043f\\u0435\\u0440"}}]	7	1
8	2022-09-12 06:26:36.813119+00	4	Беконайзер	1	[{"added": {}}, {"added": {"name": "\\u043f\\u0443\\u043d\\u043a\\u0442 \\u043c\\u0435\\u043d\\u044e \\u0440\\u0435\\u0441\\u0442\\u043e\\u0440\\u0430\\u043d\\u0430", "object": "Star Burger \\u0410\\u0440\\u0431\\u0430\\u0442 - \\u0411\\u0435\\u043a\\u043e\\u043d\\u0430\\u0439\\u0437\\u0435\\u0440"}}, {"added": {"name": "\\u043f\\u0443\\u043d\\u043a\\u0442 \\u043c\\u0435\\u043d\\u044e \\u0440\\u0435\\u0441\\u0442\\u043e\\u0440\\u0430\\u043d\\u0430", "object": "Star Burger \\u0426\\u0432\\u0435\\u0442\\u043d\\u043e\\u0439 - \\u0411\\u0435\\u043a\\u043e\\u043d\\u0430\\u0439\\u0437\\u0435\\u0440"}}]	7	1
9	2022-09-12 06:26:53.75814+00	2	Ролл	1	[{"added": {}}]	10	1
10	2022-09-12 06:27:24.283515+00	5	Фиш Ролл	1	[{"added": {}}, {"added": {"name": "\\u043f\\u0443\\u043d\\u043a\\u0442 \\u043c\\u0435\\u043d\\u044e \\u0440\\u0435\\u0441\\u0442\\u043e\\u0440\\u0430\\u043d\\u0430", "object": "Star Burger \\u0410\\u0440\\u0431\\u0430\\u0442 - \\u0424\\u0438\\u0448 \\u0420\\u043e\\u043b\\u043b"}}, {"added": {"name": "\\u043f\\u0443\\u043d\\u043a\\u0442 \\u043c\\u0435\\u043d\\u044e \\u0440\\u0435\\u0441\\u0442\\u043e\\u0440\\u0430\\u043d\\u0430", "object": "Star Burger \\u0426\\u0432\\u0435\\u0442\\u043d\\u043e\\u0439 - \\u0424\\u0438\\u0448 \\u0420\\u043e\\u043b\\u043b"}}, {"added": {"name": "\\u043f\\u0443\\u043d\\u043a\\u0442 \\u043c\\u0435\\u043d\\u044e \\u0440\\u0435\\u0441\\u0442\\u043e\\u0440\\u0430\\u043d\\u0430", "object": "Star Burger \\u0415\\u0432\\u0440\\u043e\\u043f\\u0435\\u0439\\u0441\\u043a\\u0438\\u0439 - \\u0424\\u0438\\u0448 \\u0420\\u043e\\u043b\\u043b"}}]	7	1
11	2022-09-12 06:28:06.390264+00	6	Шримп Ролл	1	[{"added": {}}, {"added": {"name": "\\u043f\\u0443\\u043d\\u043a\\u0442 \\u043c\\u0435\\u043d\\u044e \\u0440\\u0435\\u0441\\u0442\\u043e\\u0440\\u0430\\u043d\\u0430", "object": "Star Burger \\u0410\\u0440\\u0431\\u0430\\u0442 - \\u0428\\u0440\\u0438\\u043c\\u043f \\u0420\\u043e\\u043b\\u043b"}}, {"added": {"name": "\\u043f\\u0443\\u043d\\u043a\\u0442 \\u043c\\u0435\\u043d\\u044e \\u0440\\u0435\\u0441\\u0442\\u043e\\u0440\\u0430\\u043d\\u0430", "object": "Star Burger \\u0426\\u0432\\u0435\\u0442\\u043d\\u043e\\u0439 - \\u0428\\u0440\\u0438\\u043c\\u043f \\u0420\\u043e\\u043b\\u043b"}}, {"added": {"name": "\\u043f\\u0443\\u043d\\u043a\\u0442 \\u043c\\u0435\\u043d\\u044e \\u0440\\u0435\\u0441\\u0442\\u043e\\u0440\\u0430\\u043d\\u0430", "object": "Star Burger \\u0415\\u0432\\u0440\\u043e\\u043f\\u0435\\u0439\\u0441\\u043a\\u0438\\u0439 - \\u0428\\u0440\\u0438\\u043c\\u043f \\u0420\\u043e\\u043b\\u043b"}}]	7	1
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: app_dev
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	auth	permission
2	auth	group
3	auth	user
4	contenttypes	contenttype
5	sessions	session
6	admin	logentry
7	foodcartapp	product
8	foodcartapp	restaurant
9	foodcartapp	restaurantmenuitem
10	foodcartapp	productcategory
11	foodcartapp	order
12	foodcartapp	orderproduct
13	location	location
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: app_dev
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2022-09-12 06:19:58.97829+00
2	auth	0001_initial	2022-09-12 06:20:00.217456+00
3	admin	0001_initial	2022-09-12 06:20:00.282397+00
4	admin	0002_logentry_remove_auto_add	2022-09-12 06:20:00.310734+00
5	admin	0003_logentry_add_action_flag_choices	2022-09-12 06:20:00.326412+00
6	contenttypes	0002_remove_content_type_name	2022-09-12 06:20:00.355229+00
7	auth	0002_alter_permission_name_max_length	2022-09-12 06:20:00.369123+00
8	auth	0003_alter_user_email_max_length	2022-09-12 06:20:00.384422+00
9	auth	0004_alter_user_username_opts	2022-09-12 06:20:00.396563+00
10	auth	0005_alter_user_last_login_null	2022-09-12 06:20:00.407023+00
11	auth	0006_require_contenttypes_0002	2022-09-12 06:20:00.410398+00
12	auth	0007_alter_validators_add_error_messages	2022-09-12 06:20:00.419152+00
13	auth	0008_alter_user_username_max_length	2022-09-12 06:20:00.433165+00
14	auth	0009_alter_user_last_name_max_length	2022-09-12 06:20:00.443683+00
15	auth	0010_alter_group_name_max_length	2022-09-12 06:20:00.454636+00
16	auth	0011_update_proxy_permissions	2022-09-12 06:20:00.464548+00
17	auth	0012_alter_user_first_name_max_length	2022-09-12 06:20:00.476706+00
18	foodcartapp	0001_initial	2022-09-12 06:20:00.631523+00
19	foodcartapp	0002_auto_20200619_0836	2022-09-12 06:20:00.903622+00
20	foodcartapp	0003_auto_20200619_0838	2022-09-12 06:20:00.984966+00
21	foodcartapp	0004_auto_20200619_0843	2022-09-12 06:20:00.997174+00
22	foodcartapp	0005_auto_20200619_0845	2022-09-12 06:20:01.016348+00
23	foodcartapp	0006_auto_20200619_0849	2022-09-12 06:20:01.034102+00
24	foodcartapp	0007_auto_20200619_0849	2022-09-12 06:20:01.0578+00
25	foodcartapp	0008_hotel_city	2022-09-12 06:20:01.077888+00
26	foodcartapp	0009_auto_20200619_0919	2022-09-12 06:20:01.100939+00
27	foodcartapp	0010_auto_20200619_0921	2022-09-12 06:20:01.12082+00
28	foodcartapp	0011_auto_20200619_0922	2022-09-12 06:20:01.139007+00
29	foodcartapp	0012_auto_20200619_0924	2022-09-12 06:20:01.146558+00
30	foodcartapp	0013_auto_20200619_0932	2022-09-12 06:20:01.178266+00
31	foodcartapp	0014_auto_20200619_0934	2022-09-12 06:20:01.212344+00
32	foodcartapp	0015_auto_20200619_0935	2022-09-12 06:20:01.225836+00
33	foodcartapp	0016_restaurant_new_admin	2022-09-12 06:20:01.24494+00
34	foodcartapp	0017_auto_20200619_0945	2022-09-12 06:20:01.257537+00
35	foodcartapp	0018_remove_restaurant_admin	2022-09-12 06:20:01.272478+00
36	foodcartapp	0019_auto_20200619_0948	2022-09-12 06:20:01.287539+00
37	foodcartapp	0020_auto_20200619_0959	2022-09-12 06:20:01.307816+00
38	foodcartapp	0021_auto_20200619_1002	2022-09-12 06:20:01.324805+00
39	foodcartapp	0022_auto_20200619_1003	2022-09-12 06:20:01.338551+00
40	foodcartapp	0023_auto_20200620_0942	2022-09-12 06:20:01.390955+00
41	foodcartapp	0024_product_ingridients	2022-09-12 06:20:01.401806+00
42	foodcartapp	0025_auto_20200629_1004	2022-09-12 06:20:01.420469+00
43	foodcartapp	0026_restaurantmenuitem	2022-09-12 06:20:01.457798+00
44	foodcartapp	0027_auto_20200629_1022	2022-09-12 06:20:01.488089+00
45	foodcartapp	0028_auto_20200629_1024	2022-09-12 06:20:01.518623+00
46	foodcartapp	0029_remove_product_category	2022-09-12 06:20:01.524278+00
47	foodcartapp	0030_auto_20200629_1341	2022-09-12 06:20:01.548342+00
48	foodcartapp	0031_auto_20200703_0612	2022-09-12 06:20:01.568587+00
49	foodcartapp	0032_remove_restaurant_admin	2022-09-12 06:20:01.587601+00
50	foodcartapp	0033_auto_20200928_1930	2022-09-12 06:20:01.595814+00
51	foodcartapp	0034_auto_20200928_1930	2022-09-12 06:20:01.60182+00
52	foodcartapp	0035_auto_20200928_1941	2022-09-12 06:20:01.612808+00
53	foodcartapp	0036_auto_20210125_1532	2022-09-12 06:20:01.622422+00
54	foodcartapp	0037_auto_20210125_1833	2022-09-12 06:20:01.628777+00
55	foodcartapp	0038_order	2022-09-12 06:20:01.65784+00
56	foodcartapp	0039_orderproduct	2022-09-12 06:20:01.682382+00
57	foodcartapp	0040_auto_20210906_0452	2022-09-12 06:20:01.697412+00
58	foodcartapp	0041_orderproduct_cost	2022-09-12 06:20:01.704911+00
59	foodcartapp	0042_auto_20210906_1001	2022-09-12 06:20:01.721657+00
60	foodcartapp	0043_order_status	2022-09-12 06:20:01.727989+00
61	foodcartapp	0044_order_comment	2022-09-12 06:20:01.745223+00
62	foodcartapp	0045_auto_20210907_0823	2022-09-12 06:20:01.802416+00
63	foodcartapp	0046_order_payment_method	2022-09-12 06:20:01.808593+00
64	foodcartapp	0047_order_restaurant	2022-09-12 06:20:01.823896+00
65	foodcartapp	0048_auto_20210915_0415	2022-09-12 06:20:01.902304+00
66	foodcartapp	0049_alter_orderproduct_cost	2022-09-12 06:20:01.914391+00
67	foodcartapp	0050_alter_order_payment_method	2022-09-12 06:20:01.923369+00
68	location	0001_initial	2022-09-12 06:20:01.944451+00
69	sessions	0001_initial	2022-09-12 06:20:01.967247+00
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: app_dev
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
ry7zi5iuyvloznqgx78z5s55q43i1ipi	.eJxVjMsOwiAQRf-FtSE8Sgsu3fsNZIYZpGogKe3K-O_apAvd3nPOfYkI21ri1nmJM4mz0OL0uyGkB9cd0B3qrcnU6rrMKHdFHrTLayN-Xg7376BAL99aqVE78mbwCRUly4ZNVpyDQQJEBMzOBW9h9EqTgjwwgA82TzpNOaB4fwD6yjjj:1oXco7:34i9QmGGCrE21XK1plHdj6l936fTkVuzpN1dFMWurWk	2022-09-26 06:20:35.184919+00
\.


--
-- Data for Name: foodcartapp_order; Type: TABLE DATA; Schema: public; Owner: app_dev
--

COPY public.foodcartapp_order (id, firstname, lastname, phonenumber, address, status, comment, called_at, delivered_at, registrated_at, payment_method, restaurant_id) FROM stdin;
1	Радим	Петров	+79399634772	г. Кожевниково, ул. Кавказский 1-й пер, дом 137, квартира 877	unprocessed		\N	\N	2022-09-12 06:35:51.9325+00	not_selected	\N
2	Олег	Власов	+79441509611	г. Уинское, ул. Сочинская, дом 53, квартира 595	unprocessed		\N	\N	2022-09-12 06:37:10.466089+00	not_selected	\N
3	Федот	Высоцкий	+79148456616	г. Бея, ул. Балканский Б. пер, дом 89, квартира 719	unprocessed		\N	\N	2022-09-12 06:38:24.246494+00	not_selected	\N
4	Евгения	Сочинская	+79258396938	г. Свеча, ул. Славянский б-р, дом 186, квартира 861	unprocessed		\N	\N	2022-09-12 06:40:10.0247+00	not_selected	\N
5	Каролина	Арсеньева	+79524260645	г. Кедровый, ул. МОПРа Малая, дом 105, квартира 785	unprocessed		\N	\N	2022-09-12 06:41:01.268767+00	not_selected	\N
6	Елизавета	Вершинина	+79971259786	г. Баксан, ул. Энергетическая, дом 154, квартира 684	unprocessed		\N	\N	2022-09-12 06:41:48.405662+00	not_selected	\N
7	Сильвестр	Чайковский	+79817624909	г. Мордово, ул. Чукотский 4-й пер, дом 72, квартира 843	unprocessed		\N	\N	2022-09-12 06:42:33.93354+00	not_selected	\N
8	Марианна	Журавель	+79295266434	г. Сосновское, ул. Ангарская, дом 158, квартира 910	unprocessed		\N	\N	2022-09-12 06:43:20.112413+00	not_selected	\N
9	Иосиф	Вишневский	+79645307949	г. Гальбштадт, ул. Цветочный проезд, дом 11, квартира 84	unprocessed		\N	\N	2022-09-12 06:44:33.84067+00	not_selected	\N
10	Людмила	Чистякова	+79414230952	г. Чекмагуш, ул. Мирской проезд, дом 112, квартира 94	unprocessed		\N	\N	2022-09-12 06:45:32.945108+00	not_selected	\N
\.


--
-- Data for Name: foodcartapp_orderproduct; Type: TABLE DATA; Schema: public; Owner: app_dev
--

COPY public.foodcartapp_orderproduct (id, quantity, order_id, product_id, cost) FROM stdin;
1	1	1	4	319.00
2	1	1	3	369.00
3	1	1	2	219.00
4	2	2	2	438.00
5	1	2	1	269.00
6	1	2	5	199.00
7	2	3	4	638.00
8	1	3	3	369.00
9	1	3	2	219.00
10	3	4	3	1107.00
11	1	4	2	219.00
12	3	5	2	657.00
13	1	5	3	369.00
14	1	5	4	319.00
15	1	5	6	209.00
16	4	6	1	1076.00
17	1	6	4	319.00
18	1	6	3	369.00
19	1	7	2	219.00
20	1	7	3	369.00
21	3	7	4	957.00
22	3	8	2	657.00
23	3	8	3	1107.00
24	1	8	4	319.00
25	4	9	6	836.00
26	1	9	5	199.00
27	1	9	3	369.00
28	4	9	2	876.00
29	4	10	3	1476.00
30	1	10	2	219.00
31	1	10	4	319.00
\.


--
-- Data for Name: foodcartapp_product; Type: TABLE DATA; Schema: public; Owner: app_dev
--

COPY public.foodcartapp_product (id, name, price, image, special_status, description, category_id) FROM stdin;
1	Стейкхаус	269.00	steak_gdLb2Mi.jpg	f	Стейкхаус – это сочетание нашей фирменной, приготовленной на огне 100% говядины с ломтиками бекона и соусом «Барбекю», майонезом, листьями свежего салата, помидором и хрустящим луком на воздушной було	1
2	Лонг Чизбургер	219.00	long_chiz.jpg	f	Лонг Чизбургер – эталон в коллекции чизбургеров! Два приготовленных на огне бифштекса с двумя ломтиками слегка расплавленного сыра, хрустящими огурчиками, рубленым луком, горчицей и кетчупом на длинно	1
3	Тройной Воппер	369.00	triple_vopper.jpg	f	ВОППЕР® — это вкуснейшая приготовленная на огне 100% говядина с сочными помидорами, свежим нарезанным листовым салатом, густым майонезом, хрустящими маринованными огурчиками и свежим луком на нежной б	1
4	Беконайзер	319.00	beconizer.jpg	f	Встречай самый внушительный бургер в коллекции Бургер Кинг. Много мяса, много бекона и много сыра - все, как ты любишь, и ничего лишнего!	1
5	Фиш Ролл	199.00	fish_roll.jpg	f	Наш новый ролл с аппетитной котлеткой из филе белой рыбы, с фирменным соусом, маринованными огурчиками и хрустящим салатом. Легкое рыбное удовольствие!	2
6	Шримп Ролл	209.00	shrimp_roll.jpg	f	Легкий ролл с нежными королевскими креветками в хрустящей панировке, свежий салат Айсберг и ломтик сыра в пшеничной лепешке под фирменным соусом «Кинг». Внимание! Блюдо содержит аллергены – морепродук	2
\.


--
-- Data for Name: foodcartapp_productcategory; Type: TABLE DATA; Schema: public; Owner: app_dev
--

COPY public.foodcartapp_productcategory (id, name) FROM stdin;
1	Бургер
2	Ролл
\.


--
-- Data for Name: foodcartapp_restaurant; Type: TABLE DATA; Schema: public; Owner: app_dev
--

COPY public.foodcartapp_restaurant (id, name, address, contact_phone) FROM stdin;
1	Star Burger Арбат	Москва, ул. Новый Арбат, 15	+7 (967) 157-44-13
2	Star Burger Цветной	Москва, Цветной бульвар, 11с2	+7 (929) 949-55-36
3	Star Burger Европейский	Москва, пл. Киевского Вокзала, 2	+7 (929) 680-47-58
\.


--
-- Data for Name: foodcartapp_restaurantmenuitem; Type: TABLE DATA; Schema: public; Owner: app_dev
--

COPY public.foodcartapp_restaurantmenuitem (id, availability, product_id, restaurant_id) FROM stdin;
1	t	1	1
2	t	1	2
3	t	1	3
4	t	2	1
5	t	2	2
6	t	3	1
7	t	3	2
8	t	3	3
9	t	4	1
10	t	4	2
11	t	5	1
12	t	5	2
13	t	5	3
14	t	6	1
15	t	6	2
16	t	6	3
\.


--
-- Data for Name: location_location; Type: TABLE DATA; Schema: public; Owner: app_dev
--

COPY public.location_location (id, address, lat, lon, created_at) FROM stdin;
1	г. Чекмагуш, ул. Мирской проезд, дом 112, квартира 94	55.139725	54.651759	2022-09-12 06:51:41.954992+00
2	Москва, Цветной бульвар, 11с2	55.770076	37.620429	2022-09-12 06:51:42.259036+00
3	Москва, ул. Новый Арбат, 15	55.752141	37.59242	2022-09-12 06:51:42.658959+00
4	г. Гальбштадт, ул. Цветочный проезд, дом 11, квартира 84	53.226703	78.991468	2022-09-12 06:51:43.028651+00
5	г. Сосновское, ул. Ангарская, дом 158, квартира 910	54.598439	73.161366	2022-09-12 06:51:43.969878+00
6	г. Мордово, ул. Чукотский 4-й пер, дом 72, квартира 843	55.531051	37.143055	2022-09-12 06:51:44.931649+00
7	г. Баксан, ул. Энергетическая, дом 154, квартира 684	43.681946	43.534622	2022-09-12 06:51:45.911483+00
8	г. Кедровый, ул. МОПРа Малая, дом 105, квартира 785	57.560963	79.566974	2022-09-12 06:51:46.833691+00
9	г. Свеча, ул. Славянский б-р, дом 186, квартира 861	58.277721	47.510162	2022-09-12 06:51:47.744001+00
10	г. Бея, ул. Балканский Б. пер, дом 89, квартира 719	29.968797	31.258174	2022-09-12 06:51:48.640346+00
11	г. Уинское, ул. Сочинская, дом 53, квартира 595	56.879555	56.585724	2022-09-12 06:51:49.534709+00
12	г. Кожевниково, ул. Кавказский 1-й пер, дом 137, квартира 877	56.259493	83.968862	2022-09-12 06:51:50.470892+00
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app_dev
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app_dev
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app_dev
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 52, true);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app_dev
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app_dev
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 1, true);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app_dev
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app_dev
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 11, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app_dev
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 13, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app_dev
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 69, true);


--
-- Name: foodcartapp_hotel_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app_dev
--

SELECT pg_catalog.setval('public.foodcartapp_hotel_id_seq', 3, true);


--
-- Name: foodcartapp_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app_dev
--

SELECT pg_catalog.setval('public.foodcartapp_order_id_seq', 10, true);


--
-- Name: foodcartapp_orderproduct_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app_dev
--

SELECT pg_catalog.setval('public.foodcartapp_orderproduct_id_seq', 31, true);


--
-- Name: foodcartapp_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app_dev
--

SELECT pg_catalog.setval('public.foodcartapp_product_id_seq', 6, true);


--
-- Name: foodcartapp_productcategory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app_dev
--

SELECT pg_catalog.setval('public.foodcartapp_productcategory_id_seq', 2, true);


--
-- Name: foodcartapp_restaurantmenuitem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app_dev
--

SELECT pg_catalog.setval('public.foodcartapp_restaurantmenuitem_id_seq', 16, true);


--
-- Name: location_location_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app_dev
--

SELECT pg_catalog.setval('public.location_location_id_seq', 12, true);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: app_dev
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: app_dev
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: app_dev
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: app_dev
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: app_dev
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: app_dev
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: app_dev
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: app_dev
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: app_dev
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: app_dev
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: app_dev
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: app_dev
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: app_dev
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: app_dev
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: app_dev
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: app_dev
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: app_dev
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: foodcartapp_restaurant foodcartapp_hotel_pkey; Type: CONSTRAINT; Schema: public; Owner: app_dev
--

ALTER TABLE ONLY public.foodcartapp_restaurant
    ADD CONSTRAINT foodcartapp_hotel_pkey PRIMARY KEY (id);


--
-- Name: foodcartapp_order foodcartapp_order_pkey; Type: CONSTRAINT; Schema: public; Owner: app_dev
--

ALTER TABLE ONLY public.foodcartapp_order
    ADD CONSTRAINT foodcartapp_order_pkey PRIMARY KEY (id);


--
-- Name: foodcartapp_orderproduct foodcartapp_orderproduct_pkey; Type: CONSTRAINT; Schema: public; Owner: app_dev
--

ALTER TABLE ONLY public.foodcartapp_orderproduct
    ADD CONSTRAINT foodcartapp_orderproduct_pkey PRIMARY KEY (id);


--
-- Name: foodcartapp_product foodcartapp_product_pkey; Type: CONSTRAINT; Schema: public; Owner: app_dev
--

ALTER TABLE ONLY public.foodcartapp_product
    ADD CONSTRAINT foodcartapp_product_pkey PRIMARY KEY (id);


--
-- Name: foodcartapp_productcategory foodcartapp_productcategory_pkey; Type: CONSTRAINT; Schema: public; Owner: app_dev
--

ALTER TABLE ONLY public.foodcartapp_productcategory
    ADD CONSTRAINT foodcartapp_productcategory_pkey PRIMARY KEY (id);


--
-- Name: foodcartapp_restaurantmenuitem foodcartapp_restaurantme_restaurant_id_product_id_e3271626_uniq; Type: CONSTRAINT; Schema: public; Owner: app_dev
--

ALTER TABLE ONLY public.foodcartapp_restaurantmenuitem
    ADD CONSTRAINT foodcartapp_restaurantme_restaurant_id_product_id_e3271626_uniq UNIQUE (restaurant_id, product_id);


--
-- Name: foodcartapp_restaurantmenuitem foodcartapp_restaurantmenuitem_pkey; Type: CONSTRAINT; Schema: public; Owner: app_dev
--

ALTER TABLE ONLY public.foodcartapp_restaurantmenuitem
    ADD CONSTRAINT foodcartapp_restaurantmenuitem_pkey PRIMARY KEY (id);


--
-- Name: location_location location_location_address_key; Type: CONSTRAINT; Schema: public; Owner: app_dev
--

ALTER TABLE ONLY public.location_location
    ADD CONSTRAINT location_location_address_key UNIQUE (address);


--
-- Name: location_location location_location_pkey; Type: CONSTRAINT; Schema: public; Owner: app_dev
--

ALTER TABLE ONLY public.location_location
    ADD CONSTRAINT location_location_pkey PRIMARY KEY (id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: app_dev
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: app_dev
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: app_dev
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: app_dev
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: app_dev
--

CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: app_dev
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: app_dev
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: app_dev
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: app_dev
--

CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: app_dev
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: app_dev
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: app_dev
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: app_dev
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: foodcartapp_order_address_aa5c0c59; Type: INDEX; Schema: public; Owner: app_dev
--

CREATE INDEX foodcartapp_order_address_aa5c0c59 ON public.foodcartapp_order USING btree (address);


--
-- Name: foodcartapp_order_address_aa5c0c59_like; Type: INDEX; Schema: public; Owner: app_dev
--

CREATE INDEX foodcartapp_order_address_aa5c0c59_like ON public.foodcartapp_order USING btree (address varchar_pattern_ops);


--
-- Name: foodcartapp_order_called_at_7b5c797d; Type: INDEX; Schema: public; Owner: app_dev
--

CREATE INDEX foodcartapp_order_called_at_7b5c797d ON public.foodcartapp_order USING btree (called_at);


--
-- Name: foodcartapp_order_delivered_at_afa25a67; Type: INDEX; Schema: public; Owner: app_dev
--

CREATE INDEX foodcartapp_order_delivered_at_afa25a67 ON public.foodcartapp_order USING btree (delivered_at);


--
-- Name: foodcartapp_order_payment_method_4f803fc6; Type: INDEX; Schema: public; Owner: app_dev
--

CREATE INDEX foodcartapp_order_payment_method_4f803fc6 ON public.foodcartapp_order USING btree (payment_method);


--
-- Name: foodcartapp_order_payment_method_4f803fc6_like; Type: INDEX; Schema: public; Owner: app_dev
--

CREATE INDEX foodcartapp_order_payment_method_4f803fc6_like ON public.foodcartapp_order USING btree (payment_method varchar_pattern_ops);


--
-- Name: foodcartapp_order_phonenumber_d810b5c8; Type: INDEX; Schema: public; Owner: app_dev
--

CREATE INDEX foodcartapp_order_phonenumber_d810b5c8 ON public.foodcartapp_order USING btree (phonenumber);


--
-- Name: foodcartapp_order_phonenumber_d810b5c8_like; Type: INDEX; Schema: public; Owner: app_dev
--

CREATE INDEX foodcartapp_order_phonenumber_d810b5c8_like ON public.foodcartapp_order USING btree (phonenumber varchar_pattern_ops);


--
-- Name: foodcartapp_order_registrated_at_b0a763c6; Type: INDEX; Schema: public; Owner: app_dev
--

CREATE INDEX foodcartapp_order_registrated_at_b0a763c6 ON public.foodcartapp_order USING btree (registrated_at);


--
-- Name: foodcartapp_order_restaurant_id_3a8e4062; Type: INDEX; Schema: public; Owner: app_dev
--

CREATE INDEX foodcartapp_order_restaurant_id_3a8e4062 ON public.foodcartapp_order USING btree (restaurant_id);


--
-- Name: foodcartapp_order_status_65884383; Type: INDEX; Schema: public; Owner: app_dev
--

CREATE INDEX foodcartapp_order_status_65884383 ON public.foodcartapp_order USING btree (status);


--
-- Name: foodcartapp_order_status_65884383_like; Type: INDEX; Schema: public; Owner: app_dev
--

CREATE INDEX foodcartapp_order_status_65884383_like ON public.foodcartapp_order USING btree (status varchar_pattern_ops);


--
-- Name: foodcartapp_orderproduct_order_id_d2fc5c25; Type: INDEX; Schema: public; Owner: app_dev
--

CREATE INDEX foodcartapp_orderproduct_order_id_d2fc5c25 ON public.foodcartapp_orderproduct USING btree (order_id);


--
-- Name: foodcartapp_orderproduct_product_id_bcd6cda0; Type: INDEX; Schema: public; Owner: app_dev
--

CREATE INDEX foodcartapp_orderproduct_product_id_bcd6cda0 ON public.foodcartapp_orderproduct USING btree (product_id);


--
-- Name: foodcartapp_product_category_id_e35a423b; Type: INDEX; Schema: public; Owner: app_dev
--

CREATE INDEX foodcartapp_product_category_id_e35a423b ON public.foodcartapp_product USING btree (category_id);


--
-- Name: foodcartapp_product_special_status_2be2f3e9; Type: INDEX; Schema: public; Owner: app_dev
--

CREATE INDEX foodcartapp_product_special_status_2be2f3e9 ON public.foodcartapp_product USING btree (special_status);


--
-- Name: foodcartapp_restaurantmenuitem_availability_f4d4d4a7; Type: INDEX; Schema: public; Owner: app_dev
--

CREATE INDEX foodcartapp_restaurantmenuitem_availability_f4d4d4a7 ON public.foodcartapp_restaurantmenuitem USING btree (availability);


--
-- Name: foodcartapp_restaurantmenuitem_product_id_80c1a5c0; Type: INDEX; Schema: public; Owner: app_dev
--

CREATE INDEX foodcartapp_restaurantmenuitem_product_id_80c1a5c0 ON public.foodcartapp_restaurantmenuitem USING btree (product_id);


--
-- Name: foodcartapp_restaurantmenuitem_restaurant_id_561b91ba; Type: INDEX; Schema: public; Owner: app_dev
--

CREATE INDEX foodcartapp_restaurantmenuitem_restaurant_id_561b91ba ON public.foodcartapp_restaurantmenuitem USING btree (restaurant_id);


--
-- Name: location_location_address_04d1b88a_like; Type: INDEX; Schema: public; Owner: app_dev
--

CREATE INDEX location_location_address_04d1b88a_like ON public.location_location USING btree (address varchar_pattern_ops);


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: app_dev
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: app_dev
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: app_dev
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: app_dev
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: app_dev
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: app_dev
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: app_dev
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: app_dev
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: app_dev
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: foodcartapp_order foodcartapp_order_restaurant_id_3a8e4062_fk_foodcarta; Type: FK CONSTRAINT; Schema: public; Owner: app_dev
--

ALTER TABLE ONLY public.foodcartapp_order
    ADD CONSTRAINT foodcartapp_order_restaurant_id_3a8e4062_fk_foodcarta FOREIGN KEY (restaurant_id) REFERENCES public.foodcartapp_restaurant(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: foodcartapp_orderproduct foodcartapp_orderpro_order_id_d2fc5c25_fk_foodcarta; Type: FK CONSTRAINT; Schema: public; Owner: app_dev
--

ALTER TABLE ONLY public.foodcartapp_orderproduct
    ADD CONSTRAINT foodcartapp_orderpro_order_id_d2fc5c25_fk_foodcarta FOREIGN KEY (order_id) REFERENCES public.foodcartapp_order(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: foodcartapp_orderproduct foodcartapp_orderpro_product_id_bcd6cda0_fk_foodcarta; Type: FK CONSTRAINT; Schema: public; Owner: app_dev
--

ALTER TABLE ONLY public.foodcartapp_orderproduct
    ADD CONSTRAINT foodcartapp_orderpro_product_id_bcd6cda0_fk_foodcarta FOREIGN KEY (product_id) REFERENCES public.foodcartapp_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: foodcartapp_product foodcartapp_product_category_id_e35a423b_fk_foodcarta; Type: FK CONSTRAINT; Schema: public; Owner: app_dev
--

ALTER TABLE ONLY public.foodcartapp_product
    ADD CONSTRAINT foodcartapp_product_category_id_e35a423b_fk_foodcarta FOREIGN KEY (category_id) REFERENCES public.foodcartapp_productcategory(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: foodcartapp_restaurantmenuitem foodcartapp_restaura_product_id_80c1a5c0_fk_foodcarta; Type: FK CONSTRAINT; Schema: public; Owner: app_dev
--

ALTER TABLE ONLY public.foodcartapp_restaurantmenuitem
    ADD CONSTRAINT foodcartapp_restaura_product_id_80c1a5c0_fk_foodcarta FOREIGN KEY (product_id) REFERENCES public.foodcartapp_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: foodcartapp_restaurantmenuitem foodcartapp_restaura_restaurant_id_561b91ba_fk_foodcarta; Type: FK CONSTRAINT; Schema: public; Owner: app_dev
--

ALTER TABLE ONLY public.foodcartapp_restaurantmenuitem
    ADD CONSTRAINT foodcartapp_restaura_restaurant_id_561b91ba_fk_foodcarta FOREIGN KEY (restaurant_id) REFERENCES public.foodcartapp_restaurant(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--


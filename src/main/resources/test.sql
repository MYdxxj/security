--
-- PostgreSQL database dump
--

-- Dumped from database version 10.9
-- Dumped by pg_dump version 10.9

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
-- Name: b_system; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA b_system;


ALTER SCHEMA b_system OWNER TO postgres;

--
-- Name: system; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA system;


ALTER SCHEMA system OWNER TO postgres;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


--
-- Name: delete_act_id_group(); Type: FUNCTION; Schema: b_system; Owner: postgres
--

CREATE FUNCTION b_system.delete_act_id_group() RETURNS trigger
    LANGUAGE plpgsql
    AS $$DECLARE

  id INTEGER;

	v_sql  VARCHAR;

  v_sql2  VARCHAR;

	v_sql3  VARCHAR;

BEGIN

  id := OLD.id;

  v_sql := 'delete from public.act_id_membership where group_id_ = '''||id||'''';

	execute v_sql;

	v_sql2 := 'delete from b_system.user_group where job_group_id = '''||id||'''';

	execute v_sql2;

	v_sql3 := 'delete from public.act_id_group where id_='''||id||'''';

	execute v_sql3;

	RETURN NULL;

END;

$$;


ALTER FUNCTION b_system.delete_act_id_group() OWNER TO postgres;

--
-- Name: delete_act_id_shipment(); Type: FUNCTION; Schema: b_system; Owner: postgres
--

CREATE FUNCTION b_system.delete_act_id_shipment() RETURNS trigger
    LANGUAGE plpgsql
    AS $$DECLARE

  id INTEGER;

	v_sql  VARCHAR;

  v_sql2  VARCHAR;

  v_sql3  VARCHAR;

BEGIN

  id := OLD.id;

  v_sql := 'delete from public.act_id_membership where user_id_ = '''||id||'''';

	execute v_sql;

	v_sql2 := 'delete from b_system.user_group where user_id = '''||id||'''';

	execute v_sql2;

	v_sql3 := 'delete from public.act_id_user where id_='''||id||'''';

	execute v_sql3;

	RETURN NULL;

END;

$$;


ALTER FUNCTION b_system.delete_act_id_shipment() OWNER TO postgres;

--
-- Name: insert_act_id_group(); Type: FUNCTION; Schema: b_system; Owner: postgres
--

CREATE FUNCTION b_system.insert_act_id_group() RETURNS trigger
    LANGUAGE plpgsql
    AS $$DECLARE

  id INTEGER;

	name VARCHAR;

  v_sql  VARCHAR;

BEGIN

  id := NEW.id;

	name := NEW.name;

  v_sql := 'insert into public.act_id_group (id_,name_) values ('''||id||''','''||name||''')';

	execute v_sql;

	RETURN NULL;

END;

$$;


ALTER FUNCTION b_system.insert_act_id_group() OWNER TO postgres;

--
-- Name: insert_id_membership_activiti(); Type: FUNCTION; Schema: b_system; Owner: postgres
--

CREATE FUNCTION b_system.insert_id_membership_activiti() RETURNS trigger
    LANGUAGE plpgsql
    AS $$DECLARE

  user_id INTEGER;

	job_group_id VARCHAR;

  v_sql  VARCHAR;

BEGIN

  user_id := NEW.user_id;

	job_group_id := NEW.job_group_id;

  v_sql := 'insert into public.act_id_membership (user_id_,group_id_) values ('''||user_id||''','''||job_group_id||''')';

	execute v_sql;

	RETURN NULL;

END;

$$;


ALTER FUNCTION b_system.insert_id_membership_activiti() OWNER TO postgres;

--
-- Name: insert_s_user_activiti(); Type: FUNCTION; Schema: b_system; Owner: postgres
--

CREATE FUNCTION b_system.insert_s_user_activiti() RETURNS trigger
    LANGUAGE plpgsql
    AS $$DECLARE

  id INTEGER;

  v_sql  VARCHAR;

BEGIN

  id := NEW.id;

  v_sql := 'insert into public.act_id_user (id_) values ('''||id||''')';

	execute v_sql;

	RETURN NULL;

END;

$$;


ALTER FUNCTION b_system.insert_s_user_activiti() OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: b_user_info; Type: TABLE; Schema: b_system; Owner: postgres
--

CREATE TABLE b_system.b_user_info (
    user_name character varying(20) NOT NULL,
    password character varying(50),
    name character varying(20),
    email character varying(50),
    phone character varying(11),
    group_ character varying(50),
    device_id character varying(200),
    last_time timestamp(0) without time zone,
    photo character varying(255)
);


ALTER TABLE b_system.b_user_info OWNER TO postgres;

--
-- Name: d_app_config; Type: TABLE; Schema: b_system; Owner: postgres
--

CREATE TABLE b_system.d_app_config (
    pro_id character varying(50) NOT NULL,
    pro_name character varying(255),
    lgtd numeric(10,7),
    lttd numeric(10,7),
    polygon character varying(50),
    zoom integer,
    client_ip character varying(50)
);


ALTER TABLE b_system.d_app_config OWNER TO postgres;

--
-- Name: d_appuser_power; Type: TABLE; Schema: b_system; Owner: postgres
--

CREATE TABLE b_system.d_appuser_power (
    user_name character varying(20) NOT NULL,
    pro_id character varying(10) NOT NULL,
    pro_name character varying(20),
    lgtd numeric(10,7),
    lttd numeric(10,7),
    polygon character varying(50),
    zoom integer
);


ALTER TABLE b_system.d_appuser_power OWNER TO postgres;

--
-- Name: COLUMN d_appuser_power.polygon; Type: COMMENT; Schema: b_system; Owner: postgres
--

COMMENT ON COLUMN b_system.d_appuser_power.polygon IS '水库流域面积图';


--
-- Name: COLUMN d_appuser_power.zoom; Type: COMMENT; Schema: b_system; Owner: postgres
--

COMMENT ON COLUMN b_system.d_appuser_power.zoom IS '初始化显示级别';


--
-- Name: job_group_id_seq; Type: SEQUENCE; Schema: b_system; Owner: postgres
--

CREATE SEQUENCE b_system.job_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE b_system.job_group_id_seq OWNER TO postgres;

--
-- Name: job_group; Type: TABLE; Schema: b_system; Owner: postgres
--

CREATE TABLE b_system.job_group (
    id smallint DEFAULT nextval('b_system.job_group_id_seq'::regclass) NOT NULL,
    name character varying(30),
    post_duty character varying(255),
    qualification_certificate character varying(25),
    p_id smallint
);


ALTER TABLE b_system.job_group OWNER TO postgres;

--
-- Name: COLUMN job_group.id; Type: COMMENT; Schema: b_system; Owner: postgres
--

COMMENT ON COLUMN b_system.job_group.id IS '主键id';


--
-- Name: COLUMN job_group.name; Type: COMMENT; Schema: b_system; Owner: postgres
--

COMMENT ON COLUMN b_system.job_group.name IS '工作组';


--
-- Name: COLUMN job_group.post_duty; Type: COMMENT; Schema: b_system; Owner: postgres
--

COMMENT ON COLUMN b_system.job_group.post_duty IS '岗位职责';


--
-- Name: COLUMN job_group.qualification_certificate; Type: COMMENT; Schema: b_system; Owner: postgres
--

COMMENT ON COLUMN b_system.job_group.qualification_certificate IS '岗位资格证';


--
-- Name: COLUMN job_group.p_id; Type: COMMENT; Schema: b_system; Owner: postgres
--

COMMENT ON COLUMN b_system.job_group.p_id IS '父级ID';


--
-- Name: seq_menu_id; Type: SEQUENCE; Schema: b_system; Owner: postgres
--

CREATE SEQUENCE b_system.seq_menu_id
    START WITH 2
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 99999999
    CACHE 1;


ALTER TABLE b_system.seq_menu_id OWNER TO postgres;

--
-- Name: menu; Type: TABLE; Schema: b_system; Owner: postgres
--

CREATE TABLE b_system.menu (
    menu_id integer DEFAULT nextval('b_system.seq_menu_id'::regclass) NOT NULL,
    menu_name character varying(20),
    menu_icon character varying(50),
    menu_url character varying(50),
    "order" integer,
    parent_id integer,
    level integer
);


ALTER TABLE b_system.menu OWNER TO postgres;

--
-- Name: seq_role; Type: SEQUENCE; Schema: b_system; Owner: postgres
--

CREATE SEQUENCE b_system.seq_role
    START WITH 2
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 99999999
    CACHE 1;


ALTER TABLE b_system.seq_role OWNER TO postgres;

--
-- Name: role; Type: TABLE; Schema: b_system; Owner: postgres
--

CREATE TABLE b_system.role (
    id integer DEFAULT nextval('b_system.seq_role'::regclass) NOT NULL,
    name character varying(20),
    rights bigint,
    add bigint,
    del bigint,
    change bigint,
    query bigint
);


ALTER TABLE b_system.role OWNER TO postgres;

--
-- Name: s_menu; Type: TABLE; Schema: b_system; Owner: postgres
--

CREATE TABLE b_system.s_menu (
    menu_id integer DEFAULT nextval('b_system.seq_menu_id'::regclass) NOT NULL,
    menu_name character varying(20),
    menu_url character varying(50),
    "order" integer,
    parent_id integer,
    pro_id character varying
);


ALTER TABLE b_system.s_menu OWNER TO postgres;

--
-- Name: s_menu_temp; Type: TABLE; Schema: b_system; Owner: postgres
--

CREATE TABLE b_system.s_menu_temp (
    menu_id integer DEFAULT nextval('b_system.seq_menu_id'::regclass) NOT NULL,
    menu_name character varying(20),
    menu_url character varying(50),
    "order" integer,
    parent_id integer,
    pro_id character varying
);


ALTER TABLE b_system.s_menu_temp OWNER TO postgres;

--
-- Name: s_role; Type: TABLE; Schema: b_system; Owner: postgres
--

CREATE TABLE b_system.s_role (
    name character varying(20),
    rights bigint,
    add bigint,
    del bigint,
    change bigint,
    query bigint,
    id smallint NOT NULL
);


ALTER TABLE b_system.s_role OWNER TO postgres;

--
-- Name: s_role_id_seq; Type: SEQUENCE; Schema: b_system; Owner: postgres
--

CREATE SEQUENCE b_system.s_role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE b_system.s_role_id_seq OWNER TO postgres;

--
-- Name: s_role_id_seq; Type: SEQUENCE OWNED BY; Schema: b_system; Owner: postgres
--

ALTER SEQUENCE b_system.s_role_id_seq OWNED BY b_system.s_role.name;


--
-- Name: s_role_menu; Type: TABLE; Schema: b_system; Owner: postgres
--

CREATE TABLE b_system.s_role_menu (
    id integer NOT NULL,
    s_role_id integer,
    s_menu_id integer
);


ALTER TABLE b_system.s_role_menu OWNER TO postgres;

--
-- Name: s_user; Type: TABLE; Schema: b_system; Owner: postgres
--

CREATE TABLE b_system.s_user (
    login_name character varying(50),
    user_name character varying(50),
    password character varying(200),
    sex smallint,
    phone character varying(20),
    email character varying(20),
    role_id integer,
    pro_id character varying(20),
    id smallint NOT NULL,
    job_group character varying(20),
    major character varying(20),
    post character varying(50),
    title character varying(30)
);


ALTER TABLE b_system.s_user OWNER TO postgres;

--
-- Name: COLUMN s_user.job_group; Type: COMMENT; Schema: b_system; Owner: postgres
--

COMMENT ON COLUMN b_system.s_user.job_group IS '工作组';


--
-- Name: COLUMN s_user.major; Type: COMMENT; Schema: b_system; Owner: postgres
--

COMMENT ON COLUMN b_system.s_user.major IS '专业';


--
-- Name: COLUMN s_user.post; Type: COMMENT; Schema: b_system; Owner: postgres
--

COMMENT ON COLUMN b_system.s_user.post IS '职务';


--
-- Name: COLUMN s_user.title; Type: COMMENT; Schema: b_system; Owner: postgres
--

COMMENT ON COLUMN b_system.s_user.title IS '职称';


--
-- Name: s_user_id_seq; Type: SEQUENCE; Schema: b_system; Owner: postgres
--

CREATE SEQUENCE b_system.s_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE b_system.s_user_id_seq OWNER TO postgres;

--
-- Name: s_user_id_seq; Type: SEQUENCE OWNED BY; Schema: b_system; Owner: postgres
--

ALTER SEQUENCE b_system.s_user_id_seq OWNED BY b_system.s_user.id;


--
-- Name: s_user_id_seq2; Type: SEQUENCE; Schema: b_system; Owner: postgres
--

CREATE SEQUENCE b_system.s_user_id_seq2
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE b_system.s_user_id_seq2 OWNER TO postgres;

--
-- Name: s_user_id_seq2; Type: SEQUENCE OWNED BY; Schema: b_system; Owner: postgres
--

ALTER SEQUENCE b_system.s_user_id_seq2 OWNED BY b_system.s_user.id;


--
-- Name: s_user_role; Type: TABLE; Schema: b_system; Owner: postgres
--

CREATE TABLE b_system.s_user_role (
    id smallint NOT NULL,
    s_user_id smallint,
    s_role_id smallint
);


ALTER TABLE b_system.s_user_role OWNER TO postgres;

--
-- Name: seq_user; Type: SEQUENCE; Schema: b_system; Owner: postgres
--

CREATE SEQUENCE b_system.seq_user
    START WITH 2
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 99999999
    CACHE 1;


ALTER TABLE b_system.seq_user OWNER TO postgres;

--
-- Name: table_desc; Type: TABLE; Schema: b_system; Owner: postgres
--

CREATE TABLE b_system.table_desc (
    id integer NOT NULL,
    table_id integer,
    field character varying(30),
    "desc" character varying(255)
);


ALTER TABLE b_system.table_desc OWNER TO postgres;

--
-- Name: table_desc_id_seq; Type: SEQUENCE; Schema: b_system; Owner: postgres
--

CREATE SEQUENCE b_system.table_desc_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE b_system.table_desc_id_seq OWNER TO postgres;

--
-- Name: table_desc_id_seq; Type: SEQUENCE OWNED BY; Schema: b_system; Owner: postgres
--

ALTER SEQUENCE b_system.table_desc_id_seq OWNED BY b_system.table_desc.id;


--
-- Name: table_info; Type: TABLE; Schema: b_system; Owner: postgres
--

CREATE TABLE b_system.table_info (
    id smallint NOT NULL,
    schema character varying(20),
    "table" character varying(20),
    "desc" character varying(255)
);


ALTER TABLE b_system.table_info OWNER TO postgres;

--
-- Name: COLUMN table_info.id; Type: COMMENT; Schema: b_system; Owner: postgres
--

COMMENT ON COLUMN b_system.table_info.id IS '编码';


--
-- Name: COLUMN table_info.schema; Type: COMMENT; Schema: b_system; Owner: postgres
--

COMMENT ON COLUMN b_system.table_info.schema IS '模式';


--
-- Name: COLUMN table_info."table"; Type: COMMENT; Schema: b_system; Owner: postgres
--

COMMENT ON COLUMN b_system.table_info."table" IS '表名';


--
-- Name: COLUMN table_info."desc"; Type: COMMENT; Schema: b_system; Owner: postgres
--

COMMENT ON COLUMN b_system.table_info."desc" IS '表说明';


--
-- Name: table_info_id_seq; Type: SEQUENCE; Schema: b_system; Owner: postgres
--

CREATE SEQUENCE b_system.table_info_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE b_system.table_info_id_seq OWNER TO postgres;

--
-- Name: table_info_id_seq; Type: SEQUENCE OWNED BY; Schema: b_system; Owner: postgres
--

ALTER SEQUENCE b_system.table_info_id_seq OWNED BY b_system.table_info.id;


--
-- Name: user; Type: TABLE; Schema: b_system; Owner: postgres
--

CREATE TABLE b_system."user" (
    id integer DEFAULT nextval('b_system.seq_user'::regclass) NOT NULL,
    login_name character varying(50),
    user_name character varying(50),
    password character varying(200),
    sex smallint,
    phone character varying(20),
    email character varying(20),
    role_id integer
);


ALTER TABLE b_system."user" OWNER TO postgres;

--
-- Name: user_group; Type: TABLE; Schema: b_system; Owner: postgres
--

CREATE TABLE b_system.user_group (
    user_id smallint NOT NULL,
    job_group_id smallint NOT NULL
);


ALTER TABLE b_system.user_group OWNER TO postgres;

--
-- Name: user_id_seq; Type: SEQUENCE; Schema: b_system; Owner: postgres
--

CREATE SEQUENCE b_system.user_id_seq
    START WITH 6
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999
    CACHE 1;


ALTER TABLE b_system.user_id_seq OWNER TO postgres;

--
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: b_system; Owner: postgres
--

ALTER SEQUENCE b_system.user_id_seq OWNED BY b_system."user".id;


--
-- Name: sys_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_permission (
    id integer NOT NULL,
    description character varying(255),
    name character varying(255),
    p_id integer,
    url character varying(255)
);


ALTER TABLE public.sys_permission OWNER TO postgres;

--
-- Name: sys_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sys_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sys_permission_id_seq OWNER TO postgres;

--
-- Name: sys_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sys_permission_id_seq OWNED BY public.sys_permission.id;


--
-- Name: sys_permission_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_permission_role (
    role_id integer NOT NULL,
    permission_id integer NOT NULL,
    id integer NOT NULL
);


ALTER TABLE public.sys_permission_role OWNER TO postgres;

--
-- Name: sys_permission_role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sys_permission_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sys_permission_role_id_seq OWNER TO postgres;

--
-- Name: sys_permission_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sys_permission_role_id_seq OWNED BY public.sys_permission_role.id;


--
-- Name: sys_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_role (
    id integer NOT NULL,
    name character varying(255)
);


ALTER TABLE public.sys_role OWNER TO postgres;

--
-- Name: sys_role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sys_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sys_role_id_seq OWNER TO postgres;

--
-- Name: sys_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sys_role_id_seq OWNED BY public.sys_role.id;


--
-- Name: sys_role_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_role_user (
    sys_role_id integer NOT NULL,
    sys_user_id integer NOT NULL,
    id integer NOT NULL
);


ALTER TABLE public.sys_role_user OWNER TO postgres;

--
-- Name: sys_role_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sys_role_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sys_role_user_id_seq OWNER TO postgres;

--
-- Name: sys_role_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sys_role_user_id_seq OWNED BY public.sys_role_user.id;


--
-- Name: sys_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_user (
    id integer NOT NULL,
    password character varying(255),
    user_name character varying(255)
);


ALTER TABLE public.sys_user OWNER TO postgres;

--
-- Name: sys_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sys_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sys_user_id_seq OWNER TO postgres;

--
-- Name: sys_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sys_user_id_seq OWNED BY public.sys_user.id;


--
-- Name: msg; Type: TABLE; Schema: system; Owner: postgres
--

CREATE TABLE system.msg (
    title character varying(255) NOT NULL,
    content character varying(255),
    etra_info character varying(255)
);


ALTER TABLE system.msg OWNER TO postgres;

--
-- Name: system_role; Type: TABLE; Schema: system; Owner: postgres
--

CREATE TABLE system.system_role (
    id integer NOT NULL,
    name character varying(255)
);


ALTER TABLE system.system_role OWNER TO postgres;

--
-- Name: system_role_id_seq; Type: SEQUENCE; Schema: system; Owner: postgres
--

CREATE SEQUENCE system.system_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE system.system_role_id_seq OWNER TO postgres;

--
-- Name: system_role_id_seq; Type: SEQUENCE OWNED BY; Schema: system; Owner: postgres
--

ALTER SEQUENCE system.system_role_id_seq OWNED BY system.system_role.id;


--
-- Name: system_user; Type: TABLE; Schema: system; Owner: postgres
--

CREATE TABLE system.system_user (
    id integer NOT NULL,
    password character varying(255),
    user_name character varying(255)
);


ALTER TABLE system.system_user OWNER TO postgres;

--
-- Name: system_user_id_seq; Type: SEQUENCE; Schema: system; Owner: postgres
--

CREATE SEQUENCE system.system_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE system.system_user_id_seq OWNER TO postgres;

--
-- Name: system_user_id_seq; Type: SEQUENCE OWNED BY; Schema: system; Owner: postgres
--

ALTER SEQUENCE system.system_user_id_seq OWNED BY system.system_user.id;


--
-- Name: s_role id; Type: DEFAULT; Schema: b_system; Owner: postgres
--

ALTER TABLE ONLY b_system.s_role ALTER COLUMN id SET DEFAULT nextval('b_system.s_role_id_seq'::regclass);


--
-- Name: s_user id; Type: DEFAULT; Schema: b_system; Owner: postgres
--

ALTER TABLE ONLY b_system.s_user ALTER COLUMN id SET DEFAULT nextval('b_system.s_user_id_seq2'::regclass);


--
-- Name: table_desc id; Type: DEFAULT; Schema: b_system; Owner: postgres
--

ALTER TABLE ONLY b_system.table_desc ALTER COLUMN id SET DEFAULT nextval('b_system.table_desc_id_seq'::regclass);


--
-- Name: table_info id; Type: DEFAULT; Schema: b_system; Owner: postgres
--

ALTER TABLE ONLY b_system.table_info ALTER COLUMN id SET DEFAULT nextval('b_system.table_info_id_seq'::regclass);


--
-- Name: sys_permission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_permission ALTER COLUMN id SET DEFAULT nextval('public.sys_permission_id_seq'::regclass);


--
-- Name: sys_permission_role id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_permission_role ALTER COLUMN id SET DEFAULT nextval('public.sys_permission_role_id_seq'::regclass);


--
-- Name: sys_role id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_role ALTER COLUMN id SET DEFAULT nextval('public.sys_role_id_seq'::regclass);


--
-- Name: sys_role_user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_role_user ALTER COLUMN id SET DEFAULT nextval('public.sys_role_user_id_seq'::regclass);


--
-- Name: sys_user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_user ALTER COLUMN id SET DEFAULT nextval('public.sys_user_id_seq'::regclass);


--
-- Name: system_role id; Type: DEFAULT; Schema: system; Owner: postgres
--

ALTER TABLE ONLY system.system_role ALTER COLUMN id SET DEFAULT nextval('system.system_role_id_seq'::regclass);


--
-- Name: system_user id; Type: DEFAULT; Schema: system; Owner: postgres
--

ALTER TABLE ONLY system.system_user ALTER COLUMN id SET DEFAULT nextval('system.system_user_id_seq'::regclass);


--
-- Data for Name: b_user_info; Type: TABLE DATA; Schema: b_system; Owner: postgres
--

COPY b_system.b_user_info (user_name, password, name, email, phone, group_, device_id, last_time, photo) FROM stdin;
luojie	E10ADC3949BA59ABBE56E057F20F883E	罗杰			冉渡滩	\N	\N	\N
liushibang	E10ADC3949BA59ABBE56E057F20F883E	刘世邦			冉渡滩	\N	\N	\N
jiangyong	E10ADC3949BA59ABBE56E057F20F883E	蒋勇			冉渡滩	\N	\N	\N
wangao	E10ADC3949BA59ABBE56E057F20F883E	王熬			冉渡滩	\N	\N	\N
hutianyu	E10ADC3949BA59ABBE56E057F20F883E	胡天宇			冉渡滩	\N	\N	\N
gaowen	E10ADC3949BA59ABBE56E057F20F883E	高文			智慧水利	\N	\N	\N
wuhongbing	E10ADC3949BA59ABBE56E057F20F883E	吴洪兵				866067033419369	2019-04-29 08:49:56	\N
liuyu	E10ADC3949BA59ABBE56E057F20F883E	刘昱			智慧水利	\N	\N	\N
qiujingcheng	E10ADC3949BA59ABBE56E057F20F883E	邱竞诚			智慧水利	008796757866936	2018-11-30 17:19:34	\N
licy	E10ADC3949BA59ABBE56E057F20F883E	李承勇			智慧水利	357052091530238	2019-02-15 10:40:27	\N
wukun	E10ADC3949BA59ABBE56E057F20F883E	吴坤		15189805523	智慧水利	869270023644049	2019-06-12 14:43:38	http://42.123.116.200:8085/image/user/wukun.jpg
luozhongxiang	E10ADC3949BA59ABBE56E057F20F883E	罗忠祥			冉渡滩	\N	\N	\N
chenliyi	E10ADC3949BA59ABBE56E057F20F883E	陈立毅			冉渡滩	\N	\N	\N
tangpeixiong	E10ADC3949BA59ABBE56E057F20F883E	唐培雄			冉渡滩	\N	\N	\N
qsc3	E10ADC3949BA59ABBE56E057F20F883E	青山冲3		15985668896	青山冲	863325037269922	2019-07-02 07:16:11	\N
qsc2	E10ADC3949BA59ABBE56E057F20F883E	青山冲2			青山冲	866790036561750	2019-06-18 09:43:33	\N
wangzhengtao	E10ADC3949BA59ABBE56E057F20F883E	王正韬			智慧水利	869377034918435	2018-08-23 09:55:52	\N
luojianghua	E10ADC3949BA59ABBE56E057F20F883E	罗江华				868977043313311	2019-05-05 12:17:38	\N
qsh	E10ADC3949BA59ABBE56E057F20F883E	清沙河			清沙河	867910034478828	2019-07-07 08:41:30	http://42.123.116.200:8085/image/user/qsh.jpg
shenweiwei	D9578D33A8C4FC21663CC783E2122798	申位伟	345803845@qq.com	15186741432	冉渡滩	861331034952421	2018-08-16 12:14:28	\N
yangxiaobing	E10ADC3949BA59ABBE56E057F20F883E	杨晓兵			智慧水利	866875031854043	2019-05-14 08:35:28	\N
tianxiaolin	E10ADC3949BA59ABBE56E057F20F883E	田小林			智慧水利	869287037390328	2019-05-29 16:37:48	\N
xiangguo	E10ADC3949BA59ABBE56E057F20F883E	向国			冉渡滩	868299035227940	2019-04-14 09:55:42	\N
sunzhengming	EBF0B4C65FAB07D252A2E7101C7C3F0A	孙正明			冉渡滩	\N	\N	\N
denglie	FCA9DA0AAA96706BF685322EF1C72ED3	邓烈			冉渡滩	868299035227940	2019-04-14 10:01:38	\N
tangrongxin	E10ADC3949BA59ABBE56E057F20F883E	唐荣新			智慧水利	\N	\N	\N
wanggennan	E10ADC3949BA59ABBE56E057F20F883E	王根南			智慧水利	\N	\N	\N
qsh4	E10ADC3949BA59ABBE56E057F20F883E	清沙河			清沙河	868060041205233	2019-07-08 10:04:19	\N
liuyuansong	E10ADC3949BA59ABBE56E057F20F883E	刘源松			智慧水利	354730010301806	2018-10-31 11:57:36	\N
songdefu	E10ADC3949BA59ABBE56E057F20F883E	宋德富				\N	\N	\N
zhoujianming	E10ADC3949BA59ABBE56E057F20F883E	周建明				869454039074413	2019-05-20 10:04:51	\N
wangjun	E10ADC3949BA59ABBE56E057F20F883E	王军			智慧水利	\N	\N	\N
qsh2	E10ADC3949BA59ABBE56E057F20F883E	清沙河			清沙河	866654034989241	2019-06-29 06:57:19	\N
lixinchen	E10ADC3949BA59ABBE56E057F20F883E	李昕谌			智慧水利	\N	\N	\N
caochengzhong	E10ADC3949BA59ABBE56E057F20F883E	曹成忠			智慧水利	\N	\N	\N
xurenjiang	E10ADC3949BA59ABBE56E057F20F883E	徐仁江		13608583598	智慧水利	867261031517253	2019-05-21 07:31:55	\N
huangaq	E10ADC3949BA59ABBE56E057F20F883E	黄安琪	630231614@qq.com	15597789360	智慧水利	\N	\N	\N
zhangruixue	E10ADC3949BA59ABBE56E057F20F883E	张瑞雪			智慧水利	666660034193157	2019-05-22 00:30:03	\N
jihongyu	E10ADC3949BA59ABBE56E057F20F883E	吉鸿宇			吊洞水库	869496030600993	2019-05-30 12:44:12	\N
yangmaojiang	E10ADC3949BA59ABBE56E057F20F883E	杨茂江				\N	\N	\N
zhoutao	6AC08B90E462AF045C3FFB183F0D5F07	周涛	736028214@qq.com	15380928016	智慧水利	866158039050314	2018-11-27 11:57:49	\N
maozhibang	E10ADC3949BA59ABBE56E057F20F883E	毛志榜				869096035076783	2019-06-12 15:28:40	\N
songdeyu	E10ADC3949BA59ABBE56E057F20F883E	宋德余			冉渡滩	863716038800873	2019-07-05 08:30:07	\N
qsh1	E10ADC3949BA59ABBE56E057F20F883E	清沙河			清沙河	865888041791023	2019-07-07 10:35:07	\N
zhuxingguang	E10ADC3949BA59ABBE56E057F20F883E	朱兴光				869454030524572	2019-06-01 11:38:49	\N
luozy	E10ADC3949BA59ABBE56E057F20F883E	罗中元		15186659228	智慧水利	869381030478519	2019-06-11 18:35:26	\N
xiangjg	E10ADC3949BA59ABBE56E057F20F883E	向敬光	1991887681@qq.com	18984898929	智慧水利	99000828887706	2019-06-24 10:12:11	http://42.123.116.200:8085/image/user/xiangjg.jpg
HJWSQ	E10ADC3949BA59ABBE56E057F20F883E	黄家湾				867884032836529	2019-07-07 12:14:22	\N
gu	E10ADC3949BA59ABBE56E057F20F883E	顾			吊洞水库	868859046012092	2019-06-15 16:34:41	\N
xusen	E10ADC3949BA59ABBE56E057F20F883E	许森			智慧水利	860751049888339	2019-06-27 09:14:59	\N
xionglin	E10ADC3949BA59ABBE56E057F20F883E	熊林			智慧水利	666660318018666	2019-06-09 21:31:16	\N
qsh3	E10ADC3949BA59ABBE56E057F20F883E	清沙河			清沙河	352709080227440	2019-07-08 07:49:48	\N
dengjuan	E10ADC3949BA59ABBE56E057F20F883E	邓娟		13027819409	智慧水利	864493046995942	2019-06-24 14:03:55	\N
qsc1	E10ADC3949BA59ABBE56E057F20F883E	青山冲1			青山冲	865750033655113	2019-06-28 09:25:16	\N
\.


--
-- Data for Name: d_app_config; Type: TABLE DATA; Schema: b_system; Owner: postgres
--

COPY b_system.d_app_config (pro_id, pro_name, lgtd, lttd, polygon, zoom, client_ip) FROM stdin;
P000801	黄家湾水利枢纽	106.1808330	26.0536110	dfsj:hjwlayers	11	\N
P000680	马岭水库	104.8747220	25.3427780	dfsj:malinlayers	11	\N
P000317	夹岩水利枢纽	104.8850560	27.1610610	dfsj:jiayanlayers	11	\N
P000844	冉渡滩水利枢纽	107.7027780	28.2488890	dfsj:randutangroup	11	\N
P000800	黔中水利枢纽	105.3475222	26.4870000	dfsj:qianzhonglayers	11	\N
P000846	青山冲水库	108.8941600	27.1947200	\N	11	\N
P000847	吊洞水库	107.8233780	26.3094190	\N	11	\N
P000854	清沙河水库	106.7229930	26.9969110	\N	11	\N
\.


--
-- Data for Name: d_appuser_power; Type: TABLE DATA; Schema: b_system; Owner: postgres
--

COPY b_system.d_appuser_power (user_name, pro_id, pro_name, lgtd, lttd, polygon, zoom) FROM stdin;
admin	P000801	黄家湾水利枢纽	106.1808330	26.0536110	dfsj:hjwlayers	11
admin	P000680	马岭水库	104.8747220	25.3427780	dfsj:malinlayers	11
admin	P000800	黔中水利枢纽	104.9666670	26.6666670	dfsj:qianzhonglayers	11
jiayan	P000317	夹岩水利枢纽	104.8850560	27.1610610	dfsj:jiayanlayers	11
admin	P000317	夹岩水利枢纽	104.8850560	27.1610610	dfsj:jiayanlayers	11
admin	P000844	冉渡滩水利枢纽	107.7027780	28.2488890	dfsj:randutangroup	11
qsh1	P000854	\N	\N	\N	\N	\N
qsh	P000854	\N	\N	\N	\N	\N
qsh2	P000854	\N	\N	\N	\N	\N
qsh3	P000854	\N	\N	\N	\N	\N
qsh4	P000854	\N	\N	\N	\N	\N
randt	P000844	\N	\N	\N	\N	\N
HJWSQ	P000801	\N	\N	\N	\N	\N
denglie	P000844	\N	\N	\N	\N	\N
hutianyu	P000844	\N	\N	\N	\N	\N
jiangyong	P000844	\N	\N	\N	\N	\N
liushibang	P000844	\N	\N	\N	\N	\N
luojie	P000844	\N	\N	\N	\N	\N
shenweiwei	P000844	\N	\N	\N	\N	\N
wangao	P000844	\N	\N	\N	\N	\N
qsc1	P000846	\N	\N	\N	\N	\N
qsc3	P000846	\N	\N	\N	\N	\N
qsc2	P000846	\N	\N	\N	\N	\N
tianxiaolin	P000801	\N	\N	\N	\N	\N
tianxiaolin	P000844	\N	\N	\N	\N	\N
tianxiaolin	P000846	\N	\N	\N	\N	\N
xiangguo	P000844	\N	\N	\N	\N	\N
tianxiaolin	P000847	\N	\N	\N	\N	\N
tianxiaolin	P000854	\N	\N	\N	\N	\N
luozy	P000844	\N	\N	\N	\N	\N
maozhibang	P000844	\N	\N	\N	\N	\N
dengjuan	P000847	\N	\N	\N	\N	\N
luozhongxiang	P000844	\N	\N	\N	\N	\N
chenliyi	P000844	\N	\N	\N	\N	\N
songdeyu	P000844	\N	\N	\N	\N	\N
tangpeixiong	P000844	\N	\N	\N	\N	\N
sunzhengming	P000844	\N	\N	\N	\N	\N
zhangruixue	P000844	\N	\N	\N	\N	\N
yangxiaobing	P000844	\N	\N	\N	\N	\N
liuyu	P000844	\N	\N	\N	\N	\N
qiujingcheng	P000844	\N	\N	\N	\N	\N
lixinchen	P000844	\N	\N	\N	\N	\N
xusen	P000844	\N	\N	\N	\N	\N
xionglin	P000844	\N	\N	\N	\N	\N
liujingtao	P000844	\N	\N	\N	\N	\N
wangzhengtao	P000844	\N	\N	\N	\N	\N
wangjun	P000801	\N	\N	\N	\N	\N
wangjun	P000680	\N	\N	\N	\N	\N
wangjun	P000317	\N	\N	\N	\N	\N
wangjun	P000844	\N	\N	\N	\N	\N
wangjun	P000800	\N	\N	\N	\N	\N
tangrongxin	P000801	\N	\N	\N	\N	\N
tangrongxin	P000680	\N	\N	\N	\N	\N
tangrongxin	P000317	\N	\N	\N	\N	\N
tangrongxin	P000844	\N	\N	\N	\N	\N
tangrongxin	P000800	\N	\N	\N	\N	\N
wanggennan	P000801	\N	\N	\N	\N	\N
wanggennan	P000680	\N	\N	\N	\N	\N
wanggennan	P000317	\N	\N	\N	\N	\N
wanggennan	P000844	\N	\N	\N	\N	\N
wanggennan	P000800	\N	\N	\N	\N	\N
liuyuansong	P000801	\N	\N	\N	\N	\N
liuyuansong	P000680	\N	\N	\N	\N	\N
liuyuansong	P000317	\N	\N	\N	\N	\N
liuyuansong	P000844	\N	\N	\N	\N	\N
liuyuansong	P000800	\N	\N	\N	\N	\N
caochengzhong	P000801	\N	\N	\N	\N	\N
caochengzhong	P000680	\N	\N	\N	\N	\N
caochengzhong	P000317	\N	\N	\N	\N	\N
caochengzhong	P000844	\N	\N	\N	\N	\N
caochengzhong	P000800	\N	\N	\N	\N	\N
gaowen	P000801	\N	\N	\N	\N	\N
gaowen	P000680	\N	\N	\N	\N	\N
gaowen	P000317	\N	\N	\N	\N	\N
gaowen	P000844	\N	\N	\N	\N	\N
gaowen	P000800	\N	\N	\N	\N	\N
licy	P000801	\N	\N	\N	\N	\N
licy	P000680	\N	\N	\N	\N	\N
licy	P000317	\N	\N	\N	\N	\N
licy	P000844	\N	\N	\N	\N	\N
licy	P000800	\N	\N	\N	\N	\N
zhoutao	P000801	\N	\N	\N	\N	\N
zhoutao	P000680	\N	\N	\N	\N	\N
zhoutao	P000317	\N	\N	\N	\N	\N
zhoutao	P000844	\N	\N	\N	\N	\N
zhoutao	P000800	\N	\N	\N	\N	\N
zhoutao	P000846	\N	\N	\N	\N	\N
xurenjiang	P000801	\N	\N	\N	\N	\N
xurenjiang	P000680	\N	\N	\N	\N	\N
xurenjiang	P000317	\N	\N	\N	\N	\N
xurenjiang	P000844	\N	\N	\N	\N	\N
xurenjiang	P000800	\N	\N	\N	\N	\N
xurenjiang	P000846	\N	\N	\N	\N	\N
yangmj	P000844	\N	\N	\N	\N	\N
zhuxg	P000844	\N	\N	\N	\N	\N
luojh	P000844	\N	\N	\N	\N	\N
yangmaojiang	P000844	\N	\N	\N	\N	\N
luojinaghua	P000844	\N	\N	\N	\N	\N
wuhongbing	P000844	\N	\N	\N	\N	\N
luojianghua	P000844	\N	\N	\N	\N	\N
zhoujianming	P000844	\N	\N	\N	\N	\N
songdefu	P000844	\N	\N	\N	\N	\N
xiangjg	P000801	\N	\N	\N	\N	\N
xiangjg	P000680	\N	\N	\N	\N	\N
xiangjg	P000317	\N	\N	\N	\N	\N
xiangjg	P000844	\N	\N	\N	\N	\N
xiangjg	P000800	\N	\N	\N	\N	\N
xiangjg	P000846	\N	\N	\N	\N	\N
xiangjg	P000847	\N	\N	\N	\N	\N
gu	P000847	\N	\N	\N	\N	\N
jihongyu	P000847	\N	\N	\N	\N	\N
wukun	P000801	\N	\N	\N	\N	\N
wukun	P000680	\N	\N	\N	\N	\N
wukun	P000317	\N	\N	\N	\N	\N
wukun	P000844	\N	\N	\N	\N	\N
wukun	P000800	\N	\N	\N	\N	\N
wukun	P000846	\N	\N	\N	\N	\N
wukun	P000847	\N	\N	\N	\N	\N
wukun	P000854	\N	\N	\N	\N	\N
zhuxingguang	P000801	\N	\N	\N	\N	\N
zhuxingguang	P000844	\N	\N	\N	\N	\N
zhuxingguang	P000854	\N	\N	\N	\N	\N
\.


--
-- Data for Name: job_group; Type: TABLE DATA; Schema: b_system; Owner: postgres
--

COPY b_system.job_group (id, name, post_duty, qualification_certificate, p_id) FROM stdin;
1	行政负责岗	负责所有行政工作的审查审定	\N	17
2	文员岗	文件管理、会议纪要、劳务人员管理	\N	17
3	车辆管理岗	调度车辆，满足公司用车需要；车辆的维护、保养工作，保持车辆常年整洁和车况良好	\N	17
4	后勤岗	物资管理、保洁与员工三餐	\N	17
5	计划管理岗	采购设备仪器、对外专项维修项目合同	\N	17
6	安全管理岗	负责外来人员管理登记、负责各种突发事件的应急处理工作	\N	17
7	财务管理岗	建立健全会计核算和相关管理制度、编制会计报表	\N	17
8	技术负责岗	负责工程管理科的运行、技术、质量管理工作。	\N	18
9	日常巡查岗	大坝、溢洪道、泵站、上水管、渣场、料场等建筑物的日常巡查工作。	\N	18
10	设备运行岗	按调度指令进行闸门起闭作业、承担闸门及启闭机的日常维护工作；泵站操作、通信设备的运行操作	\N	18
11	水库调度岗	计划、报告总结编制	\N	18
12	监测岗	水情测报系统监测、大坝安全监测。防汛应急预案的编制、安全应急预案编制	\N	18
13	维修养护管理岗	各种建筑物和设备维修管理养护	\N	18
14	应急管理岗	溃坝、火灾、边坡垮塌等事件的处理；防汛应急预案的编制、安全应急预案编制	\N	18
15	总经理岗	\N	\N	17
16	工程部主任岗	\N	\N	18
17	行政部	\N	\N	\N
18	工程部	\N	\N	\N
\.


--
-- Data for Name: menu; Type: TABLE DATA; Schema: b_system; Owner: postgres
--

COPY b_system.menu (menu_id, menu_name, menu_icon, menu_url, "order", parent_id, level) FROM stdin;
1	项目管理	menu-icon fa fa-pencil-square-o	\N	1	0	1
6	数据管理	\N	project/toData	2	1	2
7	站点管理	\N	project/toSite	7	1	2
13	工程管理	\N	res/index	11	1	2
16	用户管理	\N	user/index	14	15	2
17	角色管理	\N	role/index	15	15	2
18	菜单管理	\N	menu/index	16	15	2
20	用户管理	\N	app/user/index	18	19	2
15	系统管理	menu-icon fa fa-cog	\N	13	0	1
19	移动端管理	menu-icon fa fa-comments	\N	17	0	1
8	水位流量	menu-icon fa fa-leaf		3	0	1
9	数据上传	\N	flow/toFlow	8	8	2
10	数据查询	\N	flow/query	9	8	2
14	测站阈值	\N	warn/threshold/index	12	19	2
11	消息推送		index/send	4	19	2
12	数据同步查询	menu-icon fa fa-bar-chart-o	monitor	10	0	1
21	数据查询	\N	wr/query	19	1	2
23	短信审核	\N	sms/index	21	22	2
22	发布管理	menu-icon fa fa-envelope		20	0	1
25	预报发布		report/index	23	24	2
24	水情预报	menu-icon fa fa-bullhorn		22	0	1
26	值班管理		duty/index	24	24	2
\.


--
-- Data for Name: role; Type: TABLE DATA; Schema: b_system; Owner: postgres
--

COPY b_system.role (id, name, rights, add, del, change, query) FROM stdin;
3	移动端管理员	3698562	\N	\N	\N	\N
1	超级管理员	134217666	33554370	134217666	33554370	33554370
4	综合管理员	121130882	16777216	117440512	16777216	16777216
5	水情预报人员	119537666	\N	\N	\N	\N
\.


--
-- Data for Name: s_menu; Type: TABLE DATA; Schema: b_system; Owner: postgres
--

COPY b_system.s_menu (menu_id, menu_name, menu_url, "order", parent_id, pro_id) FROM stdin;
1	水工建筑安全	\N	1	0	P000847
2	防洪度汛	\N	2	0	P000847
3	兴利调度	\N	3	0	P000847
5	标准化管理	\N	5	0	P000847
4	应急指挥	\N	4	0	P000847
6	挡水建筑	\N	6	1	P000847
25	流量计	\N	25	24	P000847
26	一级水泵	\N	26	24	P000847
27	二级水泵	\N	27	24	P000847
28	输配电	\N	28	24	P000847
7	泄水	\N	7	1	P000847
8	供水	\N	8	1	P000847
9	边坡	\N	9	1	P000847
10	金属结构	\N	10	1	P000847
11	现场检查	\N	11	6	P000847
12	环境量	\N	12	6	P000847
13	渗流渗压	\N	13	6	P000847
14	应力应变及温度	\N	14	6	P000847
15	变形	\N	15	6	P000847
16	汛前准备	\N	16	2	P000847
17	水情检测	\N	17	2	P000847
18	洪水预报	\N	18	2	P000847
19	洪水调度	\N	19	2	P000847
29	当前预警	\N	29	4	P000847
30	历史预警	\N	30	4	P000847
31	指挥调度	\N	31	4	P000847
32	预案	\N	32	4	P000847
33	人员管理	\N	33	5	P000847
34	巡查管理	\N	34	5	P000847
35	物资管理	\N	35	5	P000847
36	维修养护	\N	36	5	P000847
37	文档管理	\N	37	5	P000847
38	日常办公管理	\N	38	5	P000847
20	供水调度	\N	20	3	P000847
21	水量分配	\N	21	3	P000847
22	水量统计	\N	22	3	P000847
23	水质管理	\N	23	3	P000847
24	设备管理	\N	24	3	P000847
39	组织架构	\N	39	33	P000847
40	人员信息	\N	40	33	P000847
41	巡查总览	\N	41	34	P000847
42	巡查上报	\N	42	34	P000847
43	巡查统计	\N	43	34	P000847
44	应急物资	\N	44	35	P000847
45	固定物资	\N	45	35	P000847
46	日常维修养护	\N	46	36	P000847
47	年度维修养护	\N	47	36	P000847
\.


--
-- Data for Name: s_menu_temp; Type: TABLE DATA; Schema: b_system; Owner: postgres
--

COPY b_system.s_menu_temp (menu_id, menu_name, menu_url, "order", parent_id, pro_id) FROM stdin;
1	根目录1	\N	1	0	P000847
2	根目录2	\N	2	0	P000847
23	1级目录1	\N	23	1	P000847
40	3级目录	\N	40	2	P000847
39	1级目录2	\N	39	23	P000847
\.


--
-- Data for Name: s_role; Type: TABLE DATA; Schema: b_system; Owner: postgres
--

COPY b_system.s_role (name, rights, add, del, change, query, id) FROM stdin;
巡查管理员	\N	\N	\N	\N	\N	2
超级管理员	558345748480	\N	\N	\N	\N	1
\.


--
-- Data for Name: s_role_menu; Type: TABLE DATA; Schema: b_system; Owner: postgres
--

COPY b_system.s_role_menu (id, s_role_id, s_menu_id) FROM stdin;
1	1	1
2	1	2
3	1	3
4	1	4
5	1	5
7	3	1
6	4	1
7	1	6
\.


--
-- Data for Name: s_user; Type: TABLE DATA; Schema: b_system; Owner: postgres
--

COPY b_system.s_user (login_name, user_name, password, sex, phone, email, role_id, pro_id, id, job_group, major, post, title) FROM stdin;
zhsl	智慧水利	B/RjjlLrJvPzr/iD4lGvNQ==	1	18984898929	-	5	P000847	4	1	12	\N	\N
baozhao	包昭	VcSI2Rs1r9LeuGiS+K370Q==	1	18984898929		1	P000847	3	15	\N	\N	\N
wukun	吴坤	QSDlfIIf6J/094SncJ29Rg==	1	18984898929		4	P000847	5	13	\N	\N	\N
xiangjg	向敬光	SnFKo0gk4qWL2ME1/2kRLg==	1	18984898929		1	P000847	2	13	\N	\N	\N
test1	流程引擎测试	SjJSpe34/KqL3gv8znlWDQ==	\N	18984898929	\N	1	P000847	9	1	\N	\N	\N
test2	流程引擎测试2	gGYOKRA9UltpT0XjTiP0mA==	\N	18984898929	\N	1	P000847	11	16	\N	\N	\N
zhoutao	周涛	pyEUm7jdzLxXrodS2Q/xiA==	1	18984898929		3	P000847	1	15	\N	\N	\N
test3	应急管理岗测试员	7QUVX79PemNzvHw0S+BlvQ==	1	18984898929	\N	1	P000847	12	14	\N	\N	\N
\.


--
-- Data for Name: s_user_role; Type: TABLE DATA; Schema: b_system; Owner: postgres
--

COPY b_system.s_user_role (id, s_user_id, s_role_id) FROM stdin;
1	1	1
\.


--
-- Data for Name: table_desc; Type: TABLE DATA; Schema: b_system; Owner: postgres
--

COPY b_system.table_desc (id, table_id, field, "desc") FROM stdin;
\.


--
-- Data for Name: table_info; Type: TABLE DATA; Schema: b_system; Owner: postgres
--

COPY b_system.table_info (id, schema, "table", "desc") FROM stdin;
1	b_reservoir	b_reservoir_info	水库基本信息表
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: b_system; Owner: postgres
--

COPY b_system."user" (id, login_name, user_name, password, sex, phone, email, role_id) FROM stdin;
2	zhoutao	周涛	pyEUm7jdzLxXrodS2Q/xiA==	1	\N		3
3	xiangjg	向敬光	SnFKo0gk4qWL2ME1/2kRLg==	1	123		1
4	baozhao	包昭	VcSI2Rs1r9LeuGiS+K370Q==	1			1
6	zhsl	智慧水利	B/RjjlLrJvPzr/iD4lGvNQ==	1	-	-	5
5	wukun	吴坤	QSDlfIIf6J/094SncJ29Rg==	1			4
-42	tianxl	田小林	rebP9Ic25lQInnvlpGgGpw==	1	18285164063		3
-41	songdf	宋德富	FR51qY8jOGdgMv828IB+eg==	1			4
\.


--
-- Data for Name: user_group; Type: TABLE DATA; Schema: b_system; Owner: postgres
--

COPY b_system.user_group (user_id, job_group_id) FROM stdin;
9	1
3	16
11	16
1	15
12	14
\.


--
-- Data for Name: sys_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sys_permission (id, description, name, p_id, url) FROM stdin;
1	home	ROLE_HOME	\N	/
2	ABel	ROLE_ADMIN	\N	/admin
\.


--
-- Data for Name: sys_permission_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sys_permission_role (role_id, permission_id, id) FROM stdin;
1	1	1
1	2	2
2	1	3
\.


--
-- Data for Name: sys_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sys_role (id, name) FROM stdin;
1	ROLE_ADMIN
2	ROLE_USER
\.


--
-- Data for Name: sys_role_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sys_role_user (sys_role_id, sys_user_id, id) FROM stdin;
1	1	1
2	2	2
\.


--
-- Data for Name: sys_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sys_user (id, password, user_name) FROM stdin;
1	$2a$10$ddBQ.DqNn/1expfJP9JAOOL3prKp4lPV445/uns33w4jM081QWFuy	admin
2	$2a$10$i.PpEC7w.e3pHDSrvs3ZK.SmnqHhjFbsi8BeLMjlhBX1iGTn7BVcy	abel
\.


--
-- Data for Name: msg; Type: TABLE DATA; Schema: system; Owner: postgres
--

COPY system.msg (title, content, etra_info) FROM stdin;
\.


--
-- Data for Name: system_role; Type: TABLE DATA; Schema: system; Owner: postgres
--

COPY system.system_role (id, name) FROM stdin;
1	ROLE_ADMIN
2	ROLE_USER
\.


--
-- Data for Name: system_user; Type: TABLE DATA; Schema: system; Owner: postgres
--

COPY system.system_user (id, password, user_name) FROM stdin;
1	123456	admin
2	abel	abel
\.


--
-- Name: job_group_id_seq; Type: SEQUENCE SET; Schema: b_system; Owner: postgres
--

SELECT pg_catalog.setval('b_system.job_group_id_seq', 24, true);


--
-- Name: s_role_id_seq; Type: SEQUENCE SET; Schema: b_system; Owner: postgres
--

SELECT pg_catalog.setval('b_system.s_role_id_seq', 3, true);


--
-- Name: s_user_id_seq; Type: SEQUENCE SET; Schema: b_system; Owner: postgres
--

SELECT pg_catalog.setval('b_system.s_user_id_seq', 29, true);


--
-- Name: s_user_id_seq2; Type: SEQUENCE SET; Schema: b_system; Owner: postgres
--

SELECT pg_catalog.setval('b_system.s_user_id_seq2', 16, true);


--
-- Name: seq_menu_id; Type: SEQUENCE SET; Schema: b_system; Owner: postgres
--

SELECT pg_catalog.setval('b_system.seq_menu_id', 48, true);


--
-- Name: seq_role; Type: SEQUENCE SET; Schema: b_system; Owner: postgres
--

SELECT pg_catalog.setval('b_system.seq_role', 6, true);


--
-- Name: seq_user; Type: SEQUENCE SET; Schema: b_system; Owner: postgres
--

SELECT pg_catalog.setval('b_system.seq_user', 19, true);


--
-- Name: table_desc_id_seq; Type: SEQUENCE SET; Schema: b_system; Owner: postgres
--

SELECT pg_catalog.setval('b_system.table_desc_id_seq', 2, false);


--
-- Name: table_info_id_seq; Type: SEQUENCE SET; Schema: b_system; Owner: postgres
--

SELECT pg_catalog.setval('b_system.table_info_id_seq', 2, false);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: b_system; Owner: postgres
--

SELECT pg_catalog.setval('b_system.user_id_seq', 9, true);


--
-- Name: sys_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_permission_id_seq', 2, true);


--
-- Name: sys_permission_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_permission_role_id_seq', 1, false);


--
-- Name: sys_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_role_id_seq', 2, true);


--
-- Name: sys_role_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_role_user_id_seq', 1, false);


--
-- Name: sys_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_user_id_seq', 2, true);


--
-- Name: system_role_id_seq; Type: SEQUENCE SET; Schema: system; Owner: postgres
--

SELECT pg_catalog.setval('system.system_role_id_seq', 1, false);


--
-- Name: system_user_id_seq; Type: SEQUENCE SET; Schema: system; Owner: postgres
--

SELECT pg_catalog.setval('system.system_user_id_seq', 1, false);


--
-- Name: b_user_info b_user_info_pkey; Type: CONSTRAINT; Schema: b_system; Owner: postgres
--

ALTER TABLE ONLY b_system.b_user_info
    ADD CONSTRAINT b_user_info_pkey PRIMARY KEY (user_name);


--
-- Name: d_app_config d_app_config_pkey; Type: CONSTRAINT; Schema: b_system; Owner: postgres
--

ALTER TABLE ONLY b_system.d_app_config
    ADD CONSTRAINT d_app_config_pkey PRIMARY KEY (pro_id);


--
-- Name: d_appuser_power d_appuser_power_pkey; Type: CONSTRAINT; Schema: b_system; Owner: postgres
--

ALTER TABLE ONLY b_system.d_appuser_power
    ADD CONSTRAINT d_appuser_power_pkey PRIMARY KEY (user_name, pro_id);


--
-- Name: job_group job_group2_pkey; Type: CONSTRAINT; Schema: b_system; Owner: postgres
--

ALTER TABLE ONLY b_system.job_group
    ADD CONSTRAINT job_group2_pkey PRIMARY KEY (id);


--
-- Name: s_user login_name_ unique; Type: CONSTRAINT; Schema: b_system; Owner: postgres
--

ALTER TABLE ONLY b_system.s_user
    ADD CONSTRAINT "login_name_ unique" UNIQUE (login_name);


--
-- Name: s_menu menu_copy_pkey; Type: CONSTRAINT; Schema: b_system; Owner: postgres
--

ALTER TABLE ONLY b_system.s_menu
    ADD CONSTRAINT menu_copy_pkey PRIMARY KEY (menu_id);


--
-- Name: menu menu_pkey; Type: CONSTRAINT; Schema: b_system; Owner: postgres
--

ALTER TABLE ONLY b_system.menu
    ADD CONSTRAINT menu_pkey PRIMARY KEY (menu_id);


--
-- Name: s_role role_copy_pkey; Type: CONSTRAINT; Schema: b_system; Owner: postgres
--

ALTER TABLE ONLY b_system.s_role
    ADD CONSTRAINT role_copy_pkey PRIMARY KEY (id);


--
-- Name: role role_pkey; Type: CONSTRAINT; Schema: b_system; Owner: postgres
--

ALTER TABLE ONLY b_system.role
    ADD CONSTRAINT role_pkey PRIMARY KEY (id);


--
-- Name: s_menu_temp s_menu_copy_pkey; Type: CONSTRAINT; Schema: b_system; Owner: postgres
--

ALTER TABLE ONLY b_system.s_menu_temp
    ADD CONSTRAINT s_menu_copy_pkey PRIMARY KEY (menu_id);


--
-- Name: table_desc table_desc_pkey; Type: CONSTRAINT; Schema: b_system; Owner: postgres
--

ALTER TABLE ONLY b_system.table_desc
    ADD CONSTRAINT table_desc_pkey PRIMARY KEY (id);


--
-- Name: table_info table_info_pkey; Type: CONSTRAINT; Schema: b_system; Owner: postgres
--

ALTER TABLE ONLY b_system.table_info
    ADD CONSTRAINT table_info_pkey PRIMARY KEY (id);


--
-- Name: s_user user_copy_pkey; Type: CONSTRAINT; Schema: b_system; Owner: postgres
--

ALTER TABLE ONLY b_system.s_user
    ADD CONSTRAINT user_copy_pkey PRIMARY KEY (id);


--
-- Name: user_group user_group_pkey; Type: CONSTRAINT; Schema: b_system; Owner: postgres
--

ALTER TABLE ONLY b_system.user_group
    ADD CONSTRAINT user_group_pkey PRIMARY KEY (user_id, job_group_id);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: b_system; Owner: postgres
--

ALTER TABLE ONLY b_system."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: sys_permission sys_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_permission
    ADD CONSTRAINT sys_permission_pkey PRIMARY KEY (id);


--
-- Name: sys_permission_role sys_permission_role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_permission_role
    ADD CONSTRAINT sys_permission_role_pkey PRIMARY KEY (id);


--
-- Name: sys_role sys_role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_role
    ADD CONSTRAINT sys_role_pkey PRIMARY KEY (id);


--
-- Name: sys_role_user sys_role_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_role_user
    ADD CONSTRAINT sys_role_user_pkey PRIMARY KEY (id);


--
-- Name: sys_user sys_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_user
    ADD CONSTRAINT sys_user_pkey PRIMARY KEY (id);


--
-- Name: msg msg_pkey; Type: CONSTRAINT; Schema: system; Owner: postgres
--

ALTER TABLE ONLY system.msg
    ADD CONSTRAINT msg_pkey PRIMARY KEY (title);


--
-- Name: system_role system_role_pkey; Type: CONSTRAINT; Schema: system; Owner: postgres
--

ALTER TABLE ONLY system.system_role
    ADD CONSTRAINT system_role_pkey PRIMARY KEY (id);


--
-- Name: system_user system_user_pkey; Type: CONSTRAINT; Schema: system; Owner: postgres
--

ALTER TABLE ONLY system.system_user
    ADD CONSTRAINT system_user_pkey PRIMARY KEY (id);


--
-- Name: job_group fn_delete_act_id_group; Type: TRIGGER; Schema: b_system; Owner: postgres
--

CREATE TRIGGER fn_delete_act_id_group AFTER DELETE ON b_system.job_group FOR EACH ROW EXECUTE PROCEDURE b_system.delete_act_id_group();


--
-- Name: s_user fn_delete_act_id_shipment; Type: TRIGGER; Schema: b_system; Owner: postgres
--

CREATE TRIGGER fn_delete_act_id_shipment AFTER DELETE ON b_system.s_user FOR EACH ROW EXECUTE PROCEDURE b_system.delete_act_id_shipment();


--
-- Name: s_user fn_insert_s_user_activiti; Type: TRIGGER; Schema: b_system; Owner: postgres
--

CREATE TRIGGER fn_insert_s_user_activiti AFTER INSERT ON b_system.s_user FOR EACH ROW EXECUTE PROCEDURE b_system.insert_s_user_activiti();


--
-- Name: job_group insert_act_id_group; Type: TRIGGER; Schema: b_system; Owner: postgres
--

CREATE TRIGGER insert_act_id_group AFTER INSERT ON b_system.job_group FOR EACH ROW EXECUTE PROCEDURE b_system.insert_act_id_group();


--
-- Name: user_group insert_id_membership_activiti; Type: TRIGGER; Schema: b_system; Owner: postgres
--

CREATE TRIGGER insert_id_membership_activiti AFTER INSERT ON b_system.user_group FOR EACH ROW EXECUTE PROCEDURE b_system.insert_id_membership_activiti();


--
-- Name: sys_permission_role fk1db5xvu0eeo36h9wnu71awtun; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_permission_role
    ADD CONSTRAINT fk1db5xvu0eeo36h9wnu71awtun FOREIGN KEY (permission_id) REFERENCES public.sys_permission(id);


--
-- Name: sys_permission_role fkj7dnbgvr47c4nvns9yb9bdrfd; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_permission_role
    ADD CONSTRAINT fkj7dnbgvr47c4nvns9yb9bdrfd FOREIGN KEY (role_id) REFERENCES public.sys_role(id);


--
-- Name: sys_role_user fkovs1cuexw8w3lvyx65tra8yvj; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_role_user
    ADD CONSTRAINT fkovs1cuexw8w3lvyx65tra8yvj FOREIGN KEY (sys_user_id) REFERENCES public.sys_role(id);


--
-- Name: sys_role_user fkp8hel7ccbfbievuyplprchcjl; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_role_user
    ADD CONSTRAINT fkp8hel7ccbfbievuyplprchcjl FOREIGN KEY (sys_role_id) REFERENCES public.sys_user(id);


--
-- PostgreSQL database dump complete
--


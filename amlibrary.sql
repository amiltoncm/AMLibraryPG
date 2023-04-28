-- SQL Manager Lite for PostgreSQL 6.1.2.53864
-- ---------------------------------------
-- Host      : localhost:5433
-- Database  : amlibrary
-- Version   : PostgreSQL 14.2, compiled by Visual C++ build 1914, 64-bit



SET check_function_bodies = false;
--
-- Definition for procedure updatecopys (OID = 33558) : 
--
SET search_path = public, pg_catalog;
CREATE PROCEDURE public.updatecopys (
  book_id_p integer
) 
AS 
$body$
DECLARE
  nome_w			VARCHAR;
  autorId_w			INTEGER;
  edicao_w			INTEGER;
  barcode_w			VARCHAR;
  isbn_w			VARCHAR;
  editoraId_w		INTEGER;
  materiaId_w		INTEGER;
  sinopse_w			VARCHAR;
  imagem_w			VARCHAR;
  localizacaoId_w	INTEGER;
  ensinoId_w		INTEGER;
BEGIN
  SELECT liv_nome,
         aut_id,
         liv_edicao,
         liv_barcode,
         liv_isbn,
         edt_id,
         mat_id,
         liv_sinopse,
         liv_imagem,
         loc_id,
         ens_id
  INTO   nome_w,
  		 autorId_w,
  		 edicao_w,
  		 barcode_w,
  		 isbn_w,
         editoraId_w,
  		 materiaId_w,
  		 sinopse_w,
  		 imagem_w,
  		 localizacaoId_w,
  		 ensinoId_w
  FROM livros
  WHERE liv_id = book_id_p;
  
  UPDATE livros
  SET    liv_nome = nome_w,
         aut_id = autorId_w,
         liv_edicao = edicao_w,
         liv_isbn = isbn_w,
         edt_id = editoraId_w,
         mat_id = materiaId_w,
         liv_sinopse = sinopse_w,
         liv_imagem = imagem_w,
         loc_id = localizacaoId_w,
         ens_id = ensinoId_w
  WHERE  liv_barcode = barcode_w; 
  
END;
$body$
LANGUAGE plpgsql;
--
-- Structure for table usuarios (OID = 25193) : 
--
CREATE TABLE public.usuarios (
    usu_id bigint DEFAULT nextval('user_usu_id_seq'::regclass) NOT NULL,
    usu_nome varchar(25) NOT NULL,
    usu_senha varchar(128) NOT NULL,
    ace_codigo integer DEFAULT 1 NOT NULL,
    usu_status integer DEFAULT 1 NOT NULL
)
WITH (oids = false);
--
-- Structure for table materias (OID = 25216) : 
--
CREATE TABLE public.materias (
    mat_id integer DEFAULT nextval('materia_mat_id_seq'::regclass) NOT NULL,
    mat_descricao varchar(25) NOT NULL,
    mat_abreviacao char(3) NOT NULL
)
WITH (oids = false);
--
-- Structure for table editoras (OID = 25223) : 
--
CREATE TABLE public.editoras (
    edt_id integer DEFAULT nextval('editora_edt_id_seq'::regclass) NOT NULL,
    edt_nome varchar(25) NOT NULL
)
WITH (oids = false);
--
-- Structure for table professores (OID = 25248) : 
--
CREATE TABLE public.professores (
    prf_id bigint DEFAULT nextval(('public.professor_prf_id_seq'::text)::regclass) NOT NULL,
    prf_nome varchar(50) NOT NULL,
    mat_id integer NOT NULL,
    prf_status integer DEFAULT 1 NOT NULL
)
WITH (oids = false);
--
-- Definition for sequence professor_prf_id_seq (OID = 25259) : 
--
CREATE SEQUENCE public.professor_prf_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
--
-- Structure for table alunos (OID = 25287) : 
--
CREATE TABLE public.alunos (
    alu_id bigserial NOT NULL,
    alu_nome varchar(50) NOT NULL,
    alu_matricula varchar(20),
    ano_id integer NOT NULL,
    alu_status integer DEFAULT 1 NOT NULL
)
WITH (oids = false);
--
-- Structure for table autores (OID = 25392) : 
--
CREATE TABLE public.autores (
    aut_id bigint DEFAULT nextval(('public.autores_aut_id_seq'::text)::regclass) NOT NULL,
    aut_nome varchar(50) NOT NULL,
    aut_status integer DEFAULT 1 NOT NULL
)
WITH (oids = false);
--
-- Definition for sequence autores_aut_id_seq (OID = 25432) : 
--
CREATE SEQUENCE public.autores_aut_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
--
-- Structure for table localizacao (OID = 25447) : 
--
CREATE TABLE public.localizacao (
    loc_id integer DEFAULT nextval(('public.localizacao_loc_codigo_seq'::text)::regclass) NOT NULL,
    loc_descricao varchar(25) NOT NULL
)
WITH (oids = false);
--
-- Definition for sequence localizacao_loc_codigo_seq (OID = 25497) : 
--
CREATE SEQUENCE public.localizacao_loc_codigo_seq
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 2147483647
    NO MINVALUE
    CACHE 1;
--
-- Definition for sequence classificacao_cla_id_seq (OID = 25506) : 
--
CREATE SEQUENCE public.classificacao_cla_id_seq
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 2147483647
    NO MINVALUE
    CACHE 1;
--
-- Structure for table periodos (OID = 25520) : 
--
CREATE TABLE public.periodos (
    per_id char(1) NOT NULL,
    per_aux integer DEFAULT 0 NOT NULL,
    per_descricao varchar(10) NOT NULL
)
WITH (oids = false);
--
-- Structure for table empresa (OID = 25537) : 
--
CREATE TABLE public.empresa (
    emp_codigo integer DEFAULT nextval(('public.empresa_emp_codigo_seq'::text)::regclass) NOT NULL,
    emp_razao varchar(50) NOT NULL,
    emp_fantasia varchar(50) NOT NULL,
    emp_cnpj char(18) NOT NULL,
    emp_ie char(15) NOT NULL,
    emp_imun char(10) NOT NULL,
    emp_logradouro varchar(50) NOT NULL,
    emp_numero integer NOT NULL,
    emp_complemento varchar(15),
    emp_bairro varchar(30) NOT NULL,
    emp_cidade varchar(50) NOT NULL,
    emp_uf char(2) NOT NULL,
    emp_cep char(9) NOT NULL,
    emp_fone varchar(15) NOT NULL,
    emp_email varchar(50) NOT NULL,
    emp_homepage varchar(50)
)
WITH (oids = false);
--
-- Definition for sequence empresa_emp_codigo_seq (OID = 25542) : 
--
CREATE SEQUENCE public.empresa_emp_codigo_seq
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 2147483647
    NO MINVALUE
    CACHE 1;
--
-- Structure for table acesso (OID = 25547) : 
--
CREATE TABLE public.acesso (
    ace_codigo serial NOT NULL,
    ace_descricao varchar(15) NOT NULL
)
WITH (oids = false);
--
-- Structure for table ensino (OID = 33396) : 
--
CREATE TABLE public.ensino (
    ens_id integer DEFAULT nextval(('public.ensino_ens_id_seq'::text)::regclass) NOT NULL,
    ens_descricao varchar(15) NOT NULL
)
WITH (oids = false);
--
-- Structure for table anos (OID = 33406) : 
--
CREATE TABLE public.anos (
    ano_id serial NOT NULL,
    ano_ano integer NOT NULL,
    ens_id integer NOT NULL,
    per_id char(1) NOT NULL,
    ano_sala varchar(10) NOT NULL,
    ano_status integer DEFAULT 1 NOT NULL
)
WITH (oids = false);
--
-- Structure for table livros (OID = 33435) : 
--
CREATE TABLE public.livros (
    liv_id bigserial NOT NULL,
    liv_copia bigint DEFAULT 1 NOT NULL,
    liv_nome varchar(50) NOT NULL,
    aut_id bigint NOT NULL,
    liv_edicao integer NOT NULL,
    liv_barcode char(13) NOT NULL,
    liv_isbn varchar(17),
    edt_id integer NOT NULL,
    mat_id integer NOT NULL,
    liv_sinopse varchar(512),
    liv_imagem varchar(512),
    loc_id integer NOT NULL,
    ens_id integer DEFAULT 0 NOT NULL,
    liv_status integer DEFAULT 1 NOT NULL
)
WITH (oids = false);
--
-- Structure for table config (OID = 33475) : 
--
CREATE TABLE public.config (
    cfg_id integer NOT NULL,
    cfg_diasemp integer DEFAULT 1 NOT NULL,
    cfg_usebarcode integer DEFAULT 0 NOT NULL,
    cfg_emprestimos integer DEFAULT 1 NOT NULL,
    cfg_libcomatras integer DEFAULT 0 NOT NULL
)
WITH (oids = false);
--
-- Structure for table emprestimo (OID = 33482) : 
--
CREATE TABLE public.emprestimo (
    emm_id integer NOT NULL,
    emm_data date NOT NULL,
    alu_id bigint,
    prf_id bigint
)
WITH (oids = false);
--
-- Structure for table emprestimos (OID = 33503) : 
--
CREATE TABLE public.emprestimos (
    emp_id bigserial NOT NULL,
    emm_id integer NOT NULL,
    emp_data date NOT NULL,
    emp_devprevista date NOT NULL,
    emp_devolucao date,
    alu_id bigint,
    prf_id bigint,
    liv_id bigint NOT NULL,
    usu_emp integer DEFAULT 0 NOT NULL,
    usu_dev integer
)
WITH (oids = false);
--
-- Definition for sequence ensino_ens_id_seq (OID = 33529) : 
--
CREATE SEQUENCE public.ensino_ens_id_seq
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 2147483647
    NO MINVALUE
    CACHE 1;
--
-- Definition for index idx_alu_nome (OID = 25299) : 
--
CREATE INDEX idx_alu_nome ON public.alunos USING btree (alu_nome);
--
-- Definition for index idx_edt_nome (OID = 25302) : 
--
CREATE INDEX idx_edt_nome ON public.editoras USING btree (edt_nome);
--
-- Definition for index idx_mat_descricao (OID = 25318) : 
--
CREATE INDEX idx_mat_descricao ON public.materias USING btree (mat_descricao);
--
-- Definition for index idx_prf_nome (OID = 25320) : 
--
CREATE INDEX idx_prf_nome ON public.professores USING btree (prf_nome);
--
-- Definition for index idx_aut_nome (OID = 25398) : 
--
CREATE INDEX idx_aut_nome ON public.autores USING btree (aut_nome);
--
-- Definition for index idx_loc_descricao (OID = 25453) : 
--
CREATE INDEX idx_loc_descricao ON public.localizacao USING btree (loc_descricao);
--
-- Definition for index idx_per_descricao (OID = 25526) : 
--
CREATE INDEX idx_per_descricao ON public.periodos USING btree (per_descricao);
--
-- Definition for index idx_ens_descricao (OID = 33401) : 
--
CREATE INDEX idx_ens_descricao ON public.ensino USING btree (ens_descricao);
--
-- Definition for index idx_liv_copia_nome_edicao (OID = 33464) : 
--
CREATE INDEX idx_liv_copia_nome_edicao ON public.livros USING btree (liv_copia, liv_nome, liv_edicao);
--
-- Definition for index pk_user (OID = 25199) : 
--
ALTER TABLE ONLY usuarios
    ADD CONSTRAINT pk_user
    PRIMARY KEY (usu_id);
--
-- Definition for index unq_usu_name (OID = 25201) : 
--
ALTER TABLE ONLY usuarios
    ADD CONSTRAINT unq_usu_name
    UNIQUE (usu_nome);
--
-- Definition for index pk_materia (OID = 25220) : 
--
ALTER TABLE ONLY materias
    ADD CONSTRAINT pk_materia
    PRIMARY KEY (mat_id);
--
-- Definition for index pk_editora (OID = 25227) : 
--
ALTER TABLE ONLY editoras
    ADD CONSTRAINT pk_editora
    PRIMARY KEY (edt_id);
--
-- Definition for index fk_prf_mat_id (OID = 25254) : 
--
ALTER TABLE ONLY professores
    ADD CONSTRAINT fk_prf_mat_id
    FOREIGN KEY (mat_id) REFERENCES materias(mat_id);
--
-- Definition for index pk_professor (OID = 25260) : 
--
ALTER TABLE ONLY professores
    ADD CONSTRAINT pk_professor
    PRIMARY KEY (prf_id);
--
-- Definition for index pk_alunos (OID = 25292) : 
--
ALTER TABLE ONLY alunos
    ADD CONSTRAINT pk_alunos
    PRIMARY KEY (alu_id);
--
-- Definition for index pk_autores (OID = 25433) : 
--
ALTER TABLE ONLY autores
    ADD CONSTRAINT pk_autores
    PRIMARY KEY (aut_id);
--
-- Definition for index pk_localizacao (OID = 25498) : 
--
ALTER TABLE ONLY localizacao
    ADD CONSTRAINT pk_localizacao
    PRIMARY KEY (loc_id);
--
-- Definition for index pk_periodo (OID = 25524) : 
--
ALTER TABLE ONLY periodos
    ADD CONSTRAINT pk_periodo
    PRIMARY KEY (per_id);
--
-- Definition for index pk_empresa (OID = 25543) : 
--
ALTER TABLE ONLY empresa
    ADD CONSTRAINT pk_empresa
    PRIMARY KEY (emp_codigo);
--
-- Definition for index pk_acesso (OID = 25551) : 
--
ALTER TABLE ONLY acesso
    ADD CONSTRAINT pk_acesso
    PRIMARY KEY (ace_codigo);
--
-- Definition for index fk_usu_ace_codigo (OID = 25553) : 
--
ALTER TABLE ONLY usuarios
    ADD CONSTRAINT fk_usu_ace_codigo
    FOREIGN KEY (ace_codigo) REFERENCES acesso(ace_codigo);
--
-- Definition for index pk_ano (OID = 33411) : 
--
ALTER TABLE ONLY anos
    ADD CONSTRAINT pk_ano
    PRIMARY KEY (ano_id);
--
-- Definition for index fk_ano_per_id (OID = 33413) : 
--
ALTER TABLE ONLY anos
    ADD CONSTRAINT fk_ano_per_id
    FOREIGN KEY (per_id) REFERENCES periodos(per_id);
--
-- Definition for index fk_alu_ano_id (OID = 33418) : 
--
ALTER TABLE ONLY alunos
    ADD CONSTRAINT fk_alu_ano_id
    FOREIGN KEY (ano_id) REFERENCES anos(ano_id);
--
-- Definition for index pk_livros (OID = 33442) : 
--
ALTER TABLE ONLY livros
    ADD CONSTRAINT pk_livros
    PRIMARY KEY (liv_id);
--
-- Definition for index fk_liv_aut_id (OID = 33444) : 
--
ALTER TABLE ONLY livros
    ADD CONSTRAINT fk_liv_aut_id
    FOREIGN KEY (aut_id) REFERENCES autores(aut_id);
--
-- Definition for index fk_liv_edt_id (OID = 33449) : 
--
ALTER TABLE ONLY livros
    ADD CONSTRAINT fk_liv_edt_id
    FOREIGN KEY (edt_id) REFERENCES editoras(edt_id);
--
-- Definition for index fk_liv_loc_id (OID = 33454) : 
--
ALTER TABLE ONLY livros
    ADD CONSTRAINT fk_liv_loc_id
    FOREIGN KEY (loc_id) REFERENCES localizacao(loc_id);
--
-- Definition for index fk_liv_mat_id (OID = 33459) : 
--
ALTER TABLE ONLY livros
    ADD CONSTRAINT fk_liv_mat_id
    FOREIGN KEY (mat_id) REFERENCES materias(mat_id);
--
-- Definition for index pk_config (OID = 33479) : 
--
ALTER TABLE ONLY config
    ADD CONSTRAINT pk_config
    PRIMARY KEY (cfg_id);
--
-- Definition for index pk_emprestimo (OID = 33485) : 
--
ALTER TABLE ONLY emprestimo
    ADD CONSTRAINT pk_emprestimo
    PRIMARY KEY (emm_id);
--
-- Definition for index fk_emm_alu_id (OID = 33487) : 
--
ALTER TABLE ONLY emprestimo
    ADD CONSTRAINT fk_emm_alu_id
    FOREIGN KEY (alu_id) REFERENCES alunos(alu_id);
--
-- Definition for index fk_emm_prf_id (OID = 33492) : 
--
ALTER TABLE ONLY emprestimo
    ADD CONSTRAINT fk_emm_prf_id
    FOREIGN KEY (prf_id) REFERENCES professores(prf_id) DEFERRABLE;
--
-- Definition for index pk_emprestimos (OID = 33507) : 
--
ALTER TABLE ONLY emprestimos
    ADD CONSTRAINT pk_emprestimos
    PRIMARY KEY (emp_id);
--
-- Definition for index fk_emp_alu_id (OID = 33509) : 
--
ALTER TABLE ONLY emprestimos
    ADD CONSTRAINT fk_emp_alu_id
    FOREIGN KEY (alu_id) REFERENCES alunos(alu_id);
--
-- Definition for index fk_emp_liv_id (OID = 33514) : 
--
ALTER TABLE ONLY emprestimos
    ADD CONSTRAINT fk_emp_liv_id
    FOREIGN KEY (liv_id) REFERENCES livros(liv_id);
--
-- Definition for index fk_emp_prf_id (OID = 33519) : 
--
ALTER TABLE ONLY emprestimos
    ADD CONSTRAINT fk_emp_prf_id
    FOREIGN KEY (prf_id) REFERENCES professores(prf_id);
--
-- Definition for index fk_emp_emm_id (OID = 33524) : 
--
ALTER TABLE ONLY emprestimos
    ADD CONSTRAINT fk_emp_emm_id
    FOREIGN KEY (emm_id) REFERENCES emprestimo(emm_id);
--
-- Definition for index pk_ensino (OID = 33530) : 
--
ALTER TABLE ONLY ensino
    ADD CONSTRAINT pk_ensino
    PRIMARY KEY (ens_id);
--
-- Definition for index fk_ano_ens_id (OID = 33532) : 
--
ALTER TABLE ONLY anos
    ADD CONSTRAINT fk_ano_ens_id
    FOREIGN KEY (ens_id) REFERENCES ensino(ens_id);
--
-- Definition for index fk_liv_ens_id (OID = 33537) : 
--
ALTER TABLE ONLY livros
    ADD CONSTRAINT fk_liv_ens_id
    FOREIGN KEY (ens_id) REFERENCES ensino(ens_id);
--
-- Definition for index fk_emp_usu_dev (OID = 33544) : 
--
ALTER TABLE ONLY emprestimos
    ADD CONSTRAINT fk_emp_usu_dev
    FOREIGN KEY (usu_dev) REFERENCES usuarios(usu_id);
--
-- Definition for index fk_emp_usu_emp (OID = 33549) : 
--
ALTER TABLE ONLY emprestimos
    ADD CONSTRAINT fk_emp_usu_emp
    FOREIGN KEY (usu_emp) REFERENCES usuarios(usu_id);
--
-- Comments
--
COMMENT ON SCHEMA public IS 'standard public schema';
COMMENT ON COLUMN public.config.cfg_diasemp IS 'Dias para devolucao';
COMMENT ON COLUMN public.config.cfg_libcomatras IS 'Libera empréstimo com livro em atraso';

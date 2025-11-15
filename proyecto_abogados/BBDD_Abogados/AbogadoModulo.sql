/*==============================================================*/
/* DBMS name:      ORACLE Version 12c                           */
/* Created on:     13/11/2025 9:09:33 p.m.                     */
/*==============================================================*/


alter table ABOGADOESPEFK
   drop constraint FK_ABOGADOE_ABOGADOES_ABOGADO;

alter table ABOGADOESPEFK
   drop constraint FK_ABOGADOE_ABOGADOES_ESPECIAL;

alter table CASO
   drop constraint FK_CASO_CODCLIENT_CLIENTE;

alter table CASO
   drop constraint FK_CASO_ESPECASOF_ESPECIAL;

alter table CLIENTE
   drop constraint FK_CLIENTE_IDTIPODOC_TIPODOCU;

alter table CONTACTO
   drop constraint FK_CONTACTO_CODCLIENT_CLIENTE;

alter table CONTACTO
   drop constraint FK_CONTACTO_IDTIPOCON_TIPOCONT;

alter table DOCUMENTO
   drop constraint FK_DOCUMENT_EXPEDIENT_EXPEDIEN;

alter table ESPECIA_ETAPA
   drop constraint FK_ESPECIA__ETAPAPROC_ETAPAPRO;

alter table ESPECIA_ETAPA
   drop constraint FK_ESPECIA__RELATIONS_INSTANCI;

alter table ESPECIA_ETAPA
   drop constraint FK_ESPECIA__RELATIONS_ESPECIAL;

alter table ESPECIA_ETAPA
   drop constraint FK_ESPECIA__RELATIONS_IMPUGNAC;

alter table EXPEDIENTE
   drop constraint FK_EXPEDIEN_CODLUGARF_LUGAR;

alter table EXPEDIENTE
   drop constraint FK_EXPEDIEN_ESPETAPAE_ESPECIA_;

alter table EXPEDIENTE
   drop constraint FK_EXPEDIEN_NCASOFK_CASO;

alter table EXPEDIENTE
   drop constraint FK_EXPEDIEN_RELATIONS_ABOGADO;

alter table LUGAR
   drop constraint FK_LUGAR_CODLUGARS_LUGAR;

alter table LUGAR
   drop constraint FK_LUGAR_IDTIPOLUG_TIPOLUGA;

alter table PAGO
   drop constraint FK_PAGO_CODFRANQF_FRANQUIC;

alter table PAGO
   drop constraint FK_PAGO_FORMAPAGO_FORMAPAG;

alter table RESULTADO
   drop constraint FK_RESULTAD_RELATIONS_EXPEDIEN;

alter table SUCESO
   drop constraint FK_SUCESO_EXPEDIENT_EXPEDIEN;

drop table ABOGADO cascade constraints;

drop index ABOGADOESPEFK_FK2;

drop index ABOGADOESPEFK_FK;

drop table ABOGADOESPEFK cascade constraints;

drop index ESPECASOFK_FK;

drop index CODCLIENTEFK_FK2;

drop table CASO cascade constraints;

drop index IDTIPODOCFK_FK;

drop table CLIENTE cascade constraints;

drop index CODCLIENTEFK_FK;

drop index IDTIPOCONTACTOFK_FK;

drop table CONTACTO cascade constraints;

drop index EXPEDIENTEDOCFK_FK;

drop table DOCUMENTO cascade constraints;

drop table ESPECIALIZACION cascade constraints;

drop index RELATIONSHIP_22_FK;

drop index RELATIONSHIP_21_FK;

drop index INSTFK_FK;

drop index ETAPAPROCEFK_FK;

drop table ESPECIA_ETAPA cascade constraints;

drop table ETAPAPROCESAL cascade constraints;

drop index RELATIONSHIP_20_FK;

drop index NCASOFK_FK;

drop index ESPETAPAEXPFK_FK;

drop index CODLUGARFK_FK;

drop table EXPEDIENTE cascade constraints;

drop table FORMAPAGO cascade constraints;

drop table FRANQUICIA cascade constraints;

drop table IMPUGNACION cascade constraints;

drop table INSTANCIA cascade constraints;

drop index CODLUGARSUPFK_FK;

drop index IDTIPOLUGARFK_FK;

drop table LUGAR cascade constraints;

drop index CODFRANQFK_FK;

drop index FORMAPAGOFK_FK;

drop table PAGO cascade constraints;

drop index RELATIONSHIP_19_FK;

drop table RESULTADO cascade constraints;

drop index EXPEDIENTESUCESOFK_FK;

drop table SUCESO cascade constraints;

drop table TIPOCONTACT cascade constraints;

drop table TIPODOCUMENTO cascade constraints;

drop table TIPOLUGAR cascade constraints;

/*==============================================================*/
/* Table: ABOGADO                                               */
/*==============================================================*/
create table ABOGADO (
   CEDULA               VARCHAR2(10)          not null,
   NOMBRE               VARCHAR2(30),
   APELLIDO             VARCHAR2(30),
   NTARJETAPROFESIONAL  VARCHAR2(5),
   constraint PK_ABOGADO primary key (CEDULA)
);

/*==============================================================*/
/* Table: ABOGADOESPEFK                                         */
/*==============================================================*/
create table ABOGADOESPEFK (
   CODESPECIALIZACION   VARCHAR2(3)           not null,
   CEDULA               VARCHAR2(10)          not null,
   constraint PK_ABOGADOESPEFK primary key (CODESPECIALIZACION, CEDULA)
);

/*==============================================================*/
/* Index: ABOGADOESPEFK_FK                                      */
/*==============================================================*/
create index ABOGADOESPEFK_FK on ABOGADOESPEFK (
   CODESPECIALIZACION ASC
);

/*==============================================================*/
/* Index: ABOGADOESPEFK_FK2                                     */
/*==============================================================*/
create index ABOGADOESPEFK_FK2 on ABOGADOESPEFK (
   CEDULA ASC
);

/*==============================================================*/
/* Table: CASO                                                  */
/*==============================================================*/
create table CASO (
   NOCASO               INTEGER               not null,
   CODESPECIALIZACION   VARCHAR2(3)           not null,
   CODCLIENTE           VARCHAR2(5)           not null,
   FECHAINICIO          DATE,
   FECHAFIN             DATE,
   VALOR                VARCHAR2(10),
   constraint PK_CASO primary key (NOCASO)
);

/*==============================================================*/
/* Index: CODCLIENTEFK_FK2                                      */
/*==============================================================*/
create index CODCLIENTEFK_FK2 on CASO (
   CODCLIENTE ASC
);

/*==============================================================*/
/* Index: ESPECASOFK_FK                                         */
/*==============================================================*/
create index ESPECASOFK_FK on CASO (
   CODESPECIALIZACION ASC
);

/*==============================================================*/
/* Table: CLIENTE                                               */
/*==============================================================*/
create table CLIENTE (
   CODCLIENTE           VARCHAR2(5)           not null,
   IDTIPODOC            VARCHAR2(2)           not null,
   NOMCLIENTE           VARCHAR2(30),
   APELCLIENTE          VARCHAR2(30),
   NDOCUMENTO           VARCHAR2(15),
   constraint PK_CLIENTE primary key (CODCLIENTE)
);

/*==============================================================*/
/* Index: IDTIPODOCFK_FK                                        */
/*==============================================================*/
create index IDTIPODOCFK_FK on CLIENTE (
   IDTIPODOC ASC
);

/*==============================================================*/
/* Table: CONTACTO                                              */
/*==============================================================*/
create table CONTACTO (
   CODCLIENTE           VARCHAR2(5)           not null,
   CONSECONTACTO        INTEGER               not null,
   IDTIPOCONTA          VARCHAR2(3)           not null,
   VALORCONTACTO        VARCHAR2(50),
   NOTIFICACION         BOOLEAN,
   constraint PK_CONTACTO primary key (CODCLIENTE, CONSECONTACTO)
);

/*==============================================================*/
/* Index: IDTIPOCONTACTOFK_FK                                   */
/*==============================================================*/
create index IDTIPOCONTACTOFK_FK on CONTACTO (
   IDTIPOCONTA ASC
);

/*==============================================================*/
/* Index: CODCLIENTEFK_FK                                       */
/*==============================================================*/
create index CODCLIENTEFK_FK on CONTACTO (
   CODCLIENTE ASC
);

/*==============================================================*/
/* Table: DOCUMENTO                                             */
/*==============================================================*/
create table DOCUMENTO (
   CODESPECIALIZACION   VARCHAR2(3)           not null,
   PASOETAPA            INTEGER               not null,
   NOCASO               INTEGER               not null,
   CONSECEXPE           INTEGER               not null,
   CONDOC               INTEGER               not null,
   UBICADOC             VARCHAR2(50),
   constraint PK_DOCUMENTO primary key (CODESPECIALIZACION, PASOETAPA, NOCASO, CONSECEXPE, CONDOC)
);

/*==============================================================*/
/* Index: EXPEDIENTEDOCFK_FK                                    */
/*==============================================================*/
create index EXPEDIENTEDOCFK_FK on DOCUMENTO (
   CODESPECIALIZACION ASC,
   PASOETAPA ASC,
   NOCASO ASC,
   CONSECEXPE ASC
);

/*==============================================================*/
/* Table: ESPECIALIZACION                                       */
/*==============================================================*/
create table ESPECIALIZACION (
   CODESPECIALIZACION   VARCHAR2(3)           not null,
   NOMESPECIALIZACION   VARCHAR2(30),
   constraint PK_ESPECIALIZACION primary key (CODESPECIALIZACION)
);

/*==============================================================*/
/* Table: ESPECIA_ETAPA                                         */
/*==============================================================*/
create table ESPECIA_ETAPA (
   CODESPECIALIZACION   VARCHAR2(3)           not null,
   PASOETAPA            INTEGER               not null,
   NINSTANCIA           INTEGER,
   CODETAPA             VARCHAR2(3)           not null,
   IDIMPUGNA            VARCHAR2(2),
   constraint PK_ESPECIA_ETAPA primary key (CODESPECIALIZACION, PASOETAPA)
);

/*==============================================================*/
/* Index: ETAPAPROCEFK_FK                                       */
/*==============================================================*/
create index ETAPAPROCEFK_FK on ESPECIA_ETAPA (
   CODETAPA ASC
);

/*==============================================================*/
/* Index: INSTFK_FK                                             */
/*==============================================================*/
create index INSTFK_FK on ESPECIA_ETAPA (
   NINSTANCIA ASC
);

/*==============================================================*/
/* Index: RELATIONSHIP_21_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_21_FK on ESPECIA_ETAPA (
   CODESPECIALIZACION ASC
);

/*==============================================================*/
/* Index: RELATIONSHIP_22_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_22_FK on ESPECIA_ETAPA (
   IDIMPUGNA ASC
);

/*==============================================================*/
/* Table: ETAPAPROCESAL                                         */
/*==============================================================*/
create table ETAPAPROCESAL (
   CODETAPA             VARCHAR2(3)           not null,
   NOMETAPA             VARCHAR2(30),
   constraint PK_ETAPAPROCESAL primary key (CODETAPA)
);

/*==============================================================*/
/* Table: EXPEDIENTE                                            */
/*==============================================================*/
create table EXPEDIENTE (
   CODESPECIALIZACION   VARCHAR2(3)           not null,
   PASOETAPA            INTEGER               not null,
   NOCASO               INTEGER               not null,
   CONSECEXPE           INTEGER               not null,
   CEDULA               VARCHAR2(10),
   CODLUGAR             VARCHAR2(5)           not null,
   FECHAETAPA           DATE,
   constraint PK_EXPEDIENTE primary key (CODESPECIALIZACION, PASOETAPA, NOCASO, CONSECEXPE)
);

/*==============================================================*/
/* Index: CODLUGARFK_FK                                         */
/*==============================================================*/
create index CODLUGARFK_FK on EXPEDIENTE (
   CODLUGAR ASC
);

/*==============================================================*/
/* Index: ESPETAPAEXPFK_FK                                      */
/*==============================================================*/
create index ESPETAPAEXPFK_FK on EXPEDIENTE (
   CODESPECIALIZACION ASC,
   PASOETAPA ASC
);

/*==============================================================*/
/* Index: NCASOFK_FK                                            */
/*==============================================================*/
create index NCASOFK_FK on EXPEDIENTE (
   NOCASO ASC
);

/*==============================================================*/
/* Index: RELATIONSHIP_20_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_20_FK on EXPEDIENTE (
   CEDULA ASC
);

/*==============================================================*/
/* Table: FORMAPAGO                                             */
/*==============================================================*/
create table FORMAPAGO (
   IDFORMAPAGO          VARCHAR2(3)           not null,
   DESCFORMAPAGO        VARCHAR2(30),
   constraint PK_FORMAPAGO primary key (IDFORMAPAGO)
);

/*==============================================================*/
/* Table: FRANQUICIA                                            */
/*==============================================================*/
create table FRANQUICIA (
   CODFRANQUICIA        VARCHAR2(3)           not null,
   NOMFRANQUICIA        VARCHAR2(40),
   constraint PK_FRANQUICIA primary key (CODFRANQUICIA)
);

/*==============================================================*/
/* Table: IMPUGNACION                                           */
/*==============================================================*/
create table IMPUGNACION (
   IDIMPUGNA            VARCHAR2(2)           not null,
   NOMIMPUGNA           VARCHAR2(50),
   constraint PK_IMPUGNACION primary key (IDIMPUGNA)
);

/*==============================================================*/
/* Table: INSTANCIA                                             */
/*==============================================================*/
create table INSTANCIA (
   NINSTANCIA           INTEGER               not null,
   constraint PK_INSTANCIA primary key (NINSTANCIA)
);

/*==============================================================*/
/* Table: LUGAR                                                 */
/*==============================================================*/
create table LUGAR (
   CODLUGAR             VARCHAR2(5)           not null,
   LUG_CODLUGAR         VARCHAR2(5),
   IDTIPOLUGAR          VARCHAR2(4)           not null,
   NOMLUGAR             VARCHAR2(30),
   DIRELUGAR            VARCHAR2(40),
   TELLUGAR             VARCHAR2(15),
   EMAILLUGAR           VARCHAR2(50),
   constraint PK_LUGAR primary key (CODLUGAR)
);

/*==============================================================*/
/* Index: IDTIPOLUGARFK_FK                                      */
/*==============================================================*/
create index IDTIPOLUGARFK_FK on LUGAR (
   IDTIPOLUGAR ASC
);

/*==============================================================*/
/* Index: CODLUGARSUPFK_FK                                      */
/*==============================================================*/
create index CODLUGARSUPFK_FK on LUGAR (
   LUG_CODLUGAR ASC
);

/*==============================================================*/
/* Table: PAGO                                                  */
/*==============================================================*/
create table PAGO (
   CONSEPAGO            INTEGER               not null,
   CODFRANQUICIA        VARCHAR2(3),
   IDFORMAPAGO          VARCHAR2(3),
   FECHAPAGO            DATE,
   VALORPAGO            NUMBER(10,2),
   NTARJETA             NUMBER(15,0),
   constraint PK_PAGO primary key (CONSEPAGO)
);

/*==============================================================*/
/* Index: FORMAPAGOFK_FK                                        */
/*==============================================================*/
create index FORMAPAGOFK_FK on PAGO (
   IDFORMAPAGO ASC
);

/*==============================================================*/
/* Index: CODFRANQFK_FK                                         */
/*==============================================================*/
create index CODFRANQFK_FK on PAGO (
   CODFRANQUICIA ASC
);

/*==============================================================*/
/* Table: RESULTADO                                             */
/*==============================================================*/
create table RESULTADO (
   CODESPECIALIZACION   VARCHAR2(3)           not null,
   PASOETAPA            INTEGER               not null,
   NOCASO               INTEGER               not null,
   CONSECEXPE           INTEGER               not null,
   CONRESUL             INTEGER               not null,
   DESCRESUL            VARCHAR2(200),
   constraint PK_RESULTADO primary key (CODESPECIALIZACION, PASOETAPA, NOCASO, CONSECEXPE, CONRESUL)
);

/*==============================================================*/
/* Index: RELATIONSHIP_19_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_19_FK on RESULTADO (
   CODESPECIALIZACION ASC,
   PASOETAPA ASC,
   NOCASO ASC,
   CONSECEXPE ASC
);

/*==============================================================*/
/* Table: SUCESO                                                */
/*==============================================================*/
create table SUCESO (
   CODESPECIALIZACION   VARCHAR2(3)           not null,
   PASOETAPA            INTEGER               not null,
   NOCASO               INTEGER               not null,
   CONSECEXPE           INTEGER               not null,
   CONSUCESO            INTEGER               not null,
   DESCSUCESO           VARCHAR2(200),
   constraint PK_SUCESO primary key (CODESPECIALIZACION, PASOETAPA, NOCASO, CONSECEXPE, CONSUCESO)
);

/*==============================================================*/
/* Index: EXPEDIENTESUCESOFK_FK                                 */
/*==============================================================*/
create index EXPEDIENTESUCESOFK_FK on SUCESO (
   CODESPECIALIZACION ASC,
   PASOETAPA ASC,
   NOCASO ASC,
   CONSECEXPE ASC
);

/*==============================================================*/
/* Table: TIPOCONTACT                                           */
/*==============================================================*/
create table TIPOCONTACT (
   IDTIPOCONTA          VARCHAR2(3)           not null,
   DESCTIPOCONTA        VARCHAR2(30),
   constraint PK_TIPOCONTACT primary key (IDTIPOCONTA)
);

/*==============================================================*/
/* Table: TIPODOCUMENTO                                         */
/*==============================================================*/
create table TIPODOCUMENTO (
   IDTIPODOC            VARCHAR2(2)           not null,
   DESCTIPODOC          VARCHAR2(30),
   constraint PK_TIPODOCUMENTO primary key (IDTIPODOC)
);

/*==============================================================*/
/* Table: TIPOLUGAR                                             */
/*==============================================================*/
create table TIPOLUGAR (
   IDTIPOLUGAR          VARCHAR2(4)           not null,
   DESCTIPOLUGAR        VARCHAR2(50),
   constraint PK_TIPOLUGAR primary key (IDTIPOLUGAR)
);

alter table ABOGADOESPEFK
   add constraint FK_ABOGADOE_ABOGADOES_ABOGADO foreign key (CEDULA)
      references ABOGADO (CEDULA);

alter table ABOGADOESPEFK
   add constraint FK_ABOGADOE_ABOGADOES_ESPECIAL foreign key (CODESPECIALIZACION)
      references ESPECIALIZACION (CODESPECIALIZACION);

alter table CASO
   add constraint FK_CASO_CODCLIENT_CLIENTE foreign key (CODCLIENTE)
      references CLIENTE (CODCLIENTE);

alter table CASO
   add constraint FK_CASO_ESPECASOF_ESPECIAL foreign key (CODESPECIALIZACION)
      references ESPECIALIZACION (CODESPECIALIZACION);

alter table CLIENTE
   add constraint FK_CLIENTE_IDTIPODOC_TIPODOCU foreign key (IDTIPODOC)
      references TIPODOCUMENTO (IDTIPODOC);

alter table CONTACTO
   add constraint FK_CONTACTO_CODCLIENT_CLIENTE foreign key (CODCLIENTE)
      references CLIENTE (CODCLIENTE);

alter table CONTACTO
   add constraint FK_CONTACTO_IDTIPOCON_TIPOCONT foreign key (IDTIPOCONTA)
      references TIPOCONTACT (IDTIPOCONTA);

alter table DOCUMENTO
   add constraint FK_DOCUMENT_EXPEDIENT_EXPEDIEN foreign key (CODESPECIALIZACION, PASOETAPA, NOCASO, CONSECEXPE)
      references EXPEDIENTE (CODESPECIALIZACION, PASOETAPA, NOCASO, CONSECEXPE);

alter table ESPECIA_ETAPA
   add constraint FK_ESPECIA__ETAPAPROC_ETAPAPRO foreign key (CODETAPA)
      references ETAPAPROCESAL (CODETAPA);

alter table ESPECIA_ETAPA
   add constraint FK_ESPECIA__INSTFK_INSTANCI foreign key (NINSTANCIA)
      references INSTANCIA (NINSTANCIA);

alter table ESPECIA_ETAPA
   add constraint FK_ESPECIA__RELATIONS_ESPECIAL foreign key (CODESPECIALIZACION)
      references ESPECIALIZACION (CODESPECIALIZACION);

alter table ESPECIA_ETAPA
   add constraint FK_ESPECIA__RELATIONS_IMPUGNAC foreign key (IDIMPUGNA)
      references IMPUGNACION (IDIMPUGNA);

alter table EXPEDIENTE
   add constraint FK_EXPEDIEN_CODLUGARF_LUGAR foreign key (CODLUGAR)
      references LUGAR (CODLUGAR);

alter table EXPEDIENTE
   add constraint FK_EXPEDIEN_ESPETAPAE_ESPECIA_ foreign key (CODESPECIALIZACION, PASOETAPA)
      references ESPECIA_ETAPA (CODESPECIALIZACION, PASOETAPA);

alter table EXPEDIENTE
   add constraint FK_EXPEDIEN_NCASOFK_CASO foreign key (NOCASO)
      references CASO (NOCASO);

alter table EXPEDIENTE
   add constraint FK_EXPEDIEN_RELATIONS_ABOGADO foreign key (CEDULA)
      references ABOGADO (CEDULA);

alter table LUGAR
   add constraint FK_LUGAR_CODLUGARS_LUGAR foreign key (LUG_CODLUGAR)
      references LUGAR (CODLUGAR);

alter table LUGAR
   add constraint FK_LUGAR_IDTIPOLUG_TIPOLUGA foreign key (IDTIPOLUGAR)
      references TIPOLUGAR (IDTIPOLUGAR);

alter table PAGO
   add constraint FK_PAGO_CODFRANQF_FRANQUIC foreign key (CODFRANQUICIA)
      references FRANQUICIA (CODFRANQUICIA);

alter table PAGO
   add constraint FK_PAGO_FORMAPAGO_FORMAPAG foreign key (IDFORMAPAGO)
      references FORMAPAGO (IDFORMAPAGO);

alter table RESULTADO
   add constraint FK_RESULTAD_RELATIONS_EXPEDIEN foreign key (CODESPECIALIZACION, PASOETAPA, NOCASO, CONSECEXPE)
      references EXPEDIENTE (CODESPECIALIZACION, PASOETAPA, NOCASO, CONSECEXPE);

alter table SUCESO
   add constraint FK_SUCESO_EXPEDIENT_EXPEDIEN foreign key (CODESPECIALIZACION, PASOETAPA, NOCASO, CONSECEXPE)
      references EXPEDIENTE (CODESPECIALIZACION, PASOETAPA, NOCASO, CONSECEXPE);
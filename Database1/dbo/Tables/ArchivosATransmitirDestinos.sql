CREATE TABLE [dbo].[ArchivosATransmitirDestinos] (
    [IdArchivoATransmitirDestino] INT          IDENTITY (1, 1) NOT NULL,
    [Descripcion]                 VARCHAR (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Tipo]                        INT          NULL,
    [Email]                       VARCHAR (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Activo]                      VARCHAR (2)  COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Nombre]                      VARCHAR (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Direccion]                   VARCHAR (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Localidad]                   VARCHAR (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Telefono]                    VARCHAR (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Celular]                     VARCHAR (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Horario]                     VARCHAR (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Contacto]                    VARCHAR (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Observaciones]               NTEXT        COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Sistema]                     VARCHAR (20) NULL,
    [IdObra]                      INT          NULL,
    CONSTRAINT [PK_ArchivosATransmitirDestinos] PRIMARY KEY CLUSTERED ([IdArchivoATransmitirDestino] ASC) WITH (FILLFACTOR = 90)
);


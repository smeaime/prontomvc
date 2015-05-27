CREATE TABLE [dbo].[DefinicionArticulos] (
    [IdDef]                    INT          IDENTITY (1, 1) NOT NULL,
    [IdRubro]                  INT          NOT NULL,
    [IdSubrubro]               INT          NOT NULL,
    [IdFamilia]                INT          NOT NULL,
    [AddNombre]                VARCHAR (2)  COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [Orden]                    SMALLINT     NOT NULL,
    [Campo]                    VARCHAR (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [Etiqueta]                 VARCHAR (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [TablaCombo]               VARCHAR (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [CampoCombo]               VARCHAR (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [CampoUnidad]              VARCHAR (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [UnidadDefault]            INT          NULL,
    [Antes]                    VARCHAR (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Despues]                  VARCHAR (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [UsaAbreviatura]           VARCHAR (2)  COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [AgregaUnidadADescripcion] VARCHAR (2)  COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [UsaAbreviaturaUnidad]     VARCHAR (2)  COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [InformacionAdicional]     VARCHAR (2)  COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [CampoSiNo]                VARCHAR (2)  NULL,
    CONSTRAINT [PK_DefinicionArticulos] PRIMARY KEY CLUSTERED ([IdDef] ASC) WITH (FILLFACTOR = 90)
);


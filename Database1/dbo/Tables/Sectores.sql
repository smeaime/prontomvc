CREATE TABLE [dbo].[Sectores] (
    [IdSector]            INT          IDENTITY (1, 1) NOT NULL,
    [Descripcion]         VARCHAR (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [SectorDeObra]        VARCHAR (2)  COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [IdEncargado]         INT          NULL,
    [SeUsaEnPresupuestos] VARCHAR (2)  COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [OrdenPresentacion]   INT          NULL,
    [EnviarEmail]         TINYINT      NULL,
    CONSTRAINT [PK_Sectores] PRIMARY KEY CLUSTERED ([IdSector] ASC) WITH (FILLFACTOR = 90)
);


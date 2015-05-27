CREATE TABLE [dbo].[Actividades Proveedores] (
    [IdActividad] INT          IDENTITY (1, 1) NOT NULL,
    [Descripcion] VARCHAR (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Agrupacion1] INT          NULL,
    CONSTRAINT [PK_Actividades Proveedores] PRIMARY KEY CLUSTERED ([IdActividad] ASC) WITH (FILLFACTOR = 90)
);


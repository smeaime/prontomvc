CREATE TABLE [dbo].[GruposObras] (
    [IdGrupoObra] INT          IDENTITY (1, 1) NOT NULL,
    [Descripcion] VARCHAR (50) NULL,
    CONSTRAINT [PK_GruposObras] PRIMARY KEY CLUSTERED ([IdGrupoObra] ASC) WITH (FILLFACTOR = 90)
);


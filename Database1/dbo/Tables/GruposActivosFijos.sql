CREATE TABLE [dbo].[GruposActivosFijos] (
    [IdGrupoActivoFijo] INT          IDENTITY (1, 1) NOT NULL,
    [Descripcion]       VARCHAR (50) NULL,
    [Clase]             VARCHAR (1)  NULL,
    CONSTRAINT [PK_GruposActivosFijos] PRIMARY KEY CLUSTERED ([IdGrupoActivoFijo] ASC) WITH (FILLFACTOR = 90)
);


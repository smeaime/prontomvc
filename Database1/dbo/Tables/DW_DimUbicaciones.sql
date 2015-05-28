CREATE TABLE [dbo].[DW_DimUbicaciones] (
    [IdUbicacion] INT          NOT NULL,
    [Descripcion] VARCHAR (80) NULL,
    [IdDeposito]  INT          NULL,
    CONSTRAINT [PK_DW_DimUbicaciones] PRIMARY KEY CLUSTERED ([IdUbicacion] ASC) WITH (FILLFACTOR = 90)
);


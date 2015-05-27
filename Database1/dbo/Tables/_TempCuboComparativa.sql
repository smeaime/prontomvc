CREATE TABLE [dbo].[_TempCuboComparativa] (
    [IdTempCuboComparativa] INT             IDENTITY (1, 1) NOT NULL,
    [Rubro]                 VARCHAR (50)    NULL,
    [Material]              VARCHAR (5500)  NULL,
    [Solicitud]             VARCHAR (100)   NULL,
    [Cantidad]              NUMERIC (18, 2) NULL,
    [Precio]                NUMERIC (18, 2) NULL,
    CONSTRAINT [PK__TempCuboComparativa] PRIMARY KEY CLUSTERED ([IdTempCuboComparativa] ASC) WITH (FILLFACTOR = 90)
);


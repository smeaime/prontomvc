CREATE TABLE [dbo].[_TempCuboIVAPorObra] (
    [IdCuboIVAPorObra] INT             IDENTITY (1, 1) NOT NULL,
    [Obra]             VARCHAR (13)    NULL,
    [Tipo]             VARCHAR (20)    NULL,
    [Detalle]          VARCHAR (200)   NULL,
    [IVA]              NUMERIC (18, 2) NULL,
    CONSTRAINT [PK__TempCuboIVAPorObra] PRIMARY KEY CLUSTERED ([IdCuboIVAPorObra] ASC) WITH (FILLFACTOR = 90)
);


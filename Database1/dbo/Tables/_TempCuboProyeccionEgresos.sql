CREATE TABLE [dbo].[_TempCuboProyeccionEgresos] (
    [IdCuboProyeccionEgresos] INT             IDENTITY (1, 1) NOT NULL,
    [IdProveedor]             INT             NULL,
    [Proveedor]               VARCHAR (50)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Fecha]                   DATETIME        NULL,
    [Importe]                 NUMERIC (18, 2) NULL,
    [Detalle]                 VARCHAR (100)   NULL,
    CONSTRAINT [PK__TempCuboProyeccionEgresos] PRIMARY KEY CLUSTERED ([IdCuboProyeccionEgresos] ASC) WITH (FILLFACTOR = 90)
);


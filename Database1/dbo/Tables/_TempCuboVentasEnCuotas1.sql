CREATE TABLE [dbo].[_TempCuboVentasEnCuotas1] (
    [IdTempCuboVentasEnCuotas] INT             IDENTITY (1, 1) NOT NULL,
    [Cliente]                  VARCHAR (60)    NULL,
    [Detalle]                  VARCHAR (200)   NULL,
    [FechaVencimiento]         DATETIME        NULL,
    [Importe]                  NUMERIC (18, 2) NULL,
    CONSTRAINT [PK__TempCuboVentasEnCuotas1] PRIMARY KEY CLUSTERED ([IdTempCuboVentasEnCuotas] ASC) WITH (FILLFACTOR = 90)
);


CREATE TABLE [dbo].[PresentacionesTarjetas] (
    [IdPresentacionTarjeta] INT      IDENTITY (1, 1) NOT NULL,
    [IdTarjetaCredito]      INT      NULL,
    [NumeroPresentacion]    INT      NULL,
    [FechaIngreso]          DATETIME NULL,
    [Observaciones]         NTEXT    NULL,
    [IdRealizo]             INT      NULL,
    CONSTRAINT [PK_PresentacionesTarjeta] PRIMARY KEY CLUSTERED ([IdPresentacionTarjeta] ASC) WITH (FILLFACTOR = 90)
);


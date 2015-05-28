CREATE TABLE [dbo].[DetallePresentacionesTarjetas] (
    [IdDetallePresentacionTarjeta] INT IDENTITY (1, 1) NOT NULL,
    [IdPresentacionTarjeta]        INT NULL,
    [IdValor]                      INT NULL,
    CONSTRAINT [PK_DetallePresentacionesTarjetas] PRIMARY KEY CLUSTERED ([IdDetallePresentacionTarjeta] ASC) WITH (FILLFACTOR = 90)
);


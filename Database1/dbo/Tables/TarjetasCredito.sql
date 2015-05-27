CREATE TABLE [dbo].[TarjetasCredito] (
    [IdTarjetaCredito]      INT          IDENTITY (1, 1) NOT NULL,
    [Nombre]                VARCHAR (50) NULL,
    [IdCuenta]              INT          NULL,
    [IdMoneda]              INT          NULL,
    [TipoTarjeta]           VARCHAR (1)  NULL,
    [DiseñoRegistro]        INT          NULL,
    [NumeroEstablecimiento] VARCHAR (10) NULL,
    [CodigoServicio]        VARCHAR (5)  NULL,
    [NumeroServicio]        VARCHAR (10) NULL,
    [Codigo]                INT          NULL,
    CONSTRAINT [PK_TarjetasCredito] PRIMARY KEY CLUSTERED ([IdTarjetaCredito] ASC) WITH (FILLFACTOR = 90)
);


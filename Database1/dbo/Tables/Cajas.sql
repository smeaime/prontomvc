CREATE TABLE [dbo].[Cajas] (
    [IdCaja]      INT          IDENTITY (1, 1) NOT NULL,
    [Descripcion] VARCHAR (50) NULL,
    [IdCuenta]    INT          NULL,
    [IdMoneda]    INT          NULL,
    CONSTRAINT [PK_Cajas] PRIMARY KEY CLUSTERED ([IdCaja] ASC) WITH (FILLFACTOR = 90)
);


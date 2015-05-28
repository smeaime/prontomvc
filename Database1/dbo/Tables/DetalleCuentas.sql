CREATE TABLE [dbo].[DetalleCuentas] (
    [IdDetalleCuenta]   INT          IDENTITY (1, 1) NOT NULL,
    [IdCuenta]          INT          NULL,
    [NombreAnterior]    VARCHAR (50) NULL,
    [FechaCambio]       DATETIME     NULL,
    [CodigoAnterior]    INT          NULL,
    [JerarquiaAnterior] VARCHAR (20) NULL,
    CONSTRAINT [PK_DetalleCuentas] PRIMARY KEY CLUSTERED ([IdDetalleCuenta] ASC) WITH (FILLFACTOR = 90)
);


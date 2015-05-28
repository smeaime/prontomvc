CREATE TABLE [dbo].[DetalleDefinicionesFlujoCajaCuentas] (
    [IdDetalleDefinicionFlujoCaja] INT          IDENTITY (1, 1) NOT NULL,
    [IdDefinicionFlujoCaja]        INT          NULL,
    [IdCuenta]                     INT          NULL,
    [IdRubroContable]              INT          NULL,
    [OtroConcepto]                 VARCHAR (50) NULL,
    [TempCodigo]                   INT          NULL,
    CONSTRAINT [PK_DetalleDefinicionFlujoCajaCuentas] PRIMARY KEY CLUSTERED ([IdDetalleDefinicionFlujoCaja] ASC) WITH (FILLFACTOR = 90)
);


CREATE TABLE [dbo].[DetalleRubrosContables] (
    [IdDetalleRubroContable] INT            IDENTITY (1, 1) NOT NULL,
    [IdRubroContable]        INT            NULL,
    [IdObra]                 INT            NULL,
    [Porcentaje]             NUMERIC (6, 2) NULL,
    CONSTRAINT [PK_DetalleRubrosContables] PRIMARY KEY CLUSTERED ([IdDetalleRubroContable] ASC) WITH (FILLFACTOR = 90)
);


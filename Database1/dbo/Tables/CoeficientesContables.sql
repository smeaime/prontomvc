CREATE TABLE [dbo].[CoeficientesContables] (
    [IdCoeficienteContable]    INT             IDENTITY (1, 1) NOT NULL,
    [Año]                      INT             NULL,
    [Mes]                      INT             NULL,
    [CoeficienteActualizacion] NUMERIC (19, 6) NULL,
    CONSTRAINT [PK_CoeficientesContables] PRIMARY KEY CLUSTERED ([IdCoeficienteContable] ASC) WITH (FILLFACTOR = 90)
);


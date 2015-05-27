CREATE TABLE [dbo].[CoeficientesImpositivos] (
    [IdCoeficienteImpositivo]  INT             IDENTITY (1, 1) NOT NULL,
    [AñoFiscal]                INT             NULL,
    [Año]                      INT             NULL,
    [Mes]                      INT             NULL,
    [CoeficienteActualizacion] NUMERIC (19, 6) NULL,
    CONSTRAINT [PK_CoeficientesImpositivos] PRIMARY KEY CLUSTERED ([IdCoeficienteImpositivo] ASC) WITH (FILLFACTOR = 90)
);


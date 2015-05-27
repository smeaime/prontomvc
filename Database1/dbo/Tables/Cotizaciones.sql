CREATE TABLE [dbo].[Cotizaciones] (
    [IdCotizacion]       INT             IDENTITY (1, 1) NOT NULL,
    [Fecha]              DATETIME        NULL,
    [IdMoneda]           INT             NULL,
    [Cotizacion]         NUMERIC (18, 4) NULL,
    [CotizacionLibre]    NUMERIC (18, 4) NULL,
    [REP_COTIZACION_INS] VARCHAR (1)     NULL,
    [REP_COTIZACION_UPD] VARCHAR (1)     NULL,
    CONSTRAINT [PK_Cotizaciones] PRIMARY KEY CLUSTERED ([IdCotizacion] ASC) WITH (FILLFACTOR = 90)
);


CREATE TABLE [dbo].[UnidadesEmpaque] (
    [IdUnidadEmpaque]    INT             IDENTITY (1, 1) NOT NULL,
    [NumeroUnidad]       INT             NULL,
    [IdArticulo]         INT             NULL,
    [Partida]            VARCHAR (20)    NULL,
    [IdUnidad]           INT             NULL,
    [PesoBruto]          NUMERIC (18, 2) NULL,
    [Tara]               NUMERIC (18, 3) NULL,
    [PesoNeto]           NUMERIC (18, 2) NULL,
    [IdUsuarioAlta]      INT             NULL,
    [FechaAlta]          DATETIME        NULL,
    [IdUbicacion]        INT             NULL,
    [IdColor]            INT             NULL,
    [IdUnidadTipoCaja]   INT             NULL,
    [EsDevolucion]       VARCHAR (2)     NULL,
    [IdDetalleRecepcion] INT             NULL,
    [Metros]             NUMERIC (18, 2) NULL,
    [TipoRollo]          VARCHAR (1)     NULL,
    [Observaciones]      NTEXT           NULL,
    [PartidasOrigen]     VARCHAR (110)   NULL,
    CONSTRAINT [PK_UnidadesEmpaque] PRIMARY KEY CLUSTERED ([IdUnidadEmpaque] ASC) WITH (FILLFACTOR = 90)
);


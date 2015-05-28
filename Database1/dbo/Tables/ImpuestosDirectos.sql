CREATE TABLE [dbo].[ImpuestosDirectos] (
    [IdImpuestoDirecto]                              INT             IDENTITY (1, 1) NOT NULL,
    [Descripcion]                                    VARCHAR (50)    NULL,
    [Tasa]                                           NUMERIC (18, 4) NULL,
    [IdTipoImpuesto]                                 INT             NULL,
    [IdCuenta]                                       INT             NULL,
    [BaseMinima]                                     NUMERIC (18, 2) NULL,
    [ProximoNumeroCertificado]                       INT             NULL,
    [Grupo]                                          INT             NULL,
    [ActivaNumeracionPorGrupo]                       VARCHAR (2)     NULL,
    [Codigo]                                         VARCHAR (10)    NULL,
    [TopeAnual]                                      NUMERIC (18, 2) NULL,
    [ParaInscriptosEnRegistroFiscalOperadoresGranos] VARCHAR (2)     NULL,
    [CodigoRegimen]                                  INT             NULL,
    CONSTRAINT [PK_ImpuestosDirectos] PRIMARY KEY CLUSTERED ([IdImpuestoDirecto] ASC) WITH (FILLFACTOR = 90)
);


﻿CREATE TABLE [dbo].[Pedidos] (
    [IdPedido]                    INT             IDENTITY (1, 1) NOT NULL,
    [NumeroPedido]                INT             NULL,
    [IdProveedor]                 INT             NULL,
    [FechaPedido]                 DATETIME        NULL,
    [LugarEntrega]                NTEXT           COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [FormaPago]                   NTEXT           COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Observaciones]               NTEXT           COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Bonificacion]                NUMERIC (18, 2) NULL,
    [TotalIva1]                   NUMERIC (18, 2) NULL,
    [TotalIva2]                   NUMERIC (18, 2) NULL,
    [TotalPedido]                 NUMERIC (18, 2) NULL,
    [PorcentajeIva1]              NUMERIC (6, 2)  NULL,
    [PorcentajeIva2]              NUMERIC (6, 2)  NULL,
    [IdComprador]                 INT             NULL,
    [PorcentajeBonificacion]      NUMERIC (6, 2)  NULL,
    [NumeroComparativa]           INT             NULL,
    [Contacto]                    VARCHAR (50)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [PlazoEntrega]                NTEXT           COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Garantia]                    NTEXT           COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Documentacion]               NTEXT           COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Aprobo]                      INT             NULL,
    [IdMoneda]                    INT             NULL,
    [FechaAprobacion]             DATETIME        NULL,
    [Importante]                  NTEXT           COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [TipoCompra]                  INT             NULL,
    [Consorcial]                  VARCHAR (2)     COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Cumplido]                    VARCHAR (2)     COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [DetalleCondicionCompra]      VARCHAR (200)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [IdAutorizoCumplido]          INT             NULL,
    [IdDioPorCumplido]            INT             NULL,
    [FechaDadoPorCumplido]        DATETIME        NULL,
    [ObservacionesCumplido]       NTEXT           COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [SubNumero]                   INT             NULL,
    [UsuarioAnulacion]            VARCHAR (6)     COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [FechaAnulacion]              DATETIME        NULL,
    [MotivoAnulacion]             NTEXT           COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ArchivoAdjunto1]             VARCHAR (100)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ArchivoAdjunto2]             VARCHAR (100)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ArchivoAdjunto3]             VARCHAR (100)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ArchivoAdjunto4]             VARCHAR (100)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ArchivoAdjunto5]             VARCHAR (100)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ArchivoAdjunto6]             VARCHAR (100)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ArchivoAdjunto7]             VARCHAR (100)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ArchivoAdjunto8]             VARCHAR (100)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ArchivoAdjunto9]             VARCHAR (100)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ArchivoAdjunto10]            VARCHAR (100)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ImprimeImportante]           VARCHAR (2)     COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ImprimePlazoEntrega]         VARCHAR (2)     COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ImprimeLugarEntrega]         VARCHAR (2)     COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ImprimeFormaPago]            VARCHAR (2)     COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ImprimeImputaciones]         VARCHAR (2)     COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ImprimeInspecciones]         VARCHAR (2)     COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ImprimeGarantia]             VARCHAR (2)     COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ImprimeDocumentacion]        VARCHAR (2)     COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [CotizacionDolar]             NUMERIC (18, 3) NULL,
    [CotizacionMoneda]            NUMERIC (18, 3) NULL,
    [PedidoExterior]              VARCHAR (2)     NULL,
    [PRESTOPedido]                VARCHAR (13)    NULL,
    [PRESTOFechaProceso]          DATETIME        NULL,
    [IdCondicionCompra]           INT             NULL,
    [EnviarEmail]                 TINYINT         NULL,
    [IdPedidoOriginal]            INT             NULL,
    [IdOrigenTransmision]         INT             NULL,
    [FechaImportacionTransmision] DATETIME        NULL,
    [Subcontrato]                 VARCHAR (2)     NULL,
    [IdPedidoAbierto]             INT             NULL,
    [NumeroLicitacion]            VARCHAR (20)    NULL,
    [Transmitir_a_SAT]            VARCHAR (2)     NULL,
    [NumeracionAutomatica]        VARCHAR (2)     NULL,
    [Impresa]                     VARCHAR (2)     NULL,
    [EmbarcadoA]                  VARCHAR (50)    NULL,
    [FacturarA]                   VARCHAR (50)    NULL,
    [ProveedorExt]                VARCHAR (50)    NULL,
    [ImpuestosInternos]           NUMERIC (18, 2) NULL,
    [FechaSalida]                 DATETIME        NULL,
    [CodigoControl]               NUMERIC (10)    NULL,
    [CircuitoFirmasCompleto]      VARCHAR (2)     NULL,
    [OtrosConceptos1]             NUMERIC (18, 2) NULL,
    [OtrosConceptos2]             NUMERIC (18, 2) NULL,
    [OtrosConceptos3]             NUMERIC (18, 2) NULL,
    [OtrosConceptos4]             NUMERIC (18, 2) NULL,
    [OtrosConceptos5]             NUMERIC (18, 2) NULL,
    [IdClausula]                  INT             NULL,
    [IncluirObservacionesRM]      VARCHAR (2)     NULL,
    [NumeroSubcontrato]           INT             NULL,
    [IdPuntoVenta]                INT             NULL,
    [PuntoVenta]                  INT             NULL,
    [IdMonedaOriginal]            INT             NULL,
    [IdLugarEntrega]              INT             NULL,
    [ConfirmadoPorWeb]            VARCHAR (2)     NULL,
    [IdTipoCompraRM]              INT             NULL,
    [FechaEnvioProveedor]         DATETIME        NULL,
    [IdUsuarioEnvioProveedor]     INT             NULL,
    [IdPlazoEntrega]              INT             NULL,
    CONSTRAINT [PK_Pedidos] PRIMARY KEY CLUSTERED ([IdPedido] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_Pedidos_EmpleadoAprobo] FOREIGN KEY ([Aprobo]) REFERENCES [dbo].[Empleados] ([IdEmpleado]),
    CONSTRAINT [FK_Pedidos_EmpleadoComprador] FOREIGN KEY ([IdComprador]) REFERENCES [dbo].[Empleados] ([IdEmpleado]),
    CONSTRAINT [FK_Pedidos_Empleados] FOREIGN KEY ([IdComprador]) REFERENCES [dbo].[Empleados] ([IdEmpleado]),
    CONSTRAINT [FK_Pedidos_Monedas] FOREIGN KEY ([IdMoneda]) REFERENCES [dbo].[Monedas] ([IdMoneda])
);


GO
CREATE NONCLUSTERED INDEX [Indice1]
    ON [dbo].[Pedidos]([FechaPedido] ASC) WITH (FILLFACTOR = 90);


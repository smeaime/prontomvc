CREATE TABLE [dbo].[DetalleFacturas] (
    [IdDetalleFactura]            INT              IDENTITY (1, 1) NOT NULL,
    [IdFactura]                   INT              NULL,
    [NumeroFactura]               INT              NULL,
    [TipoABC]                     VARCHAR (1)      COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [PuntoVenta]                  INT              NULL,
    [IdArticulo]                  INT              NULL,
    [CodigoArticulo]              VARCHAR (20)     COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Cantidad]                    NUMERIC (18, 3)  NULL,
    [Costo]                       NUMERIC (19, 8)  NULL,
    [PrecioUnitario]              NUMERIC (19, 8)  NULL,
    [Bonificacion]                NUMERIC (6, 2)   NULL,
    [IdDetalleRemito]             INT              NULL,
    [ParteDolar]                  NUMERIC (18, 2)  NULL,
    [PartePesos]                  NUMERIC (18, 2)  NULL,
    [PorcentajeCertificacion]     NUMERIC (18, 10) NULL,
    [OrigenDescripcion]           INT              NULL,
    [TipoCancelacion]             INT              NULL,
    [IdUnidad]                    INT              NULL,
    [PrecioUnitarioTotal]         NUMERIC (18, 2)  NULL,
    [Observaciones]               NTEXT            NULL,
    [NotaAclaracion]              VARCHAR (50)     NULL,
    [EnviarEmail]                 TINYINT          NULL,
    [IdOrigenTransmision]         INT              NULL,
    [IdFacturaOriginal]           INT              NULL,
    [IdDetalleFacturaOriginal]    INT              NULL,
    [FechaImportacionTransmision] DATETIME         NULL,
    [Talle]                       VARCHAR (2)      NULL,
    [IdColor]                     INT              NULL,
    [IdDetallePresupuestoVenta]   INT              NULL,
    [OrigenRegistro]              VARCHAR (12)     NULL,
    CONSTRAINT [PK_DetalleFacturas] PRIMARY KEY NONCLUSTERED ([IdDetalleFactura] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_DetalleFacturas_DetalleRemitos] FOREIGN KEY ([IdDetalleRemito]) REFERENCES [dbo].[DetalleRemitos] ([IdDetalleRemito]),
    CONSTRAINT [FK_DetalleFacturas_Facturas] FOREIGN KEY ([IdFactura]) REFERENCES [dbo].[Facturas] ([IdFactura]),
    CONSTRAINT [FK_DetalleFacturas_Unidades] FOREIGN KEY ([IdUnidad]) REFERENCES [dbo].[Unidades] ([IdUnidad])
);


GO
CREATE NONCLUSTERED INDEX [Indice1]
    ON [dbo].[DetalleFacturas]([IdFactura] ASC, [IdDetalleFactura] ASC) WITH (FILLFACTOR = 90);


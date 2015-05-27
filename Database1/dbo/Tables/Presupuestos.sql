﻿CREATE TABLE [dbo].[Presupuestos] (
    [IdPresupuesto]          INT             IDENTITY (1, 1) NOT NULL,
    [Numero]                 INT             NULL,
    [IdProveedor]            INT             NULL,
    [FechaIngreso]           DATETIME        NULL,
    [Observaciones]          NTEXT           COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Bonificacion]           DECIMAL (6, 2)  NULL,
    [Plazo]                  VARCHAR (50)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Validez]                VARCHAR (50)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [IdCondicionCompra]      INT             NULL,
    [Garantia]               VARCHAR (50)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [LugarEntrega]           VARCHAR (50)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [IdComprador]            INT             NULL,
    [Referencia]             VARCHAR (50)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [PorcentajeIva1]         NUMERIC (18, 2) NULL,
    [PorcentajeIva2]         NUMERIC (18, 2) NULL,
    [Detalle]                VARCHAR (100)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Contacto]               VARCHAR (50)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ImporteBonificacion]    NUMERIC (18, 2) NULL,
    [ImporteIva1]            NUMERIC (18, 2) NULL,
    [ImporteTotal]           NUMERIC (18, 2) NULL,
    [SubNumero]              INT             NULL,
    [Aprobo]                 INT             NULL,
    [IdMoneda]               INT             NULL,
    [FechaAprobacion]        DATETIME        NULL,
    [DetalleCondicionCompra] VARCHAR (200)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ArchivoAdjunto1]        VARCHAR (100)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ArchivoAdjunto2]        VARCHAR (100)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ArchivoAdjunto3]        VARCHAR (100)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ArchivoAdjunto4]        VARCHAR (100)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ArchivoAdjunto5]        VARCHAR (100)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ArchivoAdjunto6]        VARCHAR (100)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ArchivoAdjunto7]        VARCHAR (100)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ArchivoAdjunto8]        VARCHAR (100)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ArchivoAdjunto9]        VARCHAR (100)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ArchivoAdjunto10]       VARCHAR (100)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [IdPlazoEntrega]         INT             NULL,
    [CotizacionMoneda]       NUMERIC (18, 3) NULL,
    [CircuitoFirmasCompleto] VARCHAR (2)     NULL,
    [ConfirmadoPorWeb]       VARCHAR (2)     NULL,
    [FechaCierreCompulsa]    DATETIME        NULL,
    [NombreUsuarioWeb]       NVARCHAR (256)  NULL,
    [FechaRespuestaweb]      DATETIME        NULL,
    CONSTRAINT [PK_Presupuestos] PRIMARY KEY CLUSTERED ([IdPresupuesto] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_Presupuestos_Empleados_Aprobo] FOREIGN KEY ([Aprobo]) REFERENCES [dbo].[Empleados] ([IdEmpleado]),
    CONSTRAINT [FK_Presupuestos_Empleados_IdComprador] FOREIGN KEY ([IdComprador]) REFERENCES [dbo].[Empleados] ([IdEmpleado])
);


GO
CREATE NONCLUSTERED INDEX [Indice1]
    ON [dbo].[Presupuestos]([FechaIngreso] ASC) WITH (FILLFACTOR = 90);


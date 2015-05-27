CREATE TABLE [dbo].[DetalleVentasEnCuotas] (
    [IdDetalleVentaEnCuotas]    INT             IDENTITY (1, 1) NOT NULL,
    [IdVentaEnCuotas]           INT             NULL,
    [Cuota]                     INT             NULL,
    [FechaCobranza]             DATETIME        NULL,
    [ImporteCobrado]            NUMERIC (18, 2) NULL,
    [Intereses]                 NUMERIC (18, 2) NULL,
    [IdRecibo]                  INT             NULL,
    [NumeroGeneracion]          INT             NULL,
    [FechaGeneracion]           DATETIME        NULL,
    [FechaPrimerVencimiento]    DATETIME        NULL,
    [FechaSegundoVencimiento]   DATETIME        NULL,
    [FechaTercerVencimiento]    DATETIME        NULL,
    [InteresPrimerVencimiento]  NUMERIC (6, 2)  NULL,
    [InteresSegundoVencimiento] NUMERIC (6, 2)  NULL,
    [IdBanco]                   INT             NULL,
    [IdNotaDebito]              INT             NULL,
    [TipoGeneracion]            VARCHAR (1)     NULL,
    [ModalidadDeGeneracion]     VARCHAR (1)     NULL,
    [FechaRegistroParaND]       DATETIME        NULL,
    CONSTRAINT [PK_DetalleVentaEnCuotas] PRIMARY KEY CLUSTERED ([IdDetalleVentaEnCuotas] ASC) WITH (FILLFACTOR = 90)
);


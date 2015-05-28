CREATE TABLE [dbo].[_TempAsientoSueldos] (
    [FechaAsiento]           DATETIME        NULL,
    [FechaLiquidacion]       DATETIME        NULL,
    [DescripcionLiquidacion] VARCHAR (50)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Legajo]                 INT             NULL,
    [Apellido]               VARCHAR (30)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Nombre]                 VARCHAR (30)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Renglon]                INT             NULL,
    [Cuenta]                 INT             NULL,
    [DescripcionCuenta]      VARCHAR (50)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [CodigoDebeHaber]        VARCHAR (1)     COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [NumeroRecibo]           INT             NULL,
    [Importe]                NUMERIC (18, 2) NULL,
    [IdEmpleado]             INT             NULL,
    [IdCuenta]               INT             NULL
);


CREATE TABLE [dbo].[Log] (
    [Tipo]                 VARCHAR (5)     NULL,
    [IdComprobante]        INT             NULL,
    [IdDetalleComprobante] INT             NULL,
    [FechaRegistro]        DATETIME        NULL,
    [Cantidad]             NUMERIC (18, 2) NULL,
    [Detalle]              VARCHAR (100)   NULL,
    [AuxString1]           VARCHAR (50)    NULL,
    [AuxString2]           VARCHAR (50)    NULL,
    [AuxString3]           VARCHAR (50)    NULL,
    [AuxString4]           VARCHAR (50)    NULL,
    [AuxString5]           VARCHAR (50)    NULL,
    [AuxDate1]             DATETIME        NULL,
    [AuxDate2]             DATETIME        NULL,
    [AuxDate3]             DATETIME        NULL,
    [AuxDate4]             DATETIME        NULL,
    [AuxDate5]             DATETIME        NULL,
    [AuxNum1]              NUMERIC (18, 2) NULL,
    [AuxNum2]              NUMERIC (18, 2) NULL,
    [AuxNum3]              NUMERIC (18, 2) NULL,
    [AuxNum4]              NUMERIC (18, 2) NULL,
    [AuxNum5]              NUMERIC (18, 2) NULL
);


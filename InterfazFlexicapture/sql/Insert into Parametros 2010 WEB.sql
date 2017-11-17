

---------------123456789012345678901234567890	
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////

--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
--Creo Roles -Y usuarios? 

--Guarda con los comentarios con asterisco en "use BDLMASTER"!!!! El analizador del 2000 no funciona igual que el 2005

--select * from aspnet_roles
--use BDLMASTER
--[aspnet_Roles_CreateRole] '/','Compras'  --ejecutar en la bdlmaster
--go

--use BDLMASTER
--[aspnet_Roles_CreateRole] '/','Comercial'  --ejecutar en la bdlmaster
--go

--use BDLMASTER2
--[aspnet_Roles_CreateRole] '/','Demo'  --ejecutar en la bdlmaster
--aspnet_Roles_DeleteRole '/','Demo',false 
--go

--use BDLMASTER
--exec [aspnet_Roles_CreateRole] '/','WilliamsAdmin'  --ejecutar en la bdlmaster
--go

--use BDLMASTER
--exec [aspnet_Roles_CreateRole] '/','WilliamsClientes'  --ejecutar en la bdlmaster
--go



--use BDLMASTER
--exec [aspnet_Roles_CreateRole] '/','WilliamsFacturacion'  --ejecutar en la bdlmaster
--go


--use BDLMASTER
--exec [aspnet_Roles_CreateRole] '/','WilliamsComercial'  --ejecutar en la bdlmaster
--go

--use BDLMASTER
--exec [aspnet_Roles_CreateRole] '/','AdministradorLimitado'  
--go

--use BDLMASTER
--exec [aspnet_Roles_CreateRole] '/','Firmas'  --ejecutar en la bdlmaster
--go


--use BDLMASTER
--exec [aspnet_Roles_CreateRole] '/','Requerimientos'  --ejecutar en la bdlmaster
--go

--use BDLMASTER
--exec [aspnet_Roles_CreateRole] '/','AdminSolo'  --ejecutar en la bdlmaster
--go


/*
Lista de SP que no empiezan con "w"

Articulos_C
GetCountRequemientoForEmployee
GetEmployeeByName
ProntoWeb_TodosLosUsuarios
ProntoWeb_CertificadoGanancias_DatosPorIdOrdenPago
ProntoWeb_CertificadoIIBB_DatosPorIdOrdenPago
ProntoWeb_CertificadoRetencionIVA_DatosPorIdOrdenPago
ProntoWeb_CertificadoSUSS_DatosPorIdOrdenPago
[ProntoWeb_CargaTodosLosUsuarios]
[ProntoWeb_CargaOrdenesPagoEnCaja]
[ProntoWeb_CargaTablas]
[ProntoWeb_DebeHaberSaldo]
[ProntoWeb_OrdenesPagoEnCaja]
*/







--PRESUPUESTOS - NEXO CON PRONTO 

--parametro PaginaSolicitudesCotizacion (con la URL de las solicitudes de cotizacion / presupuestos)


--por si no está (me esta pidiendo tambien idParametro?)
IF ( SELECT COUNT(campo)
     FROM   parametros2
     WHERE  campo = 'PaginaSolicitudesCotizacion'
   ) = 0 
    INSERT  INTO parametros2 ( campo, valor )
    VALUES  (
              'PaginaSolicitudesCotizacion',
              '/Pronto/ProntoWeb/Presupuesto.aspx' 
            )

IF ( SELECT COUNT(campo)
     FROM   parametros2
     WHERE  campo = 'HostProntoWeb'
   ) = 0 
    INSERT  INTO parametros2 ( campo, valor )
    VALUES  (
              'HostProntoWeb',
              'http://bdlconsultores2.dynalias.com' 
            )



--por si está vacío
IF ( SELECT COUNT(campo)
     FROM   parametros2
     WHERE  campo = 'PaginaSolicitudesCotizacion'
            AND ( valor = ''
                  OR valor IS NULL
                )
   ) > 0 
    UPDATE  parametros2
    SET     valor = '/Pronto/ProntoWeb/Presupuesto.aspx'
    WHERE   campo = 'PaginaSolicitudesCotizacion'
            AND ( valor = ''
                  OR valor IS NULL
                )

/*
exec Proveedores_TX_Contactos 46
select * from detalleproveedores


select * from parametros2
select PathPlantillas from parametros

update parametros set PathPlantillas='C:\ProntoWeb\Proyectos\Pronto\Documentos'




select *count(valor) from parametros2 where campo='HostProntoWeb'

select valor from parametros2 where campo='HostProntoWeb'
select valor from parametros2 where campo='PaginaSolicitudesCotizacion'

delete parametros2 where campo='PaginaSolicitudesCotizacion'
delete parametros2 where campo='HostProntoWeb'
*/


INSERT  INTO parametros2 ( campo, valor )
    VALUES  (
              'ConfiguracionEmpresa',
              'Williams' )
    

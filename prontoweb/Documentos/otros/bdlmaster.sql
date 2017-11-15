

[aspnet_Roles_CreateRole] '/','SuperAdmin'  --ejecutar en la bdlmaster
[aspnet_Roles_CreateRole] '/','WilliamsAdmin'  --ejecutar en la bdlmaster
[aspnet_Roles_CreateRole] '/','WilliamsComercial'  --ejecutar en la bdlmaster
[aspnet_Roles_CreateRole] '/','WilliamsFacturacion'  --ejecutar en la bdlmaster

aspnet_UsersInRoles_AddUsersToRoles '/','Mariano','SuperAdmin',''
aspnet_UsersInRoles_AddUsersToRoles '/','Mariano','WilliamsAdmin',''
aspnet_UsersInRoles_AddUsersToRoles '/','Mariano','WilliamsComercial',''
aspnet_UsersInRoles_AddUsersToRoles '/','Mariano','WilliamsFacturacion',''


 use bdlmaster

 select * from bases
 join DetalleUserBD on bases.IdBD=DetalleUserBD.IdBD
 where UserId=

 select * from aspnet_Users

 select * from aspnet_Applications

 select * from aspnet_Profile 

 select * from aspnet_Membership



 use bdlmaster

select * from aspnet_users

SELECT * FROM BASES

select * from DetalleUserBD

select * from userdatosextendidos

SELECT * FROM BASES join DetalleUserBD on bases.IdBD=DetalleUserBD.IdBD 
where lower(UserId)='705e6364-4535-4fcc-8746-a1ade8c66c98' AND Descripcion='Capen'  
go


bdlmaster.dbo.wResetearPass '30-65663161-1','30-65663161-'1
bdlmaster.dbo.wResetearPass 'Mariano','pirulo!'
bdlmaster.dbo.wResetearPass 'esucoreq','esucoreq!'

delete from Bases where IdBD=16


--Rather than writing INSERT statements by hand, use the stored procedures that are part of the SqlMembershipProvider implementation provider and are included when installing application services using the aspnet_reg.exe tool.

--In particular, use:

--aspnet_Roles_CreateRole to create a new role
--aspnet_Membership_CreateUser to create a user and supply his membership data (password, security question and answer, and so forth)
--aspnet_UsersInRoles_AddUsersToRoles to add an existing user to an existing role

[aspnet_Roles_CreateRole] '/','SuperAdmin'  --ejecutar en la bdlmaster
go

declare @now datetime
set @now= GETDATE()
exec aspnet_Membership_CreateUser  '/','Mariano','pirulo!','','mscalella911@gmail.com','','',1,@now,@now,0,0,null
aspnet_UsersInRoles_AddUsersToRoles '/','Mariano','SuperAdmin',''
bdlmaster.dbo.wResetearPass 'Mariano','pirulo!'


aspnet_UsersInRoles_AddUsersToRoles '/','supervisor','SuperAdmin',''

 exec aspneaspnet_Membership_CreateUser '/'

 sp_helptext 'aspnet_UsersInRoles_AddUsersToRoles'



select * from bases 
